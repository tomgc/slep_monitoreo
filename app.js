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
  const bannerList = $("#bannerList");
  const estadoLabel = { vigente: "Vigente", desarrollo: "En desarrollo" };

  function bannerEl(p, i) {
    const node = el("div", "banner");
    node.setAttribute("role", "button");
    node.setAttribute("tabindex", "0");
    node.setAttribute("data-estado", p.estado);
    node.setAttribute("aria-label", "Ver reseña: " + p.titulo);
    const media = (p.imgs && p.imgs.length)
      ? `<img class="banner-shot" src="${esc(p.imgs[0])}" alt="${esc(p.titulo)}" loading="lazy">`
      : `<div class="banner-ph"><span>Próximamente</span></div>`;
    node.innerHTML = `
      <div class="banner-body">
        <div class="banner-top">
          <span class="estado estado--${p.estado}"><span class="dot"></span>${estadoLabel[p.estado]}</span>
          <span class="banner-cta">Ver reseña <span class="arrow">→</span></span>
        </div>
        <h3>${esc(p.titulo)}</h3>
        <p class="banner-obj">${esc(p.objetivo)}</p>
      </div>
      <div class="banner-media">
        ${media}
      </div>`;
    node.addEventListener("click", () => openLightbox(p));
    node.addEventListener("keydown", (e) => {
      if (e.key === "Enter" || e.key === " ") { e.preventDefault(); openLightbox(p); }
    });
    // evitar que un clic sobre el área de imagen dispare el lightbox dos veces
    const mediaEl = node.querySelector(".banner-media");
    ["click", "mousedown", "keydown"].forEach((ev) =>
      mediaEl.addEventListener(ev, (e) => e.stopPropagation()));
    return node;
  }

  function renderBanners() {
    bannerList.innerHTML = "";
    var grupo = { vigente: 0, desarrollo: 1 };
    var list = PROYECTOS.slice().sort(function (a, b) {
      var g = (grupo[a.estado] || 0) - (grupo[b.estado] || 0);
      if (g !== 0) return g;
      return (a.orden || 0) - (b.orden || 0);
    });
    list.forEach((p, i) => bannerList.appendChild(bannerEl(p, i)));
  }

  renderBanners();

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
    shots.forEach((shot, i) => {
      let slide;
      if (shot) {
        slide = el("img", "lb-slide");
        slide.src = shot;
        slide.alt = p.titulo;
        slide.loading = "lazy";
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

  function openLightbox(p) {
    $("#lbType").textContent = p.tipo;
    $("#lbTitle").textContent = p.titulo;
    const lbObj = $("#lbObj");
    lbObj.innerHTML = "";
    const parrafos = (p.sintesis && p.sintesis.length) ? p.sintesis : [p.objetivo];
    parrafos.forEach((txt) => lbObj.appendChild(el("p", null, esc(txt))));
    buildGallery(p);
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
