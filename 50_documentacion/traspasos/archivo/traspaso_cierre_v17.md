# Traspaso de cierre — v17

> **Proyecto:** `slep_monitoreo` · **Sesión 17** · **Fecha:** 2026-08-05
> **Tipo:** CONTINUATION · **Modelo:** Claude Opus 5
> **Traspaso anterior:** v16 (2026-08-03), archivado en este cierre.

---

## 1. Identificación

**Proyecto.** `slep_monitoreo`, sitio estático institucional del Área de
Monitoreo y Seguimiento de Procesos y Resultados Educativos del SLEP Costa
Central, publicado por GitHub Pages desde `main`/`docs/` en
`https://tomgc.github.io/slep_monitoreo/`.

**Foco de la sesión.** Integrar el elemento 2 de la sección Formación a
`docs/formacion.html` y retirar en la misma tanda los restos de la metáfora
celeste. Cumplido el foco, se ejecutó la ruta acordada sobre el resto del
inventario: texto del elemento 7, higiene del código muerto, diagnóstico de
ordenación y publicación.

**Entorno.** Claude Opus 5 en chat (planificación, autoría de artefactos,
encargos) y Claude Code sobre el filesystem local del titular (ejecución,
verificación y commits). Sitio servido en `localhost:8000` para la verificación
del despliegue.

**Archivos principales modificados.**

| Archivo | Naturaleza del cambio |
|---|---|
| `docs/formacion.html` | Sección `#recorrido` nueva; sección `#atlas` retirada; etiqueta del filtro renombrada |
| `docs/formacion.css` | Bloque `fm-ruta-` completo; dos reglas huérfanas retiradas |
| `docs/formacion.js` | Segunda IIFE con la lógica del recorrido |
| `50_documentacion/activa/50_contenido_seccion_formacion.md` | v5 → v6, elemento 7 |
| `50_documentacion/activa/50_contrato_atlas_datos.md` | Ruta del paquete de handoff corregida |
| `50_documentacion/activa/50_diagnostico_ordenacion_repositorio.md` | Nuevo |
| `50_documentacion/activa/ESTADO.md` | Tres actualizaciones sucesivas |
| `_archivo/20260805_atlas_muerto/` | Destino de `atlas.js` y `atlas.css` |

---

## 2. Resumen ejecutivo

La sesión se propuso llevar a producción el elemento 2 de la sección Formación,
aprobado como maqueta en la sesión 16, y cumplió ese objetivo en su primera
mitad: los tres archivos de la página se emitieron completos desde el chat, el
traslado de la lógica fue literal (las líneas 475 a 732 de la maqueta entraron
sin una sola edición, dentro de una segunda IIFE independiente que resolvió de
raíz la colisión de `pintar()` y una segunda colisión de `fila` que el plan de
integración no había registrado), y la verificación corrió como encargo autónomo
de nueve controles programáticos. La revisión visual del titular detectó un
defecto que ningún control estático podía ver: el globo del recorrido vivía fuera
del contenedor con desplazamiento y se cortaba al elegir los nodos de la derecha;
se corrigió alojando pista y globo en un lienzo común de 1536px, estrechando la
tarjeta de 1600 a 1200px y centrando el desplazamiento sobre el nodo elegido.
Con el elemento 2 publicado, la sesión ejecutó el resto de la ruta acordada:
el texto del elemento 7 (con lo que la etapa 1 del fundamento tiene los cinco
elementos redactados), el archivado de `atlas.js` y `atlas.css` fuera del sitio
publicado, el diagnóstico de ordenación del repositorio sin ejecutar un solo
movimiento, y el push de 53 commits acumulados durante cuatro sesiones. Quedan
abiertos la redacción de los elementos 3, 4 y 6, la decisión sobre los nueve
movimientos del diagnóstico, y un desfase de versiones entre las copias de
gobernanza en disco y las de la knowledge base que se descubrió al cierre. Los
cuatro errores del asistente registrados comparten una sola causa raíz y están
en la §15.

---

## 3. Estado al cierre

### Qué funciona

| Componente | Estado | Última verificación |
|---|---|---|
| `docs/formacion.html` con el recorrido | Publicado y operativo | Navegador del titular y `localhost:8000`, esta sesión |
| Tabla de fuentes | 50 filas, 9 instituciones, 6 desafíos | Encargo de higiene, Fase 2 |
| `docs/atlas_datos.js` | Consumido por `formacion.js` | HTTP 200 en producción |
| Despliegue de GitHub Pages | `success` en 13 segundos, run 31007345692 | 2026-08-05 12:50:04Z |
| `atlas.js` y `atlas.css` en producción | HTTP 404, ya no se sirven | Tras el push |

### Qué no funciona

Ningún bug activo. Un pendiente de comportamiento conocido y no resuelto: el
recorrido en pantalla angosta. El globo quedó acotado a `max-width: 100%` bajo
720px, que es mitigación y no solución; su posición relativa al nodo elegido en
un viewport estrecho no se ha diseñado.

### Delta respecto de v16

