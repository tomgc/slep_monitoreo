# Traspaso de cierre — `slep_monitoreo` v09

## 1. Identificación

- **Proyecto:** `slep_monitoreo` — sitio institucional estático del Área de Monitoreo y Seguimiento de Procesos y Resultados Educativos, SLEP Costa Central.
- **Versión del traspaso:** v09 (correlativo global).
- **Fecha de cierre:** 2026-07-30.
- **Sesión:** 9. **Foco:** reconciliar el repositorio tras la sesión paralela e implementar el rediseño del portafolio entregado por Claude Design, cerrando por encargo autónomo la deuda operativa acumulada.
- **Modelo:** Claude Opus 5.
- **Entorno:** macOS, `/Users/tomgc/Projects/slep_monitoreo`, rama `main`, remoto `https://github.com/tomgc/slep_monitoreo.git`, publicación por GitHub Pages desde `main` y la carpeta `docs/`. Repositorio **público**.
- **Modo de trabajo:** asistente-de-Claude-Code. El asistente analiza, decide metodología y entrega archivos completos; Claude Code ejecuta en disco. En esta sesión se incorporó por primera vez el patrón de **encargo autónomo dirigido por meta** (`encargo_autonomo_claude_code_v1.md` v1.1).
- **Archivos principales modificados:** `docs/app.js`, `docs/styles.css`, `docs/index.html`, `.gitignore`, `docs/assets/proyectos/*.png` (24 de 26), `50_documentacion/activa/50_catalogo_project_cards.md` (nuevo), `50_documentacion/andamios/20260729_encargo_cierre_sesion09.md` (nuevo), `50_documentacion/andamios/logs/20260729_cierre_operativo_log.md` (nuevo).

---

## 2. Resumen ejecutivo

La sesión abrió con el repositorio inconsistente por una sesión paralela y con la prioridad 1 fijada en reconciliarlo. La reconciliación resultó lineal y no destructiva: `main` estaba ocho commits atrás, `gobernanza/v14` dos adelante y dos ramas `chore/pages-*` sobrevivían tras sus PR, de modo que bastó commitear lo heredado sin versionar, avanzar por `merge --ff-only` y borrar las tres ramas residuales. En el camino se detectó que el avance rápido había revertido, como efecto colateral y sin decisión declarada, el blindaje de los documentos de protocolo en un repositorio público; se restauró. El cuerpo de la sesión fue la integración del handoff de Claude Design: el "pliego de capturas" reemplaza la lista de banners por una franja por proyecto, con las capturas a altura normalizada y ancho natural recorridas en horizontal, y llegó a producción tras cuatro rondas de ajuste pedidas por el titular (conteo de capturas eliminado, truncado del resumen suprimido por completo, chip de estado bajo el título, columna de texto ensanchada y el indicador de desplazamiento convertido en carrusel operable). Se materializó además el encargo del catálogo de Project Cards, que fija la arquitectura de fuente única en `data.js` para que el catálogo impreso y el sitio no diverjan. La deuda operativa se agrupó en un encargo autónomo a Claude Code que cerró el pendiente de optimización de capturas arrastrado desde la sesión 6 (9,21 MB → 2,39 MB) y produjo el inventario de las cinco ramas remotas `claude/*` sin tocarlas. Quedan como gate del titular esas ramas, y como trabajo suyo entre sesiones la Fase 0 del catálogo. El estado general es sano: sitio funcional, repositorio sincronizado hasta `84a415b` y sin ramas residuales.

---

## 3. Estado al cierre

### Qué funciona

| Elemento | Verificación |
|---|---|
| Sitio en producción | `https://tomgc.github.io/slep_monitoreo/`, publicado desde `main` + `docs/` |
| Pliego de capturas | render de las 12 franjas, `node --check docs/app.js` = 0 |
| Carrusel del pasador | botones prev/next operables, avance por captura, se ocultan con una sola captura |
| Lightbox y visor full-res | intactos, no se tocaron (invariante del handoff) |
| Apertura en captura concreta | `openLightbox(p, startIndex)` |
| Capturas optimizadas | 26 archivos, 2,39 MB, dimensiones idénticas verificadas por dos vías |
| Repositorio | `main` = `84a415b` sincronizada con `origin/main` al momento del último push; sin ramas locales residuales |
| Blindaje de gobernanza | `POLITICA_PROYECTO.md`, `SETTINGS_Y_PROMPTS_OPERACIONALES.md` y `50_documentacion/traspasos/**` fuera del repositorio público |

### Qué no funciona o quedó a medias

| Elemento | Síntoma observable |
|---|---|
| Acento de color en capturas recomprimidas | en `parvularia-2.png`, el marcador naranja del ítem activo de la barra lateral pierde saturación por cuantización a paleta; el texto y las cifras quedan legibles |
| Legibilidad auditada parcialmente | se inspeccionó 1 de 26 capturas (la de mayor reducción); no es muestra exhaustiva |
| Cinco ramas remotas `claude/*` | vivas, cuatro de proyectos ajenos, ninguna fusionable sin riesgo |
| Tokens `--banner-*` y reglas `body[data-variant] .banner` | huérfanos en `styles.css` tras el pliego; inertes, no rompen nada |

### Delta respecto a v08

- v08 cerró con el repositorio inconsistente por una sesión paralela: **resuelto**.
- v08 dejó el rediseño del portafolio delegado a Claude Design, con el encargo escrito y sin implementación: **implementado**.
- v08 registró la optimización de capturas como intentada y abortada (entrada 58): **ejecutada** (entrada 66).
- v08 no conocía las cinco ramas remotas `claude/*`: **inventariadas**, sin acción.
- Aparecen dos artefactos nuevos de tipo andamio (`50_documentacion/andamios/`), inexistentes hasta v08.

---

## 4. Registro detallado de cambios

