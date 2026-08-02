# Traspaso de cierre — `slep_monitoreo` v12

> **Destino:** `50_documentacion/traspasos/traspaso_cierre_v12.md`
> **Sesión 12** · Claude Opus 5 · 2026-07-30 a 2026-07-31
> **Anterior:** `traspaso_cierre_v11.md` (sesión paralela, pipeline de datos)

---

## 1. Identificación

| | |
|---|---|
| **Proyecto** | `slep_monitoreo` — sitio institucional del Área de Monitoreo y Seguimiento de Procesos y Resultados Educativos, SLEP Costa Central |
| **Versión del traspaso** | v12 |
| **Fecha** | 2026-07-30 a 2026-07-31 |
| **Sesión** | 12. Foco: construir el atlas de datos educativos dentro de la segunda página del sitio, y publicar la deuda de cierre de la sesión 10 |
| **Entorno** | Claude Opus 5 en chat (análisis, diseño y generación de artefactos) + Claude Code (ejecución en disco) + navegador local sobre `python3 -m http.server` |
| **Archivos principales modificados** | `docs/atlas.js` (nuevo), `docs/atlas.css` (nuevo), `docs/atlas_datos.js`, `docs/formacion.html` |

**Nota de paralelismo.** Las sesiones 11 y 12 corrieron simultáneamente sobre el
mismo repositorio, sin solape de escritura: la 11 trabajó `20_insumos/`,
`30_procesamiento/` y `40_salidas/`; la 12 trabajó `docs/`. La sesión 11 cerró
primero y tomó el correlativo v11; este traspaso toma v12 por correlativo de
archivo, no por orden cronológico de inicio.

---

## 2. Resumen ejecutivo

La sesión se propuso versionar y publicar el cierre pendiente de la sesión 10 y
después construir el atlas del catálogo de fuentes, que desde v10 existía como
contrato y validador pero no como render. Lo primero se logró: los tres commits
del cierre se publicaron y `main` quedó en `1dcbafe`, y de paso se intentó cerrar
la deuda de los tokens `--banner-*` en dos encargos autónomos que se cancelaron
solos por evidencia, ambos correctamente. Lo segundo se construyó tres veces y
ninguna sirvió. La primera versión llevó la metáfora del handoff a producción con
fondo espacio, y resultó ilegible además de inerte: un `setPointerCapture` en el
arrastre desviaba todos los clics al contenedor y ninguna vista más allá de la
raíz llegó a verse. La segunda versión corrigió el bug, pasó la geometría de
porcentajes a píxeles, dio a cada cuerpo su propia órbita y trasladó todo a
superficie clara; funcionó y quedó peor. El titular descartó la línea orbital
completa y propuso una dirección distinta, un tablero de dos mitades enfrentadas
donde las fuentes y los ámbitos de indagación son caras contrapuestas y el clic
tiende el vínculo. En el camino el catálogo perdió UNESCO · OECD por decisión de
alcance nacional, la página de formación invirtió el orden de sus secciones, y
quedó propuesto el colapso del nivel 1 de 25 emisores a 11 instituciones para
que el catálogo verificado quepa en la paleta del contrato. Nada de `docs/` está
commiteado: el árbol tiene cuatro archivos de la sesión sin versionar y el
validador del catálogo no alcanzó a correr sobre el archivo modificado, porque
el clasificador de permisos de Claude Code cayó en el último tramo.

---

## 3. Estado al cierre

### Qué funciona

| Pieza | Estado | Última verificación |
|---|---|---|
| `main` publicada | `1dcbafe`, `0 0` frente al upstream tras el push, y luego 16 commits por delante por trabajo de la sesión 11 | `git rev-list --left-right --count @{u}...HEAD` → `0 16` (titular, terminal, 2026-07-30) |
| Sitio, portafolio | Sin cambios en esta sesión | — |
| Tabla filtrable de `formacion.html` | Funciona; consume `atlas_datos.js` | Navegador local, 2026-07-31 |
| `docs/atlas.js` v2 | Sintaxis válida; render de los cuatro niveles; clics, zoom, paneo y ámbitos operativos | `node --check` (asistente) + navegador del titular, 2026-07-31 |
| Retiro de UNESCO · OECD | Aplicado sobre `docs/atlas_datos.js`, sin rutas rotas según la transformación | Transformación programática del asistente, 2026-07-31 |

### Qué no funciona

| Síntoma observable | Alcance |
|---|---|
| El atlas es visualmente rechazado por el titular en sus dos versiones | Bloquea la difusión del sitio junto con P4 |
| `node 00_validar_atlas.js docs/atlas_datos.js` sin correr sobre el archivo modificado | El exit code del catálogo con 9 instituciones es desconocido |
| `.fm-atlas-espera` y `.fm-atlas-foot` quedaron huérfanas en `docs/formacion.css` | Deuda cosmética, sin efecto |

### Delta respecto a v10

v10 dejó el atlas como contrato y validador sin render, el catálogo provisorio
con 10 instituciones y la página de formación con la tabla primero y un marcador
«en desarrollo» después. v12 deja el catálogo con 9 instituciones y alcance
nacional declarado, la página con el atlas primero y la tabla después, un render
funcional pero descartado estéticamente, y una dirección de diseño nueva que no
tiene código. El pendiente P3 pasa de «no empezado» a «empezado y reorientado»,
que no es lo mismo que avanzado.

