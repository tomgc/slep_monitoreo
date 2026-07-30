#!/usr/bin/env node
/* ===========================================================
   Validador del catálogo del Atlas Celeste
   -----------------------------------------------------------
   Verifica un archivo de catálogo contra el contrato de datos
   (50_documentacion/activa/50_contrato_atlas_datos.md).

   Uso:  node 00_validar_atlas.js docs/atlas_datos.js

   Devuelve 0 si el archivo es consumible por el sitio y 1 si no.
   Distingue ERROR (bloquea el depósito) de AVISO (no bloquea).

   Qué NO hace: no comprueba que las URL resuelvan, ni que los
   años o las descripciones sean ciertos. Valida forma e
   integridad referencial; la veracidad la revisa el titular.

   Node y no R porque el artefacto validado es el mismo archivo
   que el navegador ejecutará: se carga con el intérprete real
   del sitio, no con una reimplementación del parseo.
   =========================================================== */
"use strict";

const fs = require("fs");
const path = require("path");
const vm = require("vm");

const ACCESO_VALIDO = ["Acceso público", "Acceso restringido"];
const RE_ID = /^[a-z0-9]+(-[a-z0-9]+)*$/;
const RE_HEX = /^#[0-9A-Fa-f]{6}$/;
const RE_URL = /^https:\/\/[^\s"']+$/;
const VARS_MIN = 2, VARS_MAX = 8;
const DATOS_AMBITO_MIN = 3, DATOS_AMBITO_MAX = 8;
const DIST_MIN = 12;
const X_MIN = 30, X_MAX = 88, Y_MIN = 12, Y_MAX = 88;
const ANIO_MIN = 1900;

const errores = [];
const avisos = [];
const err = (donde, msg) => errores.push(donde + ": " + msg);
const avi = (donde, msg) => avisos.push(donde + ": " + msg);

/* ---------- carga ---------- */

const archivo = process.argv[2];
if (!archivo) {
  console.error("Uso: node 00_validar_atlas.js <ruta al catalogo>");
  process.exit(1);
}
const ruta = path.resolve(archivo);
if (!fs.existsSync(ruta)) {
  console.error("No existe el archivo: " + ruta);
  process.exit(1);
}

let fuente = fs.readFileSync(ruta, "utf8");

/* Un `export` o un `import` haría fallar al navegador con SyntaxError,
   porque el sitio carga los scripts sin type="module". Se detecta aquí
   antes de evaluar, no después. */
if (/^\s*export\s/m.test(fuente)) {
  err("archivo", "usa `export`; el sitio carga scripts clásicos y fallaría con SyntaxError");
}
if (/^\s*import\s/m.test(fuente) || /\bimport\s*\(/.test(fuente)) {
  err("archivo", "usa `import`; el catálogo debe ser un script plano sin dependencias");
}

const ctx = {};
vm.createContext(ctx);
let INST, AMB, FRASES;
try {
  vm.runInContext(
    fuente.replace(/^\s*export\s+/gm, "") +
    "\nthis.__I = typeof ATLAS_INSTITUCIONES !== 'undefined' ? ATLAS_INSTITUCIONES : undefined;" +
    "\nthis.__A = typeof ATLAS_AMBITOS !== 'undefined' ? ATLAS_AMBITOS : undefined;" +
    "\nthis.__F = typeof ATLAS_FRASES !== 'undefined' ? ATLAS_FRASES : undefined;",
    ctx,
    { timeout: 5000 }
  );
  INST = ctx.__I; AMB = ctx.__A; FRASES = ctx.__F;
} catch (e) {
  console.error("El archivo no es JavaScript evaluable:\n  " + e.message);
  process.exit(1);
}

if (!Array.isArray(INST)) err("archivo", "no declara ATLAS_INSTITUCIONES como arreglo");
if (!Array.isArray(AMB)) err("archivo", "no declara ATLAS_AMBITOS como arreglo");
if (!FRASES || typeof FRASES !== "object") err("archivo", "no declara ATLAS_FRASES como objeto");

if (errores.length) { informar(); process.exit(1); }

/* ---------- helpers ---------- */

const texto = (v) => typeof v === "string" && v.trim().length > 0;
const anio = (v) => Number.isInteger(v) && v >= ANIO_MIN && v <= new Date().getFullYear();

function unicos(lista, donde, que) {
  const vistos = new Set(), dup = new Set();
  lista.forEach((v) => (vistos.has(v) ? dup.add(v) : vistos.add(v)));
  if (dup.size) err(donde, que + " duplicado(s): " + [...dup].join(", "));
}

/* ---------- instituciones, bases y datos ---------- */

const rutas = new Set();
const relacionesPorRuta = new Map();

unicos(INST.map((i) => i.id), "instituciones", "id");

INST.forEach((I, iIdx) => {
  const dI = "institucion[" + (I.id || iIdx) + "]";
  if (!texto(I.id) || !RE_ID.test(I.id)) err(dI, "id ausente o con formato inválido (minúsculas, dígitos y guion medio)");
  if (!texto(I.nombre)) err(dI, "nombre ausente");
  if (!texto(I.desc)) err(dI, "desc ausente");
  if (!RE_HEX.test(I.color || "")) err(dI, "color ausente o no es un hex de 6 dígitos");
  if (typeof I.x !== "number" || typeof I.y !== "number") err(dI, "x/y ausentes o no numéricos");
  else {
    if (I.x === 0 && I.y === 0) avi(dI, "sin ubicación asignada (0,0): pendiente de decisión de diseño");
    else if (I.x < X_MIN || I.x > X_MAX || I.y < Y_MIN || I.y > Y_MAX)
      err(dI, "x/y fuera del rango permitido (x " + X_MIN + "-" + X_MAX + ", y " + Y_MIN + "-" + Y_MAX + ")");
  }
  if ("tipo" in I) avi(dI, "conserva el campo legado `tipo`; el contrato lo elimina");
  if (Array.isArray(I.planetas)) err(dI, "usa `planetas`; el contrato lo renombró a `bases`");

  if (!Array.isArray(I.bases) || !I.bases.length) { err(dI, "sin `bases`"); return; }
  unicos(I.bases.map((b) => b.id), dI, "id de base");

  I.bases.forEach((B, bIdx) => {
    const dB = dI + ".base[" + (B.id || bIdx) + "]";
    if (!texto(B.id) || !RE_ID.test(B.id)) err(dB, "id ausente o con formato inválido");
    if (!texto(B.nombre)) err(dB, "nombre ausente");
    if (!texto(B.desc)) err(dB, "desc ausente");
    if (!anio(B.desde)) err(dB, "desde ausente o no es un año entero válido");
    if (!RE_URL.test(B.url || "")) err(dB, "url ausente o no comienza con https://");
    if (Array.isArray(B.satelites)) err(dB, "usa `satelites`; el contrato lo renombró a `datos`");

    if (!Array.isArray(B.datos) || !B.datos.length) { err(dB, "sin `datos`"); return; }
    unicos(B.datos.map((d) => d.id), dB, "id de dato");

    B.datos.forEach((D, dIdx) => {
      const dD = dB + ".dato[" + (D.id || dIdx) + "]";
      if (!texto(D.id) || !RE_ID.test(D.id)) err(dD, "id ausente o con formato inválido");
      if (!texto(D.nombre)) err(dD, "nombre ausente");
      if (!texto(D.desc)) err(dD, "desc ausente");
      if (!anio(D.desde)) err(dD, "desde ausente o no es un año entero válido");
      /* Un portal puede publicar series anteriores a su propia creación
         (Datos Abiertos existe desde 2004 y publica rendimiento desde 2002).
         Se avisa para que el revisor confirme, no se bloquea. */
      else if (anio(B.desde) && D.desde < B.desde)
        avi(dD, "desde (" + D.desde + ") es anterior al de su base (" + B.desde + "); confirmar que la base publica serie histórica previa");
      if (ACCESO_VALIDO.indexOf(D.acceso) === -1)
        err(dD, "acceso debe ser exactamente uno de: " + ACCESO_VALIDO.map((a) => '"' + a + '"').join(" o "));
      if (!Array.isArray(D.variables)) err(dD, "variables ausente");
      else {
        if (D.variables.length < VARS_MIN || D.variables.length > VARS_MAX)
          err(dD, "tiene " + D.variables.length + " variables; el contrato pide entre " + VARS_MIN + " y " + VARS_MAX);
        if (D.variables.some((v) => !texto(v))) err(dD, "alguna variable está vacía o no es texto");
        if (D.variables.some((v) => typeof v === "string" && v.length > 60))
          avi(dD, "alguna variable parece una oración y no un nombre de variable");
      }
      if ("url" in D && !RE_URL.test(D.url || "")) err(dD, "url presente pero no comienza con https://");
      if (!Array.isArray(D.relaciones)) err(dD, "relaciones ausente (puede ir vacío, pero debe existir)");

      const r = I.id + "." + B.id + "." + D.id;
      rutas.add(r);
      relacionesPorRuta.set(r, Array.isArray(D.relaciones) ? D.relaciones.slice() : []);
    });
  });
});

/* ---------- integridad referencial ---------- */

relacionesPorRuta.forEach((rels, origen) => {
  rels.forEach((destino) => {
    if (typeof destino !== "string" || destino.split(".").length !== 3) {
      err("relacion", origen + " -> " + destino + ": la ruta debe tener tres segmentos");
      return;
    }
    if (!rutas.has(destino)) { err("relacion", origen + " -> " + destino + ": el destino no existe"); return; }
    if (destino === origen) { err("relacion", origen + ": se relaciona consigo mismo"); return; }
    const vuelta = relacionesPorRuta.get(destino) || [];
    if (vuelta.indexOf(origen) === -1)
      err("reciprocidad", destino + " no declara su relación con " + origen);
  });
  const dup = rels.filter((v, i) => rels.indexOf(v) !== i);
  if (dup.length) avi("relacion", origen + ": destino repetido (" + [...new Set(dup)].join(", ") + ")");
});

/* ---------- ámbitos ---------- */

unicos(AMB.map((a) => a.id), "ambitos", "id");

AMB.forEach((A, aIdx) => {
  const dA = "ambito[" + (A.id || aIdx) + "]";
  if (!texto(A.id) || !RE_ID.test(A.id)) err(dA, "id ausente o con formato inválido");
  if (!texto(A.nombre)) err(dA, "nombre ausente");
  if (!texto(A.pregunta)) err(dA, "pregunta ausente");
  else if (!/[?？]$/.test(A.pregunta.trim())) avi(dA, "la pregunta no termina en signo de cierre");
  if (Array.isArray(A.estrellas)) err(dA, "usa `estrellas`; el contrato lo renombró a `datos`");

  if (!Array.isArray(A.datos)) { err(dA, "sin `datos`"); return; }
  if (A.datos.length < DATOS_AMBITO_MIN || A.datos.length > DATOS_AMBITO_MAX)
    err(dA, "tiene " + A.datos.length + " datos; el contrato pide entre " + DATOS_AMBITO_MIN + " y " + DATOS_AMBITO_MAX);
  A.datos.forEach((r) => { if (!rutas.has(r)) err(dA, "la ruta " + r + " no existe"); });
  const insts = new Set(A.datos.map((r) => String(r).split(".")[0]));
  if (insts.size < 2) avi(dA, "todos sus datos son de una sola institución; un ámbito gana valor cruzando emisores");
});

/* ---------- frases ---------- */

["universo", "institucion", "base", "dato", "ambito"].forEach((k) => {
  if (!texto(FRASES[k])) err("frases", "falta la frase `" + k + "`");
});

/* ---------- proximidad en el mapa ---------- */

const ubicadas = INST.filter((i) => typeof i.x === "number" && typeof i.y === "number" && !(i.x === 0 && i.y === 0));
for (let i = 0; i < ubicadas.length; i++) {
  for (let j = i + 1; j < ubicadas.length; j++) {
    const a = ubicadas[i], b = ubicadas[j];
    const d = Math.hypot(a.x - b.x, a.y - b.y);
    if (d < DIST_MIN) err("mapa", a.id + " y " + b.id + " están a " + d.toFixed(1) + " (mínimo " + DIST_MIN + ")");
  }
}

/* ---------- colores ---------- */

const porColor = new Map();
INST.forEach((i) => {
  const c = String(i.color || "").toUpperCase();
  porColor.set(c, (porColor.get(c) || []).concat(i.id));
});
porColor.forEach((ids, c) => { if (ids.length > 1) avi("color", c + " se repite en: " + ids.join(", ")); });
if (porColor.has("#FFC92E") && (porColor.get("#FFC92E") || []).length)
  avi("color", "#FFC92E es además el color de interacción del atlas; conviene no usarlo en instituciones nuevas");

/* ---------- informe ---------- */

function informar() {
  const nB = INST && Array.isArray(INST) ? INST.reduce((n, i) => n + ((i.bases || []).length), 0) : 0;
  const nD = INST && Array.isArray(INST)
    ? INST.reduce((n, i) => n + (i.bases || []).reduce((m, b) => m + ((b.datos || []).length), 0), 0) : 0;
  const nR = [...relacionesPorRuta.values()].reduce((n, r) => n + r.length, 0);

  console.log("Catálogo: " + ruta);
  console.log("Instituciones: " + (Array.isArray(INST) ? INST.length : "?") +
              " | bases: " + nB + " | datos: " + nD +
              " | ámbitos: " + (Array.isArray(AMB) ? AMB.length : "?") +
              " | relaciones: " + nR);
  console.log("");

  if (errores.length) {
    console.log("ERRORES (" + errores.length + ") — bloquean el depósito");
    errores.forEach((e) => console.log("  x " + e));
    console.log("");
  }
  if (avisos.length) {
    console.log("AVISOS (" + avisos.length + ") — no bloquean");
    avisos.forEach((a) => console.log("  ! " + a));
    console.log("");
  }
  console.log(errores.length
    ? "RESULTADO: no válido. Corregir los errores y volver a validar."
    : "RESULTADO: válido. El archivo puede depositarse en docs/atlas_datos.js.");
}

informar();
process.exit(errores.length ? 1 : 0);
