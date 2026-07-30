/* ===========================================================
   Formación en uso de datos educativos — tabla de fuentes
   Aplana el catálogo del atlas (ATLAS_INSTITUCIONES) a una fila
   por dato y la filtra en el cliente. Vanilla JS, sin dependencias.

   El catálogo es la misma fuente que consumirá el atlas: la tabla no
   tiene datos propios. Contrato del archivo:
   50_documentacion/activa/50_contrato_atlas_datos.md
   =========================================================== */
(function () {
  "use strict";

  var $ = function (s) { return document.querySelector(s); };
  var esc = function (s) {
    return String(s == null ? "" : s).replace(/[&<>"]/g, function (m) {
      return { "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;" }[m];
    });
  };

  var cuerpo = $("#fmCuerpo");
  if (!cuerpo) return;

  /* Sin catálogo no hay tabla que filtrar: se dice qué pasó, en vez de
     dejar una sección vacía sin explicación. */
  if (typeof ATLAS_INSTITUCIONES === "undefined" || !Array.isArray(ATLAS_INSTITUCIONES)) {
    $("#fmResumen").textContent = "No se pudo cargar el catálogo de fuentes.";
    return;
  }

  /* ---------- aplanado: una fila por dato ---------- */

  var FILAS = [];
  ATLAS_INSTITUCIONES.forEach(function (inst) {
    (inst.bases || []).forEach(function (base) {
      (base.datos || []).forEach(function (dato) {
        FILAS.push({
          ruta: inst.id + "." + base.id + "." + dato.id,
          dato: dato.nombre,
          desc: dato.desc,
          variables: dato.variables || [],
          relaciones: dato.relaciones || [],
          desde: dato.desde,
          acceso: dato.acceso,
          institucion: inst.nombre,
          institucionId: inst.id,
          color: inst.color,
          base: base.nombre,
          /* El enlace del dato cae al de su base cuando no tiene uno
             propio: es la misma resolución que hace el atlas. */
          url: dato.url || base.url || ""
        });
      });
    });
  });

  var AMBITOS = (typeof ATLAS_AMBITOS !== "undefined" && Array.isArray(ATLAS_AMBITOS)) ? ATLAS_AMBITOS : [];

  /* Texto de búsqueda precalculado: se normaliza una vez y no en cada
     pulsación de tecla. Sin acentos, para que "matricula" encuentre
     "matrícula". */
  var normalizar = function (s) {
    return String(s).toLowerCase().normalize("NFD").replace(/[\u0300-\u036f]/g, "");
  };
  FILAS.forEach(function (f) {
    f._busca = normalizar([f.dato, f.institucion, f.base, f.desc, f.variables.join(" ")].join(" "));
  });

  /* ---------- poblar los selectores ---------- */

  var selInst = $("#fmInstitucion");
  ATLAS_INSTITUCIONES.forEach(function (inst) {
    var o = document.createElement("option");
    o.value = inst.id;
    o.textContent = inst.nombre;
    selInst.appendChild(o);
  });

  var selAmb = $("#fmAmbito");
  AMBITOS.forEach(function (a) {
    var o = document.createElement("option");
    o.value = a.id;
    o.textContent = a.nombre;
    selAmb.appendChild(o);
  });

  /* ---------- render ---------- */

  var vacio = $("#fmVacio");
  var resumen = $("#fmResumen");
  var pregunta = $("#fmPregunta");
  var tabla = $("#fmTabla");

  function fila(f) {
    var tr = document.createElement("tr");
    var claseAcceso = f.acceso === "Acceso restringido" ? "fm-acceso fm-acceso--rest" : "fm-acceso";
    var etiqueta = f.acceso === "Acceso restringido" ? "Restringido" : "Público";
    tr.innerHTML =
      '<th scope="row" class="fm-dato">' +
        '<span class="fm-punto" style="background:' + esc(f.color) + '" aria-hidden="true"></span>' +
        '<span class="fm-dato-nombre">' + esc(f.dato) + "</span>" +
        '<span class="fm-dato-desc">' + esc(f.desc) + "</span>" +
        (f.variables.length
          ? '<span class="fm-vars">' + f.variables.map(function (v) {
              return '<span class="fm-var">' + esc(v) + "</span>";
            }).join("") + "</span>"
          : "") +
      "</th>" +
      "<td>" + esc(f.institucion) + "</td>" +
      "<td>" + esc(f.base) + "</td>" +
      '<td class="fm-col-anio">' + esc(f.desde) + "</td>" +
      '<td><span class="' + claseAcceso + '">' + etiqueta + "</span></td>" +
      "<td>" + (f.url
        ? '<a href="' + esc(f.url) + '" target="_blank" rel="noopener">Ir a la fuente</a>'
        : '<span class="fm-sin-url">Sin enlace</span>') + "</td>";
    return tr;
  }

  function pintar(lista) {
    cuerpo.innerHTML = "";
    lista.forEach(function (f) { cuerpo.appendChild(fila(f)); });

    var hay = lista.length > 0;
    vacio.hidden = hay;
    tabla.hidden = !hay;

    var n = lista.length, total = FILAS.length;
    resumen.textContent = n === total
      ? total + " fuentes de " + ATLAS_INSTITUCIONES.length + " instituciones"
      : n + " de " + total + " fuentes";
  }

  /* ---------- filtrado ---------- */

  var iBuscar = $("#fmBuscar");
  var iAcceso = $("#fmAcceso");

  function filtrar() {
    var q = normalizar(iBuscar.value.trim());
    var inst = selInst.value;
    var acc = iAcceso.value;
    var amb = selAmb.value;

    var rutasAmbito = null;
    var elAmbito = amb ? AMBITOS.filter(function (a) { return a.id === amb; })[0] : null;
    if (elAmbito) rutasAmbito = elAmbito.datos || [];

    if (elAmbito) {
      pregunta.textContent = elAmbito.pregunta;
      pregunta.hidden = false;
    } else {
      pregunta.hidden = true;
    }

    pintar(FILAS.filter(function (f) {
      if (q && f._busca.indexOf(q) === -1) return false;
      if (inst && f.institucionId !== inst) return false;
      if (acc && f.acceso !== acc) return false;
      if (rutasAmbito && rutasAmbito.indexOf(f.ruta) === -1) return false;
      return true;
    }));
  }

  /* La búsqueda se aplica al soltar la tecla; con 52 filas no hace falta
     debounce, y agregarlo introduciría un retardo perceptible sin motivo. */
  iBuscar.addEventListener("input", filtrar);
  selInst.addEventListener("change", filtrar);
  iAcceso.addEventListener("change", filtrar);
  selAmb.addEventListener("change", filtrar);

  $("#fmLimpiar").addEventListener("click", function () {
    iBuscar.value = "";
    selInst.value = "";
    iAcceso.value = "";
    selAmb.value = "";
    filtrar();
    iBuscar.focus();
  });

  filtrar();
})();