---

## 4. Registro detallado de cambios

### 4.1 Publicación del cierre de la sesión 10

**Archivos:** ninguno. **Categoría:** arquitectura del repositorio.
Se publicaron `4061e89`, `da6b586` y `1dcbafe` mediante encargo autónomo.
**Por qué:** el cierre de la sesión 10 quedó commiteado y sin publicar por
decisión de dejar el push como acto explícito del titular.
**Cómo se verificó:** `git rev-list --left-right --count @{u}...HEAD` → `0 0` y
`git ls-remote --heads origin` → una línea.
**Dependencia:** era precondición bloqueante del protocolo de ordenación §4.7.
Registrado en el backlog como entrada 82, dentro del cierre de la sesión 11.

### 4.2 Doble cancelación del pendiente P5

**Archivos:** ninguno; `docs/styles.css` quedó sin diff. **Categoría:** deuda técnica.
Dos encargos autónomos consecutivos diagnosticaron los tokens `--banner-*` y las
reglas `body[data-variant] .banner`, y ambos se cancelaron por su propia regla de
decisión: el primero porque el grep encontró `class="banner-type"` vivo en
`docs/index.html:138`, el segundo porque `data-variant="d2"` está vivo en el
`<body>` de ambas páginas.
**Por qué importa:** la primera cancelación evitó un daño real. La Fase 1.4 del
encargo mandaba eliminar «las reglas cuyo selector contiene `.banner`», y eso
incluía `docs/styles.css:517`, `.lb-text .banner-type`, que estila el lightbox de
reseña, invariante 🔒.
**Estado:** P5 abierto, con la evidencia acumulada y la metodología correcta
escrita. Registrado como entrada 82 del backlog.

### 4.3 Render del atlas, versión 1 (metáfora espacial)

**Archivos:** `docs/atlas.js`, `docs/atlas.css` (nuevos), `docs/formacion.html`.
**Categoría:** interacción y JS.
Implementación completa de los cuatro niveles del contrato con fondo `#050A16`,
campo de estrellas generado, nebulosas, cometas y deriva, siguiendo el README del
handoff. Todo dentro de una IIFE, sin ninguna constante global nueva.
**Por qué:** el contrato y el validador existían desde v10; faltaba el consumidor.
**Cómo se verificó:** `node --check docs/atlas.js` → `exit=0`; inspección de DOM
por Claude Code (10 sistemas, 6 ámbitos, ficha y controles presentes); consola sin
errores.
**Líneas clave:** el contenedor usa `id="atlasCeleste"` porque `#atlas` ya era el
ancla de la sección.
**Tensión resuelta:** el handoff sugería React; el sitio no tiene build ni
módulos, así que se recreó en JS clásico con `<script src>`, igual que `data.js`.

### 4.4 Inversión del orden de las secciones de `formacion.html`

**Archivo:** `docs/formacion.html`. **Categoría:** layout y composición.
El bloque del atlas pasa antes que el de fuentes.
**Por qué:** decisión del titular; el mapa es la puerta de entrada y la tabla el
detalle consultable.
**Cómo se verificó:** lectura del archivo resultante y render en navegador.
**Dependencias afectadas:** las clases `section` y `section--alt` se
intercambiaron para conservar la alternancia de fondos del sitio, y los dos ledes
se reescribieron porque cada uno se refería al otro como «lo anterior». Ninguno de
los dos ajustes es cosmético: omitirlos habría dejado dos secciones claras
consecutivas y dos textos que se contradicen.

### 4.5 Retiro de UNESCO · OECD del catálogo

**Archivo:** `docs/atlas_datos.js`. **Categoría:** estructura de contenido.
Se eliminó la institución `internacional` y las tres relaciones entrantes que la
referenciaban.
**Por qué:** decisión de alcance del titular. El atlas se centra en el sistema
nacional.
**Cómo se verificó:** transformación programática con verificación de integridad
referencial en el mismo paso: 10 → 9 instituciones, 27 → 25 bases, 52 → 50 datos,
130 → 124 relaciones, 3 relaciones entrantes retiradas, 0 ámbitos afectados,
0 rutas rotas.
**Precaución vigente:** la verificación es del transformador, no del validador
canónico. `node 00_validar_atlas.js docs/atlas_datos.js` **no se ejecutó** sobre
el archivo resultante.
**Efecto lateral aprovechable:** `--cream` (`#FFF6E0`) quedó libre en la paleta
del contrato §4.

### 4.6 Render del atlas, versión 2 (superficie clara, geometría en píxeles)

**Archivos:** `docs/atlas.js`, `docs/atlas.css`. **Categoría:** interacción y JS.
Reescritura completa de ambos archivos. La metáfora espacial se abandonó y quedó
como geometría abstracta sobre `--paper`; los colores salen de
`colors_and_type.css` y el atlas dejó de definir paleta propia.
**Por qué:** el fondo oscuro resultó ilegible y desalineado con el resto del sitio.
**Cinco correcciones estructurales:**

1. Geometría en píxeles y no en porcentajes. Un porcentaje sobre un contenedor no
   cuadrado convierte cada círculo en una elipse distinta por eje: era la causa
   del descalce entre sol y órbita y de la deformación de las líneas de ámbito.
2. Un anillo por cuerpo, calculado por `anillos()`. Dos bases nunca comparten
   órbita.
