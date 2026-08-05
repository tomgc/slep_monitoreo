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

  var DESAFIOS = (typeof ATLAS_DESAFIOS !== "undefined" && Array.isArray(ATLAS_DESAFIOS)) ? ATLAS_DESAFIOS : [];

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

  var selDes = $("#fmDesafio");
  DESAFIOS.forEach(function (a) {
    var o = document.createElement("option");
    o.value = a.id;
    o.textContent = a.nombre;
    selDes.appendChild(o);
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
    var des = selDes.value;

    var rutasDesafio = null;
    var elDesafio = des ? DESAFIOS.filter(function (a) { return a.id === des; })[0] : null;
    if (elDesafio) rutasDesafio = elDesafio.datos || [];

    if (elDesafio) {
      pregunta.textContent = elDesafio.pregunta;
      pregunta.hidden = false;
    } else {
      pregunta.hidden = true;
    }

    pintar(FILAS.filter(function (f) {
      if (q && f._busca.indexOf(q) === -1) return false;
      if (inst && f.institucionId !== inst) return false;
      if (acc && f.acceso !== acc) return false;
      if (rutasDesafio && rutasDesafio.indexOf(f.ruta) === -1) return false;
      return true;
    }));
  }

  /* La búsqueda se aplica al soltar la tecla; con 52 filas no hace falta
     debounce, y agregarlo introduciría un retardo perceptible sin motivo. */
  iBuscar.addEventListener("input", filtrar);
  selInst.addEventListener("change", filtrar);
  iAcceso.addEventListener("change", filtrar);
  selDes.addEventListener("change", filtrar);

  $("#fmLimpiar").addEventListener("click", function () {
    iBuscar.value = "";
    selInst.value = "";
    iAcceso.value = "";
    selDes.value = "";
    filtrar();
    iBuscar.focus();
  });

  filtrar();
})();


/* ===========================================================
   Recorrido del elemento 2 — «De la pregunta a la respuesta»
   Unidad independiente de la tabla: su propio ambito, su propia
   guarda temprana. Un fallo aqui no se lleva la tabla, ni al reves.
   Traslado literal de 50_documentacion/andamios/
   20260803_maqueta_elemento2_v2.html (maqueta aprobada).
   =========================================================== */