La sesión 16 no tocó `docs/`. La 17 lo tocó en profundidad y además publicó: el
sitio en internet pasó de estar cuatro sesiones desactualizado a reflejar el
estado del repositorio. Al cierre, `origin/main` y `main` no divergen. La
estructura pasó de 118 a 121 archivos en 16 carpetas (fuente:
`estructura_actual.md`, generado 2026-08-05 13:24:50), con dos archivos menos en
`docs/` y cinco documentos nuevos entre andamios, logs y `activa/`.

---

## 4. Registro detallado de cambios

### 4.1 Integración del elemento 2 a `docs/formacion.html`

**Archivos:** `docs/formacion.html`, `docs/formacion.css`, `docs/formacion.js`.
**Categoría temática:** Estructura de contenido.
**Commits:** `5e58276`, `a3427c3`, `1303394`.

Los tres archivos se emitieron completos desde el chat y el titular los trasladó
a `docs/`. El reparto siguió el plan de integración de la sesión 16 con tres
desviaciones declaradas antes de ejecutar:

1. **Los commits 1 y 2 del plan se fusionaron.** Ambos eran P2 (la etiqueta
   «Ámbito de indagación» es parte de la metáfora celeste, no un cambio aparte), y
   separar en dos commits un archivo entregado completo habría exigido replicar el
   estado de `HEAD` para reconstruir el intermedio.
2. **El encabezado usa el patrón `section-head` del sitio** (`eyebrow`,
   `section-title`, `section-lede`) y no el encabezado propio de la maqueta. Es lo
   que pedía el plan §5.2 para alinear con `#proposito`, y evita un tercer estilo
   de título en la misma página. Las cuatro reglas del encabezado de la maqueta no
   se trasladaron.
3. **Las dos familias tipográficas se resolvieron con los tokens del sitio**
   (`var(--font-display)`, `var(--font-body)`) y no con pilas literales como
   proponía el plan §2.2, para no crear una segunda fuente de verdad tipográfica.

**Por qué la segunda IIFE.** El plan mandaba insertar la lógica dentro de la IIFE
existente y renombrar `pintar()`. Al leer la maqueta contra `formacion.js`
apareció una segunda colisión que el plan no registraba: `fila` es una función en
el archivo del sitio y una referencia a contenedor en la maqueta. Una segunda
IIFE independiente elimina ambas colisiones sin editar una línea del código
aprobado y da al recorrido su propia guarda temprana: un fallo en una unidad no
se lleva la otra.

**Cómo se verificó.** Nueve controles programáticos ejecutados por Claude Code
(encargo `20260804_encargo_integracion_elemento2.md`, log
`20260804_integracion_elemento2_log.md`): cero referencias vivas al atlas
retirado, etiqueta renombrada, 26 identificadores consultados y todos presentes,
47 clases emitidas contra 47 selectores sin huérfanas en ninguna dirección, cero
`text-transform`, 15 tokens todos declarados y cero hexadecimales literales, 267
líneas agregadas y **cero eliminadas** en `formacion.js`, ámbitos disjuntos con
cero identificadores duplicados dentro de un mismo ámbito, y `node --check` en
cero.

**Líneas clave.** `formacion.js` líneas 190 a 447, traslado literal de las líneas
475 a 732 de `20260803_maqueta_elemento2_v2.html`.

**Tensión resuelta.** Una responsabilidad por unidad contra no fragmentar el
stack sin sistema de compilación: se resolvió con dos IIFE en un mismo archivo,
que da aislamiento de ámbito sin agregar una petición HTTP.

### 4.2 Corrección del ancho y del desplazamiento del recorrido

**Archivos:** los mismos tres.
**Categoría temática:** Layout y composición.
**Commits:** entraron en los mismos `5e58276`, `a3427c3`, `1303394`, porque la
corrección precedió al commit.

El titular revisó en navegador y reportó con captura que el objeto se veía
cortado. **Causa:** el globo estaba fuera de `#fmRutaMapa`, el único elemento con
`overflow-x`, y se posiciona con `margin-left` de hasta 976px sobre una pista de
1536px. En la maqueta la tarjeta medía 1600px y el globo cabía; en producción,
con la tarjeta más angosta que el viewport, el globo sobresalía de un contenedor
sin `overflow` y se recortaba.

**Solución.** Pista y globo pasaron a un `.fm-ruta-lienzo` común de 1536px dentro
del contenedor con desplazamiento, de modo que el objeto entero se panea junto y
el globo nunca sale de su plano. La tarjeta bajó de 1600 a 1200px. Se agregó
`scroll-behavior: smooth`, desactivado bajo `prefers-reduced-motion`, y un
centrado programático: tras anclar el globo, el mapa desplaza su `scrollLeft`
hasta centrar el nodo elegido, acotado entre 0 y `geo._w - visible`.

**Cómo se verificó.** Navegador del titular, y después `localhost:8000` con 11
peticiones todas en 200 y cero errores de consola.

### 4.3 Corrección de la ruta rota del contrato del atlas (P3)

**Archivo:** `50_documentacion/activa/50_contrato_atlas_datos.md`.
**Categoría temática:** Documentación. **Commit:** `1e95bfb`.

`design_handoff_atlas_celeste/atlas-data.js` pasó a
`50_documentacion/handoffs/20260730_atlas_celeste/atlas-data.js`, verificada en
disco (28 373 bytes).

