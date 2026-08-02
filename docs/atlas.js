/* ===========================================================
   Atlas de los datos educativos
   Área de Monitoreo · SLEP Costa Central

   Consume las tres constantes globales de atlas_datos.js
   (ATLAS_INSTITUCIONES, ATLAS_DESAFIOS, ATLAS_FRASES).

   Todo vive dentro de una IIFE: este archivo no agrega ninguna
   constante al ámbito global.

   Geometría en píxeles, no en porcentajes: las órbitas son
   círculos y un porcentaje sobre un contenedor no cuadrado los
   convierte en elipses distintas por eje. Cada cuerpo tiene su
   propio radio, de modo que dos cuerpos nunca comparten anillo.

   No toca app.js, data.js ni atlas_datos.js.
   =========================================================== */

(function () {
  "use strict";

  // El id de la sección (#atlas) es el ancla de navegación;
  // el contenedor del mapa usa uno propio.
  var raiz = document.getElementById("atlasCeleste");
  if (!raiz) return;

  var INST = typeof ATLAS_INSTITUCIONES !== "undefined" ? ATLAS_INSTITUCIONES : null;
  var DES = typeof ATLAS_DESAFIOS !== "undefined" ? ATLAS_DESAFIOS : [];

  if (!INST || !INST.length) {
    raiz.innerHTML = '<p class="atlas-error">El catálogo del atlas no está disponible en esta página.</p>';
    return;
  }

  /* ---------- Utilidades ---------- */

  function esc(s) {
    return String(s == null ? "" : s)
      .replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;")
      .replace(/"/g, "&quot;").replace(/'/g, "&#39;");
  }
  function bases(i) { return (i && i.bases) || []; }
  function datos(b) { return (b && b.datos) || []; }
  function nDatos(i) { var n = 0; bases(i).forEach(function (b) { n += datos(b).length; }); return n; }
  function porId(l, id) { for (var k = 0; k < l.length; k++) if (l[k].id === id) return l[k]; return null; }
  function plural(n, s, p) { return n + " " + (n === 1 ? s : p); }
  function acotar(v, a, b) { return Math.max(a, Math.min(b, v)); }

  function buscar(ruta) {
    var p = String(ruta || "").split(".");
    if (p.length !== 3) return null;
    var i = porId(INST, p[0]); if (!i) return null;
    var b = porId(bases(i), p[1]); if (!b) return null;
    var d = porId(datos(b), p[2]); if (!d) return null;
    return { inst: i, base: b, dato: d, ruta: ruta };
  }

  /* Posiciones normalizadas del nivel raíz. El catálogo trae x,y
     en una franja pensada para un encabezado superpuesto; con la
     barra arriba esa franja quedó libre y se reescala para llenar
     el lienzo. Si todas las instituciones comparten coordenada, el
     divisor cae a 1 y no se divide por cero. */
  var norm = (function () {
    var xs = INST.map(function (i) { return +i.x || 0; });
    var ys = INST.map(function (i) { return +i.y || 0; });
    var x0 = Math.min.apply(null, xs), x1 = Math.max.apply(null, xs);
    var y0 = Math.min.apply(null, ys), y1 = Math.max.apply(null, ys);
    return function (i) {
      var dx = x1 - x0 || 1, dy = y1 - y0 || 1;
      return {
        x: 12 + ((+i.x || 0) - x0) / dx * 76,
        y: 16 + ((+i.y || 0) - y0) / dy * 68
      };
    };
  })();

  /* ---------- Estado ---------- */

  var st = {
    nivel: "raiz",   // raiz | institucion | base | desafio
    inst: null, base: null, ruta: null, desafio: null,
    prev: null, dir: "in",
    z: 1, px: 0, py: 0, menu: false
  };

  /* ---------- Andamio ---------- */

  raiz.innerHTML =
    '<div class="atlas-barra">' +
      '<nav class="atlas-migas" id="atMigas" aria-label="Nivel del atlas"></nav>' +
      '<span class="crece"></span>' +
      '<div class="atlas-desafios">' +
        '<button type="button" id="atBtnDes" aria-expanded="false" aria-controls="atMenu">Ámbitos de indagación</button>' +
        '<div class="atlas-menu" id="atMenu" hidden></div>' +
      "</div>" +
    "</div>" +
    '<div class="atlas-lienzo" id="atLienzo">' +
      '<div class="atlas-escena" id="atEscena"><div class="atlas-mapa" id="atMapa"></div></div>' +
      '<aside class="atlas-ficha" id="atFicha" hidden aria-label="Ficha del dato"></aside>' +
      '<div class="atlas-controles">' +
        '<button type="button" id="atFull" title="Pantalla completa" aria-label="Pantalla completa">⛶</button>' +
        '<button type="button" id="atMas" title="Acercar" aria-label="Acercar">+</button>' +
        '<button type="button" id="atMenos" title="Alejar" aria-label="Alejar">−</button>' +
        '<button type="button" id="atReset" title="Restablecer la vista" aria-label="Restablecer la vista">↺</button>' +
      "</div>" +
      '<p class="atlas-pie" id="atPie"></p>' +
    "</div>";

  var elLienzo = raiz.querySelector("#atLienzo");
  var elEscena = raiz.querySelector("#atEscena");
  var elMapa = raiz.querySelector("#atMapa");
  var elMigas = raiz.querySelector("#atMigas");
  var elMenu = raiz.querySelector("#atMenu");
  var elBtnDes = raiz.querySelector("#atBtnDes");
  var elFicha = raiz.querySelector("#atFicha");
  var elPie = raiz.querySelector("#atPie");

  function medida() {
    var r = elLienzo.getBoundingClientRect();
    return { w: r.width || 900, h: r.height || 520 };
  }

  /* ---------- Zoom y paneo ---------- */

  function transform() {
    elEscena.style.transform = "translate(" + st.px + "px," + st.py + "px) scale(" + st.z + ")";
  }
  function acotarZ(z) { return acotar(z, 0.5, 3.2); }
  function resetVista() { st.z = 1; st.px = 0; st.py = 0; transform(); }

  elLienzo.addEventListener("wheel", function (e) {
    if (elFicha.contains(e.target)) return;
    e.preventDefault();
    var r = elLienzo.getBoundingClientRect();
    var cx = e.clientX - r.left - r.width / 2;
    var cy = e.clientY - r.top - r.height / 2;
    var nz = acotarZ(st.z * Math.exp(-e.deltaY * 0.0012));
    var k = nz / st.z;
    st.px = cx - (cx - st.px) * k;
    st.py = cy - (cy - st.py) * k;
    st.z = nz;
    transform();
  }, { passive: false });

  /* Arrastre sin setPointerCapture. La captura hacía que el evento
     click posterior se despachara sobre el contenedor y no sobre el
     nodo, de modo que ningún clic del mapa llegaba a su destino.
     El seguimiento va en document y el umbral de 5 px distingue un
     arrastre real de un clic. */
  var drag = null;

  elLienzo.addEventListener("pointerdown", function (e) {
    if (e.button !== 0) return;
    if (elFicha.contains(e.target)) return;
    if (e.target.closest(".atlas-controles, .atlas-lista, .atlas-nodo")) return;
    drag = { x: e.clientX, y: e.clientY, px: st.px, py: st.py, movido: false };
  });

  document.addEventListener("pointermove", function (e) {
    if (!drag) return;
    var dx = e.clientX - drag.x, dy = e.clientY - drag.y;
    if (!drag.movido && Math.abs(dx) + Math.abs(dy) > 5) {
      drag.movido = true;
      elLienzo.classList.add("is-arrastrando");
    }
    if (!drag.movido) return;
    st.px = drag.px + dx;
    st.py = drag.py + dy;
    transform();
  });

  document.addEventListener("pointerup", function () {
    if (!drag) return;
    drag = null;
    elLienzo.classList.remove("is-arrastrando");
  });

  raiz.querySelector("#atMas").addEventListener("click", function () { st.z = acotarZ(st.z * 1.25); transform(); });
  raiz.querySelector("#atMenos").addEventListener("click", function () { st.z = acotarZ(st.z / 1.25); transform(); });
  raiz.querySelector("#atReset").addEventListener("click", resetVista);
  raiz.querySelector("#atFull").addEventListener("click", function () {
    if (document.fullscreenElement) document.exitFullscreen();
    else if (raiz.requestFullscreen) raiz.requestFullscreen();
  });

  /* ---------- Navegación ---------- */

  function ir(nuevo, dir) {
    st.dir = dir || "in";
    Object.keys(nuevo).forEach(function (k) { st[k] = nuevo[k]; });
    resetVista();
    render();
  }

  function subir() {
    if (st.ruta) { st.ruta = null; render(); return; }
    if (st.nivel === "base") ir({ nivel: "institucion", base: null }, "out");
    else if (st.nivel === "institucion") ir({ nivel: "raiz", inst: null }, "out");
    else if (st.nivel === "desafio") ir({ nivel: "raiz", desafio: null }, "out");
  }

  document.addEventListener("keydown", function (e) {
    if (e.key !== "Escape" || !raiz.isConnected) return;
    if (st.menu) { cerrarMenu(); return; }
    if (st.ruta || st.nivel !== "raiz") subir();
  });

  /* ---------- Menú de desafíos ---------- */

  if (!DES.length) elBtnDes.hidden = true;
  elMenu.innerHTML = DES.map(function (a) {
    return '<button type="button" data-desafio="' + esc(a.id) + '">' +
      '<span class="n">' + esc(a.nombre) + "</span>" +
      '<span class="q">' + esc(a.pregunta) + "</span></button>";
  }).join("");

  function cerrarMenu() {
    st.menu = false;
    var habia = st.prev !== null;
    st.prev = null;
    elMenu.hidden = true;
    elBtnDes.setAttribute("aria-expanded", "false");
    raiz.classList.remove("menu-abierto");
    if (habia) render();
  }

  elBtnDes.addEventListener("click", function (e) {
    e.stopPropagation();
    if (st.menu) { cerrarMenu(); return; }
    st.menu = true;
    elMenu.hidden = false;
    elBtnDes.setAttribute("aria-expanded", "true");
    raiz.classList.add("menu-abierto");
  });

  elMenu.addEventListener("click", function (e) {
    var b = e.target.closest("[data-desafio]");
    if (!b) return;
    e.stopPropagation();
    var id = b.getAttribute("data-desafio");
    cerrarMenu();
    ir({ nivel: "desafio", desafio: id, inst: null, base: null, ruta: null }, "in");
  });

  elMenu.addEventListener("mouseover", function (e) {
    var b = e.target.closest("[data-desafio]");
    if (!b) return;
    var id = b.getAttribute("data-desafio");
    if (st.prev === id) return;
    st.prev = id;
    if (st.nivel === "raiz") render();
  });
  elMenu.addEventListener("mouseleave", function () {
    if (st.prev === null) return;
    st.prev = null;
    if (st.nivel === "raiz") render();
  });

  document.addEventListener("click", function (e) {
    if (!st.menu) return;
    if (e.target.closest(".atlas-desafios")) return;
    cerrarMenu();
  });

  /* ---------- Migas ---------- */

  function pintarMigas() {
    var partes = [{ t: "Instituciones", ir: { nivel: "raiz", inst: null, base: null, desafio: null, ruta: null } }];

    if (st.nivel === "desafio") {
      var a = porId(DES, st.desafio);
      partes.push({ t: a ? a.nombre : "Ámbito" });
    } else if (st.nivel !== "raiz") {
      var i = porId(INST, st.inst);
      if (i) partes.push({ t: i.nombre, ir: { nivel: "institucion", base: null, ruta: null } });
      if (st.nivel === "base") {
        var b = porId(bases(i), st.base);
        if (b) partes.push({ t: b.nombre });
      }
    }

    elMigas.innerHTML = partes.map(function (p, k) {
      var sep = k ? '<span class="sep">›</span>' : "";
      if (k === partes.length - 1) return sep + '<span class="actual">' + esc(p.t) + "</span>";
      return sep + '<button type="button" data-miga="' + k + '">' + esc(p.t) + "</button>";
    }).join("");

    elMigas.querySelectorAll("[data-miga]").forEach(function (btn) {
      btn.addEventListener("click", function () {
        ir(partes[+btn.getAttribute("data-miga")].ir, "out");
      });
    });
  }

  /* ---------- Piezas de dibujo ---------- */

  function orbita(cx, cy, r, destacada) {
    return '<div class="atlas-orbita' + (destacada ? " destacada" : "") + '" style="left:' + cx +
      "px;top:" + cy + "px;width:" + r * 2 + "px;height:" + r * 2 + 'px"></div>';
  }

  function nodo(o) {
    var s = '<button type="button" class="atlas-nodo' + (o.atenuado ? " atenuado" : "") +
      '" style="left:' + o.x + "px;top:" + o.y + 'px" ' + (o.attr || "") +
      ' title="' + esc(o.desc || "") + '">';
    s += '<span class="cuerpo' + (o.activo ? " activo" : "") + '" style="--c:' + esc(o.color) +
      ";width:" + o.d + "px;height:" + o.d + 'px"></span>';
    s += '<span class="nombre">' + esc(o.nombre) + "</span>";
    if (o.meta) s += '<span class="meta">' + esc(o.meta) + "</span>";
    s += "</button>";
    return s;
  }

  function trazo(pts, punteado) {
    if (pts.length < 2) return "";
    var m = medida();
    var s = '<svg class="atlas-trazo' + (punteado ? " punteado" : "") + '" viewBox="0 0 ' +
      m.w + " " + m.h + '" width="' + m.w + '" height="' + m.h + '">';
    for (var k = 0; k < pts.length - 1; k++) {
      s += '<line x1="' + pts[k].x + '" y1="' + pts[k].y +
        '" x2="' + pts[k + 1].x + '" y2="' + pts[k + 1].y + '" />';
    }
    return s + "</svg>";
  }

  /* Reparte n cuerpos en anillos concéntricos distintos. Devuelve
     para cada índice su radio y su ángulo. */
  function anillos(n, rMin, rMax) {
    var out = [];
    for (var k = 0; k < n; k++) {
      var t = n === 1 ? 0.5 : k / (n - 1);
      out.push({ r: rMin + (rMax - rMin) * t, a: (-90 + (k * 360) / n) * Math.PI / 180 });
    }
    return out;
  }

  /* ---------- Vistas ---------- */

  function preview(desafioId) {
    var a = porId(DES, desafioId);
    if (!a) return null;
    var ids = [];
    (a.datos || []).forEach(function (r) {
      var f = buscar(r);
      if (f && ids.indexOf(f.inst.id) === -1) ids.push(f.inst.id);
    });
    if (!ids.length) return null;
    var m = medida(), mapa = {}, orden = [];
    ids.forEach(function (id, k) {
      var t = ids.length === 1 ? 0.5 : k / (ids.length - 1);
      var p = { x: m.w * (0.14 + t * 0.72), y: m.h * (0.58 - 0.26 * Math.sin(t * Math.PI)) };
      mapa[id] = p; orden.push(p);
    });
    return { mapa: mapa, orden: orden };
  }

  function vistaRaiz() {
    var m = medida();
    var pv = st.prev ? preview(st.prev) : null;
    var s = pv ? trazo(pv.orden, true) : "";

    INST.forEach(function (i) {
      var n = nDatos(i);
      var d = acotar(18 + n * 1.1, 20, 44);
      var p = norm(i);
      var pos = pv && pv.mapa[i.id] ? pv.mapa[i.id] : { x: m.w * p.x / 100, y: m.h * p.y / 100 };
      // Un solo anillo por institución, proporcional a su tamaño.
      s += orbita(pos.x, pos.y, d / 2 + 14, false);
      s += nodo({
        x: Math.round(pos.x), y: Math.round(pos.y), d: Math.round(d),
        color: i.color, nombre: i.nombre,
        meta: plural(bases(i).length, "base", "bases") + " · " + plural(n, "dato", "datos"),
        desc: i.desc,
        atenuado: !!(pv && !pv.mapa[i.id]),
        attr: 'data-inst="' + esc(i.id) + '"'
      });
    });
    return s;
  }

  function vistaInstitucion() {
    var i = porId(INST, st.inst);
    if (!i) return "";
    var m = medida(), bs = bases(i);
    var cx = m.w / 2, cy = m.h * 0.54;
    var rMax = Math.min(m.w, m.h) * 0.40;
    var rMin = Math.min(rMax - 10, 96);
    var an = anillos(bs.length, rMin, rMax);
    var s = "";

    an.forEach(function (o) { s += orbita(cx, cy, o.r, false); });

    s += '<div class="atlas-centro" style="left:' + cx + "px;top:" + cy + 'px">' +
      '<span class="cuerpo" style="--c:' + esc(i.color) + ';width:46px;height:46px"></span>' +
      "<h3>" + esc(i.nombre) + "</h3><p>" + esc(i.desc) + "</p>" +
      '<span class="meta">' + plural(bs.length, "base", "bases") + " · " +
      plural(nDatos(i), "dato", "datos") + "</span></div>";

    bs.forEach(function (b, k) {
      var n = datos(b).length;
      s += nodo({
        x: Math.round(cx + an[k].r * Math.cos(an[k].a)),
        y: Math.round(cy + an[k].r * Math.sin(an[k].a)),
        d: Math.round(acotar(14 + n * 2, 16, 32)),
        color: i.color, nombre: b.nombre,
        meta: plural(n, "dato", "datos") + (b.desde ? " · desde " + b.desde : ""),
        desc: b.desc,
        attr: 'data-base="' + esc(b.id) + '"'
      });
    });
    return s;
  }

  function vistaBase() {
    var i = porId(INST, st.inst);
    var b = i && porId(bases(i), st.base);
    if (!b) return "";
    var m = medida(), ds = datos(b);
    var cx = m.w * (st.ruta ? 0.40 : 0.5), cy = m.h * 0.54;
    var rMax = Math.min(m.w, m.h) * 0.38;
    var rMin = Math.min(rMax - 10, 92);
    var an = anillos(ds.length, rMin, rMax);
    var s = "";

    an.forEach(function (o) { s += orbita(cx, cy, o.r, false); });

    s += '<div class="atlas-centro" style="left:' + cx + "px;top:" + cy + 'px">' +
      '<span class="cuerpo" style="--c:' + esc(i.color) + ';width:54px;height:54px"></span>' +
      '<h3 class="menor">' + esc(b.nombre) + "</h3><p>" + esc(b.desc) + "</p>" +
      '<span class="meta">' + (b.desde ? "Desde " + esc(b.desde) + " · " : "") +
      plural(ds.length, "dato", "datos") + "</span></div>";

    ds.forEach(function (d, k) {
      var nv = (d.variables || []).length;
      var ruta = i.id + "." + b.id + "." + d.id;
      s += nodo({
        x: Math.round(cx + an[k].r * Math.cos(an[k].a)),
        y: Math.round(cy + an[k].r * Math.sin(an[k].a)),
        d: Math.round(acotar(12 + nv * 1.4, 14, 26)),
        color: i.color, nombre: d.nombre, desc: d.desc,
        activo: st.ruta === ruta,
        attr: 'data-dato="' + esc(ruta) + '"'
      });
    });
    return s;
  }

  function vistaDesafio() {
    var a = porId(DES, st.desafio);
    if (!a) return "";
    var m = medida();
    var fichas = (a.datos || []).map(buscar).filter(Boolean);

    var pts = fichas.map(function (f, k) {
      var t = fichas.length === 1 ? 0.5 : k / (fichas.length - 1);
      return { x: m.w * (0.28 + t * 0.60), y: m.h * (0.52 + (k % 2 ? 0.13 : -0.13)) };
    });

    var s = trazo(pts, false);

    s += '<div class="atlas-cabecera-des"><p class="eyebrow">Ámbito de indagación · ' +
      esc(a.nombre) + "</p><h3>" + esc(a.pregunta) + "</h3></div>";

    fichas.forEach(function (f, k) {
      s += nodo({
        x: Math.round(pts[k].x), y: Math.round(pts[k].y), d: 16,
        color: f.inst.color, nombre: f.dato.nombre, meta: f.inst.nombre,
        desc: f.dato.desc, activo: st.ruta === f.ruta,
        attr: 'data-dato="' + esc(f.ruta) + '"'
      });
    });

    s += '<div class="atlas-lista"><h4>Datos de este ámbito</h4>' +
      fichas.map(function (f) {
        return '<button type="button" data-dato="' + esc(f.ruta) + '">' +
          '<span class="atlas-punto" style="--c:' + esc(f.inst.color) + '"></span>' +
          "<span>" + esc(f.dato.nombre) +
          '<span class="atlas-ruta"><br>' + esc(f.inst.nombre + " · " + f.base.nombre) + "</span></span></button>";
      }).join("") + "</div>";

    return s;
  }

  /* ---------- Ficha ---------- */

  function pintarFicha() {
    if (!st.ruta) { elFicha.hidden = true; elFicha.innerHTML = ""; return; }
    var f = buscar(st.ruta);
    if (!f) { st.ruta = null; elFicha.hidden = true; return; }

    var d = f.dato;
    var vars = d.variables || [];
    var rel = (d.relaciones || []).map(buscar).filter(Boolean);
    var url = d.url || f.base.url;

    var s = '<button type="button" class="cerrar" aria-label="Cerrar la ficha">×</button>';
    s += '<p class="ruta-larga"><span class="atlas-punto" style="--c:' + esc(f.inst.color) + '"></span>' +
      esc(f.inst.nombre + " · " + f.base.nombre) + "</p>";
    s += "<h3>" + esc(d.nombre) + "</h3>";
    s += '<p class="desc">' + esc(d.desc) + "</p>";
    s += '<p class="meta">' + (d.desde ? "Desde " + esc(d.desde) + " · " : "") + esc(d.acceso || "") + "</p>";

    if (vars.length) {
      s += "<h4>Variables</h4><ul class=\"atlas-chips\">" +
        vars.map(function (v) { return "<li>" + esc(v) + "</li>"; }).join("") + "</ul>";
    }

    s += "<h4>Se cruza con</h4>";
    if (rel.length) {
      s += '<div class="atlas-conexiones">' + rel.map(function (r) {
        return '<button type="button" data-dato="' + esc(r.ruta) + '">' +
          '<span class="atlas-punto" style="--c:' + esc(r.inst.color) + '"></span>' +
          "<span>" + esc(r.dato.nombre) +
          '<span class="atlas-ruta"><br>' + esc(r.inst.nombre + " · " + r.base.nombre) + "</span></span></button>";
      }).join("") + "</div>";
    } else {
      s += '<p class="sin">Este dato aún no declara cruces con otros datos del catálogo.</p>';
    }

    if (url) s += '<a class="fuente" href="' + esc(url) + '" target="_blank" rel="noopener">Ir a la fuente →</a>';

    elFicha.innerHTML = s;
    elFicha.hidden = false;
    elFicha.querySelector(".cerrar").addEventListener("click", function () { st.ruta = null; render(); });
  }

  /* ---------- Render ---------- */

  var PIE = {
    raiz: "Haz clic en una institución · rueda para acercar · arrastra para mover",
    institucion: "Haz clic en una base de datos · Esc para volver",
    base: "Haz clic en un dato para ver su ficha · Esc para volver",
    desafio: "Haz clic en un dato para ver su ficha · Esc para volver"
  };

  function render() {
    var html = "";
    if (st.nivel === "raiz") html = vistaRaiz();
    else if (st.nivel === "institucion") html = vistaInstitucion();
    else if (st.nivel === "base") html = vistaBase();
    else if (st.nivel === "desafio") html = vistaDesafio();

    elMapa.innerHTML = '<div class="atlas-vista entra-' + st.dir + '">' + html + "</div>";
    elPie.textContent = PIE[st.nivel] || "";
    pintarMigas();
    pintarFicha();
  }

  /* Delegación única. El guardia de arrastre evita que soltar el
     puntero encima de un nodo, tras mover el mapa, se lea como un
     clic de navegación. */
  var ultimoArrastre = 0;
  document.addEventListener("pointerup", function () {
    if (drag && drag.movido) ultimoArrastre = Date.now();
  }, true);

  raiz.addEventListener("click", function (e) {
    if (Date.now() - ultimoArrastre < 120) return;
    var t = e.target.closest("[data-inst],[data-base],[data-dato]");
    if (!t) return;

    if (t.hasAttribute("data-inst")) {
      ir({ nivel: "institucion", inst: t.getAttribute("data-inst"), base: null, ruta: null }, "in");
      return;
    }
    if (t.hasAttribute("data-base")) {
      ir({ nivel: "base", base: t.getAttribute("data-base"), ruta: null }, "in");
      return;
    }
    var ruta = t.getAttribute("data-dato");
    var f = buscar(ruta);
    if (!f) return;
    if (st.nivel === "desafio" && porId(DES, st.desafio) &&
        (porId(DES, st.desafio).datos || []).indexOf(ruta) !== -1) {
      st.ruta = ruta;
      render();
      return;
    }
    ir({ nivel: "base", inst: f.inst.id, base: f.base.id, ruta: ruta, desafio: null }, "in");
  });

  /* Redibujo al cambiar de tamaño: la geometría está en píxeles. */
  var t0 = null;
  window.addEventListener("resize", function () {
    clearTimeout(t0);
    t0 = setTimeout(function () { st.dir = "in"; render(); }, 160);
  });
  document.addEventListener("fullscreenchange", function () {
    setTimeout(function () { resetVista(); render(); }, 60);
  });

  transform();
  render();
})();
