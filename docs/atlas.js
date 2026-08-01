/* ===========================================================
   Atlas de los datos educativos — tablero de dos mitades
   Área de Monitoreo · SLEP Costa Central

   Dos caras enfrentadas sobre el mismo catálogo:

     izquierda   fuentes, en la jerarquía de tres niveles del
                 contrato: institución → base → dato
     derecha     ámbitos de indagación, una tarjeta por pregunta

   Seleccionar una pieza de cualquiera de las dos caras destaca
   sus contrapartes en la otra y abre su ficha en línea. Los
   cuatro niveles del contrato son alcanzables sin salir del
   tablero.

   Consume las constantes de atlas_datos.js. Contrato del archivo:
   50_documentacion/activa/50_contrato_atlas_datos.md

   Todo el código vive en una IIFE y NO declara ninguna constante
   global: no puede colisionar con PROYECTOS, HITOS, EQUIPO,
   ATLAS_INSTITUCIONES, ATLAS_AMBITOS ni ATLAS_FRASES.

   Sustituye la representación orbital de la sesión 12, descartada
   por el titular. Dos lecciones de esa sesión se conservan como
   restricciones de este archivo: no hay setPointerCapture (BUG-01)
   y no hay geometría circular dependiente del tamaño del
   contenedor (BUG-02). Aquí, sencillamente, no hay geometría.
   =========================================================== */