### 4.1 Reconciliación del repositorio (`bb5cf68`, `19d0b99`)

- **Archivos:** `50_documentacion/activa/ESTADO.md`, `50_documentacion/activa/encargo_diseno_portafolio.md`, `50_documentacion/estructura/*` (4).
- **Categoría:** Arquitectura del repositorio.
- **Qué:** dos commits (documental y escáner), avance de `main` por `merge --ff-only` desde `gobernanza/v14`, borrado de `chore/pages-docs`, `chore/pages-workflow` y `gobernanza/v14` local y remotamente.
- **Por qué:** `git branch -vv` mostró que no había divergencia sino desfase lineal; las dos `chore/*` ya estaban absorbidas por los PR #4 y #5.
- **Cómo se verificó:** `git log --all --oneline`, `git branch -a -vv` antes y después; `git status` limpio.
- **Tensión resuelta:** la política de proyecto trata los cuatro archivos de `50_documentacion/estructura/` como ruido permanente del escáner que jamás se commitea (aprendizaje de v07). Aquí sí se commitearon, porque su diff no era una re-corrida idéntica sino el reflejo del traslado real del sitio a `docs/`. La regla se mantiene con su excepción declarada: se commitean cuando el diff es sustantivo.

### 4.2 Restauración del blindaje de protocolo (`d5b9f45`)

- **Archivos:** `.gitignore`; desindexación de `50_documentacion/activa/POLITICA_PROYECTO.md` y `SETTINGS_Y_PROMPTS_OPERACIONALES.md`.
- **Categoría:** Arquitectura del repositorio.
- **Qué:** `.gitignore` por nombre exacto más `git rm --cached`, que desindexa sin borrar del disco.
- **Por qué:** el `merge --ff-only` de 4.1 trajo `56f8dc7` de la sesión paralela, que devolvió ambos documentos al repositorio público revirtiendo las entradas 35 y 43 del backlog sin decisión declarada. Que Pages publique solo `docs/` resuelve la exposición por el sitio, no la exposición por GitHub.
- **Cómo se verificó:** `ls -la 50_documentacion/activa/` (ambos presentes, 40 KB y 83,7 KB), `git status --short` (ambos como `D` en el índice), `tail -6 .gitignore`.
- **Decisión del titular:** se le presentaron las dos opciones (mantener la reversión o restaurar) y eligió la recomendación.

### 4.3 Blindaje del archivado de traspasos (`79b2579`)

- **Archivos:** `.gitignore`; movimiento de `traspaso_cierre_v01..v08.md` a `50_documentacion/traspasos/archivo/`.
- **Categoría:** Arquitectura del repositorio.
- **Qué:** el patrón pasó de `50_documentacion/traspasos/*.md` a `50_documentacion/traspasos/**`.
- **Por qué:** `*.md` cubre un solo nivel; al crear `archivo/` los ocho traspasos aparecieron como `??` y habrían quedado versionables en un repositorio público.
- **Cómo se verificó:** `git check-ignore -v 50_documentacion/traspasos/archivo/traspaso_cierre_v01.md` devuelve la regla que lo cubre.
- **Desviación declarada:** SETTINGS §2.1 exige `git mv` para conservar `git log --follow`. Se usó `mv` plano porque los traspasos nunca estuvieron trackeados y `git mv` habría fallado.

### 4.4 Pliego de capturas (`0c9adee`)

- **Archivos:** `docs/app.js`, `docs/styles.css`, `docs/index.html`.
- **Categoría:** Layout y composición.
- **Qué:** `bannerEl()` y `renderBanners()` reemplazadas por `bandEl()` y `renderPliego()`; el bloque "PORTAFOLIO — banners" de `styles.css` (líneas 207-279 del archivo previo) reemplazado por el CSS del pliego; `#bannerList` → `#pliego` en `index.html` y `section-lede` reescrito.
- **Por qué:** las capturas quedaban subordinadas al texto y no se veían a tamaño útil sin abrir el lightbox.
- **Cómo se verificó:** `node --check` = 0; `grep` sin residuos de `bannerEl`, `renderBanners`, `banner-list`, `#bannerList`; 37 reglas `.pl-` presentes; contraste de `git hash-object` entre los archivos generados y los de disco antes de cada commit.
- **Seis trampas del handoff, no documentadas en su README:** ver §7.

### 4.5 Ajustes iterativos del pliego (parte de `0c9adee`)

Cuatro rondas pedidas por el titular sobre la primera implementación, cada una un cambio conceptualmente independiente pero commiteadas juntas por corresponder a un único artefacto en revisión:

1. Eliminación del conteo "N capturas" (`conteoLabel()` y `.pl-count`).
2. Supresión total del truncado del resumen. El JS cortaba a 170 caracteres y el CSS a cuatro líneas con `-webkit-line-clamp`; **el CSS cortaba primero**, así que subir el tope del JS no cambiaba nada visible. Se eliminó `resumenCorto()` completa y el `line-clamp`: la franja imprime el `objetivo` íntegro.
3. Campo de proyectos sin capturas: fondo `--ocean-20` del handoff reemplazado por transparente con hairline `--line` y textos neutros, para que pase desapercibido.
4. Chip de estado movido bajo el número y el tipo, y columna de texto de 240px a 320px.

### 4.6 Carrusel del pasador (parte de `0c9adee`)

