# Traspaso de Cierre — slep_monitoreo

- **Versión de traspaso:** v02
- **Fecha:** 2026-05-27
- **Sesión:** 2 — Reorganización del repositorio en decenas + pipeline de datos para la sección "Fuentes utilizadas" + prototipo galaxia. Cierra en v2.1.
- **Modelo utilizado:** Claude (modo asistente-de-Claude-Code: el usuario dirige desde un chat externo, Claude Code ejecuta y reporta en el repo local).
- **Entorno:** Web estático (HTML5 + CSS + JS inline) sobre GitHub Pages + pipeline de datos en R (`Rscript` 4.5.2 sobre macOS).
- **Archivos principales modificados o creados:**
  - `index.html` — sección "Fuentes utilizadas" insertada entre Equipo y Glosario.
  - `datos/fuentes.js` — nuevo: `window.FUENTES` con las 67 fuentes (generado por R, no editar a mano).
  - `20_procesamiento/21_generar_fuentes.R` — nuevo: script generador del `.js`.
  - `10_insumos/fuentes/fuentes_informacion_2026.xlsx` y `.pdf` — nuevos: Excel maestro y PDF de referencia.
  - `variants/fuentes-galaxia.html` — nuevo: prototipo de galaxia de nodos por institución.
  - `variants/index.html` — galería actualizada con la cuarta entrada.
  - `10_insumos/`, `20_procesamiento/`, `30_documentacion/{activa,traspasos,estructura}/` — estructura nueva del repo.
  - `30_documentacion/traspasos/traspaso-cierre-v01.md` — movido con `git mv` desde `docs/traspasos/`.
  - `.gitignore` — nuevo: ignora `.DS_Store`, `_archivo/`, `.claude/`.
  - `CHANGELOG.md` — nuevo: bitácora del repositorio (separada del Changelog del sitio que vive en README).
  - `README.md` — sección "Estructura del repositorio" + sub-sección "Pipeline de datos" + bump a 2.1.
  - `30_documentacion/traspasos/traspaso-cierre-v02.md` — este documento.

---

## 1. Resumen de la sesión

La sesión 2 operó en modo **asistente-Claude-Code**: el usuario (Tomás) dirige desde un chat externo, redacta prompts detallados, y Claude Code los ejecuta en el repo local, reporta diffs y screenshots, espera confirmación, commitea y empuja. Cada paso fue un mini-contrato: prompt → diagnóstico → ejecución → reporte → OK → commit. No hubo trabajo sin reporte previo, ni commits sin confirmación explícita.

La sesión cierra el repo en **v2.1**: misma identidad visual y mismo workflow de Pages, pero con un pipeline reproducible de datos (Excel → R → `.js` → HTML), una sección Fuentes nueva en el index, y un prototipo experimental de galaxia. La estructura de carpetas del repo pasa de plana a "decenas" (`10_insumos`, `20_procesamiento`, `30_documentacion`), pero los archivos del sitio publicado siguen en raíz para no romper Pages.

---

## 2. Cambios estructurales del repositorio

- **Decenas creadas** según la norma del usuario, solo para contenido nuevo:
  - `10_insumos/fuentes/` — Excel maestro y PDF de referencia.
  - `20_procesamiento/` — scripts R que transforman insumos en outputs.
  - `30_documentacion/{activa,traspasos,estructura}/` — documentación del proyecto. Traspasos migrados desde `docs/traspasos/` con `git mv` para preservar historial.
- **`docs/` eliminada** tras migrar su único contenido (`traspaso-cierre-v01.md`).
- **`.gitignore` creado** con tres reglas:
  - `.DS_Store` (archivos macOS).
  - `_archivo/` (snapshots locales pre-reorganización, no se versionan).
  - `.claude/` (config local del editor / MCP).