**Alcance acotado, y es lo importante del cambio.** `git grep` devolvió siete
ocurrencias en cuatro archivos versionados; se corrigió una. Las otras seis viven
en el backlog acumulativo (que se rige por «sin reescritura de las anteriores»
desde la sesión 5), en el traspaso v10 archivado, y en el v16, que describe este
mismo pendiente citando la ruta rota. Corregirlas habría vuelto falsos enunciados
que eran ciertos cuando se escribieron. La verificación tal como el encargo la
formulaba (`git grep` sin coincidencias) no podía aprobarse sin corromper la
memoria del proyecto; el ejecutor lo declaró y el titular ratificó el alcance
acotado.

### 4.4 Redacción del elemento 7, cierre de la sección (P4)

**Archivo:** `50_documentacion/activa/50_contenido_seccion_formacion.md`, v5 → v6.
**Categoría temática:** Estructura de contenido. **Commit:** `62b8969`.

Título «Dónde seguir», texto de entrada, bloque del portafolio, bloque de
contacto con los dos correos institucionales del Área, y cierre de sección en
cursiva declarando el espacio en crecimiento. Verificado contra los siete
criterios del fundamento §9 en una tabla dentro del propio documento, con cinco
decisiones declaradas para revisión del titular.

Con este elemento, los cinco de la etapa 1 del fundamento §8 tienen texto. Falta
que tres de ellos tengan maqueta.

### 4.5 Archivado del código muerto del atlas (P13)

**Archivos:** `docs/atlas.js`, `docs/atlas.css` → `_archivo/20260805_atlas_muerto/`;
`docs/formacion.css`.
**Categoría temática:** Arquitectura del repositorio.
**Commits:** `f0f5f00`, `37d44ad`.

Decisión del titular entre tres opciones: archivar, no borrar. `_archivo/` está
ignorado por `.gitignore:5`, de modo que **ante git el movimiento equivale a un
borrado de `docs/` más dos archivos no versionados**; el contenido sobrevive en
el historial y el tablero en `wip/atlas_tablero_v3`. Se movió con `mv` y no con
`git mv` porque el destino no está versionado, y se dejó un `README.md` en el
directorio de archivo explicando qué eran, en qué commit dejaron de tener
consumidor y dónde vive la otra copia.

En el mismo lote salieron las dos reglas huérfanas `.fm-atlas-espera` y
`.fm-atlas-foot` (16 líneas con su comentario de bloque, llaves balanceadas
110/110 tras la edición).

**Cómo se verificó.** Antes: cero referencias vivas en los dos `.html` de `docs/`,
y `atlas.js` envuelto en una IIFE que no expone identificadores, de modo que
tampoco podía haber consumidor por nombre. Después: el sitio servido en local con
cero peticiones a los archivos archivados, y en producción HTTP 404 para ambos
contra 200 para `atlas_datos.js`.

### 4.6 Diagnóstico de ordenación del repositorio (P10, avanzado)

**Archivo:** `50_documentacion/activa/50_diagnostico_ordenacion_repositorio.md`,
321 líneas. **Categoría temática:** Arquitectura del repositorio.
**Commit:** `91993d8`.

Cuatro incumplimientos, cuatro casos dudosos declarados como dudosos, nueve
movimientos propuestos ordenados por riesgo, siete de ellos marcados como
decisión del titular. **Ningún movimiento ejecutado.**

**Desviación de nombre, deliberada y correcta.** El encargo pedía emitirlo como
`50_ordenacion_repositorio.md`. Ese nombre está reservado por SETTINGS §4.7.3
punto 7 como marcador de una ordenación **ya ejecutada**, y su sola existencia
apaga el gatillo de §1.2.2 punto 4bis. Emitirlo habría certificado como ordenado
un repositorio que no se movió. El ejecutor lo renombró a
`50_diagnostico_ordenacion_repositorio.md` y lo declaró.

### 4.7 Publicación (P11)

**Commit final publicado:** `22b7c5b`. **Rango:** `1dcbafe..22b7c5b`.

53 commits publicados, acumulados desde la sesión 13. Avance rápido, divergencia
`0 53` antes y `0 0` después. Sin `--force`, sin tags (el tag local `v2.1` no
viajó: `git push origin main` no los arrastra), sin tocar `wip/atlas_tablero_v3`,
que sigue siendo solo local. Workflow «Deploy static content to Pages», run
31007345692, `success` en 13 segundos a las 12:50:04Z.

---

## 5. Backlog acumulativo

Actualizado en `50_documentacion/activa/backlog_acumulativo.md`: 7 entradas
nuevas (128-134), total 127 → 134, sin reescritura ni renumeración de las
anteriores. Delta completo en la §6 de ese archivo.

---

## 6. Bugs de la sesión

Un bug de código, reportado por el titular con captura.

