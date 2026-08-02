# Traspaso de cierre — v02

## 1. Identificación

- **Proyecto:** slep_monitoreo (sitio institucional Área de Monitoreo, SLEP Costa Central)
- **Versión del traspaso:** v02
- **Fecha:** 2026-06-15
- **Sesión:** 2 — foco en el reemplazo total del sitio por una identidad nueva (v1.0 gobCL + Museo Sans) y la posterior puesta en norma del repositorio según `POLITICA_PROYECTO.md`.
- **Entorno:** modo asistente-de-Claude-Code (planificación en chat, ejecución en Claude Code sobre `/Users/tomgc/Projects/slep_monitoreo`).
- **Archivos principales modificados:** `index.html`, `app.js`, `data.js`, `styles.css`, `colors_and_type.css`, `.github/workflows/static.yml`, `00_escanear_proyecto.R` (nuevo), `CLAUDE.md` (nuevo); reorganización de `30_documentacion/` → `50_documentacion/`; eliminación de `image-slot.js`, `image-slots.state.json`, `datos/`, `variants/`, `scripts/`, `og-image.*`, decenas `10_insumos/` y `20_procesamiento/`.

## 2. Resumen ejecutivo

La sesión reemplazó por completo el sitio v2.1 (single-file con sección "Fuentes" y pipeline R) por un sitio nuevo v1.0 entregado vía un handoff de Claude Code: identidad gobCL + Museo Sans, portafolio y trayectoria generados desde `data.js`, arquitectura multi-archivo. Se fijó la dirección de diseño "Papel puro" (d2) en vista cómoda y se ocultó el panel de variantes. Se implementó una galería de capturas en el lightbox (pasador con flechas, puntos, teclado y contador; placeholder cuando un proyecto no tiene capturas), eliminando el componente `image-slot` en favor de `<img>` directo desde `assets/proyectos/`. Se mitigó una deprecación de GitHub Actions (Node 20 → Node 24) un día antes del corte. Finalmente se puso el repositorio en norma con aplicación pragmática de la política (sitio estático, sin pipeline de R): documentación a `50_documentacion/`, traspasos a snake_case y luego fuera del repo, decenas huérfanas retiradas, escáner de estructura adaptado y `CLAUDE.md` creado. Todo verificado en producción (HTTP 200, deploy en verde). Quedó pendiente, con auditoría de sensibilidad, sacar `POLITICA_PROYECTO.md` del repo público.

## 3. Estado al cierre

**Qué funciona:**
- Sitio v1.0 sirviendo en `https://tomgc.github.io/slep_monitoreo/` (última verificación: HTTP 200, deploy `success`).
- Galería de capturas operativa (verificada funcionalmente: navegación, contador, placeholder, limpieza al cambiar de proyecto).
- Escáner `00_escanear_proyecto.R` operativo con esquema actual/anterior.
- Workflow de Pages al día con acciones en Node 24.

**Qué no funciona / pendiente visible:**
- Sin Open Graph: al compartir el link no aparece tarjeta de preview social.
- `colors_and_type.css` referencia `fonts/MuseoSans-100.otf`, que no existe (un `@font-face` apunta a un archivo ausente).

**Delta respecto a v01:** el sitio cambió de identidad por completo (v2.1 → v1.0); se eliminó la feature Fuentes y su pipeline R; el repo pasó a estar en norma.

## 4. Registro detallado de cambios