3. La meta (`N bases · M datos`) aparece solo en hover y foco. Con nueve etiquetas
   permanentes el mapa se leía como una lista.
4. El encabezado superpuesto pasó a barra propia, lo que libera la franja
   izquierda y permite reescalar las posiciones del catálogo para llenar el lienzo.
5. Las líneas de ámbito se trazan en coordenadas reales del contenedor.

**Cómo se verificó:** `node --check` (asistente) y navegador del titular, que
confirmó que la interacción funciona y que la estética empeoró.

### 4.7 Colapso propuesto del nivel 1

**Archivos:** ninguno; vive en este traspaso y en el backlog. **Categoría:**
estructura de contenido.
El catálogo verificado de la sesión 11 tiene 25 emisores distintos y la paleta del
contrato §4 tiene 10 tokens, todos asignados.
**Alternativas consideradas:** ampliar la paleta (viola §4 y rompe la identidad
gobCL); colorear por ámbito en vez de por institución (deja sin código visual al
nivel que el atlas dibuja primero); colapsar por corrección institucional pura
(baja a 20, no alcanza); colisión declarada para los 10 excedentes (§4 la permite,
pero diez colisiones no son una excepción sino una regla nueva).
**Adoptada:** híbrido de once nodos, con granularidad institucional en el núcleo
educativo y agrupación por familia en las fuentes intersectoriales, con una sola
colisión declarada.

### 4.8 Descarte de la línea orbital

**Archivos:** ninguno. **Categoría:** layout y composición.
El titular descartó las dos versiones tras verlas renderizadas y propuso una
dirección nueva: un tablero de dos mitades enfrentadas, a la izquierda las fuentes
por institución, base y dato, a la derecha los ámbitos de indagación, y el clic en
una pieza destaca sus contrapartes.
**Por qué la orbital falló:** la metáfora del sistema solar sostenía la
composición por el fondo, no por la estructura; sin cielo nocturno quedan discos
flotando sin relación legible entre sí. Y los ámbitos de indagación eran un menú
lateral, es decir una vista alternativa, cuando el catálogo los trata como una
dimensión del dato.

---

## 5. Backlog acumulativo

Archivo canónico: `50_documentacion/activa/backlog_acumulativo.md`, actualizado en
este cierre con las entradas 89-94. Total 88 → 94. Sin reescritura ni renumeración
de entradas anteriores. La entrada 82, que registra el push del cierre de la
sesión 10 y las dos cancelaciones de P5, corresponde a trabajo emitido desde esta
sesión y absorbido por el cierre de la sesión 11: se deja donde está.

---

## 6. Bugs de la sesión

### BUG-01 · El atlas no respondía a ningún clic

| Campo | Contenido |
|---|---|
| **Síntoma observable** | Ningún clic del mapa navegaba. El hover de los nodos se comportaba de forma errática. La consola no arrojaba errores. |
| **Causa raíz** | `raiz.setPointerCapture(e.pointerId)` en el `pointerdown` del contenedor. Con captura activa, el `click` posterior se despacha sobre el elemento capturador y no sobre el nodo, de modo que `e.target.closest("[data-inst]")` devolvía `null` en todos los casos. |
| **Solución exacta** | `docs/atlas.js`: se eliminó la captura; el seguimiento del arrastre pasó a escuchas en `document` y el umbral de 5 px se complementó con un guardia temporal de 120 ms para que soltar el puntero tras mover no se lea como clic. |
| **Criterio de verificación** | Clic en una institución entra a su vista; clic en una base entra a la vista de base; clic en un dato abre la ficha. Confirmado por el titular en navegador. |
| **Patrón general aprendido** | La captura de puntero sirve para arrastres que deben seguir recibiendo eventos fuera del elemento, no para arrastres que conviven con clics de navegación en los hijos. Si un contenedor necesita paneo y sus hijos necesitan clic, el seguimiento va en `document` y la desambiguación va por umbral, no por captura. |
| **Principios** | Aplicado: verificación observable antes de dar por bueno un render. La estructura del DOM estaba correcta y la interacción no; una inspección estática los ve idénticos. |
| **Estado** | Resuelto. |

### BUG-02 · Órbitas descalzadas y líneas de ámbito deformadas

| Campo | Contenido |
|---|---|
| **Síntoma observable** | El anillo alrededor de cada institución no coincidía con el borde del cuerpo; las líneas del ámbito se veían torcidas respecto de los nodos que unían. |
| **Causa raíz** | Los cuerpos se dimensionaban en píxeles y las órbitas y trazos en porcentajes del contenedor. Sobre un contenedor no cuadrado, el mismo porcentaje produce radios distintos por eje. |
| **Solución exacta** | `docs/atlas.js`: toda la geometría se calcula en píxeles desde `getBoundingClientRect()` del lienzo, con redibujo en `resize` y en `fullscreenchange`. |
| **Criterio de verificación** | Anillo concéntrico al cuerpo en cualquier razón de aspecto del contenedor. |
| **Patrón general aprendido** | Un porcentaje de CSS no es una unidad geométrica: en un contenedor no cuadrado, `width: 30%` y `height: 30%` no describen un círculo. Todo lo que deba ser circular o equidistante se calcula en píxeles. |
| **Estado** | Resuelto en la versión 2, que a su vez quedó descartada por diseño. |

---

## 7. Aprendizajes y restricciones descubiertas