| Campo | Contenido |
|---|---|
| **Síntoma observable** | El objeto del recorrido se veía cortado por la derecha al elegir los nodos finales; el globo quedaba parcialmente fuera de la tarjeta |
| **Causa raíz** | El globo estaba fuera de `#fmRutaMapa`, el único elemento con `overflow-x`, y se posiciona con `margin-left` de hasta 976px sobre una pista de 1536px. En la maqueta la tarjeta medía 1600px y cabía; en producción no |
| **Solución exacta** | `docs/formacion.html`: pista y globo dentro de un `.fm-ruta-lienzo` común. `docs/formacion.css`: `.fm-ruta-lienzo { width: 1536px }`, tarjeta de 1600 a 1200px, `scroll-behavior: smooth`. `docs/formacion.js`: centrado del `scrollLeft` sobre el nodo elegido |
| **Criterio de verificación** | Con el paso 6 elegido, el globo se ve completo; el `body` no adquiere desplazamiento horizontal; al elegir una rama el mapa se desplaza solo |
| **Patrón general aprendido** | Un elemento que se posiciona en píxeles respecto de un plano debe vivir dentro del mismo contenedor que ese plano. Si el plano se desplaza y el elemento no, la relación se rompe en cuanto el contenedor deja de ser tan ancho como el plano |
| **Principios** | Verificación visual antes de commit: los nueve controles estáticos pasaron y el defecto seguía ahí |
| **Estado** | Resuelto |

---

## 7. Aprendizajes y restricciones descubiertas

1. **Un prototipo aprobado trae supuestos de ancho que la producción no
   hereda.** La maqueta fue aprobada en una tarjeta de 1600px, ancho que ninguna
   pantalla de trabajo del titular ofrece dentro del sitio. Regla: al trasladar un
   prototipo, listar qué medidas del prototipo son diseño y cuáles son andamiaje
   del entorno donde se aprobó. Qué pasa si se viola: se integra un objeto que
   funciona solo en el ancho en que se revisó.

2. **Los controles estáticos no sustituyen la revisión visual, y el orden
   importa.** Nueve controles programáticos en verde convivieron con un objeto
   visiblemente roto. Regla: el gate visual va después de los controles y antes
   del commit, nunca al revés.

3. **Un nombre de archivo puede ser un marcador de estado.**
   `50_ordenacion_repositorio.md` no es un nombre libre: su existencia apaga un
   gatillo de apertura. Regla: antes de nombrar un archivo en `50_documentacion/
   activa/`, verificar en SETTINGS si ese nombre está reservado por un protocolo.

4. **Corregir todas las ocurrencias de una ruta obsoleta puede ser
   destructivo.** Los documentos de memoria sellada afirman cosas sobre el pasado
   que eran ciertas al escribirse. Regla: distinguir referencias operativas (una
   ruta que alguien va a seguir) de enunciados históricos, y corregir solo las
   primeras.

5. **`git mv` no sirve cuando el destino está ignorado.** Ante git, mover a
   `_archivo/` es un borrado más un archivo no versionado. No es un problema, pero
   cambia el significado del commit y hay que declararlo.

---

## 8. Decisiones de diseño

| # | Decisión | Alternativas | Justificación | Implicancia |
|---|---|---|---|---|
| 1 | Segunda IIFE independiente en `formacion.js` | Bloque dentro de la IIFE existente con renombre de `pintar()` | Resuelve dos colisiones (`pintar` y `fila`) sin editar el código aprobado, y da guarda temprana propia | Dos unidades en un archivo; ninguna expone identificadores |
| 2 | Encabezado con el patrón del sitio, no el de la maqueta | Traslado literal del encabezado de la maqueta | Alineación con las demás secciones; evita un tercer estilo de título en la misma página | Cuatro reglas de la maqueta no se trasladaron |
| 3 | Tarjeta de 1200px con lienzo de 1536px desplazable | Tarjeta de 1600px como el prototipo; encoger la pista | La pista a 1536px es la medida en que los rótulos caben en una línea (aprendizaje de la sesión 16); lo que cede es la tarjeta, no el contenido | El objeto se navega por desplazamiento en toda pantalla menor a 1576px |
| 4 | Archivar `atlas.js` y `atlas.css`, no borrarlos | Borrar; dejarlos publicados | Quita 34 KB del sitio publicado sin apostar a que nunca se querrá mirar la única implementación del atlas | El contenido queda fuera del árbol versionado; su respaldo es el historial |
| 5 | Diagnóstico de ordenación con nombre propio | Emitirlo con el nombre reservado | El nombre reservado certifica una ordenación ejecutada | El gatillo de 4bis sigue activo, que es correcto: la ordenación no ocurrió |
| 6 | Publicar la etapa 1 incompleta | Esperar a los elementos 3, 4 y 6 | El fundamento §8 declara la etapa 1 publicable y el salto narrativo ya estaba aceptado en el plan §8 | La página salta del recorrido al catálogo, y el portafolio sigue en tercera persona mientras el cierre habla en primera |

---

## 9. Constantes y parámetros

| Constante | Valor anterior | Valor nuevo | Archivo | Motivo |
|---|---|---|---|---|
| Ancho de la tarjeta del recorrido | 1600px | 1200px | `docs/formacion.css`, `.fm-ruta` y `.fm-ruta-ancho` | El objeto se cortaba; el desplazamiento pasa a ser el modo de navegación |
| Ancho del plano desplazable | (no existía) | 1536px | `docs/formacion.css`, `.fm-ruta-lienzo` | Ancho de la pista, heredado del prototipo aprobado |