- **Archivos:** `docs/app.js` (`navEl()`, `desplazarPasador()`, `marcarDesplazamiento()`), `docs/styles.css` (`.pl-nav`, `.pl-scroll::before`).
- **Categoría:** Interacción y JS.
- **Qué:** el indicador pasó de `<span>` decorativo con `pointer-events: none` a dos `<button>` reales con `aria-label`, avance hasta el borde de la captura siguiente, degradado y control simétricos a ambos lados, hover opaco invertido y `:active` hundido.
- **Por qué:** el titular pidió un control, no una señal. El error fue de concepto, no de estilo.
- **Detalles que costaron una ronda cada uno:** el glifo `›` de Museo Sans se dibuja como línea fina y a 20px es casi invisible (se reemplazó por SVG con trazo de 2,4px); el fondo `rgba(255,255,255,0.72)` desaparece sobre capturas claras (se pasó a `--paper` opaco con sombra); y una captura sola más ancha que la franja satisface `scrollWidth > clientWidth` sin tener "más capturas" que anunciar (se agregó el guard de menos de dos capturas).

### 4.7 Encargo del catálogo de Project Cards (`e790582`, `84a415b`)

- **Archivo:** `50_documentacion/activa/50_catalogo_project_cards.md`.
- **Categoría:** Estructura de contenido.
- **Qué:** encargo completo con taxonomía, esquema de campos, enum de madurez, política de QR, gobernanza de impresión y cinco fases.
- **Por qué:** ver §8.1.
- **Corrección posterior (`84a415b`):** `data.js` no tiene campo `id`; los slugs que el backlog usa desde la sesión 6 viven solo en los nombres de archivo de las capturas, y los tres proyectos con `imgs: []` no tienen ninguno.

### 4.8 Optimización de las 26 capturas (sin commitear al cierre)

- **Archivos:** `docs/assets/proyectos/*.png` (24 de 26).
- **Categoría:** Reproducibilidad y tooling.
- **Qué:** `pngquant --quality=70-92 --speed 1` sobre los 24 que superaban 250 KB. 9,21 MB → 2,39 MB (−74%).
- **Cómo se verificó:** respaldo íntegro previo en `_archivo/20260729/capturas_originales/` (26 archivos, 9,3 MB); dimensiones comparadas por `sips` y, de forma independiente, por lectura cruda del chunk IHDR en Python; nómina comparada por `diff` de listados; `git status --short docs/` sin altas ni bajas.
- **Restricción del entorno:** `oxipng` no está instalado, así que la pasada sin pérdida nunca corrió y toda la compresión es con pérdida.

---

## 5. Backlog acumulativo

Vive en `50_documentacion/activa/backlog_acumulativo.md` (archivo canónico, POLITICA §10). Esta sesión agrega las entradas **59-69** y consolida las **54-58** que v08 había dejado provisionales. Total acumulado: **69 entradas**.

**Delta de esta sesión:** 11 entradas nuevas, sin reescritura ni renumeración de las anteriores. Se confirmaron las dos categorías que v08 dejó pendientes de contrastar contra el catálogo de §3 (entradas 56 y 57 → Documentación). Se cerraron los pendientes de optimización de capturas de las entradas 46 y 58. Se registró en el delta la corrección de la numeración provisional anunciada en el chat durante la sesión.

---

## 6. Bugs de la sesión

**Ningún bug de código propio del proyecto.** Sí hubo tres defectos introducidos por el asistente durante la iteración del pliego y corregidos dentro de la misma sesión; se registran aquí por tener causa raíz técnica identificable y patrón general aprendido, y además en §15 por ser desviaciones del asistente.

### 6.1 Doble truncado del resumen de la franja

- **Síntoma observable:** el titular reportó dos veces textos cortados ("de los jardines infantiles del…") pese a que el tope de caracteres se había subido de 170 a 260.
- **Causa raíz:** dos mecanismos de corte independientes actuando sobre el mismo texto. `resumenCorto()` en `app.js` cortaba por caracteres; `.pl-resumen` en `styles.css` cortaba por `-webkit-line-clamp: 4`. En una columna de 240px a 13px, cuatro líneas son ~120 caracteres: **el CSS cortaba siempre primero**, así que ajustar el JS no producía ningún cambio visible.
- **Solución exacta:** eliminación de `resumenCorto()` completa en `app.js` y del `-webkit-line-clamp` en la regla `.pl-resumen` de `styles.css`. La franja imprime `p.objetivo` íntegro.
- **Criterio de verificación:** `grep -nE "…|line-clamp" app.js styles.css` sin coincidencias en el código de render.
- **Patrón general aprendido:** cuando un síntoma persiste tras corregir el mecanismo que se cree responsable, la hipótesis siguiente no es "el tope quedó corto" sino "hay un segundo mecanismo actuando". Dos capas que recortan el mismo contenido son siempre un defecto de diseño, no una redundancia defensiva: se elimina una.
- **Principio aplicado:** C.11 (causa raíz, no síntoma). **Violado antes de corregir:** el mismo, al asumir que el corte visible provenía del único mecanismo que yo había escrito.
- **Estado:** resuelto.

### 6.2 Indicador de desplazamiento construido como decoración

- **Síntoma observable:** el titular reportó que la flecha "apenas se ve" y luego que "no sirve de nada más que para apuntar, es estática".
- **Causa raíz:** el pedido original ("una flecha semitransparente o algo que indique que si hace scroll para el lado verá más capturas") se implementó literalmente como señal (`<span>` con `pointer-events: none`), cuando la intención era un affordance operable. Sumado a eso, el glifo `›` de Museo Sans se dibuja como línea fina y a 20px sobre fondo `rgba(255,255,255,0.72)` era ilegible.
- **Solución exacta:** `navEl()` en `app.js` produce dos `<button type="button">` con `aria-label` y handler; `desplazarPasador()` avanza al borde de la captura siguiente; `.pl-nav` en `styles.css` con fondo `--paper` opaco, borde `--line-strong`, sombra e inversión a azul institucional en hover.
- **Criterio de verificación:** el botón debe responder al click desplazando el pasador, apagarse en el extremo y no aparecer con menos de dos capturas.
- **Patrón general aprendido:** cuando el titular describe un elemento por lo que debe *comunicar* ("algo que indique que hay más"), preguntar o asumir que también debe *operar*. Un indicador que apunta a una acción disponible y no la ejecuta obliga al usuario a descubrir el gesto por su cuenta; en una interfaz de escritorio sin gesto táctil, eso es un callejón.
- **Estado:** resuelto.