1. **La captura de puntero y los clics en hijos son incompatibles.** Si un
   contenedor panea y sus hijos navegan, el seguimiento del arrastre va en
   `document`. Contexto: sin esto, todos los clics del mapa se pierden en
   silencio y la consola no dice nada.
2. **Un porcentaje de CSS no describe un círculo.** Sobre un contenedor no
   cuadrado, un porcentaje produce radios distintos por eje. Toda geometría
   circular o equidistante se calcula en píxeles y se redibuja al cambiar de
   tamaño.
3. **La estructura correcta del DOM no es evidencia de comportamiento.** Un
   `aria-expanded="false"` que nunca pasa a `true` se ve idéntico en una
   inspección estática a uno que sí funciona. Toda verificación de interacción
   necesita eventos reales, y si la herramienta no puede generarlos, la
   verificación es del titular y así se declara.
4. **Una metáfora visual que depende del fondo no sobrevive al cambio de fondo.**
   La composición orbital funcionaba porque el cielo nocturno daba profundidad y
   contraste; sobre blanco quedan discos sin relación legible. Si la estructura
   no se sostiene sin el ambiente, no es estructura.
5. **Una dimensión del dato no se representa como menú.** Los ámbitos de
   indagación son un atributo de cada dato en el contrato; tratarlos como vista
   alternativa los saca del objeto y los convierte en filtro.
6. **La paleta del contrato es un límite duro sobre el cardinal del nivel 1.**
   Diez tokens implican que el nivel 1 no puede tener veinticinco nodos sin
   convertir la colisión declarada en regla. El problema no se resuelve eligiendo
   colores: se resuelve decidiendo qué es una institución de nivel 1.

---

## 8. Decisiones de diseño

| Decisión | Alternativas | Justificación | Implicancia |
|---|---|---|---|
| Recrear el atlas en JS clásico dentro de una IIFE | React o Vue, como sugería el handoff | El sitio no tiene build ni módulos; un `export` produce `SyntaxError` fuera de `type="module"` | El archivo no agrega ninguna constante global y no puede colisionar con las seis existentes |
| Contenedor con `id="atlasCeleste"` | Reutilizar `#atlas` | `#atlas` ya era el ancla de navegación de la sección | Dos identificadores conviven sin conflicto |
| Tokens del atlas heredados de `colors_and_type.css` (versión 2) | Paleta local literal (versión 1) | En superficie clara el atlas es parte del sitio, no una isla | Un cambio de paleta del sitio alcanza al atlas, que es lo deseable |
| Alcance nacional del catálogo | Conservar UNESCO · OECD como espejo comparado | Decisión del titular | Libera `--cream` en la paleta del contrato |
| Colapso de nivel 1 a once nodos | Ampliar paleta; colorear por ámbito; colisión declarada para diez | Corrige el desajuste de granularidad entre catálogo y contrato, y de paso resuelve la distancia euclídea mínima | Requiere una transformación declarada entre `catalogo_fuentes.csv` y `atlas_datos.js` |
| Tablero de dos mitades enfrentadas | Grilla de fichas que se voltean, tipo memorice | El valor del catálogo está en el cruce entre emisores y preguntas; una ficha que se voltea esconde la mitad que uno quiere comparar | `atlas.js` se rehace; sobreviven el modelo de datos y `buscar()` |

---

## 9. Constantes y parámetros

| Constante | Valor anterior | Valor nuevo | Archivo | Motivo |
|---|---|---|---|---|
| Instituciones del catálogo | 10 | 9 | `docs/atlas_datos.js` | Retiro de UNESCO · OECD |
| Bases del catálogo | 27 | 25 | `docs/atlas_datos.js` | Idem |
| Datos del catálogo | 52 | 50 | `docs/atlas_datos.js` | Idem |
| Relaciones declaradas | 130 | 124 | `docs/atlas_datos.js` | Idem, más 3 relaciones entrantes |
| Límites de zoom del atlas | — | 0.5 a 3.2 | `docs/atlas.js` | Constante nueva de la sesión |

Las constantes vigentes del catálogo son las que declara `docs/atlas_datos.js`; su
contrato vive en `50_documentacion/activa/50_contrato_atlas_datos.md`. Las cifras
de esta tabla provienen de la transformación programática y **no** del validador
canónico, que no alcanzó a correr.

---

## 10. Arquitectura de archivos

Escáner de referencia: `50_documentacion/estructura/estructura_actual.md`,
generado el 2026-07-31 a las 06:56 por la sesión 11. Registra 16 carpetas y 95
archivos, e **incluye ya** los tres archivos de esta sesión: `docs/atlas.css`
(12.0 KB), `docs/atlas.js` (22.0 KB) y `docs/atlas_datos.js` reducido a 36.7 KB.

El escáner **no se volvió a correr en este cierre**, en aplicación del invariante
de corrida única por sesión: la sesión 11 ya consumió la corrida del día y una
segunda pasada habría destruido el par `actual`/`anterior`. La estructura no
cambió después de esa corrida salvo por el contenido de `atlas.js` y `atlas.css`,
que se reescribieron sin cambiar de nombre ni de ubicación.

Cumplimiento de la política: las decenas `20_insumos/`, `30_procesamiento/` y
`40_salidas/` que introdujo la sesión 11 están en su lugar; `docs/` sigue siendo
la raíz de publicación de GitHub Pages; no hay archivos con tildes, ñ ni espacios
en el árbol vivo.