- **`CHANGELOG.md` creado** en la raíz. Cambios al **repositorio**. Los cambios al **sitio publicado** siguen documentados en el Changelog del README.
- **Decisión documentada:** el sitio publicado (`index.html`, `variants/`, `scripts/`, `og-image.*`, `.github/workflows/static.yml`) **se queda en raíz** para no romper el deploy de Pages. La norma de decenas se aplica solo a contenido nuevo (insumos, procesamiento, docs).
- **Snapshot pre-reorganización** guardado localmente en `_archivo/20260526/README.md` (ignorado por git, sirve como punto de referencia si hay que rollback manual).

---

## 3. Nueva pieza: pipeline de datos

### Insumo

- `10_insumos/fuentes/fuentes_informacion_2026.xlsx` — base maestra: 67 fuentes × 14 columnas en la hoja `Fuentes de información`.
- `10_insumos/fuentes/fuentes_informacion_2026.pdf` — vista visual de referencia (no procesado por el script).

### Script generador

`20_procesamiento/21_generar_fuentes.R` lee el Excel y emite `datos/fuentes.js` con `window.FUENTES = [...]`. Características clave:

- **Auto-instalación de paquetes** (`readxl`, `dplyr`, `janitor`, `glue`, `jsonlite`, `here`) si no están presentes.
- **Locale UTF-8 forzado al inicio**: sin esto, `Rscript` desde shell entra en locale C y rompe los strings con tildes (warnings `unable to translate '<U+00C4>' to native encoding` y caracteres mutilados en el output). El script intenta `es_CL.UTF-8 → es_ES.UTF-8 → en_US.UTF-8 → C.UTF-8` con fallback silencioso.
- **Modelo de datos con arrays para funciones**: descubrimos que el Excel tiene 2 fuentes (DIA y Cuestionarios SIMCE) cuyo campo `funcion` contiene **dos** funciones separadas por salto de línea (`\n`). Modelo final: `funcion_num: [int]` y `funcion_label: [string]` siempre como arrays, incluso con un solo elemento. La matriz del index cuenta esas fuentes en ambas columnas; el total global se mantiene en 67.
- **Limpieza universal de strings**: reemplaza NBSP (U+00A0) por espacio normal, `trimws`, colapsa espacios horizontales múltiples. Preserva `\n` para parsear funciones.
- **Diccionario explícito de normalizaciones de institución** (10 filas ajustadas):
  - `"Centro de Estudios Mineduc (CEM -SIGE)" → "(CEM)"` (1 fila).
  - 3 variantes de Junji (con tilde / sin tilde / con sufijo Gesparvu) colapsan a `"Junta Nacional de Jardines Infantiles y Salas Cunas (Junji)"` (9 filas).
  - Las claves con tilde se escriben con `í` para evitar problemas de copy-paste entre editores; los bytes coinciden con los del Excel (verificado con `hexdump`).
- **ID único y estable** por fila: slug de `variable_o_indicador + nombre_base_de_datos + proveedor` vía `janitor::make_clean_names()`. Si colapsan, sufijar `-2`, `-3` (no se dio en este Excel).
- **Output como `.js` puro**: `window.FUENTES = [...]` precedido por 3 líneas de comentario con timestamp. Se escribe con `file(..., encoding="UTF-8")` + `writeLines(useBytes=FALSE)` para garantizar bytes UTF-8 reales (no escape literal `<XX>`).
- **Resumen en stdout**: total, distribución por ámbito, por acceso, por institución (todas, ordenadas), por función (con doble contabilización para multi-función), filas con campos críticos vacíos.

### Output

`datos/fuentes.js` (~55 KB, 1278 líneas, UTF-8) consumido por `index.html` y `variants/fuentes-galaxia.html` vía `<script src>` (no `fetch`, no CORS).

### Resultados del run final

- 67 fuentes procesadas.
- Distribución por ámbito: A=54, B=13.
- Distribución por acceso: pública=44, privada=21, indefinido=2.
- 12 instituciones únicas (bajó de 14 vía normalización).
- 6 funciones presentes en los datos (1, 2, 3, 4, 6, 7). **La función 5 no aparece** — confirmado por el usuario, el catálogo del DEP salta 4 → 6 en los datos actuales.
- 2 fuentes multi-función: DIA y Cuestionarios SIMCE, ambas en funciones [2, 3].

