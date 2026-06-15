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

  function slug(s) {
    return String(s).normalize("NFD").replace(/[\u0300-\u036f]/g, "")
      .toLowerCase().replace(/[^a-z0-9]+/g, "-").replace(/(^-|-$)/g, "").slice(0, 48);
  }

  function bannerEl(p, i) {
    const node = el("div", "banner");
    node.setAttribute("role", "button");
    node.setAttribute("tabindex", "0");
    node.setAttribute("data-estado", p.estado);
    node.setAttribute("aria-label", "Ver reseña: " + p.titulo);
    const sid = "pf-" + slug(p.titulo);
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
        <image-slot id="${sid}" shape="rounded" radius="6" placeholder="Imagen del proyecto"></image-slot>
      </div>`;
    node.addEventListener("click", () => openLightbox(p));
    node.addEventListener("keydown", (e) => {
      if (e.key === "Enter" || e.key === " ") { e.preventDefault(); openLightbox(p); }
    });
    // let the image slot handle its own drag/drop/click without opening the lightbox
    const media = node.querySelector(".banner-media");
    ["click", "mousedown", "keydown", "dragover", "drop"].forEach((ev) =>
      media.addEventListener(ev, (e) => e.stopPropagation()));
    return node;
  }

  function renderBanners() {
    bannerList.innerHTML = "";
    var order = { vigente: 0, desarrollo: 1 };
    var list = PROYECTOS.slice().sort(function (a, b) {
      return (order[a.estado] || 0) - (order[b.estado] || 0);
    });
    list.forEach((p, i) => bannerList.appendChild(bannerEl(p, i)));
  }

  renderBanners();

  /* ===========================================================
     LIGHTBOX
     =========================================================== */
  const lightbox = $("#lightbox");

  function openLightbox(p) {
    $("#lbType").textContent = p.tipo;
    $("#lbTitle").textContent = p.titulo;
    $("#lbObj").textContent = p.objetivo;
    lightbox.classList.add("open");
    document.body.style.overflow = "hidden";
    $("#lbClose").focus();
  }
  function closeLightbox() {
    lightbox.classList.remove("open");
    document.body.style.overflow = "";
  }
  $("#lbClose").addEventListener("click", closeLightbox);
  lightbox.addEventListener("click", (e) => { if (e.target === lightbox) closeLightbox(); });
  document.addEventListener("keydown", (e) => { if (e.key === "Escape") closeLightbox(); });

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

  /* ===========================================================
     NAV — mobile toggle + scrollspy + header shadow
     =========================================================== */
  const navToggle = $("#navToggle");
  navToggle && navToggle.addEventListener("click", () => document.body.classList.toggle("nav-open"));
  $$("#siteNav a").forEach((a) => a.addEventListener("click", () => document.body.classList.remove("nav-open")));

  const sections = ["que-hace", "trayectoria", "portafolio"];
  const navLinks = {};
  $$("#siteNav a").forEach((a) => { navLinks[a.getAttribute("href").slice(1)] = a; });
  const spy = new IntersectionObserver((entries) => {
    entries.forEach((e) => {
      if (e.isIntersecting) {
        Object.values(navLinks).forEach((l) => l.classList.remove("active"));
        const l = navLinks[e.target.id];
        if (l) l.classList.add("active");
      }
    });
  }, { rootMargin: "-45% 0px -50% 0px" });
  sections.forEach((id) => { const s = document.getElementById(id); if (s) spy.observe(s); });

  /* ===========================================================
     VARIANTS PANEL
     =========================================================== */
  const fab = $("#variantsFab");
  const panel = $("#variantsPanel");
  const STORE = "am-variants-2";

  function applyStored() {
    document.body.setAttribute("data-variant", "d2");
    document.body.setAttribute("data-density", "comfortable");
  }
  function save() {
    const v = {
      variant: document.body.getAttribute("data-variant"),
      density: document.body.getAttribute("data-density")
    };
    try { localStorage.setItem(STORE, JSON.stringify(v)); } catch (e) {}
  }
  function syncControls() {
    $$(".vp-seg, .vp-swatches").forEach((group) => {
      const prop = group.getAttribute("data-prop");
      const cur = document.body.getAttribute("data-" + prop);
      $$("button", group).forEach((b) => b.classList.toggle("active", b.getAttribute("data-val") === cur));
    });
  }
  $$(".vp-seg, .vp-swatches").forEach((group) => {
    const prop = group.getAttribute("data-prop");
    $$("button", group).forEach((btn) => {
      btn.addEventListener("click", () => {
        document.body.setAttribute("data-" + prop, btn.getAttribute("data-val"));
        syncControls();
        save();
      });
    });
  });
  function togglePanel(open) {
    const show = open == null ? !panel.classList.contains("open") : open;
    panel.classList.toggle("open", show);
  }
  fab.addEventListener("click", () => togglePanel());
  $("#vpClose").addEventListener("click", () => togglePanel(false));
  document.addEventListener("keydown", (e) => { if (e.key === "Escape") togglePanel(false); });

  applyStored();
})();