---

## 11. Pendientes y ruta sugerida

### 11.1 Inventario

**P1 · Versionar el trabajo de `docs/` de esta sesión**
Descripción: cuatro archivos sin commitear (`atlas.js` y `atlas.css` nuevos,
`atlas_datos.js` y `formacion.html` modificados).
Tipo: bloqueante. Impacto: alto; sin esto el trabajo vive solo en el disco.
Dependencias: correr antes el validador (P2), porque `atlas_datos.js` entra en el
mismo lote. Complejidad: baja.
Precaución: commits atómicos, uno por cambio conceptual; el retiro de UNESCO ·
OECD y la reordenación de secciones no van en el mismo commit que el render.
Criterio de éxito: `git status --short` vacío y `git log --oneline` con un commit
por cambio conceptual.

**P2 · Correr el validador sobre `docs/atlas_datos.js`**
Descripción: `node 00_validar_atlas.js docs/atlas_datos.js` no se ejecutó tras el
retiro de UNESCO · OECD.
Tipo: bloqueante. Impacto: alto; toda cifra del catálogo declarada en este
traspaso proviene del transformador y no del validador canónico.
Dependencias: que el clasificador de permisos de Claude Code esté operativo, o
que lo corra el titular. Complejidad: trivial.
Criterio de éxito: `exit=0`. Si devuelve `1`, quedó una referencia colgando y hay
que reportarla antes de commitear.

**P3 · Construir el tablero de fichas enfrentadas**
Descripción: reemplazo completo de la representación del atlas por dos mitades,
fuentes a la izquierda y ámbitos a la derecha, con destacado recíproco al clic.
Tipo: funcionalidad. Impacto: alto; es la puerta de entrada de la página.
Dependencias: ninguna técnica; el modelo de datos ya sirve.
Complejidad: alta. Es una sesión completa.
Precauciones: `docs/app.js` es 🔒; el contenedor sigue siendo `#atlasCeleste`;
nada de constantes globales nuevas.
Sugerencia de enfoque: empezar por la mitad de fuentes, que es una lista
jerárquica, y solo después la de ámbitos y el vínculo. Sobreviven de `atlas.js`
el resolutor `buscar()`, `norm()` y las utilidades de conteo.
Criterio de éxito: el titular lo aprueba visualmente antes de que se escriba la
lógica de destacado.

**P4 · Resolver las 38 solicitudes al titular**
Descripción: heredado de la sesión 11. `40_salidas/solicitudes_al_titular.md`.
Tipo: bloqueante de contenido. Impacto: alto; sin esto `variables` y
`cobertura_temporal` no alcanzan a llenar el contrato, que los exige obligatorios.
Complejidad: media, pero requiere descargas y credenciales del titular.

**P5 · Aplicar el colapso de nivel 1 al catálogo verificado**
Descripción: transformar los 25 emisores de `catalogo_fuentes.csv` en las once
instituciones de §4.7, con su asignación de color y su colisión declarada.
Tipo: funcionalidad. Impacto: alto. Dependencias: P4.
Precaución: la transformación se declara por escrito antes de ejecutarse; el
contrato §4 exige que una institución nueva no invente color.

**P6 · Tokens `--banner-*`**
Descripción: heredado; dos cancelaciones documentadas. Cerrar exige decidir si la
variante `d3`, que no tiene consumidor en ninguna de las dos páginas, se elimina.
Tipo: deuda técnica. Impacto: bajo.
Sugerencia: no gastar un tercer encargo; resolverlo cuando `styles.css` se toque
por otra razón, con verificación positiva de ausencia en el DOM renderizado
(`document.querySelectorAll('.banner').length === 0`) en vez de otro grep.

**P7 · Ordenación del repositorio (§4.7)**
Descripción: heredado de la sesión 10, con el encargo ya escrito en
`50_documentacion/andamios/20260730_encargo_sesion11.md`, Tramo 2.
Tipo: deuda heredada. Impacto: medio; el gatillo 4bis se enciende en cada
apertura mientras no exista `50_documentacion/activa/50_ordenacion_repositorio.md`.
**Precaución que invalida el encargo tal como está:** su tabla de movimientos de
la Fase 2.2 se construyó sobre el escáner del 2026-07-30 a las 11:35, que no
conocía `20_insumos/`, `30_procesamiento/` ni `40_salidas/`. Hay que rehacer la
Fase 2.2 con el escáner vigente antes de lanzarlo.

**P8 · Huérfanas en `formacion.css`**
Descripción: `.fm-atlas-espera` y `.fm-atlas-foot` quedaron sin markup.
Tipo: deuda cosmética. Impacto: nulo.

**P9 · Fase 0 del catálogo de Project Cards**
Descripción: heredado. Los once campos están diagnosticados y transcritos en el
log `20260730_ordenacion_y_deuda_log.md`, §4. Cuatro dependen de decisiones del
Área que ningún comando resuelve.
Tipo: funcionalidad. Impacto: medio.

**P10 · Entrada del proyecto Simce**
Descripción: heredado desde v07. Espera tres PDF del titular. Tipo: contenido.