---

## 4. Nueva pieza: sección "Fuentes utilizadas" en `index.html`

Insertada como **5ª sección** del bento, entre Equipo y Glosario. Nav lateral renumerado: `5. Fuentes`, `6. Glosario`. Scroll-spy actualizado para incluir `#fuentes`.

### Componentes

- **Matriz interactiva ámbito (A/B) × función (1, 2, 3, 4, 6, 7)** con totales marginales por fila, por columna y total global.
- **Heatmap** con 5 niveles discretos sobre `var(--purple)` vía `color-mix(in srgb, var(--purple) X%, var(--card))`. Sin colores nuevos: 10/22/40/65/100% del morado oficial.
- **Buscador de texto libre** sobre `nombre_largo`, `base_datos`, `institucion`, `proveedor`. Normaliza acentos en ambos lados con `.normalize('NFD').replace(/[̀-ͯ]/g, '')` — `"educacion"` matchea `"Educación"`.
- **Filtros combinables en AND**: click en celda (ámbito + función) + click en header (solo función) + click en label de fila (solo ámbito) + buscador. Chips visuales para cada filtro activo con botón ×. Botón "Limpiar filtros" cuando hay 2+ chips.
- **Lista de detalle con tarjetas expandibles**: estado inicial vacío con mensaje guía. Al filtrar, muestra tarjetas con `nombre_corto`, `institucion`, badges (acceso → verde/coral/beige según pública/privada/indefinido; periodicidad; `f.N` por función). Click en tarjeta expande inline con todos los campos del detalle.
- **Nota explicativa** bajo la matriz: "2 fuentes (DIA y Cuestionarios SIMCE) monitorean simultáneamente las funciones 2 y 3, por lo que aparecen en ambas columnas; el total global se mantiene en 67."

### Decisiones específicas

- **Externalización solo del dataset**, no de la presentación. El patrón single-file original asumía ~30 ítems totales. Con 67 fuentes + 17 campos cada una, los datos crecieron lo suficiente como para justificar separación, pero la presentación (CSS + JS de la UI) sigue inline en `index.html` para preservar la simplicidad del patrón.
- **Sin `fetch`**: `<script src="datos/fuentes.js">` asigna `window.FUENTES` y el script inline lo consume. Esto evita CORS y mantiene el sitio funcional desde `file://` (útil para debugging local sin server).
- **Función 5 ausente**: la matriz muestra solo las 6 funciones presentes en los datos. Si en el futuro el catálogo del DEP confirma que la 5 existe vacía, se agrega como columna con conteo 0.
- **Responsive mobile (<700px)**: matriz con `min-width: 420px` y scroll horizontal. Decisión justificada porque la matriz es una visualización **comparativa** (ámbito × función) y perdería su valor al fragmentarla en acordeón.

### Bugs detectados y corregidos durante la verificación visual

- **Width del primer `<th>`**: `table-layout: fixed` repartía equitativo entre 8 columnas y "COMUNIDADES EDUCATIVAS" se solapaba con la primera celda. Fix: `col-corner { width: 140px }`, `col-total-head { width: 64px }`.
- **`[hidden]` ignorado por `display: grid/flex`**: el atributo HTML `hidden` tiene `display: none` en el user-agent stylesheet, pero un `.fuente-tarjeta-detalle { display: grid }` con la misma especificidad lo sobrescribía (ganaba el último declarado). Fix: regla específica `.fuente-tarjeta-detalle[hidden], .fuentes-filtros-activos[hidden], .fuentes-resultados-contador[hidden] { display: none }` con especificidad (0, 2, 0).

---

## 5. Nueva pieza: prototipo galaxia

`variants/fuentes-galaxia.html` — HTML standalone que vive aislado en `variants/`, sin afectar el index ni las otras 3 variantes.

### Pregunta que responde