### 6.3 Falso positivo del indicador con una sola captura

- **Síntoma observable:** en el proyecto `ael`, con una única captura, aparecía la flecha.
- **Causa raíz:** `marcarDesplazamiento()` decidía por `scrollWidth > clientWidth`. `ael-1.png` a 266px de altura es más ancha que la franja, así que el pasador efectivamente se desplaza; la condición era verdadera y el render, correcto. El error era de criterio: la flecha anuncia "más capturas", no "más píxeles de esta captura".
- **Solución exacta:** guard `if (s.querySelectorAll(".pl-shot").length < 2) { ... return; }` al inicio de `marcarDesplazamiento()`.
- **Patrón general aprendido:** una condición técnica correcta puede ser el predicado equivocado. Antes de codificar un `if`, formular en palabras qué afirma para el usuario y comprobar que esa afirmación sea la que se quiere hacer.
- **Estado:** resuelto.

---

## 7. Aprendizajes y restricciones descubiertas

1. **Un `grep` sin coincidencias devuelve 1 y rompe todo `&&` posterior.** Los pasos de verificación encadenados con `&&` se saltan en silencio cuando un `grep` de control no encuentra nada. *Contexto:* en esta sesión un commit se publicó sin su chequeo de privacidad porque la cadena se cortó antes. *Regla:* todo paso de verificación va con `;` o `|| true`, nunca encadenado con `&&` a lo que debe condicionar. *Principio:* B.4 (verificación observable).

2. **El handoff de una herramienta de diseño necesita auditoría de integración, no solo lectura.** El bundle de Claude Design traía código "listo para pegar" con seis trampas que su README no menciona: (a) `.estado` vivía dentro del bloque a reemplazar y el CSS nuevo no lo redefine; (b) `portafolio.js` redeclaraba `estadoLabel`, ya presente en `app.js`, lo que produce `SyntaxError` y sitio en blanco; (c) el código empieza en ámbito global mientras `app.js` es un IIFE; (d) `.pl-foot` tenía CSS sin markup que lo emitiera; (e) los tokens `--banner-*` quedaban huérfanos; (f) las capturas pasaban de estar tras un click a renderizarse en página, lo que reclasifica una deuda de peso. *Regla:* antes de integrar un handoff, contrastar sus selectores y sus identificadores contra el archivo destino completo, no solo contra el bloque que dice reemplazar. *Principio:* B.1 (sin supuestos implícitos).

3. **`[hidden]` y `pointer-events: none` son la misma clase de trampa.** El proyecto ya había aprendido que `[hidden]` es inerte si una regla de autor fija `display` (entradas 39 y 49). Esta sesión agrega el reverso: un elemento con `pointer-events: none` es visualmente indistinguible de uno operable. *Regla:* al construir cualquier elemento que parezca un control, declarar explícitamente si lo es; si no lo es, que tampoco lo parezca. *Principio:* accesibilidad y honestidad de la interfaz.

4. **El escáner rota un par fijo `actual`/`anterior` y cada corrida pisa.** Correrlo dos veces en la misma sesión deja `estructura_anterior.*` con un snapshot intermedio espurio y pierde el punto de comparación útil. *Regla:* el escáner corre **una sola vez** por sesión, al final y después de todo movimiento de archivos. *Origen:* deducido por Claude Code durante el encargo autónomo; no estaba en el encargo ni en el protocolo.

5. **Una cifra declarada en un encargo es una premisa que la ejecución verificará.** El encargo declaró 11 archivos y 4 `.dc.html` en el handoff; había 10 y 3. La detención fue correcta y detuvo dos fases. *Regla:* toda cifra que entre a un encargo se recuenta programáticamente en el momento de redactarlo; leerla de un inventario generado horas antes no es contarla. *Principio:* la regla de fuente de `userPreferences` (una cifra solo admite recuento programático del mismo turno).

6. **La renumeración de fases invalida las referencias cruzadas del propio documento.** Al insertar una fase intermedia en el encargo, el invariante 🔒 I8 quedó apuntando a "la fase 3" cuando su objeto había pasado a ser la 4. *Regla:* los invariantes se refieren a su objeto por nombre ("la fase de inventario de ramas"), no por número.

7. **`pngquant` cuantiza a paleta y sacrifica primero los acentos de color aislados.** Un marcador de pocos píxeles muy saturado sobre un fondo de otro tono es el primer candidato a perder su entrada de paleta, aunque todo el texto sobreviva intacto. *Regla:* al auditar una recompresión con pérdida sobre capturas de tableros, mirar los acentos de color saturado sobre fondos oscuros, no solo la legibilidad del texto.

---

## 8. Decisiones de diseño

### 8.1 Catálogo de Project Cards: fuente única en `data.js`

- **Decisión:** el catálogo impreso y el sitio se generan del mismo `docs/data.js` extendido; las tarjetas se producen con `docs/cards.html` más `@page` A5 impreso a PDF desde el navegador.
- **Alternativas consideradas:** (A) diseño manual en Canva o InDesign, rápido para tres tarjetas e insostenible a doce, sin vínculo con el sitio; (C) proyecto hermano en R con Quarto o typst, mejor control tipográfico de imprenta pero con repositorio y ciclo de vida propios.
- **Justificación:** el contenido de las tarjetas es casi el mismo de `data.js`, y el sitio ya cubre los niveles 3 a 5 de la escala de evolución que el propio documento fuente define. El riesgo real del proyecto es duplicar la fuente y que las dos versiones diverjan a la primera corrección.
- **Tensión resuelta:** control de imprenta (CMYK, sangrado) contra unicidad de la fuente. Se resolvió a favor de la unicidad, dejando explícito que si la imprenta exige control de CMYK la opción C se reevalúa sobre datos ya normalizados.
- **Implicancia:** `data.js` gana once campos nuevos, y `id` pasa a ser prerrequisito de los enlaces profundos y de los QR.