(function () {
  "use strict";

  var raiz = document.getElementById("atlasCeleste");
  if (!raiz) return;

  var INST = (typeof ATLAS_INSTITUCIONES !== "undefined" && Array.isArray(ATLAS_INSTITUCIONES))
    ? ATLAS_INSTITUCIONES : null;
  var AMB = (typeof ATLAS_AMBITOS !== "undefined" && Array.isArray(ATLAS_AMBITOS))
    ? ATLAS_AMBITOS : [];

  /* Sin catálogo no hay tablero: se dice qué pasó, en vez de dejar
     un contenedor vacío sin explicación. */
  if (!INST || !INST.length) {
    raiz.innerHTML = '<p class="atlas-error">No se pudo cargar el catálogo de fuentes. ' +
                     'La misma información está disponible como tabla más abajo.</p>';
    return;
  }

  /* ---------- utilidades ---------- */

  function esc(s) {
    return String(s == null ? "" : s).replace(/[&<>"]/g, function (m) {
      return { "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;" }[m];
    });
  }
  function porId(lista, id) {
    for (var k = 0; k < lista.length; k++) if (lista[k].id === id) return lista[k];
    return null;
  }
  function plural(n, s, p) { return n + " " + (n === 1 ? s : p); }

  /* Resolutor de rutas de tres segmentos. La unicidad de base y dato
     es por ámbito y no global, así que ningún id sirve como llave por
     sí solo: la llave es la ruta completa. */
  function buscar(ruta) {
    var p = String(ruta || "").split(".");
    if (p.length !== 3) return null;
    var i = porId(INST, p[0]); if (!i) return null;
    var b = porId(i.bases || [], p[1]); if (!b) return null;
    var d = porId(b.datos || [], p[2]); if (!d) return null;
    return { inst: i, base: b, dato: d, ruta: ruta };
  }

  /* ---------- índices ---------- */

  var RUTAS = [];         // toda ruta de dato existente
  var AMB_DE_RUTA = {};   // ruta -> [idAmbito]
  var RUTAS_DE_AMB = {};  // idAmbito -> [ruta que resuelve]
  var nBases = 0, nDatos = 0;

  INST.forEach(function (i) {
    (i.bases || []).forEach(function (b) {
      nBases++;
      (b.datos || []).forEach(function (d) {
        nDatos++;
        RUTAS.push(i.id + "." + b.id + "." + d.id);
      });
    });
  });

  AMB.forEach(function (a) {
    RUTAS_DE_AMB[a.id] = [];
    (a.datos || []).forEach(function (r) {
      if (!buscar(r)) return;   // ruta colgante: no se dibuja
      RUTAS_DE_AMB[a.id].push(r);
      (AMB_DE_RUTA[r] = AMB_DE_RUTA[r] || []).push(a.id);
    });
  });

  var sinAmbito = RUTAS.filter(function (r) { return !AMB_DE_RUTA[r]; }).length;

  /* ---------- esqueleto ---------- */

  raiz.innerHTML =
    '<div class="atlas-barra">' +
      '<span class="at-estado" id="atEstado" role="status" aria-live="polite"></span>' +
      '<span class="at-crece"></span>' +
      '<button type="button" id="atLimpiar" hidden>Limpiar selección</button>' +
    "</div>" +
    '<div class="atlas-tablero">' +
      '<section class="atlas-cara atlas-cara--izq" aria-labelledby="atTitIzq">' +
        "<header>" +
          '<p class="eyebrow">Quién los produce</p>' +
          '<h3 id="atTitIzq">Fuentes</h3>' +
          '<p id="atMetaIzq"></p>' +
        "</header>" +
        '<div class="atlas-scroll" id="atIzq"></div>' +
      "</section>" +
      '<section class="atlas-cara atlas-cara--der" aria-labelledby="atTitDer">' +
        "<header>" +
          '<p class="eyebrow">Para qué preguntar</p>' +
          '<h3 id="atTitDer">Ámbitos de indagación</h3>' +
          '<p id="atMetaDer"></p>' +
        "</header>" +
        '<div class="atlas-scroll" id="atDer"></div>' +
      "</section>" +
    "</div>";

  var elIzq = raiz.querySelector("#atIzq");
  var elDer = raiz.querySelector("#atDer");
  var elEstado = raiz.querySelector("#atEstado");
  var elLimpiar = raiz.querySelector("#atLimpiar");

  raiz.querySelector("#atMetaIzq").textContent =
    plural(INST.length, "institución", "instituciones") + " · " +
    plural(nBases, "base", "bases") + " · " + plural(nDatos, "dato", "datos");
  raiz.querySelector("#atMetaDer").textContent =
    plural(AMB.length, "pregunta", "preguntas") + " que cruzan emisores";

  /* ---------- cara izquierda ---------- */

  function pintarArbol() {
    var html = '<ul class="atlas-arbol">';
    INST.forEach(function (i) {
      var bs = i.bases || [];
      var cd = bs.reduce(function (a, b) { return a + (b.datos || []).length; }, 0);

      html += '<li class="atlas-inst" data-inst="' + esc(i.id) + '" style="--c:' + esc(i.color) + '">' +
        '<button type="button" class="atlas-fila" data-tipo="inst" data-clave="' + esc(i.id) + '" aria-expanded="false">' +
          '<span class="at-caret" aria-hidden="true">&#9654;</span>' +
          '<span class="atlas-punto" aria-hidden="true"></span>' +
          '<span class="at-n">' + esc(i.nombre) + "</span>" +
          '<span class="at-m">' + bs.length + " b · " + cd + " d</span>" +
        "</button>" +
        '<ul class="atlas-hijos">';

      bs.forEach(function (b) {
        var rb = i.id + "." + b.id;
        html += '<li class="atlas-base" data-base="' + esc(rb) + '">' +
          '<button type="button" class="atlas-fila" data-tipo="base" data-clave="' + esc(rb) + '" aria-expanded="false">' +
            '<span class="at-caret" aria-hidden="true">&#9654;</span>' +
            '<span class="at-n">' + esc(b.nombre) + "</span>" +
            '<span class="at-m">desde ' + esc(b.desde) + "</span>" +
          "</button>" +
          '<ul class="atlas-hijos">';

        (b.datos || []).forEach(function (d) {
          var rd = rb + "." + d.id;
          var na = (AMB_DE_RUTA[rd] || []).length;
          html += '<li class="atlas-dato" data-dato="' + esc(rd) + '">' +
            '<button type="button" class="atlas-fila" data-tipo="dato" data-clave="' + esc(rd) + '" aria-pressed="false">' +
              '<span class="at-n">' + esc(d.nombre) + "</span>" +
              (na ? '<span class="at-amb" title="' + esc(plural(na, "ámbito de indagación", "ámbitos de indagación")) + '">' +
                    na + "&#9670;</span>" : "") +
              '<span class="at-m">' + esc(d.desde) + "</span>" +
            "</button></li>";
        });

        html += "</ul></li>";
      });

      html += "</ul></li>";
    });
    elIzq.innerHTML = html + "</ul>";
  }

  /* ---------- cara derecha ---------- */

  function pintarAmbitos() {
    elDer.innerHTML = '<ul class="atlas-ambitos">' + AMB.map(function (a) {
      var rs = RUTAS_DE_AMB[a.id] || [];
      var emisores = {};
      var pts = rs.map(function (r) {
        var n = buscar(r);
        emisores[r.split(".")[0]] = 1;
        return '<i style="--c:' + esc(n ? n.inst.color : "") + '"></i>';
      }).join("");

      return '<li>' +
        '<button type="button" class="atlas-amb" data-amb="' + esc(a.id) + '" ' +
                'data-tipo="ambito" data-clave="' + esc(a.id) + '" aria-pressed="false">' +
          '<span class="at-q">' + esc(a.pregunta) + "</span>" +
          '<span class="at-n">' + esc(a.nombre) + " · " + plural(rs.length, "dato", "datos") +
            " de " + plural(Object.keys(emisores).length, "institución", "instituciones") + "</span>" +
          '<span class="at-pts" aria-hidden="true">' + pts + "</span>" +
        "</button></li>";
    }).join("") + "</ul>";
  }

  /* ---------- estado de selección ---------- */

  var sel = null;   // { tipo: "inst"|"base"|"dato"|"ambito", clave: string }

  function rutasDe(s) {
    if (!s) return [];
    if (s.tipo === "dato") return [s.clave];
    if (s.tipo === "base") return RUTAS.filter(function (r) { return r.indexOf(s.clave + ".") === 0; });
    if (s.tipo === "inst") return RUTAS.filter(function (r) { return r.split(".")[0] === s.clave; });
    if (s.tipo === "ambito") return RUTAS_DE_AMB[s.clave] || [];
    return [];
  }

  function ambitosDe(s, rutas) {
    if (!s) return [];
    if (s.tipo === "ambito") return [s.clave];
    var vistos = {}, out = [];
    rutas.forEach(function (r) {
      (AMB_DE_RUTA[r] || []).forEach(function (a) {
        if (!vistos[a]) { vistos[a] = 1; out.push(a); }
      });
    });
    return out;
  }

  /* ---------- fichas en línea ---------- */

  function enlaceDe(url, texto) {
    if (!url) return "";
    return '<p class="at-enlaces"><a href="' + esc(url) + '" target="_blank" rel="noopener">' +
           esc(texto) + "</a></p>";
  }

  function fichaDato(n) {
    var d = n.dato;
    var rest = d.acceso === "Acceso restringido";
    var vars = (d.variables || []).map(function (v) { return "<li>" + esc(v) + "</li>"; }).join("");
    var rel = (d.relaciones || []).map(function (r) {
      var o = buscar(r);
      if (!o) return "";
      return "<li>" +
        '<button type="button" class="at-ir" data-ir="' + esc(r) + '">' +
          '<span class="atlas-punto" style="--c:' + esc(o.inst.color) + '" aria-hidden="true"></span>' +
          "<span>" + esc(o.dato.nombre) + "</span>" +
          '<span class="at-ruta">' + esc(o.inst.nombre) + " · " + esc(o.base.nombre) + "</span>" +
        "</button></li>";
    }).join("");

    return '<div class="atlas-ficha">' +
      '<p class="at-desc">' + esc(d.desc) + "</p>" +
      '<p class="at-meta">' + esc(n.inst.nombre) + " · " + esc(n.base.nombre) +
        " · serie desde " + esc(d.desde) +
        ' · <span class="at-acceso' + (rest ? " at-acceso--rest" : "") + '">' +
        (rest ? "Acceso restringido" : "Acceso público") + "</span></p>" +
      (vars ? "<h4>Variables</h4><ul class=\"at-vars\">" + vars + "</ul>" : "") +
      (rel ? "<h4>Se cruza con</h4><ul class=\"at-conex\">" + rel + "</ul>"
           : '<p class="at-sin">Sin cruces declarados en el catálogo.</p>') +
      enlaceDe(d.url || n.base.url, "Ir a la fuente") +
      "</div>";
  }

  function fichaBase(i, b) {
    return '<div class="atlas-ficha">' +
      '<p class="at-desc">' + esc(b.desc) + "</p>" +
      '<p class="at-meta">' + esc(i.nombre) + " · " + plural((b.datos || []).length, "dato", "datos") +
        " · serie desde " + esc(b.desde) + "</p>" +
      enlaceDe(b.url, "Ir al portal de la base") +
      "</div>";
  }

  function fichaInst(i) {
    var bs = i.bases || [];
    var cd = bs.reduce(function (a, b) { return a + (b.datos || []).length; }, 0);
    return '<div class="atlas-ficha">' +
      '<p class="at-desc">' + esc(i.desc) + "</p>" +
      '<p class="at-meta">' + plural(bs.length, "base", "bases") + " · " +
        plural(cd, "dato", "datos") + "</p>" +
      "</div>";
  }

  function fichaAmbito(a) {
    var rs = RUTAS_DE_AMB[a.id] || [];
    var lis = rs.map(function (r) {
      var o = buscar(r);
      if (!o) return "";
      return "<li>" +
        '<button type="button" class="at-ir" data-ir="' + esc(r) + '">' +
          '<span class="atlas-punto" style="--c:' + esc(o.inst.color) + '" aria-hidden="true"></span>' +
          "<span>" + esc(o.dato.nombre) + "</span>" +
          '<span class="at-ruta">' + esc(o.inst.nombre) + "</span>" +
        "</button></li>";
    }).join("");
    return '<div class="atlas-ficha">' +
      "<h4>Datos que responden esta pregunta</h4>" +
      '<ul class="at-conex">' + lis + "</ul>" +
      "</div>";
  }

  /* ---------- aplicar la selección ---------- */

  function limpiarPintado() {
    raiz.querySelectorAll(".destacado, .elegido, .rama").forEach(function (n) {
      n.classList.remove("destacado", "elegido", "rama");
    });
    raiz.querySelectorAll(".atlas-ficha").forEach(function (n) { n.remove(); });
    raiz.querySelectorAll('[aria-pressed="true"]').forEach(function (n) {
      n.setAttribute("aria-pressed", "false");
    });
  }

  function abrirRama(li) {
    while (li && li !== raiz) {
      if (li.classList && (li.classList.contains("atlas-inst") || li.classList.contains("atlas-base"))) {
        li.classList.add("abierta");
        var b = li.querySelector(":scope > .atlas-fila");
        if (b) b.setAttribute("aria-expanded", "true");
      }
      li = li.parentNode;
    }
  }

  function aplicar() {
    limpiarPintado();

    if (!sel) {
      raiz.classList.remove("hay-seleccion");
      elLimpiar.hidden = true;
      elEstado.innerHTML =
        plural(nDatos, "dato", "datos") + " de " +
        plural(INST.length, "institución", "instituciones") +
        ' <span class="at-sep">·</span> ' + plural(AMB.length, "ámbito", "ámbitos") +
        ' <span class="at-sep">·</span> ' +
        plural(sinAmbito, "dato sin ámbito", "datos sin ámbito");
      return;
    }

    raiz.classList.add("hay-seleccion");
    elLimpiar.hidden = false;

    var rutas = rutasDe(sel);
    var ambs = ambitosDe(sel, rutas);

    /* contrapartes en la cara izquierda */
    rutas.forEach(function (r) {
      var p = r.split(".");
      var li = elIzq.querySelector('.atlas-dato[data-dato="' + r + '"]');
      if (li) { li.classList.add("destacado"); abrirRama(li.parentNode); }
      var lb = elIzq.querySelector('.atlas-base[data-base="' + p[0] + "." + p[1] + '"]');
      if (lb) lb.classList.add("rama");
      var lin = elIzq.querySelector('.atlas-inst[data-inst="' + p[0] + '"]');
      if (lin) lin.classList.add("rama");
    });

    /* contrapartes en la cara derecha */
    ambs.forEach(function (a) {
      var el = elDer.querySelector('.atlas-amb[data-amb="' + a + '"]');
      if (el) el.classList.add("destacado");
    });

    /* la pieza elegida, con su ficha */
    var etiqueta = "";
    if (sel.tipo === "ambito") {
      var a = porId(AMB, sel.clave);
      var btn = elDer.querySelector('.atlas-amb[data-amb="' + sel.clave + '"]');
      if (btn) {
        btn.classList.add("elegido");
        btn.setAttribute("aria-pressed", "true");
        btn.parentNode.insertAdjacentHTML("beforeend", fichaAmbito(a));
      }
      etiqueta = "Ámbito · " + esc(a ? a.nombre : sel.clave);

    } else if (sel.tipo === "dato") {
      var n = buscar(sel.clave);
      var li = elIzq.querySelector('.atlas-dato[data-dato="' + sel.clave + '"]');
      if (li && n) {
        li.classList.add("elegido");
        abrirRama(li.parentNode);
        li.querySelector(".atlas-fila").setAttribute("aria-pressed", "true");
        li.insertAdjacentHTML("beforeend", fichaDato(n));
      }
      etiqueta = n ? "Dato · " + esc(n.inst.nombre) + " · " + esc(n.dato.nombre) : esc(sel.clave);

    } else if (sel.tipo === "base") {
      var pb = sel.clave.split(".");
      var i2 = porId(INST, pb[0]);
      var b2 = i2 ? porId(i2.bases || [], pb[1]) : null;
      var lb2 = elIzq.querySelector('.atlas-base[data-base="' + sel.clave + '"]');
      if (lb2 && b2) {
        lb2.classList.add("elegido");
        lb2.querySelector(":scope > .atlas-fila").insertAdjacentHTML("afterend", fichaBase(i2, b2));
      }
      etiqueta = "Base · " + esc(i2 ? i2.nombre : pb[0]) + " · " + esc(b2 ? b2.nombre : pb[1]);

    } else {
      var i3 = porId(INST, sel.clave);
      var li3 = elIzq.querySelector('.atlas-inst[data-inst="' + sel.clave + '"]');
      if (li3 && i3) {
        li3.classList.add("elegido");
        li3.querySelector(":scope > .atlas-fila").insertAdjacentHTML("afterend", fichaInst(i3));
      }
      etiqueta = "Institución · " + esc(i3 ? i3.nombre : sel.clave);
    }

    elEstado.innerHTML =
      "<b>" + etiqueta + "</b>" +
      ' <span class="at-sep">·</span> ' + plural(rutas.length, "dato", "datos") +
      " ↔ " + plural(ambs.length, "ámbito", "ámbitos") +
      (ambs.length === 0 ? ' <span class="at-sep">·</span> sin contraparte declarada' : "");
  }

  /* ---------- selección y navegación ---------- */

  function seleccionar(tipo, clave, forzar) {
    if (!forzar && sel && sel.tipo === tipo && sel.clave === clave) {
      /* segundo clic sobre la misma pieza: se deselecciona, y las ramas
         de nivel 1 y 2 se cierran para devolver el árbol a su estado. */
      if (tipo === "inst" || tipo === "base") {
        var attr = tipo === "inst" ? "data-inst" : "data-base";
        var li = elIzq.querySelector("[" + attr + '="' + clave + '"]');
        if (li) {
          li.classList.remove("abierta");
          var b = li.querySelector(":scope > .atlas-fila");
          if (b) b.setAttribute("aria-expanded", "false");
        }
      }
      sel = null;
    } else {
      sel = { tipo: tipo, clave: clave };
      if (tipo === "inst" || tipo === "base") {
        var attr2 = tipo === "inst" ? "data-inst" : "data-base";
        var li2 = elIzq.querySelector("[" + attr2 + '="' + clave + '"]');
        if (li2) abrirRama(li2);
      }
    }
    aplicar();
  }

  function irA(ruta) {
    seleccionar("dato", ruta, true);
    var li = elIzq.querySelector('.atlas-dato[data-dato="' + ruta + '"]');
    if (li) li.scrollIntoView({ block: "nearest", behavior: "smooth" });
  }

  raiz.addEventListener("click", function (e) {
    var ir = e.target.closest("[data-ir]");
    if (ir) { irA(ir.getAttribute("data-ir")); return; }

    if (e.target.closest("a")) return;   // el enlace a la fuente no selecciona

    if (e.target.closest("#atLimpiar")) { sel = null; aplicar(); return; }

    var b = e.target.closest("[data-tipo][data-clave]");
    if (!b) return;
    seleccionar(b.getAttribute("data-tipo"), b.getAttribute("data-clave"), false);
  });

  document.addEventListener("keydown", function (e) {
    if (e.key !== "Escape" || !sel) return;
    if (!raiz.contains(document.activeElement)) return;
    sel = null;
    aplicar();
  });

  /* ---------- arranque ---------- */

  pintarArbol();
  pintarAmbitos();
  aplicar();
})();