"**¿De qué instituciones depende el monitoreo SLEP?**" — distinta a la del index (cobertura por función). Complementaria, no redundante. Las 67 fuentes como nodos agrupados por institución; el cluster de CEM (33 nodos) muestra inmediatamente que casi la mitad del catálogo viene de una sola institución.

### Implementación

- **SVG inline** 1000×700 viewBox con tres grupos: `.enlaces` (reservado), `.nodos`, `.labels`.
- **Layout force-directed con seed determinista**: 250 iteraciones. Posición inicial por `hash(id)` (sin `Math.random`). Anchors angulares proporcionales a `sqrt(count)`. Atracción al anchor + repulsión entre pares cercanos (cutoff 48px) + damping 0.84. Recargar 3 veces da coordenadas idénticas píxel a píxel (verificado).
- **12 colores estables** asignados explícitamente en `COLORES_INSTITUCION`: 5 plenos para las grandes (CEM, ACE, Junji, base SIGE, Datos Abiertos Superint.) + 7 que reutilizan colores aceptando alguna repetición (la posición espacial las desambigua). Fallback a `--gray` si aparece una institución no mapeada.
- **Opacidad del nodo refleja `usos_unidad`**: 0.35 si vacío (catalogada sin uso declarado), 1.0 si poblado. Hoy las 67 están en 0.35 porque el campo aún no se pobló.
- **Panel lateral con detalle al click**: posición fixed, slide-in desde la derecha. Muestra todos los campos. Click fuera lo cierra.
- **Hover en label de institución**: nodos del cluster pasan a opacidad 1.0; el resto baja a 0.12. Permite identificar visualmente qué nodos pertenecen a cada cluster.
- **Click en label**: abre el panel con un listado de todas las fuentes de la institución, cada una clickeable para ver su detalle.
- **Fallback mobile (<700px)**: SVG oculto, listado agrupado por institución (12 secciones con borde-color institucional). Honesto sobre la limitación visual de mostrar 67 nodos en pantalla chica.

### Galería

`variants/index.html` actualizada con la **cuarta entrada** (tag "PROTOTIPO · FUENTES" para diferenciar de "VARIANTE N"). Preview mini con SVG simplificado mostrando ~10 puntos agrupados con los colores de la paleta.

---

## 6. Paleta y patrón visual

Sin cambios respecto a v01. Misma paleta SLEP de 7 colores (`--purple` `#4A2746`, `--cream` `#FFF6E0`, `--blue` `#0062A0`, `--gray` `#747474`, `--green` `#75924E`, `--beige` `#BCA493`, `--coral` `#E88663`), tints `-soft` derivados, fondo de página blanco, layout bento de 6 columnas con sidebar izquierda.

La sección Fuentes y la galaxia reutilizan las variables CSS existentes. Heatmap morado vía `color-mix`. Badges con `*-soft` para fondos suaves. No se introdujeron colores nuevos.

---

## 7. Commits de esta sesión

```
59787a4 feat(variants): prototipo "galaxia de fuentes" en variants/
85f3080 feat(sitio): agregar sección "Fuentes utilizadas" con matriz interactiva
aec0356 feat(datos): generar datos/fuentes.js desde Excel maestro
0aa8d2c chore(insumos): agregar Excel y PDF de fuentes de información
56d95b6 refactor: reorganizar estructura del repo según norma de carpetas
```

Cinco commits empujados a `origin/main`. El último commit (este traspaso + bump a 2.1) cierra la sesión.

---

## 8. Decisiones de diseño que conviene recordar

### 8.1 Solo `index.html` lleva la sección Fuentes

Las 3 variantes (`classic`, `editorial`, `institucional`) **no se tocaron** — son del freeze v2.0. Si en algún momento se decide propagar la sección Fuentes a alguna variante, requiere decisión explícita: cada variante tiene su propio CSS y patrones tipográficos, y la matriz tendría que adaptarse al lenguaje de cada una.

### 8.2 `usos_unidad` se llenará en el Excel, no en el `.js`