### 8.2 `id` y `codigo` coexisten

- **Decisión:** agregar un campo `id` (slug legible) además del `codigo` de catálogo (`GES-01`).
- **Alternativas:** derivar el slug del nombre de archivo de `imgs[0]` (se rompe en los tres proyectos sin capturas); usar `codigo` como llave única de URL.
- **Justificación:** son identificadores de audiencias distintas. `id` es la llave de la URL, compartible por correo; `codigo` es la referencia impresa que se dice en voz alta en una reunión. Colapsarlos haría que reclasificar un proyecto de categoría rompiera enlaces ya compartidos.

### 8.3 `madurez` no reemplaza a `estado`

- **Decisión:** agregar `madurez` con el enum de seis valores del documento fuente y **no** tocar `estado`.
- **Justificación:** son dos ejes. `estado` responde "¿se muestra publicado en el sitio?" y controla el render; `madurez` responde "¿en qué punto de su ciclo está?". Colapsarlos obligaría a decidir si un piloto en marcha es "vigente" o "desarrollo", pregunta que hoy no existe.

### 8.4 Agrupar la deuda mecánica en un encargo autónomo

- **Decisión:** en vez de ejecutar los pendientes uno a uno en el chat, agrupar commits, archivado, escáner, inventario de ramas y optimización de capturas en un solo encargo dirigido por meta.
- **Justificación:** la optimización de 26 PNG estaba planificada como sesión completa de la número 10; delegada al encargo, dejó de ocupar una sesión. El reparto se hizo por naturaleza de la tarea: lo mecánico y lo medible va al encargo; la autoría de archivos y las decisiones de metodología no se delegan.
- **Implicancia:** la sesión 10 abre con funcionalidad, no con deuda.

### 8.5 El campo vacío del pliego pierde el azul del handoff

- **Decisión:** los proyectos sin capturas usan fondo transparente con hairline `--line`, no el `--ocean-20` que el handoff especifica.
- **Justificación:** pedido explícito del titular ("ocupa mucha tinta, tiene que pasar desapercibido"). Un campo azul saturado en tres de doce franjas convierte la ausencia de capturas en el elemento más llamativo de la página.
- **Tensión resuelta:** fidelidad al handoff contra jerarquía visual. Se documenta como desviación deliberada del entregable de diseño.

---

## 9. Constantes y parámetros

| Constante | Valor anterior | Valor nuevo | Archivo | Motivo |
|---|---|---|---|---|
| Columna de texto de la franja | 240px | 320px | `docs/styles.css` (`.pl-band`) | el `objetivo` íntegro necesitaba menos líneas |
| Altura normalizada de captura | (no existía) | 266px escritorio / 176px móvil | `docs/styles.css` (`.pl-shot img`) | del handoff |
| Tope del resumen de la franja | 170 caracteres | eliminado | `docs/app.js` | ningún mecanismo de corte podía garantizar no cortar |
| Umbral de peso por captura | (no existía) | 250 KB | encargo, fase 5 | criterio de término verificable |
| Rango de calidad de recompresión | (no existía) | `--quality=70-92` | encargo, fase 5.5 | pérdida controlada preservando texto |

Las constantes de identidad (paleta, escala tipográfica, espaciado) viven en `docs/colors_and_type.css` y no cambiaron. Las de la sesión que aún no viven en código son las del catálogo de Project Cards (códigos de categoría, enum de madurez, topes de palabras por campo), completas en `50_documentacion/activa/50_catalogo_project_cards.md`.

---

## 10. Arquitectura de archivos

Escáner al cierre: `50_documentacion/estructura/estructura_actual.md`, generado 2026-07-30 06:07:53. **13 carpetas, 70 archivos.**

Cambios estructurales de la sesión:

- **Nueva** `50_documentacion/andamios/` con `20260729_encargo_cierre_sesion09.md` y `logs/20260729_cierre_operativo_log.md`. Primera adopción del patrón de andamios en este proyecto.
- **Nueva** `50_documentacion/traspasos/archivo/` con los ocho traspasos v01-v08. `traspasos/` queda con un solo `.md` vigente, como exige SETTINGS §2.1.
- **Eliminada del árbol vivo** `design_handoff_portafolio_pliego/`, archivada en `_archivo/20260729/handoff_diseno/` (11 entradas declaradas, 10 reales).
- **Nuevo** `50_documentacion/activa/50_catalogo_project_cards.md`.
- `docs/assets/proyectos/` pasa de 9,21 MB a 2,39 MB sin cambiar de nómina ni de dimensiones.

Verificación contra la política: los nombres nuevos son snake_case sin tildes ni espacios (POLITICA §2). El único incumplimiento conocido son los `.dc.html` del handoff, con espacios y paréntesis, y por eso se archivaron en vez de versionarse.

---

## 11. Pendientes y ruta sugerida

### 11.1 Inventario