Las demás vigentes viven en `docs/colors_and_type.css` y `docs/styles.css` (los
catorce tokens del sistema visual) y en el objeto de datos `D` de la segunda IIFE
de `docs/formacion.js` (contenido del recorrido).

---

## 10. Arquitectura de archivos

Escáner al cierre: `50_documentacion/estructura/estructura_actual.md`, generado
2026-08-05 13:24:50, 16 carpetas y 121 archivos.

Cambios de estructura: `docs/` perdió `atlas.js` y `atlas.css`; `activa/` ganó
`50_diagnostico_ordenacion_repositorio.md`; `andamios/` ganó los dos encargos de
la sesión y `andamios/logs/` sus dos logs. La estructura respeta la política,
con la deuda conocida de `handoffs/`, cuyos nombres internos conservan espacios
por ser entregables de terceros.

---

## 11. Pendientes y ruta sugerida

### 11.1 Inventario

**P1 · Redacción de los elementos 3, 4 y 6 de la sección Formación**
Tipo: funcionalidad. Impacto: alto, es lo que falta para que la etapa 1 esté
completa y para que la página deje de saltar del recorrido al catálogo.
Dependencias: ninguna técnica; el fundamento §7 y §9 son el criterio.
Complejidad: alta (tres elementos, dos intentos por elemento según el
fundamento §10). Precaución: el elemento 3 usa un caso real del Área y debe
mantenerse en términos conceptuales, sin nombrar establecimientos.
Criterio de éxito: los tres textos aprobados por el titular contra los siete
criterios del fundamento §9.

**P2 · Decisión sobre los nueve movimientos del diagnóstico de ordenación**
Tipo: deuda técnica. Impacto: medio; el gatillo 4bis seguirá proponiendo la
ordenación en cada apertura hasta que se ejecute. Dependencias: **debe
resolverse antes P3**, porque el diagnóstico se hizo contra versiones anteriores
de la gobernanza. Complejidad: baja para decidir, media para ejecutar. Enfoque
sugerido: leer el diagnóstico, resolver los siete movimientos marcados como
decisión, y emitir un encargo de ejecución que termine creando
`50_ordenacion_repositorio.md`. Criterio de éxito: la comprobación `vigentes=1`
y el marcador creado.

**P3 · Desfase de versiones de la gobernanza en disco**
Tipo: bug de gobernanza. La knowledge base tiene POLITICA v5.6 y SETTINGS v16;
en disco están v5.5 y v15 (fuente: encabezados leídos en `/mnt/project/` esta
sesión y reporte de Claude Code). Impacto: alto y silencioso: todo encargo que
lea la copia en disco opera contra una versión anterior, y el diagnóstico de
ordenación ya lo hizo. Complejidad: baja, es un reemplazo manual de dos archivos.
Criterio de éxito: los encabezados en disco declaran v5.6 y v16.

**P4 · El recorrido en pantalla angosta**
Tipo: mejora visual. El globo quedó acotado a `max-width: 100%` bajo 720px, que
es mitigación. Impacto: medio; la sección es proyectable en taller y consultable
desde teléfono. Complejidad: media. Precaución: no resolverlo con
`overflow-wrap` ni `hyphens`, que disimulan el dimensionamiento.

**P5 · `index.html` a primera persona plural**
Tipo: funcionalidad. Impacto: medio, y **subió con la publicación**: el cierre
del elemento 7 remite a un portafolio en tercera persona, de modo que el lector
salta de «nosotros» a «el Área» en un clic. Origen: fundamento §5 y §11 tarea 1.

**P6 · Barra de navegación que exprese mandatos y no secciones**
Tipo: mejora visual. Depende de P5. Origen: fundamento §4 y §11 tarea 2.

**P7 · Renombre de identificadores internos de `ambito` a `desafio`**
Tipo: deuda técnica. `ATLAS_AMBITOS` en `atlas_datos.js`, el esquema de
`50_contrato_atlas_datos.md` §2.4 y el validador. La etiqueta visible ya se
renombró en esta sesión. Origen: fundamento §11 tarea 3.

**P8 · Las 38 fuentes pendientes del catálogo**
Tipo: bloqueante de difusión. Requiere descargas, revisión en navegador o
credenciales institucionales del titular. Origen: `solicitudes_al_titular.md` y
fundamento §8, regla de difusión.

**P9 · Destino del tablero en `wip/atlas_tablero_v3`**
Tipo: decisión. La rama sigue siendo local y es la única copia.

**P10 · Optimización del payload de capturas**
Tipo: deuda técnica. Varios archivos sobre 400 KB en `docs/assets/proyectos/`.

**P11 · Entrada de Simce 2025 en el portafolio**
Tipo: contenido. Tres briefs analíticos pendientes de incorporar.

**P12 · Peso Museo Sans 400 ausente**
Tipo: deuda técnica conocida. Las solicitudes de weight 400 resuelven en
silencio a 500.

### 11.2 Evaluación de deuda técnica

**Zonas frágiles.**

1. **`docs/formacion.js` tiene dos unidades en un archivo.** Es deliberado y está
   documentado, pero un tercer objeto interactivo en la misma página obligará a
   decidir si el archivo se parte. Principio en tensión: una responsabilidad por
   unidad contra no fragmentar un stack sin sistema de compilación.
