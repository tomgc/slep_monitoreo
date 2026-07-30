/* ===========================================================
   Área de Monitoreo — App
   Render del portafolio, trayectoria, equipo + interacciones.
   Vanilla JS, sin dependencias → compatible con GitHub Pages.
   =========================================================== */
(function () {
  "use strict";

  /* Silence the benign "ResizeObserver loop" notice some browsers emit. */
  window.addEventListener("error", function (e) {
    if (e && e.message && /ResizeObserver loop/.test(e.message)) {
      e.stopImmediatePropagation();
      e.preventDefault();
    }
  });

  /* ---------- helpers ---------- */
  const $ = (s, c) => (c || document).querySelector(s);
  const $$ = (s, c) => Array.from((c || document).querySelectorAll(s));
  const el = (tag, cls, html) => {
    const n = document.createElement(tag);
    if (cls) n.className = cls;
    if (html != null) n.innerHTML = html;
    return n;
  };
  const esc = (s) => String(s).replace(/[&<>"]/g, (m) => ({ "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;" }[m]));

  /* ===========================================================
     PORTAFOLIO
     =========================================================== */
  /* Render del pliego: una franja por proyecto, capturas a altura
     normalizada y ancho natural. Reemplaza los banners de v1. */
  const pliego = $("#pliego");
  const estadoLabel = { vigente: "Vigente", desarrollo: "En desarrollo" };

  /* Marca si el pasador tiene capturas fuera de vista, para mostrar el
     degradado y la flecha del borde derecho. Se recalcula al cargar cada
     imagen (el ancho depende de la proporción real), al desplazar y al
     redimensionar la ventana. */
  function marcarDesplazamiento(wrap) {
    var s = wrap.querySelector(".pl-strip");
    if (!s) return;
    /* Con una sola captura no hay "más capturas" que anunciar, aunque esa
       captura sea más ancha que la franja y por tanto desplazable. */
    if (s.querySelectorAll(".pl-shot").length < 2) {
      wrap.classList.remove("has-more");
      wrap.classList.remove("has-prev");
      return;
    }
    var resto = s.scrollWidth - s.clientWidth;
    wrap.classList.toggle("has-more", resto > 4 && s.scrollLeft < resto - 4);
    wrap.classList.toggle("has-prev", s.scrollLeft > 4);
  }

  /* Avanza o retrocede el pasador hasta el borde de la captura siguiente, en
     vez de una cantidad fija de píxeles: las capturas tienen anchos distintos
     (la altura es la que se normaliza), así que un salto fijo dejaría medias
     capturas a la vista. */
  var SIN_ANIMACION = window.matchMedia && window.matchMedia("(prefers-reduced-motion: reduce)").matches;
  function desplazarPasador(wrap, dir) {
    var s = wrap.querySelector(".pl-strip");
    if (!s) return;
    var base = s.getBoundingClientRect().left;
    var shots = $$(".pl-shot", s);
    var destino = null;
    for (var i = 0; i < shots.length; i++) {
      var x = shots[i].getBoundingClientRect().left - base + s.scrollLeft;
      if (dir > 0 && x > s.scrollLeft + 4) { destino = x; break; }
      if (dir < 0 && x < s.scrollLeft - 4) { destino = x; }
    }
    if (destino === null) destino = dir > 0 ? s.scrollWidth : 0;
    s.scrollTo({ left: destino, behavior: SIN_ANIMACION ? "auto" : "smooth" });
  }

  function navEl(wrap, dir) {
    var b = el("button", "pl-nav " + (dir > 0 ? "next" : "prev"),
      '<svg viewBox="0 0 24 24" width="18" height="18" fill="none" stroke="currentColor" stroke-width="2.4" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M' +
      (dir > 0 ? "9 5l7 7-7 7" : "15 5l-7 7 7 7") + '"/></svg>');
    b.type = "button";
    b.setAttribute("aria-label", dir > 0 ? "Ver capturas siguientes" : "Ver capturas anteriores");
    b.addEventListener("click", function () { desplazarPasador(wrap, dir); });
    return b;
  }

  function bandEl(p) {
    var band = el("div", "pl-band");
    band.setAttribute("data-estado", p.estado);

    /* ---- columna de texto ---- */
    var side = el("div", "pl-side");
    side.innerHTML =
      '<div class="pl-head">' +
        '<span class="pl-num">' + String(p.orden).padStart(2, "0") + "</span>" +
        '<span class="pl-tipo">' + esc(p.tipo) + "</span>" +
      "</div>" +
      '<span class="estado estado--' + p.estado + '"><span class="dot"></span>' + estadoLabel[p.estado] + "</span>" +
      '<h3 class="pl-title">' + esc(p.titulo) + "</h3>" +
      '<p class="pl-resumen">' + esc(p.objetivo) + "</p>";

    var link = el("button", "pl-link", 'Ver reseña <span class="arrow">→</span>');
    link.type = "button";
    link.setAttribute("aria-label", "Ver reseña: " + p.titulo);
    link.addEventListener("click", function () { openLightbox(p); });
    side.appendChild(link);
    band.appendChild(side);

    /* ---- capturas ---- */
    if (p.imgs && p.imgs.length) {
      var wrap = el("div", "pl-scroll");
      var strip = el("div", "pl-strip");
      strip.setAttribute("role", "group");
      strip.setAttribute("aria-label", "Capturas de " + p.titulo);
      p.imgs.forEach(function (src, i) {
        var b = el("button", "pl-shot");
        b.type = "button";
        b.setAttribute("aria-label", "Ver captura " + (i + 1) + " de " + p.imgs.length + ": " + p.titulo);
        b.innerHTML = '<img src="' + esc(src) + '" alt="' + esc(p.titulo) + " — captura " + (i + 1) + '" loading="lazy">';
        b.addEventListener("click", function () { openLightbox(p, i); });
        b.querySelector("img").addEventListener("load", function () { marcarDesplazamiento(wrap); });
        strip.appendChild(b);
      });
      wrap.appendChild(strip);
      wrap.appendChild(navEl(wrap, -1));
      wrap.appendChild(navEl(wrap, 1));
      strip.addEventListener("scroll", function () { marcarDesplazamiento(wrap); });
      band.appendChild(wrap);
    } else {
      /* sin capturas: campo azul claro.
         - en desarrollo → campo vacío, solo el pie "En desarrollo…"
         - vigente       → eyebrow + línea destacada + pie
         El texto opcional vive en data.js como p.vacio = [eyebrow, linea, pie]. */
      var v = p.vacio || [];
      var empty = el("div", "pl-empty");
      if (p.estado === "desarrollo") {
        empty.innerHTML = '<span class="pl-empty-foot">En desarrollo…</span>';
      } else {
        empty.innerHTML =
          (v[0] ? '<p class="pl-empty-eyebrow">' + esc(v[0]) + "</p>" : "<span></span>") +
          (v[1] ? '<p class="pl-empty-line">' + esc(v[1]) + "</p>" : "") +
          '<span class="pl-empty-foot">' + esc(v[2] || "Vigente · capturas en preparación") + "</span>";
      }
      band.appendChild(empty);
    }

    return band;
  }

  function renderPliego() {
    pliego.innerHTML = "";
    var grupo = { vigente: 0, desarrollo: 1 };
    var list = PROYECTOS.slice().sort(function (a, b) {
      var g = (grupo[a.estado] || 0) - (grupo[b.estado] || 0);
      if (g !== 0) return g;
      return (a.orden || 0) - (b.orden || 0);
    });
    list.forEach(function (p) { pliego.appendChild(bandEl(p)); });
    $$(".pl-scroll", pliego).forEach(marcarDesplazamiento);
  }
  window.addEventListener("resize", function () {
    $$(".pl-scroll", pliego).forEach(marcarDesplazamiento);
  });

  renderPliego();

  /* ===========================================================
     LIGHTBOX
     =========================================================== */
  const lightbox = $("#lightbox");
  const lbStage = $("#lbStage");
  const lbDots = $("#lbDots");
  const lbCount = $("#lbCount");
  const lbPrev = $("#lbPrev");
  const lbNext = $("#lbNext");
  let lbIndex = 0;

  /* visor full-res: overlay propio, creado una vez y reutilizado */
  let fsShots = [];      // capturas del proyecto abierto (sin placeholder)
  let fsAlt = "";
  const fsViewer = el("div", "lb-full");
  fsViewer.setAttribute("aria-hidden", "true");
  const fsImg = el("img");
  const fsClose = el("button", "lb-full-close", "&times;");
  fsClose.setAttribute("type", "button");
  fsClose.setAttribute("aria-label", "Cerrar imagen");
  const fsPrev = el("button", "lb-full-nav prev", "&#8249;");
  fsPrev.setAttribute("type", "button");
  fsPrev.setAttribute("aria-label", "Captura anterior");
  const fsNext = el("button", "lb-full-nav next", "&#8250;");
  fsNext.setAttribute("type", "button");
  fsNext.setAttribute("aria-label", "Captura siguiente");
  fsViewer.appendChild(fsImg);
  fsViewer.appendChild(fsPrev);
  fsViewer.appendChild(fsNext);
  fsViewer.appendChild(fsClose);
  document.body.appendChild(fsViewer);

  function fsRender() {
    const n = fsShots.length;
    const single = n <= 1;
    fsImg.src = fsShots[lbIndex];
    fsImg.alt = fsAlt;
    fsPrev.hidden = single;
    fsNext.hidden = single;
    fsPrev.disabled = lbIndex === 0;
    fsNext.disabled = lbIndex === n - 1;
  }
  function fsGo(delta) {
    const n = fsShots.length;
    lbIndex = Math.max(0, Math.min(n - 1, lbIndex + delta));
    fsRender();   // mueve el visor full-res
    lbRender();   // y sincroniza el slide de fondo
  }
  function openFull(i) {
    lbIndex = i;
    fsRender();
    lbRender();
    fsViewer.classList.add("open");
    fsViewer.setAttribute("aria-hidden", "false");
    fsClose.focus();
  }
  function closeFull() {
    fsViewer.classList.remove("open");
    fsViewer.setAttribute("aria-hidden", "true");
    fsImg.removeAttribute("src");
  }
  fsClose.addEventListener("click", closeFull);
  fsPrev.addEventListener("click", () => fsGo(-1));
  fsNext.addEventListener("click", () => fsGo(1));
  fsViewer.addEventListener("click", (e) => { if (e.target === fsViewer) closeFull(); });

  function lbRender() {
    const slides = $$(".lb-slide", lbStage);
    const dots = $$(".lb-dot", lbDots);
    const n = slides.length;
    const single = n <= 1;
    slides.forEach((s, i) => s.classList.toggle("active", i === lbIndex));
    dots.forEach((d, i) => d.classList.toggle("active", i === lbIndex));
    lbPrev.disabled = lbIndex === 0;
    lbNext.disabled = lbIndex === n - 1;
    lbPrev.hidden = single;
    lbNext.hidden = single;
    lbCount.textContent = single ? "" : (lbIndex + 1) + " / " + n;
    lbDots.style.display = single ? "none" : "";
  }
  function lbGo(delta) {
    const n = $$(".lb-slide", lbStage).length;
    lbIndex = Math.max(0, Math.min(n - 1, lbIndex + delta));
    lbRender();
  }
  function buildGallery(p) {
    // limpiar las slides del proyecto anterior
    $$(".lb-slide", lbStage).forEach((s) => s.remove());
    lbDots.innerHTML = "";
    lbIndex = 0;
    const shots = (p.imgs && p.imgs.length) ? p.imgs : [null];
    fsShots = (p.imgs && p.imgs.length) ? p.imgs.slice() : [];
    fsAlt = p.titulo;
    shots.forEach((shot, i) => {
      let slide;
      if (shot) {
        slide = el("img", "lb-slide");
        slide.src = shot;
        slide.alt = p.titulo;
        slide.loading = "lazy";
        slide.addEventListener("click", () => openFull(i));
      } else {
        slide = el("div", "lb-slide lb-ph", "<span>Reseña del producto · próximamente</span>");
      }
      // las slides van antes de los botones de navegación
      lbStage.insertBefore(slide, lbPrev);
      if (shots.length > 1) {
        const dot = el("button", "lb-dot");
        dot.setAttribute("aria-label", "Ir a la captura " + (i + 1));
        dot.addEventListener("click", () => { lbIndex = i; lbRender(); });
        lbDots.appendChild(dot);
      }
    });
    lbRender();
  }

  function openLightbox(p, startIndex) {
    $("#lbType").textContent = p.tipo;
    $("#lbTitle").textContent = p.titulo;
    const lbObj = $("#lbObj");
    lbObj.innerHTML = "";
    const parrafos = (p.sintesis && p.sintesis.length) ? p.sintesis : [p.objetivo];
    parrafos.forEach((txt) => lbObj.appendChild(el("p", null, esc(txt))));
    buildGallery(p);
    if (startIndex) { lbIndex = startIndex; lbRender(); }
    lightbox.classList.add("open");
    document.body.style.overflow = "hidden";
    $("#lbClose").focus();
  }
  function closeLightbox() {
    lightbox.classList.remove("open");
    document.body.style.overflow = "";
  }
  $("#lbClose").addEventListener("click", closeLightbox);
  lbPrev.addEventListener("click", () => lbGo(-1));
  lbNext.addEventListener("click", () => lbGo(1));
  lightbox.addEventListener("click", (e) => { if (e.target === lightbox) closeLightbox(); });
  document.addEventListener("keydown", (e) => {
    if (fsViewer.classList.contains("open")) {
      if (e.key === "Escape") { e.stopPropagation(); closeFull(); }
      else if (e.key === "ArrowLeft") fsGo(-1);
      else if (e.key === "ArrowRight") fsGo(1);
      return;
    }
    if (!lightbox.classList.contains("open")) return;
    if (e.key === "Escape") closeLightbox();
    else if (e.key === "ArrowLeft") lbGo(-1);
    else if (e.key === "ArrowRight") lbGo(1);
  });

  /* ===========================================================
     TRAYECTORIA
     =========================================================== */
  const timeline = $("#timeline");
  HITOS.slice().reverse().forEach((h) => {
    const node = el("div", "t-node" + (h.future ? " is-future" : ""));
    node.innerHTML = `
      <p class="t-date">${esc(h.fecha)}</p>
      <h3>${esc(h.titulo)}</h3>
      <p>${esc(h.texto)}</p>`;
    timeline.appendChild(node);
  });

  /* ===========================================================
     EQUIPO — sección eliminada
     =========================================================== */
})();