| # | Pendiente | Tipo | Impacto | Dependencias | Complejidad | Criterio de éxito |
|---|---|---|---|---|---|---|
| P1 | Commitear el cierre: escáner, capturas optimizadas, traspaso v09, backlog, `ESTADO.md`, andamios | administrativo | bloquea el arranque limpio de la sesión 10 | gate visual de las capturas | baja | `git status --short` limpio y `main` sincronizada |
| P2 | Catálogo Project Cards, Fase 0: aprobar taxonomía y asignar los 12 valores de `madurez` | del titular | bloquea las fases 1-4 del catálogo | ninguna | baja, pero son 24 decisiones | archivo editado y devuelto |
| P3 | Catálogo, Fase 1: campo `id` en los 12 proyectos y enlaces profundos `#p=<id>` en `app.js` | funcionalidad | prerrequisito de todos los QR; útil por sí solo para compartir un proyecto | P2 | media | abrir `#p=asistencia` despliega esa reseña |
| P4 | Atlas de datos educativos: segunda página del sitio | nuevo | define la navegación del sitio, hoy inexistente | mockup de Claude Design; decisión de navegación | alta | esquema de `fuentes.js` aprobado y página con la tabla filtrable |
| P5 | Gate de las cinco ramas remotas `claude/*` | deuda heredada | un merge accidental sobrescribiría el docroot histórico | ninguna | baja | ramas ajenas borradas o documentadas como intocables |
| P6 | Texto `vacio` del proyecto Simce (vigente sin capturas) | cosmética | hoy muestra el pie por defecto | redacción del titular | baja | tres líneas en `data.js` |
| P7 | Tokens `--banner-*` y reglas `body[data-variant] .banner` huérfanas | deuda técnica | inerte; ensucia `styles.css` | ninguna | baja | `grep "\\.banner" styles.css` solo devuelve `.lb-text .banner-type` |
| P8 | Auditoría de legibilidad del resto de las capturas | deuda técnica | se auditó 1 de 26 | ninguna | baja | pasada visual completa |
| P9 | Instalar `oxipng` y rehacer la optimización con la prelación completa | mejora | hoy toda la compresión es con pérdida | `brew install oxipng` | baja | menos archivos tocados por `pngquant` |

**Precauciones por pendiente.** P3: `orden` se renumera al insertar proyectos (ocurrió en la sesión 8), así que no sirve como llave de URL. P4: sin build, el `<head>`, el Open Graph y el footer se duplican a mano; aceptable con dos páginas, insostenible desde cuatro. P5: los diffs tocan rutas de la raíz y preceden al traslado a `docs/`.

### 11.2 Evaluación de deuda técnica

- **Zona frágil:** `docs/styles.css` acumula reglas de tres generaciones de diseño (variantes d1-d5, banners, pliego). Los tokens `--banner-*` y las reglas `body[data-variant] .banner` ya no tienen markup. Principio en riesgo: presentación sin código muerto.
- **Zona frágil:** `docs/app.js` creció a 331 líneas en un único IIFE sin separación por sección. Todavía manejable, pero la segunda página del atlas obligará a decidir si se comparte código o se duplica.
- **Oportunidad:** los campos que el catálogo introduce (`categoria`, `madurez`) son exactamente los que habilitarían el nivel 5 del documento fuente, un catálogo interactivo con filtros en el propio sitio.

### 11.3 Auditoría de cierre

| Pregunta | Respuesta |
|---|---|
| ¿El escáner corrió al cierre y se referencia? | Sí, 2026-07-30 06:07:53, referenciado en §10. |
| ¿El backlog está en su archivo canónico y numerado sin renumerar? | Sí, 69 entradas correlativas. |
| ¿Todo cambio quedó verificado con evidencia observable? | Sí, salvo la legibilidad de las capturas, auditada en 1 de 26 → **P8**. |
| ¿Quedó código muerto sin declarar? | No: los tokens `--banner-*` están declarados → **P7**. |
| ¿Se respetó la gobernanza de datos? | Sí. Ningún dato identificable entró al repositorio; el `grep` de privacidad sobre el encargo del catálogo solo devolvió la línea que prohíbe los RBD. |
| ¿Hay artefactos entregados sin materializar como archivo? | No. |
| ¿Quedó algún commit sin push? | Sí, los del cierre → **P1**. |
| ¿El traspaso anterior quedó archivado? | Sí, v01-v08 en `traspasos/archivo/`. |

### 11.4 Ruta sugerida para la sesión 10

1. **P1, commitear el cierre.** Bloqueante y mecánico. Criterio: árbol limpio y `main` sincronizada.
2. **P3, campo `id` y enlaces profundos.** Funcionalidad con valor propio, independiente de que el catálogo avance. Criterio: `#p=<id>` abre la reseña correspondiente.
3. **P5, gate de las ramas `claude/*`.** Barato y elimina un riesgo real. Criterio: decisión tomada y registrada.
4. **P7 y P9, deuda técnica.** Si sobra sesión.

**Conviene diferir:** P4 (atlas) hasta que llegue el mockup y esté decidida la navegación; P2 y P6 son trabajo del titular entre sesiones; P8 no requiere sesión, es una pasada visual.

---

## 12. Instrucciones específicas para la próxima sesión

- ⚠️ **NO** ejecutar `git push` sin autorización explícita del titular en el turno inmediatamente anterior.
- ⚠️ **NO** encadenar con `&&` un paso de verificación a lo que debe condicionar: un `grep` sin coincidencias devuelve 1 y corta la cadena en silencio.
- ⚠️ **NO** correr `00_escanear_proyecto.R` más de una vez por sesión: rota un par fijo `actual`/`anterior` y la segunda corrida destruye el punto de comparación.
- ⚠️ **NO** fusionar, rebasar ni borrar ninguna rama `origin/claude/*` sin decisión explícita del titular: cuatro tocan rutas de la raíz y preceden al traslado del sitio a `docs/`.
- ✅ **ANTES** de declarar cualquier cifra en un encargo o en el chat, recontarla programáticamente en el mismo turno. Un inventario generado antes no es una fuente.
- ✅ **ANTES** de pedir un archivo por comando, verificar `/mnt/user-data/uploads/` y confirmar por escrito qué se tiene leído.
- ✅ **ANTES** de tocar `docs/data.js`, recordar que no tiene campo `id` y que `orden` se renumera al insertar proyectos.
- 🔒 El lightbox de reseña y el visor a resolución completa **no se tocan** (invariante heredado del handoff de diseño).
- 🔒 `POLITICA_PROYECTO.md`, `SETTINGS_Y_PROMPTS_OPERACIONALES.md` y `50_documentacion/traspasos/**` permanecen fuera del repositorio público.
- 🔒 Los originales de las capturas viven en `_archivo/20260729/capturas_originales/` y no se borran jamás.