NO editar `datos/fuentes.js` a mano. Si hay que poblar `usos_unidad`, se hace en el Excel y se re-corre el script. Plan tentativo: agregar una columna nueva al Excel con valores separados por `;` (`proyecto-1;reporte-x`), ajustar el script R para parsear esa columna como array, re-correr.

### 8.3 El script R asume locale UTF-8

Si en algún momento se corre el script en un runner sin UTF-8 (CI, contenedor distinto), confirmar que la línea `Sys.setlocale("LC_ALL", "C.UTF-8")` del fallback funciona en ese entorno. Sin locale UTF-8, los strings con tilde quedan corruptos.

### 8.4 La galaxia es prototipo, no compromiso

Si se decide que la matriz es suficiente y la galaxia sobra, eliminar `variants/fuentes-galaxia.html` y su entrada de `variants/index.html`. No hay dependencias externas que la consuman.

### 8.5 Patrón externalizado solo para datos, no para presentación

Cuando el dataset crece 2× lo previsto, el patrón single-file deja de servir literalmente. La solución elegida (externalizar solo `datos/fuentes.js`, mantener CSS+JS de presentación inline) preserva la simplicidad del patrón original sin asumir build steps ni framework.

---

## 9. Pendientes para próxima sesión (lo importante)

### 9.1 Poblar `usos_unidad` en el Excel

Tomás define qué proyecto/reporte/iniciativa usa cada una de las 67 fuentes. Estrategia tentativa:

1. Agregar una columna nueva al Excel (ej. `Usos en el Área`) con valores separados por `;` (`reporte-trayectorias-2026;tablero-asistencia`).
2. Ajustar el script R para detectar y parsear esa columna como array.
3. Re-correr el script.
4. La galaxia automáticamente pasa nodos a opacidad plena para las fuentes con usos declarados. En el index, las tarjetas expandidas muestran los usos como badges azules destacados (ya implementado, hoy invisible porque el array está vacío).

### 9.2 Resolver normalizaciones pendientes

Dos casos quedaron documentados sin resolver:

- **"CNT-CEM" (2 filas):** ¿es CEM abreviado, CNT (Coordinación Nacional Técnica) distinto de CEM, o entidad propia? Si se confirma equivalencia con CEM, agregar al diccionario `normalizaciones_inst` y re-correr.
- **"Base de datos SIGE - CNT / DEP" (4 filas):** parece dato en campo equivocado — es una base de datos, no una institución. Decisión: ¿qué institución real corresponde? El dato actual del campo institucional describe el `base_datos`, no un proveedor distinto. Si se reasigna, mover el detalle a `nombre_base_de_datos` en el Excel.

### 9.3 Función 5 ausente

Confirmar con el DEP si el catálogo conceptual de funciones incluye una **función 5** (vacía actualmente) o si la numeración salta 4 → 6 por diseño. Si existe vacía, agregarla como columna en la matriz con conteo 0 (cambio menor en el JS: hardcodear la lista de funciones esperadas en lugar de inferirla de los datos).

### 9.4 Solapamiento de labels en la galaxia

Las 6 instituciones de 1 nodo a la izquierda quedan apiladas verticalmente (Ministerio Medio Ambiente, División Educación General, Departamento Evaluación, SIES, Junta Auxilio Escolar, CPEIP) — legible pero denso. Refinamiento opcional para una próxima iteración: implementar resolución de colisión de labels (~30 líneas extra de JS) o desplazar labels con offset radial. No bloqueante hoy.

### 9.5 Mini-mockups SVG vs capturas reales

Pendiente desde v01, sigue vigente. Los mini-mockups de los productos en `index.html` y `variants/classic.html` siguen siendo SVG genéricos. Cuando haya capturas reales, reemplazarlas y quitar la etiqueta "Imagen referencial".

---

## 10. Pendientes operativos menores

### 10.1 Verificar deploy a Pages

En la próxima sesión, después de cualquier cambio que toque archivos del sitio (`index.html`, `variants/`, `datos/`), verificar con `curl -I https://tomgc.github.io/slep_monitoreo/` que Pages respondió y comparar `content-length` con el local. Esta sesión cerró con verificación: HTTP 200, `content-length: 60796`, byte-perfect match con el commit empujado.