(function () {
  "use strict";

  var $ = function (s) { return document.querySelector(s); };
  var esc = function (s) {
    return String(s == null ? "" : s).replace(/[&<>"]/g, function (m) {
      return { "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;" }[m];
    });
  };

  var fila = $("#fmRutaFila");
  var globo = $("#fmRutaGlobo");
  var mapa = $("#fmRutaMapa");

  /* Guarda temprana: sin contenedor no hay objeto que montar. */
  if (!fila || !globo) return;

  /* ---------- d(): contenido literal de la §1 de la especificacion ----------
     Traslado del objeto de datos del prototipo, con las decisiones del
     titular aplicadas: sin el bloque nota del paso 4 (decision 3) y sin
     el pasaje del bucle sobre proyecciones y reporteria. */
  var T = function (t) { return [{ t: t }]; };

  var D = {
    orden: ["p1", "p2", "dA", "p3", "dB", "p4", "dC", "p5", "p6", "loop"],
    el: {
      p1: { tipo: "paso", num: "1", titulo: "Llega la pregunta", rotulo: "En el lenguaje de quien la formula", cuerpo: T("La pregunta llega desde un espacio de trabajo compartido con otras áreas del Servicio, con la dirección o con las comunidades educativas. Llega en el lenguaje de quien la formula, no en el de los datos. Nuestra primera tarea no es responderla: es entenderla. Preguntamos a qué decisión va a servir la respuesta.") },
      p2: { tipo: "paso", num: "2", titulo: "La traducimos a algo observable", rotulo: "Qué, sobre quiénes y en qué período", cuerpo: T("Traducir la pregunta significa acordar tres cosas: qué queremos observar, sobre quiénes y en qué período."), vocab: [{ t: "Llamamos " }, { b: "unidad de observación" }, { t: " a la respuesta de la segunda pregunta. No es lo mismo observar estudiantes, cursos, establecimientos o comunas: cada una responde cosas distintas y ninguna sustituye a las otras." }] },
      dA: { tipo: "dec", nombre: "Primera decisión", pregunta: "¿La pregunta admite una respuesta con datos?", ramas: [
        { id: "si", label: "Sí", sigue: true, cuerpo: T("Existe algo observable y registrado que se relaciona con la pregunta. El recorrido sigue.") },
        { id: "no", label: "No, o no todavía", sigue: false, cuerpo: T("La pregunta pide una explicación que ningún registro contiene, o mezcla varias preguntas distintas. Volvemos a quien la formuló con lo que sí puede responderse y con lo que quedaría fuera. Es un resultado legítimo, no un fracaso.") }
      ] },
      p3: { tipo: "paso", num: "3", titulo: "Buscamos si el dato existe", rotulo: "Dónde vive lo que necesitamos", cuerpo: T("Con la pregunta traducida, buscamos dónde vive lo que necesitamos.") },
      dB: { tipo: "dec", nombre: "Segunda decisión", pregunta: "¿Dónde está el dato?", ramas: [
        { id: "pub", label: "En una fuente pública oficial", sigue: true, cuerpo: T("Ministerio de Educación, Agencia de Calidad, Junaeb, Junji y otras instituciones publican información del sistema escolar. Saber qué publica cada una, con qué cobertura y cada cuánto, es la mitad del trabajo.") },
        { id: "int", label: "En los sistemas del propio Servicio", sigue: true, cuerpo: T("Parte de lo que necesitamos existe solo en nuestros registros de gestión.") },
        { id: "nex", label: "No existe", sigue: false, cuerpo: T("Evaluamos si es factible levantarlo con un instrumento propio. Si no es factible, lo declaramos: hay preguntas cuya respuesta hoy no está disponible, y decirlo también es un aporte.") }
      ] },
      p4: { tipo: "paso", num: "4", titulo: "Evaluamos si la fuente sirve", rotulo: "Cobertura, periodicidad, unidad, comparabilidad", cuerpo: T("Que un dato exista no significa que responda lo que se preguntó. Revisamos cuatro cosas antes de usarlo: cobertura (a quiénes incluye y a quiénes deja fuera), periodicidad (cada cuánto se actualiza), unidad de observación (si coincide con la acordada en el paso 2) y comparabilidad (si el dato de este año significa lo mismo que el de hace cinco)."), vocab: [{ t: "Un " }, { b: "dato agregado" }, { t: " ya viene resumido (un promedio, un total por establecimiento). Un " }, { b: "microdato" }, { t: " trae un registro por cada caso observado." }] },
      dC: { tipo: "dec", nombre: "Tercera decisión", pregunta: "¿Una sola fuente basta?", ramas: [
        { id: "si", label: "Sí", sigue: true, cuerpo: T("El recorrido continúa directo al paso 5.") },
        { id: "unir", label: "No: hay que unir fuentes", sigue: true, cuerpo: [{ t: "Necesitamos un " }, { b: "identificador de unión" }, { t: ", una llave que exista en ambas y signifique lo mismo en las dos. Si no existe, no forzamos la unión: analizamos cada fuente por separado y declaramos que son observaciones paralelas." }] }
      ] },
      p5: { tipo: "paso", num: "5", titulo: "Procesamos y verificamos", rotulo: "Desconfiar de los propios resultados", cuerpo: T("Aquí ocurre el trabajo técnico: ordenar, limpiar, calcular. Y con él, el control de calidad. Un resultado que no sabemos reproducir no sale del Área.") },
      p6: { tipo: "paso", num: "6", titulo: "Interpretamos y entregamos", rotulo: "Con los límites declarados", cuerpo: T("Un número no habla solo. Entregamos la respuesta con sus límites declarados: qué afirma, qué no afirma y con qué grado de certeza. Y con una compuerta previa: revisamos que lo que se entrega respete lo que corresponde proteger de las comunidades educativas.") },
      loop: { tipo: "loop", titulo: "¿Cómo seguimos?", rotulo: "Casi siempre, vuelve al paso 1", cuerpo: T("Casi siempre la respuesta abre una pregunta nueva y el recorrido vuelve al paso 1, ahora con una pregunta mejor formulada. Cuando la cierra, el producto queda disponible y documentado para que otro equipo pueda reutilizarlo.") }
    }
  };

  var PIE = {
    paso: "Haz clic en un paso para ver su detalle",
    dec: "aquí el camino se abre",
    loop: "Del paso 6 al paso 1 · un resultado del trabajo, no una decisión"
  };

  /* ---------- bGeo(): traslado literal del prototipo ---------- */
  function bGeo() {
    var orden = D.orden, el = D.el;
    var x = 0;
    var c = {};
    orden.filter(function (i) { return i !== "loop"; }).forEach(function (id) {
      var w = el[id].tipo === "dec" ? 176 : 136;
      c[id] = x + w / 2;
      x += w + 8;
    });
    c["loop"] = x + 60;
    x += 128;
    c._w = x - 8;
    return c;
  }

  /* ---------- estado: sel y ramas. Sin pfx, sin rama a*. ----------
     rutaPersistente y controlesGuiados quedan fijos en true. */
  var sel = "p1";
  var ramas = {};

  function seg(arr) {
    return (arr || []).map(function (s) {
      return s.b ? "<strong>" + esc(s.b) + "</strong>" : esc(s.t);
    }).join("");
  }

  /* ---------- render del mapa por concatenacion ---------- */
  function pintarFila() {
    var html = D.orden.filter(function (i) { return i !== "loop"; }).map(function (id) {
      var d = D.el[id];
      var act = sel === id;

      if (d.tipo === "paso") {
        var aria = "Paso " + d.num + ": " + d.titulo;
        return '<button type="button" class="fm-ruta-paso' + (act ? " fm-ruta-paso--activo" : "") +
          '" data-nodo="' + esc(id) + '" aria-pressed="' + act + '" aria-label="' + esc(aria) + '">' +
          '<span class="fm-ruta-paso-num">' + esc(d.num) + "</span>" +
          '<span class="fm-ruta-paso-titulo">' + esc(d.titulo) + "</span>" +
          '<span class="fm-ruta-paso-rotulo">' + esc(d.rotulo) + "</span>" +
          "</button>";
      }

      var chips = d.ramas.map(function (r) {
        var cAct = ramas[id] === r.id;
        var marca = r.sigue
          ? '<span class="fm-ruta-chip-marca--sigue" aria-hidden="true">→</span>'
          : '<span class="fm-ruta-chip-marca--detiene" aria-hidden="true"></span>';
        var cAria = r.label + " — " + (r.sigue ? "el recorrido sigue" : "se detiene aquí");
        return '<button type="button" class="fm-ruta-chip' + (cAct ? " fm-ruta-chip--elegida" : "") +
          '" data-chip="' + esc(r.id) + '" data-dec="' + esc(id) + '"' +
          ' aria-pressed="' + cAct + '" aria-label="' + esc(cAria) + '">' +
          '<span class="fm-ruta-chip-label">' + esc(r.label) + "</span>" + marca +
          "</button>";
      }).join("");

      var dAria = d.nombre + ": " + d.pregunta;
      return '<div class="fm-ruta-dec' + (act ? " fm-ruta-dec--activa" : "") + '">' +
        '<button type="button" class="fm-ruta-dec-cab" data-nodo="' + esc(id) + '"' +
        ' aria-pressed="' + act + '" aria-label="' + esc(dAria) + '">' +
        '<span class="fm-ruta-dec-fila">' +
        '<span class="fm-ruta-dec-rombo" aria-hidden="true"></span>' +
        '<span class="fm-ruta-dec-nombre">' + esc(d.nombre) + "</span></span>" +
        '<span class="fm-ruta-dec-pregunta">' + esc(d.pregunta) + "</span>" +
        "</button>" +
        '<div class="fm-ruta-chips">' + chips + "</div>" +
        "</div>";
    }).join("");

    var l = D.el.loop;
    var lAct = sel === "loop";
    html += '<button type="button" class="fm-ruta-loop' + (lAct ? " fm-ruta-loop--activo" : "") +
      '" data-nodo="loop" aria-pressed="' + lAct + '"' +
      ' aria-label="¿Cómo seguimos?: casi siempre el recorrido vuelve al paso 1">' +
      '<span class="fm-ruta-loop-glifo" aria-hidden="true">←</span>' +
      '<span class="fm-ruta-loop-titulo">' + esc(l.titulo) + "</span>" +
      '<span class="fm-ruta-loop-rotulo">' + esc(l.rotulo) + "</span>" +
      "</button>";

    fila.innerHTML = html;
  }

  /* ---------- render del globo ---------- */
  function pintarGlobo() {
    var d = D.el[sel];
    var kicker, titulo, cuerpo = "";
    var hayVocab = false, sinRama = false, hayRama = false;

    if (d.tipo === "paso") {
      kicker = "Paso " + d.num + " · " + d.rotulo;
      titulo = d.titulo;
      cuerpo = seg(d.cuerpo);
      hayVocab = !!d.vocab;
    } else if (d.tipo === "loop") {
      kicker = PIE.loop;
      titulo = d.titulo;
      cuerpo = seg(d.cuerpo);
    } else {
      kicker = d.nombre + " · " + PIE.dec;
      titulo = d.pregunta;
      var r = null;
      d.ramas.forEach(function (x) { if (x.id === ramas[sel]) r = x; });
      if (r) {
        hayRama = true;
        $("#fmRutaRama").innerHTML = esc(r.label) +
          ' <span class="fm-ruta-rama-marca">· ' +
          (r.sigue ? "el recorrido sigue" : "se detiene aquí") + "</span>";
        $("#fmRutaRamaCuerpo").innerHTML = seg(r.cuerpo);
      } else {
        sinRama = true;
      }
    }

    $("#fmRutaKicker").textContent = kicker;
    $("#fmRutaGloboTitulo").textContent = titulo;
    $("#fmRutaCuerpo").innerHTML = cuerpo;
    if (hayVocab) $("#fmRutaVocabCuerpo").innerHTML = seg(d.vocab);

    /* Visibilidad por la propiedad hidden, nunca por clases ni display. */
    $("#fmRutaCuerpo").hidden = !cuerpo;
    $("#fmRutaVocab").hidden = !hayVocab;
    $("#fmRutaInstruccion").hidden = !sinRama;
    $("#fmRutaRama").hidden = !hayRama;
    $("#fmRutaRamaCuerpo").hidden = !hayRama;

    /* Anclaje: traslado literal de renderVals() del prototipo. */
    var geo = bGeo();
    var bc = geo[sel] !== undefined ? geo[sel] : geo._w / 2;
    var bLeft = Math.min(Math.max(bc - 280, 0), geo._w - 560);
    var bNotch = Math.min(Math.max(bc - bLeft - 6, 14), 534);
    globo.style.marginLeft = bLeft + "px";
    $("#fmRutaMuesca").style.left = bNotch + "px";

    /* Centrado del plano desplazable sobre el nodo elegido. La tarjeta es
       mas angosta que la pista, de modo que sin esto el globo puede quedar
       fuera de vista tras un clic. La suavidad la pone `scroll-behavior`,
       que la media query de movimiento reducido desactiva. */
    if (mapa) {
      var visible = mapa.clientWidth;
      mapa.scrollLeft = Math.max(0, Math.min(bc - visible / 2, geo._w - visible));
    }

    var i = D.orden.indexOf(sel);
    $("#fmRutaPos").textContent = (i + 1) + " de " + D.orden.length;
    $("#fmRutaPrev").disabled = i <= 0;
    $("#fmRutaNext").disabled = i >= D.orden.length - 1;
  }

  /* ---------- conector de retorno (decision 4 del titular) ----------
     Origen: centro de la tarjeta del bucle, que bGeo() devuelve como
     c['loop']. El paso 6 no es origen del trazo. Destino: centro de la
     ficha del paso 1. Ancho del viewBox: el ancho de pista que bGeo()
     calcula en _w. Ningun numero de la geometria se escribe en el marcado.

     El svg va absoluto con bottom:0 dentro de la pista, cuyo padding
     inferior lo aloja: queda integramente bajo la fila de nodos, de modo
     que no cruza ninguna caja. */
  function pintarRetorno() {
    var svg = $("#fmRutaRetorno");
    if (!svg) return;

    var geo = bGeo();
    var xIni = geo["loop"];   // centro de la tarjeta «¿Cómo seguimos?»
    var xFin = geo.p1;        // centro de la ficha del paso 1
    var ancho = geo._w;

    var alto = 26, r = 4;
    var yBaja = 14, yCorre = 18, ySube = 7, yPunta = 5, yAla = 11;

    svg.setAttribute("viewBox", "0 0 " + ancho + " " + alto);
    svg.setAttribute("width", ancho);
    svg.setAttribute("height", alto);

    svg.innerHTML =
      '<path d="M ' + xIni + " 0 V " + yBaja +
      " A " + r + " " + r + " 0 0 1 " + (xIni - r) + " " + yCorre +
      " H " + (xFin + r) +
      " A " + r + " " + r + " 0 0 1 " + xFin + " " + yBaja +
      " V " + ySube + '" />' +
      '<polyline points="' + (xFin - r) + "," + yAla + " " +
      xFin + "," + yPunta + " " + (xFin + r) + "," + yAla + '" />';
  }

  function pintar() { pintarFila(); pintarGlobo(); }

  /* ---------- un solo listener sobre el contenedor del mapa ---------- */
  $("#fmRutaMapa").addEventListener("click", function (e) {
    var chip = e.target.closest("[data-chip]");
    if (chip) {
      ramas[chip.getAttribute("data-dec")] = chip.getAttribute("data-chip");
      sel = chip.getAttribute("data-dec");
      pintar();
      return;
    }
    var nodo = e.target.closest("[data-nodo]");
    if (!nodo) return;
    sel = nodo.getAttribute("data-nodo");
    pintar();
  });

  $("#fmRutaPrev").addEventListener("click", function () {
    var i = D.orden.indexOf(sel);
    if (i > 0) { sel = D.orden[i - 1]; pintar(); }
  });

  $("#fmRutaNext").addEventListener("click", function () {
    var i = D.orden.indexOf(sel);
    if (i < D.orden.length - 1) { sel = D.orden[i + 1]; pintar(); }
  });

  pintarRetorno();
  pintar();
}());