---

## 13. Fragmentos de código de referencia

Dos patrones nuevos de esta sesión, ejecutables tal cual.

**Indicador de desplazamiento que distingue "hay más elementos" de "hay más píxeles".** El predicado técnico obvio (`scrollWidth > clientWidth`) es verdadero también con un solo elemento más ancho que su contenedor:

```javascript
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
```

**Avance por borde de elemento, no por cantidad fija de píxeles.** Necesario cuando los elementos tienen anchos distintos porque lo normalizado es la altura:

```javascript
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
```

Los patrones estables del proyecto viven en `CLAUDE.md` y no se recopian aquí.

**Registro de ejecución detallado:** `50_documentacion/andamios/logs/20260729_cierre_operativo_log.md` (log de la sesión de Claude Code; detalle paso a paso no reproducido en este traspaso).

---

## 14. Reapertura

* Mensaje de apertura: "Tipo CONTINUATION. El protocolo (`POLITICA_PROYECTO.md` v5.5 + `SETTINGS_Y_PROMPTS_OPERACIONALES.md` v15) vive en la knowledge base del Project y se lee desde ahí; verifica que estén al día antes de empezar. Adjunto el traspaso v09, el escáner al cierre y el backlog. La sesión 9 cerró con el pliego de capturas implementado y las capturas optimizadas, pero con el cierre sin commitear: la prioridad 1 es commitear y sincronizar, y luego el campo `id` con enlaces profundos."
* Protocolo en knowledge base (no adjuntar, solo verificar que estén al día): `POLITICA_PROYECTO.md` v5.5, `SETTINGS_Y_PROMPTS_OPERACIONALES.md` v15, `encargo_autonomo_claude_code_v1.md` v1.1.
* Opcionales según foco: `CLAUDE.md` si correrá en Claude Code; `50_catalogo_project_cards.md` si se aborda la Fase 1 del catálogo.
* Específicos de la sesión (sí adjuntar): `traspaso_cierre_v09.md`; `estructura_actual.md` recién corrido; `backlog_acumulativo.md`; `docs/data.js` y `docs/app.js` (imprescindibles para el campo `id` y los enlaces profundos); el mockup del atlas de Claude Design si llegó.
* Nota final: `docs/app.js` y `docs/styles.css` cambiaron sustancialmente en la sesión 9 (331 y 494 líneas); adjunta las versiones de disco, no versiones anteriores. Si el gate visual de las capturas terminó en reversión, avísalo en la apertura.

---

## 15. Errores del asistente

Siete desviaciones registradas. **Nota de alcance:** el catálogo canónico `herramientas_dev/gobernanza/catalogo_patrones_errores_v3.md` no estuvo disponible en esta sesión, de modo que el campo `patron` se deja con una etiqueta descriptiva y sin `PAT-NN`; asignarlo es tarea de la próxima sesión que tenga el catálogo a la vista. No se inventaron códigos.

### E1

| Campo | Contenido |
|---|---|
| `momento` | Redacción del encargo autónomo, sección de la fase de archivado |
| `disparador` | Claude Code lo detectó al ejecutar y se detuvo |
| `que_paso` | Declaré 11 archivos y 4 `.dc.html` en `design_handoff_portafolio_pliego/`; había 10 y 3 |
| `regla_violada` | `userPreferences`, marcador de fuente: una cifra solo admite recuento programático del mismo turno |
| `causa_raiz` | Conté de vista sobre `estructura_actual.md`, generado horas antes, y traté un inventario leído como si fuera un recuento hecho |
| `salvaguarda_presente` | `userPreferences` y `encargo_autonomo_claude_code_v1.md` §2.4 |
| `patron` | Sin código de catálogo disponible; mecanismo: cifra derivada de un inventario en vez de recontada |
| `gatillo_observable` | `cifras-datos`: declarar un conteo de archivos sin ejecutar el conteo en el turno |
| `intentos_previos` | 0 |
| `costo` | Dos fases del encargo detenidas; un turno de corrección |

### E2

| Campo | Contenido |
|---|---|
| `momento` | Redacción del encargo autónomo, sección de invariantes |
| `disparador` | Claude Code lo señaló en el log al aplicar el invariante por su objeto |
| `que_paso` | 🔒 I8 dice "la fase 3 es de solo lectura", pero tras insertar una fase intermedia la de ramas pasó a ser la 4 |
| `regla_violada` | `encargo_autonomo_claude_code_v1.md` §2.3: cada invariante con su objeto inequívoco |
| `causa_raiz` | Inserté la fase del escáner y renumeré las fases sin revisar las referencias cruzadas del propio documento |
| `salvaguarda_presente` | `encargo_autonomo_claude_code_v1.md` |
| `patron` | Sin código de catálogo disponible; mecanismo: referencia cruzada por número invalidada al renumerar |
| `gatillo_observable` | `otro`: renumerar secciones sin revisar las referencias internas al número renumerado |
| `intentos_previos` | 0 |
| `costo` | Ninguno; Claude Code resolvió por el objeto y lo documentó |

### E3