2. **La geometría del recorrido depende de tres números acoplados**: 1536 en el
   lienzo, 1536 en la pista y `geo._w` calculado en el script. Cambiar uno sin los
   otros descuadra el conector de retorno.
3. **`_archivo/` no está versionado.** Lo que se archiva ahí depende del respaldo
   local del titular y del historial de git. Es la política vigente, pero conviene
   tenerlo presente antes de archivar algo que no exista en ningún commit.

**Oportunidades de mejora.** Los nueve movimientos del diagnóstico de ordenación,
ya inventariados y priorizados por riesgo.

### 11.3 Auditoría de cierre (política 5.6)

| # | Pregunta | Respuesta |
|---|---|---|
| 2 | ¿El pipeline corre de cero sin intervención manual? | No verificado en esta sesión: no se tocaron los tres scripts de R. Se declara como excepción, no como conformidad |
| 5 | ¿Cada transformación crítica tiene check de validación? | Sí para el sitio (nueve controles programáticos más verificación en navegador y en producción). Para el pipeline de datos, `32_validar_catalogo_fuentes.R` y `00_validar_atlas.js` siguen vigentes y no se ejecutaron |
| 6 | ¿Los outputs son reproducibles e idempotentes? | Sí. El sitio es estático y el despliegue lo produce el workflow desde `main`/`docs/` |
| 7 | ¿Decisiones metodológicas como constantes nombradas? | Parcial. Los tres números de geometría del recorrido están escritos en tres lugares distintos: es la zona frágil 2 y entra como pendiente |
| 8 | ¿Nombres sin tildes, ñ ni espacios? | Sí en todo lo generado esta sesión. La excepción conocida son los nombres internos de los paquetes de `handoffs/`, entregables de terceros |

Las respuestas parciales de las preguntas 2 y 7 quedan incorporadas al inventario
como parte de P2 y de la zona frágil 2.

### 11.4 Ruta sugerida para la próxima sesión

**Prioridad 1 · P3, sincronizar la gobernanza en disco.** Complejidad baja, y es
condición para que cualquier encargo posterior opere contra la versión correcta.
Criterio de éxito: encabezados en disco declarando v5.6 y v16.

**Prioridad 2 · P1, redacción del elemento 3.** Un elemento por sesión, no los
tres: el fundamento §10 concede dos intentos por elemento y el 3 es el que usa un
caso real, de modo que exige decisiones del titular sobre qué se cuenta y cómo.
Criterio de éxito: texto aprobado contra los siete criterios del fundamento §9.

**Prioridad 3 · P5, `index.html` a primera persona plural.** Subió de prioridad
al publicarse el cierre que remite al portafolio. Es texto, sin riesgo técnico.
Criterio de éxito: el portafolio habla en la misma voz que Formación.

**Conviene diferir:** P2 (sesión propia, mueve archivos y necesita P3 resuelto
antes), P4 (después de que la sección esté completa, para no rehacer el trabajo
responsivo dos veces), P6 (depende de P5), P7 (toca el contrato y el validador, y
merece su propio encargo), P8 (requiere credenciales y navegador del titular),
P9, P10, P11 y P12.

---

## 12. Instrucciones específicas para la próxima sesión

- ⚠️ **NO** emitir un encargo con premisas sobre ubicación de secciones, nombres
  de archivo o estado del repositorio sin haberlas verificado en el archivo real
  en la misma sesión. Cuatro errores de la sesión 17 tienen esa causa.
- ⚠️ **NO** dar por buena una integración porque los controles estáticos pasaron:
  el gate visual va antes del commit.
- ⚠️ **NO** escribir código de producción de un elemento de la sección Formación
  antes de que su maqueta esté revisada en navegador (fundamento §9).
- ⚠️ **NO** reinterpretar un prototipo desde una descripción en prosa cuando su
  código fuente está disponible: se traslada mecánicamente.
- ⚠️ **NO** reducir un ancho heredado de un diseño sin comprobar qué rótulos
  dejan de caber en una línea, ni resolver un desbordamiento con
  `overflow-wrap: break-word` o `hyphens: auto`.
- ⚠️ **NO** corregir todas las ocurrencias de una ruta obsoleta: distinguir
  referencias operativas de enunciados históricos en documentos de memoria
  sellada.
- ✅ **ANTES** de emitir cualquier encargo, releer los invariantes del encargo
  contra sus fases: en la sesión 17 un invariante prohibió editar un archivo que
  una fase ordenaba editar.
- ✅ **ANTES** de nombrar un archivo en `50_documentacion/activa/`, verificar en
  SETTINGS si ese nombre está reservado por un protocolo. `50_ordenacion_
  repositorio.md` es un marcador de estado, no un nombre libre.
- ✅ **ANTES** de ejecutar los movimientos del diagnóstico de ordenación,
  sincronizar POLITICA y SETTINGS en disco: el diagnóstico se hizo contra v5.5 y
  v15.
- 🔒 La rama `wip/atlas_tablero_v3` es la única copia del tablero: no se borra ni
  se reescribe sin decisión explícita.
