# Traspaso de cierre — v04

## 1. Identificación

- **Proyecto:** slep_monitoreo (sitio institucional Área de Monitoreo, SLEP Costa Central)
- **Versión del traspaso:** v04
- **Fecha:** 2026-06-16
- **Sesión:** 4
- **Modelo:** Claude Opus 4.8
- **Foco:** limpieza y cierre de deuda — eliminar chrome de variantes, consolidar backlog, estandarizar tipografía y unificar naming de fuentes.
- **Entorno:** modo asistente-de-Claude-Code (planificación en chat, ejecución en Claude Code sobre `/Users/tomgc/Projects/slep_monitoreo`).
- **Archivos modificados:** `index.html`, `app.js`, `styles.css`, `colors_and_type.css`, `fonts/*` (4 renames a esquema `Familia_PESO`), `assets/proyectos/.gitkeep` (restaurado); **nuevo:** `50_documentacion/traspasos/backlog_acumulado.md`.

## 2. Resumen ejecutivo

Sesión de limpieza y cierre de deuda acumulada. Cuatro frentes resueltos, todos en producción y verificados:

1. **Botón/panel de variantes eliminado de raíz** — el chrome de desarrollo seguía visible en producción pese a tener `hidden`. Causa raíz diagnosticada (cascada CSS) y eliminado en las tres capas (markup/JS/CSS).
2. **Backlog consolidado** — se creó `backlog_acumulado.md` como documento único de memoria de largo plazo (consolida v01-v03, entradas 1-38; esta sesión llega a 41), cerrando la deuda de consolidación abierta desde v02.
3. **Escala tipográfica estandarizada** — los `font-size` hardcodeados se colapsaron a tokens `--fs-*`, con piso de 13px (ningún texto por debajo); se eliminó el `@font-face` roto de Museo Sans 100 (archivo ausente).
4. **Naming de fuentes unificado** — esquema `Familia_PESO` (renombre físico + reescritura de `url()` en un mismo commit atómico).

Cierre con sitio sirviendo en producción (HTTP 200, deploy `success`), fuentes nuevas respondiendo 200 y nombres viejos 404.

## 3. Estado al cierre

**Qué funciona:**
- Sitio v1.0 sirviendo en `https://tomgc.github.io/slep_monitoreo/` (última verificación: HTTP 200, deploy `success`).
- Dirección de diseño fija en **d2 / comfortable** ("Papel puro", vista cómoda); sin chrome de variantes.
- Tipografía: 6 `@font-face` con naming `Familia_PESO` cargando sin 404; escala en tokens `--fs-*`.
- Tarjeta social (Open Graph) operativa desde v03.