| Campo | Contenido |
|---|---|
| `momento` | Turno en que propuse cerrar la sesión |
| `disparador` | El usuario lo corrigió ("no te he dicho que cierres, por qué cierras?") |
| `que_paso` | Propuse el cierre y en el mismo turno escribí "Procedo con el cierre", ejecutando una propuesta que el titular no había aprobado |
| `regla_violada` | SETTINGS §1.2.4 y POLITICA §0.3: los gates estratégicos son del titular |
| `causa_raiz` | Traté el cierre como una consecuencia mecánica de haber cumplido la prioridad 1, cuando es una decisión de continuidad de sesión |
| `salvaguarda_presente` | POLITICA y SETTINGS |
| `patron` | Sin código de catálogo disponible; mecanismo: anunciar ejecución en el mismo turno que propone |
| `gatillo_observable` | `otro`: escribir un verbo en primera persona de acción en el mismo turno donde se propone esa acción |
| `intentos_previos` | 0 |
| `costo` | Un turno perdido; además se abrió el cierre con el handoff sin integrar |

### E4

| Campo | Contenido |
|---|---|
| `momento` | Commit del encargo del catálogo de Project Cards |
| `disparador` | El asistente lo señaló espontáneamente al revisar la salida |
| `que_paso` | Encadené con `&&` el `grep` de privacidad y el resto de la verificación; el `grep` de `id:` no encontró nada, devolvió 1 y cortó la cadena, de modo que el commit se hizo sin su guarda |
| `regla_violada` | B.4 (verificación observable que condiciona el avance) y `userPreferences` (comandos con verificación previa) |
| `causa_raiz` | Usé `&&` por costumbre de encadenar comandos que deben abortar ante error, sin distinguir que un `grep` de control sin coincidencias no es un error |
| `salvaguarda_presente` | POLITICA §5 y `userPreferences` |
| `patron` | Sin código de catálogo disponible; mecanismo: semántica del código de salida de `grep` en cadenas `&&` |
| `gatillo_observable` | `comando-entorno`: encadenar con `&&` un `grep` cuyo resultado vacío es un desenlace válido |
| `intentos_previos` | 0 |
| `costo` | Un commit publicado sin su chequeo de privacidad previo; un turno de verificación posterior |

### E5

| Campo | Contenido |
|---|---|
| `momento` | Solicitud de los archivos del handoff de Claude Design |
| `disparador` | El usuario lo corrigió ("te adjunté archivos, confirma que los lees antes de darme comandos para leer archivos") |
| `que_paso` | Emití comandos de lectura sin confirmar antes qué archivos adjuntos ya tenía en contexto |
| `regla_violada` | Aprendizaje registrado del propio proyecto: verificar `/mnt/user-data/uploads/` antes de pedir que el titular re-suba archivos |
| `causa_raiz` | Verifiqué la carpeta de adjuntos en turnos anteriores y no repetí la verificación cuando llegó una tanda nueva; asumí continuidad del estado de adjuntos entre turnos |
| `salvaguarda_presente` | Memoria del proyecto y `userPreferences` |
| `patron` | Sin código de catálogo disponible; mecanismo: no re-verificar el estado de adjuntos tras una tanda nueva |
| `gatillo_observable` | `ausencia-adjuntos`: emitir un comando de lectura sin haber listado la carpeta de adjuntos en el mismo turno |
| `intentos_previos` | 0 |
| `costo` | Un turno perdido |

### E6

| Campo | Contenido |
|---|---|
| `momento` | Segunda ronda de ajustes del pliego |
| `disparador` | El usuario lo corrigió repitiendo la instrucción ("repito: no puede quedar cortada la intro") |
| `que_paso` | Subí el tope de caracteres de 170 a 260 creyendo corregir el corte, sin ver que el `-webkit-line-clamp` del CSS cortaba antes |
| `regla_violada` | C.11 (causa raíz, no síntoma) |
| `causa_raiz` | Asumí que el único mecanismo de corte era el que yo había escrito en el JS, sin releer la regla CSS que venía del handoff |
| `salvaguarda_presente` | POLITICA (C.11) |
| `patron` | Sin código de catálogo disponible; mecanismo: corregir un mecanismo sin verificar si hay un segundo actuando sobre el mismo efecto |
| `gatillo_observable` | `otro`: el síntoma persiste tras corregir la causa supuesta y se ajusta el mismo parámetro por segunda vez |
| `intentos_previos` | 1 (la primera corrección subió el tope y no cambió nada visible) |
| `costo` | Dos turnos; el titular tuvo que repetir la instrucción |

### E7

| Campo | Contenido |
|---|---|
| `momento` | Implementación del indicador de desplazamiento del pasador |
| `disparador` | El usuario lo corrigió ("la flecha tiene que ser clickeable... hoy no sirve de nada más que para apuntar, es estática, entiendes?") |
| `que_paso` | Construí el indicador como elemento decorativo con `pointer-events: none` cuando lo pedido era un control operable |
| `regla_violada` | B.1 (sin supuestos implícitos): interpreté literalmente "algo que indique" sin verificar la intención funcional |
| `causa_raiz` | Leí el pedido como especificación de apariencia y no como especificación de comportamiento, y no pregunté pese a que la ambigüedad era resoluble con una línea |
| `salvaguarda_presente` | POLITICA §0.1 (preguntar con alternativas y recomendación) |
| `patron` | Sin código de catálogo disponible; mecanismo: implementar la forma literal de un pedido en vez de su función |
| `gatillo_observable` | `iteracion-sin-criterio`: producir un elemento que parece control sin declarar si opera |
| `intentos_previos` | 1 (primera versión visible pero decorativa; segunda, más visible y aún decorativa) |
| `costo` | Tres turnos de iteración sobre el mismo elemento |

### Fricciones

- `friccion: el titular tuvo que repetir la instrucción sobre el texto cortado → se eliminó todo mecanismo de truncado en vez de seguir ajustando el tope.`
- `friccion: la flecha del pasador requirió tres rondas (visibilidad, falso positivo, clickeabilidad) → se pasó a describir el comportamiento esperado antes de codificar, no solo la apariencia.`