- 🔒 Ningún `git push`, `--force`, `reset --hard` ni tag sin autorización
  explícita del titular.
- 🔒 Nunca `git add -A` ni `git add -f`; staging selectivo siempre. Los cuatro
  archivos de `50_documentacion/estructura/` no se commitean.
- 🔒 `docs/atlas_datos.js` alimenta la tabla de fuentes: no se toca sin verificar
  que la tabla sigue trayendo sus filas.
- 🔒 Ninguna cadena visible en mayúsculas sostenidas, ni escrita ni por
  `text-transform`. Solo siglas.
- 🔒 El texto de la sección no nombra establecimientos, personas ni
  identificadores, y no publica código.

---

## 13. Fragmentos de código de referencia

**Patrón nuevo de la sesión: dos unidades independientes en un archivo sin
sistema de compilación.**

```javascript
/* Unidad 1 — tabla de fuentes */
(function () {
  "use strict";
  var cuerpo = document.querySelector("#fmCuerpo");
  if (!cuerpo) return;              // guarda temprana propia
  function fila(f) { /* ... */ }    // este nombre no colisiona
  function pintar(lista) { /* ... */ }
})();

/* Unidad 2 — recorrido. Ámbito disjunto: los mismos nombres son otros. */
(function () {
  "use strict";
  var fila = document.querySelector("#fmRutaFila");   // aquí es un contenedor
  if (!fila) return;                                  // guarda temprana propia
  function pintar() { /* ... */ }
}());
```

Lo que compra: un fallo en una unidad no deja la otra sin renderizar, y los
nombres obvios (`fila`, `pintar`) se pueden repetir sin renombrar código ya
aprobado.

**Patrón nuevo: elemento posicionado en píxeles dentro del plano que se
desplaza.**

```css
.fm-ruta-mapa   { overflow-x: auto; scroll-behavior: smooth; }
.fm-ruta-lienzo { width: 1536px; }   /* el plano, no el contenedor */
```

```javascript
/* Tras anclar el elemento, centrar el plano sobre él. */
if (mapa) {
  var visible = mapa.clientWidth;
  mapa.scrollLeft = Math.max(0, Math.min(bc - visible / 2, geo._w - visible));
}
```

Los patrones estables del proyecto viven en `CLAUDE.md` y en
`50_documentacion/activa/POLITICA_PROYECTO.md`.

---

## 14. Reapertura

**Mensaje de apertura pre-armado:**

> Tipo CONTINUATION. El protocolo (`POLITICA_PROYECTO.md` v5.6 +
> `SETTINGS_Y_PROMPTS_OPERACIONALES.md` v16) vive en la knowledge base del
> Project; verifica que estén al día antes de empezar. Adjunto el traspaso v17,
> el escáner, el backlog, el fundamento y el contenido de la sección Formación.
> Esta sesión es la número 4 de la ruta de implementación de la sección
> Formación. El foco propuesto es sincronizar las copias de gobernanza en disco
> (están en v5.5 y v15 mientras la knowledge base va en v5.6 y v16) y redactar el
> elemento 3, el desafío educativo en detalle.
> Estado: sin bugs activos, sin bloqueantes, árbol limpio y `main` publicado.
> Documentos a adjuntar: `traspaso_cierre_v17.md`, `estructura_actual.md`,
> `backlog_acumulativo.md`, `50_fundamento_seccion_formacion.md`,
> `50_contenido_seccion_formacion.md`,
> `50_diagnostico_ordenacion_repositorio.md`.

**Documentos para la próxima sesión.**

1. *Protocolo en knowledge base (NO se adjuntan; se listan para verificar que
   esté al día):* `POLITICA_PROYECTO.md`, `SETTINGS_Y_PROMPTS_OPERACIONALES.md`.
2. *Opcionales según el foco real:* `CLAUDE.md` si correrá en Claude Code;
   `encargo_autonomo_claude_code_v1.md` si habrá encargos autónomos.
3. *Específicos de la sesión (SÍ se adjuntan):* `traspaso_cierre_v17.md`;
   `estructura_actual.md`; `backlog_acumulativo.md` (voluminoso pero crítico);
   `50_fundamento_seccion_formacion.md` (es el criterio contra el que se juzga el
   elemento 3); `50_contenido_seccion_formacion.md` (contiene los cinco elementos
   ya redactados, y el 3 debe mantener su registro);
   `50_diagnostico_ordenacion_repositorio.md` si se abordará P2.

**Nota final.** Si alguno de estos archivos cambia entre sesiones, adjuntar la
versión más actualizada al abrir y avisarlo en el mensaje de apertura. En
particular, `50_contenido_seccion_formacion.md` va en v6 desde esta sesión.

---

## 15. Errores del asistente

Cuatro errores registrados. Los cuatro comparten causa raíz: **premisas de
encargo escritas desde memoria en vez de verificadas en el archivo**. Ninguno
produjo daño en el repositorio, porque los tres primeros los detuvo la ejecución
y el cuarto lo resolvió el ejecutor declarándolo.

### Error 1 · Estilo de cierre de la primera IIFE