1. **Reemplazo total del sitio** (`d1e3710`). El handoff `handoff/site/` reemplazó al sitio v2.1. El v2.1 se respaldó en `_archivo/20260615_v2.1_pre_reemplazo/`. Footer fijado en 1.0 (primera versión del sitio nuevo). Se corrigió un voseo en comentario de `data.js` ("Reemplazá" → "Reemplaza"). `handoff/` quedó fuera de Git (gitignored).
2. **Papel puro fijado** (`a39cfde`). `<body>` a `data-variant="d2" data-density="comfortable"`. Botón y panel de variantes con `hidden`. `applyStored()` fija los valores en vez de leer localStorage. Estilos d1–d5 conservados.
3. **Galería en lightbox** (`ec35516`). Eliminado `image-slot.js` e `image-slots.state.json`. Banner usa `<img>` directo desde `imgs[0]` o placeholder. Lightbox con pasador (flechas, puntos, teclado, contador). Campo `imgs: []` agregado a los 10 proyectos. Carpeta `assets/proyectos/` creada.
4. **CI a Node 24** (`2f5f679`). Acciones del workflow actualizadas: `checkout@v6`, `configure-pages@v6`, `upload-pages-artifact@v5`, `deploy-pages@v5`. Mitiga el forzado de Node 24 del 16-jun-2026.
5. **Reorganización estructural** (`8a9196d`). `30_documentacion/` → `50_documentacion/`. Traspasos a snake_case. Decenas huérfanas `10_insumos/` y `20_procesamiento/` retiradas del árbol vivo (respaldadas en `_archivo/` e historial).
6. **Puesta en norma** (`ef7a097`). Creado `00_escanear_proyecto.R` (excepción de R declarada). Creado `CLAUDE.md`. `POLITICA_PROYECTO.md` reubicada a `50_documentacion/activa/`.
7. **Cierre** (`c5212c1`). Escáner migrado a esquema actual/anterior (excepción declarada a política 7.3-7.4). Traspasos movidos a `_archivo/traspasos/` (gitignored): no deben ser públicos vía Pages. `CLAUDE.md` actualizado con ambas excepciones. Inventario refrescado para reflejar el árbol sin traspasos.

## 5. Backlog acumulativo

> **NOTA PARA CLAUDE CODE / próxima sesión:** este traspaso se redactó en el chat, que no tenía a la vista el detalle cronológico completo del backlog del traspaso v01. Antes de archivar este v02, **copiar íntegro el backlog acumulativo del traspaso v01** (objetivo del proyecto, nota metodológica, clasificación temática, resumen estadístico por sesión y detalle cronológico con numeración correlativa global) y **agregar al final** los cambios de la sesión 2 (entradas 1-7 de la sección 4 de este documento, renumeradas de forma correlativa global continuando desde el último número de v01). El traspaso v01 vive en `_archivo/traspasos/`. No reescribir ni renumerar entradas anteriores.

**Delta del backlog (sesión 2):** 7 cambios conceptuales nuevos (reemplazo total, Papel puro, galería, CI Node 24, reorganización estructural, puesta en norma, cierre). Refinamiento de taxonomía: la categoría "pipeline de datos / R" del backlog histórico queda cerrada (la feature Fuentes se retiró); aparece una categoría nueva de "gobernanza y estructura del repositorio".

## 6. Bugs de la sesión

No hubo bugs de runtime. Sí dos defectos de proceso, ambos resueltos:

- **`git add -A` arrastró `handoff/` al commit del reemplazo.** Síntoma: el commit `45d11cb` incluyó `handoff/` completo (duplicación + voseo fósil en `handoff/site/data.js`). Causa raíz: prompt usó `git add -A` sin excluir una carpeta no versionada. Solución: `git rm -r --cached handoff/`, regla en `.gitignore`, commit enmendado (`45d11cb` → `d1e3710`). **Regla aprendida:** al commitear tras una operación que introduce carpetas nuevas no versionadas, stagear rutas explícitas en vez de `git add -A`, o excluir explícitamente lo que no debe versionarse.
- **Compuerta de respaldo con falso positivo.** Síntoma: el conteo respaldo (23) < raíz (27) detuvo la migración. Causa raíz: comparaba dos universos distintos (respaldo de activos del sitio vs. toda la raíz, que incluía `.DS_Store`, `.claude/`, `.gitignore`). Solución: re-verificación item por item de la lista de activos del sitio. **Regla aprendida:** una compuerta de conteo debe comparar conjuntos definidos de forma simétrica; comparar "subconjunto curado" contra "todo" produce falsos negativos.

## 7. Aprendizajes y restricciones descubiertas

- **GitHub Pages publica TODO el repo (`path: '.'`).** Todo archivo versionado es accesible por URL pública. Implicancia directa: la documentación interna (traspasos, política) no debe versionarse si no se quiere pública. Por eso los traspasos salieron del repo en esta sesión.
- **El sitio vive en la raíz por restricción de Pages.** No mover `index.html`, `app.js`, `styles.css`, `colors_and_type.css`, `data.js`, `.nojekyll`, `assets/`, `fonts/`. Registrado en `CLAUDE.md`.
- **`image-slot` con `fetch` no funciona desde `file://`.** Se eliminó en favor de `<img>` directo; el sitio nuevo igual usa `fetch` para otras cosas, pero al servirse por HTTPS en Pages no es problema. Deuda de patrón (rompe el invariante histórico single-file sin fetch), documentada, no accionada.
- **El escáner es la única excepción al "sin pipeline de R".** Es herramienta de estructura, no procesamiento de datos.