### 10.2 La matriz se adapta a los datos automáticamente

El campo `funcion_num` en la matriz solo muestra funciones **presentes en los datos**. Si una función desaparece (cambio en el Excel) o aparece una nueva (ej. función 5 poblada), la matriz lo refleja sin tocar el código. Esto es bueno para flexibilidad pero implica que la galaxia y la matriz pueden divergir si una función crítica desaparece y nadie nota. Heurística defensiva: si el `total global` en la matriz no coincide con `FUENTES.length`, hay un problema (alguna fuente sin función o sin ámbito).

---

## 11. Lecciones de la sesión

### 11.1 Subestimación del modelo de datos

Asumimos `funcion: string` al diseñar el esquema inicial. Al correr el script descubrimos que el Excel tiene fuentes con `funcion` multilínea (DIA y SIMCE, funciones [2, 3]). Bien que el script R detectara el caso antes de la UI: si hubiéramos descubierto el problema al renderizar la matriz, habría requerido refactor cruzado. Lección: **mirar los datos reales antes de finalizar el esquema**, no solo los nombres de columnas esperados.

### 11.2 Locale C en `Rscript` rompe strings no-ASCII

Cuando `Rscript` se invoca desde shell sin `LANG` UTF-8, R entra en locale "C" y los strings con tildes/eñes se mutilan al pasar por funciones de I/O (incluido `writeLines`). Solución durable: `Sys.setlocale("LC_ALL", "C.UTF-8")` (o el equivalente disponible) al inicio del script. Documentado en sección 8.3.

### 11.3 Bugs CSS típicos detectados solo con preview visual

Dos bugs aparecieron solo al ver la página renderizada:
- `table-layout: fixed` con primer `<th>` corto → labels solapando celdas.
- `display: grid` con misma especificidad que `[hidden]` → atributo HTML ignorado.

El `git diff` no muestra bugs visuales. **Lección: siempre verificar en preview visual** después de cambios de CSS que toquen layout o display. Esta sesión usó `mcp__Claude_Preview` para capturar screenshots e inspeccionar estado del DOM en tiempo real.

### 11.4 Decisión arquitectural: externalizar datos, mantener presentación

Cuando el dataset crece 2× lo previsto, el patrón single-file deja de servir literalmente. Pero la solución no es necesariamente refactorizar todo a `fetch`/JSON/framework. **Externalizar solo los datos** (no la presentación) preserva la simplicidad del patrón original sin introducir CORS, build steps ni dependencias.

### 11.5 Verificación interactiva con MCP Preview

Usar `mcp__Claude_Preview` (con `.claude/launch.json` apuntando a `python3 -m http.server`) permite:
- Ejecutar JS en el contexto de la página (`preview_eval`).
- Inspeccionar estado del DOM y consolas.
- Click programático (`preview_click`) y fill (`preview_fill`).
- Resize a presets responsive.
- Screenshots.

Esto reduce el ciclo de "edit → curl → grep" a "edit → eval → screenshot" para verificación visual.

---

## 12. Cómo retomar (próxima sesión)

1. **CONTINUATION** — adjuntar este traspaso (`30_documentacion/traspasos/traspaso-cierre-v02.md`) + prompt-apertura.
2. **La próxima tarea natural es 9.1** (poblar `usos_unidad`). Si el usuario trae el Excel actualizado con la columna nueva, la sesión es corta: ajustar el script R para parsear la columna, re-correr, verificar visualmente que la galaxia destaca los nodos con uso declarado, commit.
3. **Si en cambio la próxima sesión es para 9.2** (normalizaciones CNT-CEM y SIGE-CNT/DEP) o **9.3** (función 5), son trabajos más exploratorios: requieren input institucional del DEP. Sin ese input, no se puede ejecutar.
4. **Si es para 9.4** (labels en la galaxia), es solo refinamiento de JS — sesión corta.

---

## 13. Estado del repo al cierre