| Campo | Contenido |
|---|---|
| `momento` | Redacción del encargo `20260804_encargo_integracion_elemento2.md`, control 8 |
| `disparador` | Ejecutor lo detectó al correr el control |
| `que_paso` | El control 8 declaró que ambas IIFE cierran con `}());` cuando la primera, código preexistente, cierra con `})();` |
| `regla_violada` | `userPreferences`, marcador de fuente: premisa de encargo verificable en el archivo, no desde memoria |
| `causa_raiz` | Escribí la premisa desde la forma de la unidad que yo había redactado, y la generalicé a la unidad que ya existía sin leerla |
| `salvaguarda_presente` | `userPreferences` y `encargo_autonomo_claude_code_v1.md` |
| `patron` | `PAT-01`, sobre forma sintáctica de código no leído |
| `gatillo_observable` | `encargos-premisas`: el encargo afirma una forma de código que no se leyó en la sesión |
| `intentos_previos` | 0 |
| `costo` | Ninguno en el repositorio; un control reformulado por el ejecutor y un párrafo de diagnóstico en el log |

### Error 2 · Justificación falsa sobre el ignorado de `andamios/`

| Campo | Contenido |
|---|---|
| `momento` | Redacción del mismo encargo, §5, log de cierre |
| `disparador` | Ejecutor lo señaló tras verificar con `git check-ignore` |
| `que_paso` | Afirmé que el log no se commitea «porque `andamios/` está ignorado»; `.gitignore` reabre `andamios/logs/*.md` desde la sesión 15, de modo que sí es versionable |
| `regla_violada` | POLITICA 0.6 y `userPreferences`, marcador de fuente: afirmación sobre el contenido de un archivo no leído en la sesión, emitida sin marcador de hipótesis |
| `causa_raiz` | Di por vigente un estado del `.gitignore` anterior a la sesión 15 sin abrir el archivo |
| `salvaguarda_presente` | POLITICA, `userPreferences` |
| `patron` | `PAT-01`, sobre estado de ignorado de git |
| `gatillo_observable` | `estado-git`: se afirma el ignorado de una ruta sin `check-ignore` en la sesión |
| `intentos_previos` | 0 |
| `costo` | Ninguno; el log quedó sin commitear una ronda y se commiteó después |

### Error 3 · Ubicación de la §4.7

| Campo | Contenido |
|---|---|
| `momento` | Redacción del encargo `20260805_encargo_higiene_repositorio.md`, Fase 3 |
| `disparador` | Ejecutor lo detectó al no encontrar la sección |
| `que_paso` | El encargo ubicó la §4.7 en `POLITICA_PROYECTO.md`; vive en `SETTINGS_Y_PROMPTS_OPERACIONALES.md`, y la §4 de la política es el orquestador y no tiene subsecciones |
| `regla_violada` | `userPreferences`, marcador de fuente: cita de sección de un documento sin verificar en él |
| `causa_raiz` | Reconstruí la referencia de memoria a partir del gatillo 4bis, que sí había leído, sin volver al documento para localizar la sección |
| `salvaguarda_presente` | `userPreferences`; el documento estaba disponible en la knowledge base durante la redacción |
| `patron` | `PAT-01`, sobre ubicación de sección normativa |
| `gatillo_observable` | `encargos-premisas`: el encargo cita documento y sección sin haberlos abierto en la sesión |
| `intentos_previos` | 0 |
| `costo` | Ninguno; el ejecutor localizó la sección real y siguió |

### Error 4 · Contradicción interna del encargo

| Campo | Contenido |
|---|---|
| `momento` | Mismo encargo: invariante §2 contra Fase 2.3 |
| `disparador` | Ejecutor lo declaró antes de actuar |
| `que_paso` | El invariante §2 prohibió editar `docs/formacion.css` y la Fase 2.3 ordenó editarlo para retirar las dos reglas huérfanas |
| `regla_violada` | `encargo_autonomo_claude_code_v1.md`: los invariantes y las fases deben ser consistentes entre sí |
| `causa_raiz` | Escribí los invariantes copiando el patrón del encargo anterior (donde `docs/` era intocable) sin releerlos contra las fases del encargo nuevo, donde sí había una edición prevista |
| `salvaguarda_presente` | `encargo_autonomo_claude_code_v1.md` |
| `patron` | `PAT-01`, sobre coherencia interna del propio artefacto |
| `gatillo_observable` | `encargos-premisas`: dos secciones del mismo encargo mandan cosas opuestas sobre el mismo archivo |
| `intentos_previos` | 0 |
| `costo` | Ninguno; el ejecutor resolvió a favor de la instrucción específica y lo declaró |

**Patrón agregado de la sesión.** Cuatro errores, un solo mecanismo: al redactar
encargos, escribí premisas verificables (forma de un código, estado de git,
ubicación de una sección, coherencia de mi propio texto) desde memoria o por
analogía con el encargo anterior, en vez de abrir el archivo. La salvaguarda que
funcionó no fue una regla mía sino la regla de detención del encargo, que el
ejecutor aplicó las cuatro veces. Salvaguarda propuesta para la próxima sesión:
antes de entregar un encargo, releer sus premisas verificables una por una y
marcar cada una con el comando o archivo que la respalda; las que no tengan
respaldo, o se verifican o se declaran como hipótesis dentro del propio encargo.