## 8. Decisiones de diseño

- **Reemplazo total en vez de migración selectiva.** El usuario optó por sustituir el sitio completo, asumiendo la pérdida de la sección Fuentes y el pipeline R (preservados en `_archivo/` e historial). Alternativas consideradas: convivencia en rama de preview, migración selectiva de piezas. Justificación: decisión explícita del usuario por un sitio nuevo con identidad gobCL.
- **Dirección "Papel puro" (d2) en vista cómoda.** El usuario eligió esta variante por la legibilidad del objetivo de cada proyecto. Panel de variantes oculto (no eliminado: los estilos d1–d5 se conservan).
- **Galería en lightbox (enfoque B: `<img>` directo).** Se eliminó `image-slot` (drag-drop inerte en Pages) por un solo sistema de imágenes desde archivos reales. Más liviano (−270 KB de base64).
- **Aplicación pragmática de la política.** El sitio estático no tiene pipeline de R; se declararon excepciones (sin orquestador, sin `10_utils/`, sin decenas de procesamiento, sitio en raíz) en vez de forzar una estructura que el proyecto no usa.
- **Escáner a esquema actual/anterior.** Se simplificaron los snapshots sellados con timestamp + poda de retención 2 a dos versiones fijas que se pisan. Excepción declarada a la política 7.3-7.4; justificación: sitio estático que cambia poco.
- **Traspasos fuera del repo.** Por la exposición pública de Pages, los traspasos se movieron a `_archivo/traspasos/` (gitignored). La carpeta `50_documentacion/traspasos/` se conserva vacía (`.gitkeep`) por convención.

## 9. Constantes y parámetros vigentes

| Constante | Valor | Archivo | Nota |
|---|---|---|---|
| Versión del sitio | 1.0 | `index.html` (footer) | Primera versión del sitio nuevo |
| Variante de diseño | d2 / comfortable | `index.html` (`<body>`), `app.js` (`applyStored`) | "Papel puro", panel oculto |
| Campo de capturas | `imgs: []` | `data.js` | Arreglo de rutas; `[0]` es portada; vacío = placeholder |
| Carpeta de capturas | `assets/proyectos/` | — | Donde van las capturas reales |
| Retención del escáner | 2 versiones fijas | `00_escanear_proyecto.R` | actual / anterior, sin timestamps |

## 10. Arquitectura de archivos

Estado al cierre en `50_documentacion/estructura/estructura_actual.md` (regenerar con `Rscript 00_escanear_proyecto.R`). Cambio estructural mayor: `30_documentacion/` → `50_documentacion/` con subcarpetas `activa/` (política), `traspasos/` (vacía, traspasos en `_archivo/`), `estructura/` (snapshots del escáner). Decenas `10_insumos/` y `20_procesamiento/` retiradas. Sitio en raíz.

## 11. Pendientes y ruta sugerida

**Inventario de pendientes:**

1. **[Seguridad — sensibilidad MEDIA] Sacar `POLITICA_PROYECTO.md` del repo público.** Auditada esta sesión: la política expone el marco de gobernanza de datos de NNA del SLEP (sección 6.4: leyes, Condiciones de Uso de la Agencia de Calidad, números de resolución internos, arquitectura de datos sensibles). No es filtración de datos, pero es información que un encargado de seguridad institucional preferiría no ver pública/indexada. **Enfoque sugerido:** mismo patrón que los traspasos (mover a `_archivo/`, gitignored). Mínimo y sin tocar el workflow. **Criterio de éxito:** la política deja de ser accesible por URL de Pages (404) y queda preservada local.
2. **[Seguridad — sensibilidad BAJA, sin acción] `CLAUDE.md` y snapshots de estructura.** Auditados: solo reglas de proyecto e inventario de archivos ya públicos. No requieren acción. Anotado para constancia.
3. **[Decisión de diseño] Open Graph ausente.** El sitio v1.0 no tiene `og-image` ni metas OG; el v2.1 sí. Al compartir el link no hay tarjeta de preview. **Enfoque:** generar `og-image` con identidad gobCL + metas en `<head>`. Alta prioridad si el sitio se difundirá por mensajería.
4. **[Decisión de diseño] ¿Barra de navegación?** `app.js` busca `#siteNav`, `#navToggle` y scrollspy, pero el HTML no tiene nav (código inerte, protegido con guardas). Decidir si el sitio quiere nav (útil en pantallas largas) o si se limpia el código muerto.
5. **[Bug de contenido] `@font-face` roto.** `colors_and_type.css` referencia `fonts/MuseoSans-100.otf`, ausente. Conseguir la fuente o quitar la regla.
6. **[Cosmético] Comentario huérfano en `data.js`.** El bloque de comentario superior quedó con una línea suelta tras la edición de la galería. Limpiar en la próxima pasada por el archivo.
7. **[Naming] Fuentes con naming mixto.** `fonts/` mezcla guion (`MuseoSans-300`) y guion bajo (`MuseoSans_500/700`). Bloqueado en raíz porque `colors_and_type.css` las referencia literalmente; renombrar exige actualizar los `@font-face` en la misma operación.