**P11 · Corregir el patrón de encargo autónomo**
Descripción: `encargo_autonomo_claude_code_v1.md` agrupa comandos por fase y no
por nivel de riesgo, lo que hizo que `git push` viajara junto a verificaciones y
el clasificador bloqueara el bloque entero. Sumar además la regla de que ningún
encargo incluye tareas manuales de traslado de archivos.
Tipo: documentación. Impacto: medio; afecta a los 16 proyectos de la cartera.

### 11.2 Evaluación de deuda técnica

**Zonas frágiles.** `docs/atlas.js` completo es deuda a la espera de reemplazo: es
código correcto que implementa una representación descartada, y mantenerlo
mientras se escribe la nueva duplica superficie. Conviene decidir explícitamente
si se conserva como referencia en `_archivo/` o si se sustituye en el mismo
commit. `docs/formacion.css` acumula ahora reglas huérfanas, que es el mismo
patrón de la entrada 62 del backlog y de P6: reglas que sobreviven al markup que
las justificaba.

**Oportunidades.** El resolutor de rutas de tres segmentos y las utilidades de
conteo son independientes de la representación y ya están probadas; extraerlas a
su propio archivo antes de escribir el tablero evitaría reescribirlas por tercera
vez.

### 11.3 Auditoría de cierre (política 5.6, preguntas «Cierre»)

| # | Pregunta | Respuesta |
|---|---|---|
| 2 | ¿El pipeline corre de cero sin intervención manual? | No aplica en `docs/` (sitio estático). El equivalente, `node --check` sobre los JS, sí corre de cero. Pero `node 00_validar_atlas.js` **no se ejecutó** sobre el archivo modificado → se agrega como P2. |
| 8 | ¿Nombres de archivos y carpetas sin tildes, ñ ni espacios? | Sí. `atlas.js`, `atlas.css` y `atlas_datos.js` cumplen; ningún archivo nuevo introduce guiones medios. |

Toda respuesta «no» quedó como pendiente: la de la pregunta 2 es P2.

### 11.4 Ruta sugerida

| Orden | Ítem | Justificación (criterios de 1.2.4) | Criterio de éxito |
|---|---|---|---|
| 1 | P2, validador | Bloqueante y trivial. Toda cifra del catálogo de este traspaso está sin confirmar por la fuente canónica | `exit=0` |
| 2 | P1, versionar | Bloqueante. Cuatro archivos de una sesión completa viven solo en disco | `git status --short` vacío, commits atómicos |
| 3 | P3, tablero de fichas | Es el foco real y la única forma de desbloquear la difusión junto con P4 | El titular aprueba la maqueta antes de que se escriba la lógica |

**Conviene diferir:** P6 (dos encargos gastados, impacto bajo), P8 (nulo), P9 y
P10 (dependen de insumos del titular), P7 (su encargo está desactualizado y
rehacerlo compite con P3 por la misma sesión).

---

## 12. Instrucciones específicas para la próxima sesión

- ⚠️ **NO** commitear `docs/atlas_datos.js` sin haber corrido antes
  `node 00_validar_atlas.js docs/atlas_datos.js` y obtenido `exit=0`.
- ⚠️ **NO** lanzar el Tramo 2 del encargo `20260730_encargo_sesion11.md` tal como
  está: su tabla de movimientos se construyó sobre un escáner que no conocía las
  tres decenas nuevas.
- ⚠️ **NO** correr `00_escanear_proyecto.R` más de una vez por sesión, y
  verificar antes si una sesión paralela ya lo corrió ese día.
- ⚠️ **NO** ejecutar `git push` sin autorización explícita del titular en el turno
  inmediatamente anterior. La autorización no se hereda entre encargos.
- ⚠️ **NO** agrupar `git push` con verificaciones en un mismo bloque de comandos:
  el clasificador bloquea el bloque completo.
- ⚠️ **NO** incluir tareas manuales de traslado de archivos (copiar, mover,
  descargar, reemplazar) en un encargo ni en un mensaje para Claude Code. Los
  encargos parten del supuesto de que los archivos ya están en su destino.
- ✅ **ANTES** de declarar que un render funciona, verificar con eventos reales.
  La presencia de un nodo en el DOM no es evidencia de que responda.
- ✅ **ANTES** de agregar cualquier constante global a un script de `docs/`,
  verificar que no colisione con `PROYECTOS`, `HITOS`, `EQUIPO`,
  `ATLAS_INSTITUCIONES`, `ATLAS_AMBITOS` ni `ATLAS_FRASES`.
- ✅ **ANTES** de escribir geometría circular en CSS, verificar que se calcule en
  píxeles y no en porcentajes del contenedor.
- ✅ **ANTES** de tomar una cifra del catálogo, recontarla programáticamente en el
  mismo turno. Ninguna cifra de este traspaso proviene del validador canónico.
- 🔒 `docs/app.js` no se toca. El lightbox de reseña y el visor a resolución
  completa se enganchan por fuera, por envoltura.
- 🔒 `.lb-text .banner-type` de `docs/styles.css` no se toca: es del lightbox.
- 🔒 `POLITICA_PROYECTO.md`, `SETTINGS_Y_PROMPTS_OPERACIONALES.md`,
  `50_documentacion/traspasos/**` y `50_documentacion/andamios/**` permanecen
  fuera del repositorio público.
- 🔒 Los bundles de `_archivo/20260730/ramas_claude/` y los originales de
  `_archivo/20260729/capturas_originales/` no se borran jamás.