- **Versión:** 2.1
- **Tag:** opcional crear `v2.1` después del bump si el usuario lo prefiere.
- **Branch `main`:** alineada con `origin/main` en el commit de cierre.
- **Working tree:** limpio.
- **Pages deploy verificado en producción:** HTTP 200, content-length local == remoto.
- **5 commits + 1 de cierre** empujados en esta sesión.

---

## 14. Notas para Claude (próxima instancia)

### 14.1 Versión pública vs versión local

Misma advertencia que v01: el repo público en GitHub vive su propia historia. Para evitar desfases entre asistente y código, lo más seguro es pedir al usuario que adjunte los archivos relevantes o que los traiga vía `gh`/`git` en el entorno de Claude Code.

### 14.2 Modo asistente-de-Claude-Code

Esta sesión funcionó en modo asistente-de-Claude-Code: el usuario (Tomás) generó los prompts en un chat externo, los pegó en Claude Code, y Claude Code ejecutó y reportó. **Mantener esa dinámica si el usuario lo confirma al abrir la próxima sesión** — el formato de prompts del usuario incluye procedimiento numerado, criterios de verificación, mensaje exacto de commit, y un "NO commitear todavía / espero OK" explícito antes de cada acción irreversible. Respetar ese protocolo.

### 14.3 Idioma y estilo

El usuario prefiere español neutro latinoamericano sin voseo. Forma "tú" o impersonal. Regla en memoria permanente. **No usar "vos" / "tenés" / "che"** salvo que el usuario lo cambie explícitamente.

### 14.4 Aprobación granular para git

El usuario aprueba operaciones git de forma individual:
- Commits locales: agrupables con otros cambios reversibles.
- `git push`: SIEMPRE requiere aprobación individual explícita.
- `git push --force`, `git reset --hard` sobre commits ya pusheados: requiere aprobación individual + nota explícita de irreversibilidad.
- `git tag` y `git push origin <tag>`: requiere aprobación.

### 14.5 Estructura de prompts esperada del usuario

Los prompts del usuario en esta sesión siguieron un formato muy consistente:
1. Título (`# Tarea: ...`).
2. Contexto (1 párrafo).
3. Restricciones no negociables (lista).
4. Procedimiento numerado (pasos atómicos).
5. Verificación antes de commitear (qué mostrar al usuario).
6. Mensaje exacto del commit (con variables a completar).
7. "Después del commit, NO hagas push" (típicamente al final).

Cuando el usuario escribe en este formato, **seguir el procedimiento literal**, no inventar atajos ni reordenar pasos. Es el contrato de la sesión.

---

## Apéndice — Composición de archivos al cierre (`tree -L 3`, ignorando `.git/`)

```
slep_monitoreo/
├── .github/workflows/static.yml      # Deploy Pages (intacto)
├── .gitignore                        # NUEVO: .DS_Store, _archivo/, .claude/
├── 10_insumos/
│   └── fuentes/
│       ├── fuentes_informacion_2026.xlsx
│       └── fuentes_informacion_2026.pdf
├── 20_procesamiento/
│   └── 21_generar_fuentes.R          # NUEVO: pipeline R → JS
├── 30_documentacion/
│   ├── activa/.gitkeep
│   ├── estructura/.gitkeep
│   └── traspasos/
│       ├── traspaso-cierre-v01.md    # movido desde docs/
│       └── traspaso-cierre-v02.md    # ESTE DOCUMENTO
├── CHANGELOG.md                       # NUEVO: bitácora del repo
├── README.md                          # bump a 2.1
├── datos/
│   └── fuentes.js                    # NUEVO: window.FUENTES, generado por R
├── index.html                         # + sección Fuentes
├── og-image.{svg,png}                 # intactos
├── scripts/regenerate-og-image.sh    # intacto
└── variants/
    ├── index.html                    # + 4ta entrada
    ├── classic.html                  # intacto
    ├── editorial.html                # intacto
    ├── institucional.html            # intacto
    └── fuentes-galaxia.html          # NUEVO: prototipo
```