**Auditoría de cierre (política 5.6):** el pipeline (escáner) corre de cero; estructura en norma (con excepciones declaradas); nombres sin tildes/ñ/espacios en lo versionado (los traspasos con guion salieron del repo y los renombrados quedaron snake_case). Sin deuda nueva sin documentar.

**Ruta sugerida para la sesión 3:** (1) sacar la política del repo público (pendiente 1, seguridad, rápido); (2) Open Graph (pendiente 3, visible al compartir); (3) decidir nav (pendiente 4). Diferir: cosmético y naming de fuentes hasta tener las capturas reales que pueblen la galería.

## 12. Instrucciones específicas para la próxima sesión

- ⚠️ NO versionar documentación interna (traspasos, política) sin recordar que Pages la publica. Todo lo versionado es público.
- ⚠️ NO mover los archivos del sitio fuera de la raíz: rompe el deploy de Pages.
- ✅ ANTES de commitear tras operaciones que crean carpetas nuevas, stagear rutas explícitas (no `git add -A`).
- ✅ ANTES de archivar este v02, copiar íntegro el backlog acumulativo de v01 (ver nota en sección 5).
- 🔒 `git push` siempre requiere aprobación explícita del usuario.
- 🔒 Español neutro sin voseo en todo (código, comentarios, commits, contenido). Claude Code introdujo voseo en sus reportes esta sesión; `CLAUDE.md` ya fija la regla, reforzarla si reaparece.
- 🔒 `data.js` nunca se edita para datos derivados: el campo `imgs` se puebla con rutas reales a `assets/proyectos/`.

## 13. Fragmentos de código de referencia

**Correr el escáner (regenera el inventario, esquema actual/anterior):**
```bash
Rscript 00_escanear_proyecto.R
```

**Poblar capturas de un proyecto en `data.js`** (la primera es la portada; vacío = placeholder):
```javascript
imgs: ["assets/proyectos/ael-1.jpg", "assets/proyectos/ael-2.jpg", "assets/proyectos/ael-3.jpg"]
```

## 14. Reapertura

- **Nombre del chat:** `slep_monitoreo, sesión 3 (Claude Opus 4.8)`
- **Mensaje de apertura pre-armado:** tipo CONTINUATION. El protocolo (política + settings operacionales) vive en la knowledge base del Project y se lee desde ahí. Se adjuntan los específicos de la sesión.
- **Documentos para la próxima sesión:**
  1. *Protocolo en knowledge base (NO se adjuntan, solo verificar que estén al día):* `POLITICA_PROYECTO.md`, `SETTINGS_Y_PROMPTS_OPERACIONALES.md`.
  2. *Opcionales según el foco:* `CLAUDE.md` (vive en el repo, en la raíz) si la sesión corre en Claude Code.
  3. *Específicos de la sesión (SÍ se adjuntan):* este traspaso `traspaso_cierre_v02.md`; el inventario `50_documentacion/estructura/estructura_actual.md`; los archivos del sitio que la tarea toque (probablemente `index.html` y `colors_and_type.css` si se aborda Open Graph o el `@font-face` roto).
- **Nota final:** si algún archivo listado cambió entre sesiones, adjuntar la versión más actualizada al abrir y avisarlo en el mensaje de apertura.