**Delta vs v03:**
- v03 dejó pendiente el botón de variantes (visible en producción) → resuelto (#39).
- v03 no tenía backlog consolidado → creado esta sesión (`backlog_acumulado.md`).
- Tipografía: de ~17 tamaños fijos fragmentados + un `@font-face` roto + naming mixto → escala en tokens, sin face roto, naming uniforme (#40, #41).
- Verificación en producción de fuentes: `gobCL_400.otf` 200, `MuseoSans_300.otf` 200, `gobCL_Regular.otf` (viejo) 404.

**Qué no funciona / pendiente:** ver §11. Nada roto al cierre.

## 4. Registro detallado de cambios

Las entradas de esta sesión son, en la numeración correlativa global de `backlog_acumulado.md`, **#39, #40, #41**:

39. **Eliminar de raíz el botón/panel de variantes de diseño** (`4c7424a`). Causa raíz: el atributo `[hidden]` quedó inerte porque `.variants-fab` definía `display: inline-flex`, una regla de autor que vence el `display: none` que el user-agent aplica a `[hidden]` (origen autor > user-agent en la cascada). Se eliminaron las tres capas: markup en `index.html` (botón `variants-fab` + panel `variants-panel`), sección VARIANTS PANEL en `app.js` (incluido `applyStored()`, redundante porque el `<body>` ya trae `data-variant="d2" data-density="comfortable"` hardcodeados), y reglas `.variants-fab`/`.variants-panel`/`.vp-*` en `styles.css`. Se conservaron las reglas de diseño `[data-variant]`/`[data-density]`. Verificado en preview y en producción (grep sin coincidencias). Categoría: Interacción y JS.

40. **Estandarizar escala tipográfica a tokens `--fs-*`, piso 13px, eliminar `@font-face` roto de Museo Sans 100** (`b1fc564`). 28 reglas `font-size` hardcodeadas de `styles.css` colapsadas a `var(--fs-overline|caption|body|body-lg|h4|h3)`; `--fs-overline` subido de 12px a 13px (piso, ningún texto < 13px). Clamps e iconos (`.lb-nav` 18px, `.lb-close` 20px, `.site-nav a` mobile 15px) intactos. Eliminado el `@font-face` de Museo Sans weight 100 (referenciaba `MuseoSans-100.otf`, ausente; ningún elemento usaba weight 100). Categoría: Identidad visual.

41. **Unificar naming de fuentes a `Familia_PESO` + restaurar `assets/proyectos/`** (`881819f`). Operación atómica (renombre físico + reescritura de `url()` en el mismo commit, para que nunca haya `@font-face` apuntando a archivos inexistentes): `gobCL_Light→gobCL_300`, `gobCL_Regular→gobCL_400`, `gobCL_Heavy→gobCL_900`, `MuseoSans-300→MuseoSans_300` (`MuseoSans_500/700` ya cumplían). Restaurada la carpeta `assets/proyectos/` (con `.gitkeep`), borrada por error en el working tree. Categoría: Identidad visual.

## 5. Backlog

⚠️ **NOTA IMPORTANTE — fuente de verdad del conteo:** el backlog acumulativo ahora vive en **`50_documentacion/traspasos/backlog_acumulado.md`** (creado esta sesión; consolida v01-v04). Este traspaso **referencia** ese archivo y **NO duplica** el detalle cronológico completo.

Decisiones de la consolidación (registradas para constancia):
- **Numeración correlativa global y permanente:** 1-27 (sesión 1), 28-34 (sesión 2), 35-38 (sesión 3), 39-41 (sesión 4). Nunca se reinicia ni renumera; las entradas previas se copian verbatim.
- **Opción A en la tabla de categorías:** la suma de categorías da **37**, con nota al pie que documenta que hereda la aproximación de v01 (§5.3 original, declarada "≈ 25"). La diferencia con el total cronológico son entradas de la sesión 1 que v01 nunca clasificó, **conservadas sin recategorizar** para no reescribir el backlog previo. **La fuente de verdad del conteo es el detalle cronológico, no la tabla de categorías.**
- **Gap heredado documentado, no corregido:** v01 declara ≈25 categorizadas vs 27 entradas cronológicas. Se documenta la discrepancia; no se "arregla" recategorizando.

## 6. Bugs encontrados y patrones aprendidos

### REGLA GENERAL (elevada de incidente a regla — segundo caso)

**El atributo `[hidden]` queda inerte si una regla de autor define `display` en el mismo selector.** Origen autor vence al user-agent en la cascada, así que `.clase { display: ... }` anula el `[hidden] { display: none }` del user-agent.
- **Mitigación obligatoria:** toda clase que pueda recibir `[hidden]` necesita su guarda `.clase[hidden] { display: none }`, o no debe definir `display` en esa clase.
- **Primer caso:** detalle del lightbox (sesión previa, se agregaron guardas `[hidden]`).
- **Segundo caso:** botón de variantes (#39 de esta sesión) — el `hidden` "puesto" en una sesión anterior nunca ocultó nada porque `.variants-fab` traía `display: inline-flex`.

### Regla de consolidación de backlog

La numeración correlativa global jamás se reinicia; las entradas previas se copian verbatim; un gap heredado (v01 ≈25 vs 27 cronológicas) se **documenta, no se corrige** recategorizando.

## 7. Aprendizajes y restricciones técnicas

- **Cluster atómico de fuentes:** renombrar archivos de fuente + reescribir las `url()` de `@font-face` debe ir en **un mismo commit**. Si se separan, queda una ventana con `@font-face` apuntando a archivos inexistentes (FOUT / fallback a system-ui). Patrón obligatorio para cualquier rename de assets referenciados literalmente.
- **Staging selectivo permanente:** el escáner de estructura deja ruido permanente en el working tree (`50_documentacion/estructura/*` modificados tras cada corrida). **Nunca** usar `git add -A`; siempre stagear archivo por archivo lo que pertenece al cambio.
- **Museo Sans sin face 400:** la familia declara 300/500/700; las reglas con `font-weight: 400` + `--font-body` resuelven al face más cercano (500) por el algoritmo de font-matching de CSS. No rompe nada visible, pero el "400 del cuerpo" no tiene face propio (ver §11).

## 8. Decisiones de diseño tomadas

- Dirección de diseño congelada en **d2 / comfortable**; el sistema de variantes d1-d5 se conserva en CSS (`[data-variant]`/`[data-density]`) pero sin UI para conmutarlo (chrome eliminado).
- Escala tipográfica gobernada por tokens `--fs-*` con piso de 13px; intermedios fuera de escala (11-15.5px) colapsados al token más cercano.
- Naming de fuentes `Familia_PESO` (peso numérico, guion bajo) como convención única.

## 9. Constantes y parámetros vigentes

- **Tokens de tamaño** (`colors_and_type.css`): `--fs-display-1/2`, `--fs-h1..h4`, `--fs-body` (16), `--fs-body-lg` (18), `--fs-caption` (14), `--fs-overline` (13). 10 tokens.
- **Familias:** `--font-display` = gobCL (300/400/900); `--font-body` = Museo Sans (300/500/700) con fallback gobCL.
- **Excepciones de px en `styles.css`:** `.site-nav a` mobile 15px (touch target), `.lb-nav` 18px y `.lb-close` 20px (iconos). Lo demás en tokens o `clamp()`.

## 10. Arquitectura de archivos relevante

Ver `50_documentacion/estructura/estructura_actual.md` (sellado esta sesión): sitio en raíz (`index.html`, `app.js`, `data.js`, `styles.css`, `colors_and_type.css`, `.nojekyll`, `assets/`, `fonts/`), `50_documentacion/{activa,estructura,traspasos}/`, escáner `00_escanear_proyecto.R`, `CLAUDE.md`. Traspasos y `backlog_acumulado.md` viven en `50_documentacion/traspasos/` (gitignored).

## 11. Pendientes, próximos pasos y ruta sugerida

### 11.1 Inventario de pendientes (por prioridad)

#### ALTA — Actualizar banners de proyectos (contenido editorial)
- **Descripción:** poblar, por proyecto, el **objetivo** (visible en el banner y en el lightbox) y una **descripción breve** (solo lightbox), más las capturas reales.
- **Bloqueado por:** contenido y capturas que entrega el usuario (input externo).
- **Tipo:** contenido editorial (no datos derivados). Probable edición de `data.js`.
- **Complejidad:** baja-media (editar arrays + colocar imágenes en `assets/proyectos/`).
- **Criterio de éxito:** cada banner muestra su objetivo; cada lightbox muestra objetivo + descripción; el campo `imgs` poblado con capturas reales desde `assets/proyectos/` (la galería ya soporta múltiples imágenes con pasador).

#### MEDIA — Decisión de nav (pendiente heredado)
- **Descripción:** hay CSS para barra de navegación (header) y footer multicolumna **sin markup** en `index.html`. Confirmado esta sesión al tokenizar: `.brand-sub`, `.site-nav a`, `.site-footer h4`, `.site-footer .addr` son reglas sin elemento que las use (dead CSS).
- **Decisión:** implementar las tres capas (markup + JS de scroll-spy/toggle, que `app.js` ya busca con guardas) **o** limpiar el CSS muerto.
- **Complejidad:** baja (limpiar) / media (implementar).
- **Enfoque sugerido:** revisar primero cuánto crece la página con el contenido real; si el scroll es largo, implementar nav; si no, limpiar.

#### MEDIA — Face 400 de Museo Sans ausente
- **Descripción:** la familia declara 100 (eliminado) / 300 / 500 / 700, sin 400. Las reglas con `font-weight: 400` + `--font-body` resuelven a 500 por font-matching.
- **Impacto:** no rompe nada visible.
- **Decisión:** añadir un face 400 real (si se consigue el archivo) **o** normalizar los `font-weight: 400` del cuerpo a 300/500 explícitos.

#### BAJA — Comentario huérfano en `data.js` (heredado)
- Línea suelta en el bloque de comentario superior tras una edición previa. Limpiar en la próxima pasada por el archivo.

#### BAJA — Discrepancia en `CLAUDE.md` (heredado)
- `CLAUDE.md` afirma que los traspasos viven en `_archivo/traspasos/`, pero **están en `50_documentacion/traspasos/`** (y ahora también `backlog_acumulado.md`). Actualizar `CLAUDE.md` para reflejar la realidad.

### 11.2 Auditoría de cierre (preguntas "Cierre" de la política §5.6)

- **¿El estado quedó sellado y reproducible?** Sí — escáner corrido, `estructura_actual.md` refleja el árbol real (32 archivos, fonts con naming nuevo, `backlog_acumulado.md` presente).
- **¿Hay trabajo a medio terminar sin documentar?** No — los 4 frentes están commiteados y en producción; los pendientes son input-dependientes (banners) o decisiones diferidas (nav, face 400).
- **¿El conteo de cambios es trazable?** Sí — `backlog_acumulado.md` con numeración 1-41; esta sesión #39-41.
- **¿Working tree limpio?** Solo el ruido permanente del escáner (`estructura/*`), gitignorable por convención de staging selectivo; sin cambios de código sin commitear.

### 11.3 Ruta sugerida para la sesión 5

Priorizar **banners** cuando llegue el contenido del usuario (pendiente ALTA): editar `data.js` con objetivo + descripción + `imgs` por proyecto, colocar capturas en `assets/proyectos/`, verificar banner + lightbox + galería en preview, y desplegar. En paralelo o si no hay contenido aún: resolver la **decisión de nav** y actualizar `CLAUDE.md`.

## 12. Instrucciones para la próxima sesión

Hereda las de v03, y agrega:

- 🔒 **`backlog_acumulado.md` es la fuente de verdad del conteo.** Las entradas previas NO se reescriben, resumen ni renumeran. Numeración correlativa global, permanente.
- 🔒 **El sitio vive en la RAÍZ** (restricción de GitHub Pages); no mover `index.html`/`app.js`/`styles.css`/`colors_and_type.css`/`data.js`/`.nojekyll`/`assets/`/`fonts/`.
- 🔒 **Español neutro sin voseo** en código, comentarios, contenido y commits.
- 🔒 **`git push` SIEMPRE requiere aprobación explícita.**
- ✅ **ANTES de commitear: staging selectivo** (el escáner deja ruido permanente en el working tree; nunca `git add -A`).
- ✅ **Rename de assets referenciados** (fuentes, imágenes): renombre + reescritura de referencias en **un mismo commit** (cluster atómico).
- ⚠️ **NO eliminar las reglas CSS de nav/footer** sin decidir antes si se implementa el markup (pendiente nav). Son dead CSS hoy, pero a la espera de decisión.
- ⚠️ **Guarda `[hidden]`:** toda clase que pueda recibir `[hidden]` y defina `display` necesita `.clase[hidden]{display:none}`.

## 13. Fragmentos de referencia

- **Correr el escáner:** `Rscript 00_escanear_proyecto.R` (genera `estructura_actual/anterior.*`).
- **Verificar fuentes en producción:** `curl -so /dev/null -w "%{http_code}\n" https://tomgc.github.io/slep_monitoreo/fonts/<archivo>.otf`.
- **Guarda `[hidden]` (patrón):** `.fuente-tarjeta-detalle[hidden], .clase[hidden] { display: none; }`.

## 14. Reapertura de la sesión

### 14.1 Nombre sugerido del chat

`slep_monitoreo, sesión 5 (Claude Opus 4.8)`

### 14.2 Mensaje de apertura (CONTINUATION)

> Continuación del proyecto **slep_monitoreo** (sitio en `https://tomgc.github.io/slep_monitoreo/`). Tipo: CONTINUATION (protocolo de apertura en la knowledge base). Adjunto `traspaso_cierre_v04.md`, `estructura_actual.md` y `backlog_acumulado.md`. La próxima tarea prioritaria es **poblar los banners de proyectos** (objetivo + descripción + capturas) cuando traiga el contenido; si aún no lo tengo, avanzamos con la decisión de nav y la actualización de `CLAUDE.md`. Lee el traspaso, identifica los pendientes de la §11 y proponme la ruta.

### 14.3 Documentos a adjuntar

- `50_documentacion/traspasos/traspaso_cierre_v04.md` (este documento).
- `50_documentacion/estructura/estructura_actual.md` (inventario sellado).
- `50_documentacion/traspasos/backlog_acumulado.md` (fuente de verdad del conteo).
- Para el foco de banners (cuando el usuario traiga contenido): `data.js`, `index.html`, y las capturas para `assets/proyectos/`.

### 14.4 Nota sobre archivos modificados entre sesiones

Si algún archivo de los listados cambió entre sesiones, adjuntar la versión más actual y avisarlo en el mensaje de apertura. Recordar que los traspasos y `backlog_acumulado.md` son **gitignored** (no viajan por el repo público); hay que adjuntarlos manualmente.