- 🔒 El catálogo `docs/atlas_datos.js` sigue sin revisión de contenido del
  titular: **el sitio no se difunde** hasta que P4 se resuelva.

---

## 13. Fragmentos de código de referencia

**Reparto en anillos concéntricos, un cuerpo por anillo.** Patrón nuevo de esta
sesión; sobrevive al cambio de representación si el tablero conserva alguna
disposición radial.

```javascript
/* Devuelve, para cada uno de los n cuerpos, su radio y su ángulo.
   Radios distintos garantizan que dos cuerpos nunca compartan anillo. */
function anillos(n, rMin, rMax) {
  var out = [];
  for (var k = 0; k < n; k++) {
    var t = n === 1 ? 0.5 : k / (n - 1);
    out.push({ r: rMin + (rMax - rMin) * t, a: (-90 + (k * 360) / n) * Math.PI / 180 });
  }
  return out;
}
```

**Arrastre que convive con clics en los hijos.** Sin `setPointerCapture`, con
umbral de distancia y guardia temporal.

```javascript
var drag = null, ultimoArrastre = 0;

elLienzo.addEventListener("pointerdown", function (e) {
  if (e.button !== 0) return;
  if (e.target.closest(".atlas-nodo, .atlas-controles")) return;
  drag = { x: e.clientX, y: e.clientY, px: st.px, py: st.py, movido: false };
});

document.addEventListener("pointermove", function (e) {
  if (!drag) return;
  var dx = e.clientX - drag.x, dy = e.clientY - drag.y;
  if (!drag.movido && Math.abs(dx) + Math.abs(dy) > 5) drag.movido = true;
  if (!drag.movido) return;
  st.px = drag.px + dx; st.py = drag.py + dy; transform();
});

document.addEventListener("pointerup", function () {
  if (drag && drag.movido) ultimoArrastre = Date.now();
  drag = null;
});

// En el manejador de clic, primera línea:
// if (Date.now() - ultimoArrastre < 120) return;
```

**Resolutor de rutas de tres segmentos.** Patrón estable que sobrevive al cambio
de representación y conviene extraer antes de reescribir.

```javascript
function buscar(ruta) {
  var p = String(ruta || "").split(".");
  if (p.length !== 3) return null;
  var i = porId(INST, p[0]); if (!i) return null;
  var b = porId(i.bases || [], p[1]); if (!b) return null;
  var d = porId(b.datos || [], p[2]); if (!d) return null;
  return { inst: i, base: b, dato: d, ruta: ruta };
}
```

---

## 14. Reapertura

### Mensaje de apertura pre-armado

> Tipo CONTINUATION. El protocolo (`POLITICA_PROYECTO.md` v5.5 +
> `SETTINGS_Y_PROMPTS_OPERACIONALES.md` v15) vive en la knowledge base del
> Project; verifica que estén al día antes de empezar. Adjunto el traspaso v12, el
> escáner, el backlog, el contrato del atlas y los tres archivos del atlas actual.
> La sesión 12 dejó el atlas construido y descartado: funciona pero la
> representación orbital no sirve, y la dirección acordada es un tablero de dos
> mitades enfrentadas, fuentes a la izquierda y ámbitos de indagación a la
> derecha. Hay cuatro archivos de `docs/` sin commitear y el validador del
> catálogo no alcanzó a correr tras el retiro de UNESCO · OECD. La prioridad 1 es
> correr el validador y versionar; el foco de la sesión es construir el tablero.

### Documentos para la próxima sesión

**1. Protocolo en knowledge base (no se adjuntan; solo para verificar que esté al día)**

- `POLITICA_PROYECTO.md`
- `SETTINGS_Y_PROMPTS_OPERACIONALES.md`

**2. Opcionales según el foco real**

- `CLAUDE.md`, si habrá ejecución en Claude Code.
- `encargo_autonomo_claude_code_v1.md`, si se emitirá un encargo autónomo.
- Protocolo §4.7 de `SETTINGS_Y_PROMPTS_OPERACIONALES.md`, solo si se retoma P7.

**3. Específicos de la sesión (sí se adjuntan)**

- `50_documentacion/traspasos/traspaso_cierre_v12.md` — este documento.
- `50_documentacion/estructura/estructura_actual.md` — escáner vigente.
- `50_documentacion/activa/backlog_acumulativo.md` — voluminoso (≈62 KB) y crítico.
- `50_documentacion/activa/50_contrato_atlas_datos.md` — el contrato manda sobre
  la forma del archivo aunque cambie la representación.
- `docs/atlas_datos.js` — el catálogo con 9 instituciones, sin validar.
- `docs/atlas.js` y `docs/atlas.css` — la representación descartada; se adjuntan
  para decidir qué se conserva y qué se sustituye, no para continuarla.
- `docs/formacion.html` — la página que hospeda el tablero.
- `docs/formacion.css` y `docs/styles.css` — necesarios para que el tablero use
  los tokens del sitio y para resolver P8.

**Nota final obligatoria.** Si alguno de estos archivos cambia entre sesiones,
adjuntar la versión más actualizada al abrir y avisarlo en el mensaje de apertura.
En particular, `atlas_datos.js` cambiará si se resuelve P4 o P5, y el escáner
cambiará si la sesión paralela vuelve a correrlo.

---

## 15. Errores del asistente

### E-01 · Encargo con especificación de eliminación que alcanzaba un invariante

| Campo | Contenido |
|---|---|
| `momento` | Redacción de la Fase 1.4 del encargo `20260730_encargo_sesion11.md`, primer tercio de la sesión |
| `disparador` | Asistente lo señaló espontáneamente, al leer el reporte de la cancelación |
| `que_paso` | La fase mandaba eliminar «las reglas cuyo selector contiene `.banner`», y eso incluía `docs/styles.css:517`, `.lb-text .banner-type`, que es parte del lightbox declarado 🔒 |
| `regla_violada` | Traspaso v10 §12: «El lightbox de reseña y el visor a resolución completa no se tocan» |
| `causa_raiz` | Se escribió el criterio de eliminación por coincidencia textual del selector en vez de por identidad del selector, sin cruzarlo contra la lista de invariantes del propio encargo antes de emitirlo |
| `salvaguarda_presente` | Traspaso v10 (invariantes) y el propio encargo, cuya §2 listaba el lightbox como 🔒 |
| `patron` | PAT-01, sobre especificación de un criterio de borrado más ancho que su intención |
| `gatillo_observable` | `encargos-premisas`: una fase de eliminación cuyo criterio es textual y no de identidad, sobre un archivo que contiene un invariante |
| `intentos_previos` | 0 |
| `costo` | Ninguno realizado: la regla de cancelación del propio encargo lo detuvo. Costo potencial alto (rotura del lightbox) |

### E-02 · Segundo criterio de cancelación mal diseñado en el mismo pendiente

| Campo | Contenido |
|---|---|
| `momento` | Redacción de la Fase 1 del encargo `20260730_encargo_sesion11b.md` |
| `disparador` | Usuario lo señaló al pasar el reporte de Claude Code |
| `que_paso` | Se hizo de `data-variant` un cancelador absoluto sin distinguir su posición en el selector, y el patrón `\\bbanner\\b` capturó `banner-type` porque el guion es frontera de palabra, justo lo que la fase decía excluir |
| `regla_violada` | `userPreferences`, edición de archivos: no escribir ediciones a ciegas; y el principio de verificación observable, que exige que el criterio mida lo que dice medir |
| `causa_raiz` | Se corrigió el síntoma del primer encargo (grep demasiado ancho) sin revisar si el criterio nuevo tenía el mismo defecto de forma en otro lugar |
| `salvaguarda_presente` | `userPreferences` y el propio encargo 11b, que declaraba querer excluir `banner-type` |
| `patron` | PAT-01, sobre reformular un criterio conservando el defecto de forma |
| `gatillo_observable` | `iteracion-sin-criterio`: segunda pasada sobre el mismo pendiente sin revisar la forma del criterio nuevo |
| `intentos_previos` | 1, el encargo 11a, cancelado por grep demasiado ancho |
| `costo` | Un encargo completo gastado sin resolver el pendiente |

### E-03 · Tarea mecánica manual delegada a Claude Code

| Campo | Contenido |
|---|---|
| `momento` | Mensaje para Claude Code con la primera entrega del atlas |
| `disparador` | Usuario lo corrigió, en mayúsculas |
| `que_paso` | El mensaje abría con «Copia los tres archivos entregados a `docs/`», delegando a la herramienta un traslado que es del titular |
| `regla_violada` | `userPreferences`, autonomía: «Mechanical manual tasks are MINE. Do not generate scripts for them» |
| `causa_raiz` | Al redactar el bloque de comandos se trató el traslado como un paso más de la secuencia de ejecución, en vez de como precondición del encargo |
| `salvaguarda_presente` | `userPreferences` y el propio patrón de encargo, que declara que los encargos parten del supuesto de que los archivos están en destino |
| `patron` | PAT-04, sobre frontera de responsabilidad entre titular y herramienta |
| `gatillo_observable` | `restriccion-no-propagada`: una regla de frontera conocida que no se aplicó al redactar un mensaje para la herramienta |
| `intentos_previos` | 0 |
| `costo` | Un turno perdido y una corrección explícita del titular |

### E-04 · Dos representaciones entregadas sin verificación visual previa

| Campo | Contenido |
|---|---|
| `momento` | Entrega de `atlas.js` v1 y v2 |
| `disparador` | Usuario lo señaló sin nombrarlo error («está muy feo», «lograste que quedara aun más horrible») |
| `que_paso` | Se entregaron dos representaciones completas sin haber propuesto antes una maqueta o un criterio estético que el titular pudiera aprobar o rechazar barato |
| `regla_violada` | Traspaso v10 y `POLITICA_PROYECTO.md`: verificación visual antes de dar por bueno un cambio visual; y el criterio de iterar con criterio de éxito declarado |
| `causa_raiz` | Se tomó el README del handoff como especificación suficiente y se saltó el paso de acordar dirección visual, porque el handoff declaraba fidelidad alta y eso se leyó como aprobación previa |
| `salvaguarda_presente` | POLITICA (verificación visual) y `userPreferences` (recomendación explícita al presentar opciones) |
| `patron` | PAT-09, sobre entregar el artefacto completo antes de acordar el criterio con que se juzgará |
| `gatillo_observable` | `iteracion-sin-criterio`: dos entregas sucesivas de la misma pieza sin criterio de aceptación acordado |
| `intentos_previos` | 1, la versión oscura, rechazada |
| `costo` | Dos versiones completas de `atlas.js` y `atlas.css` desechadas; aproximadamente media sesión |
