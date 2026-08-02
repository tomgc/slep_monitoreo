# Traspaso de cierre — v03

## 1. Identificación

- **Proyecto:** slep_monitoreo (sitio institucional Área de Monitoreo, SLEP Costa Central)
- **Versión del traspaso:** v03
- **Fecha:** 2026-06-15
- **Sesión:** 3 — foco en seguridad del repo (sacar la política del público) y en la tarjeta para compartir (Open Graph) con la identidad oficial del kit.
- **Entorno:** modo asistente-de-Claude-Code (planificación en chat, ejecución en Claude Code sobre `/Users/tomgc/Projects/slep_monitoreo`).
- **Archivos principales modificados:** `index.html` (metas Open Graph + Twitter Card), `assets/og-image.png` (nuevo, tarjeta oficial del kit); baja de `50_documentacion/activa/POLITICA_PROYECTO.md` del versionado; kit de identidad colocado en `_archivo/documentacion/kit-identidad/` (gitignored).

## 2. Resumen ejecutivo

La sesión ejecutó las dos primeras prioridades de la ruta sugerida en v02 y resolvió la tercera (Open Graph) con un insumo que llegó a mitad de sesión. Primero se sacó `POLITICA_PROYECTO.md` del repositorio público: el archivo estaba trackeado y su copia física ya había sido borrada del disco en una sesión previa, así que Claude Code recuperó el contenido desde el blob de git (`git show HEAD:`), lo preservó en `_archivo/documentacion/` y lo desindexó (`git rm --cached`). Commit `b7df700`, pusheado y verificado (la política da 404 en la URL de Pages). Se decidió mantener el repo público (lo necesita Pages) y NO reescribir el historial; queda anotado que la política persiste en commits viejos accesibles vía la interfaz de GitHub. Luego, para Open Graph, se generó primero una `og-image` provisional adaptando el flujo viejo (descartada) y enseguida llegó el "kit de identidad" oficial del usuario con la tarjeta definitiva (concepto del traspaso municipal→SLEP narrado con barras que se completan). Se adoptó la imagen oficial, se insertaron las metas OG + Twitter Card en `index.html` apuntando a `assets/og-image.png` con URL absoluta, y se colocó el kit editable en `_archivo/`. Commit `fc7da2f`, pusheado y verificado (HTTP 200, deploy `success`). Quedó pendiente solo la validación social manual (forzar el scrapeo en el debugger de Facebook) y la prioridad 4 (decidir nav).

## 3. Estado al cierre

**Qué funciona:**
- Sitio v1.0 sirviendo en `https://tomgc.github.io/slep_monitoreo/` (última verificación: HTTP 200, deploy `success`).
- `POLITICA_PROYECTO.md` fuera del repo público: da 404 en la URL de Pages, preservada local en `_archivo/documentacion/POLITICA_PROYECTO.md`.
- Tarjeta para compartir publicada: `assets/og-image.png` (1200×630) responde HTTP 200; metas Open Graph y Twitter Card en `index.html` la referencian con URL absoluta.
- Kit de identidad editable preservado en `_archivo/documentacion/kit-identidad/` (tarjeta-editable.html + 5 fuentes + COMO-USAR.md), gitignored.

**Qué no funciona / pendiente visible:**
- Validación social pendiente: falta forzar el primer scrapeo en el debugger de Facebook (developers.facebook.com/tools/debug) para que WhatsApp/redes cacheen la tarjeta antes de difundir. Es paso manual del usuario, no defecto del sitio.
- `colors_and_type.css` sigue referenciando `fonts/MuseoSans-100.otf`, ausente (pendiente heredado 5, no abordado).

**Delta respecto a v02:** la política dejó de ser pública; el sitio ganó tarjeta social oficial. Sin cambios en el contenido del sitio (data.js, layout, estilos intactos).

## 4. Registro detallado de cambios

1. **Sacar `POLITICA_PROYECTO.md` del repo público** (`b7df700`). La política estaba trackeada en `50_documentacion/activa/POLITICA_PROYECTO.md` y su archivo físico ya había sido borrado del disco en una sesión previa (baja sin commitear). Procedimiento adaptado: `git show HEAD:50_documentacion/activa/POLITICA_PROYECTO.md > _archivo/documentacion/POLITICA_PROYECTO.md` (recuperar copia local desde el blob), `git rm --cached` (desindexar). Staging selectivo para no arrastrar el output del escáner sin commitear. Pusheado y verificado: 404 en la URL de Pages. Categoría: gobernanza y estructura del repositorio.
2. **Metas Open Graph + Twitter Card en `index.html`** (parte de `fc7da2f`). Bloque insertado en el `<head>` tras `theme-color`: `og:type`, `og:site_name`, `og:title`, `og:description` (acortada respecto al meta description largo para no truncar en la tarjeta), `og:url`, `og:image` + `width`/`height`/`alt`, `og:locale`; Twitter Card `summary_large_image` con `title`/`description`/`image`/`image:alt`. URLs absolutas al dominio de Pages. Categoría: decisión de diseño / difusión.
3. **Tarjeta para compartir oficial** (parte de `fc7da2f`). Se descartó una `og-image` provisional generada en el chat (adaptación del flujo viejo a la identidad v1.0) al llegar el kit oficial del usuario. La imagen oficial (`og-image.png`, 1200×630) implementa el concepto narrativo del traspaso (cuatro barras: contorno gris heredado → bosquejo azul claro → azul sólido consolidado) con tipografías reales gobCL + Museo Sans. Colocada en `assets/og-image.png` (versionada, pública). Categoría: identidad visual.
4. **Kit de identidad a `_archivo/`** (no versionado). `tarjeta-editable.html` (fuente de regeneración de la og-image), `COMO-USAR.md` y `fonts/` (5 otf) colocados en `_archivo/documentacion/kit-identidad/`. Instrumental de regeneración, no parte del sitio público. Categoría: gobernanza y estructura del repositorio.

## 5. Backlog acumulativo

> **NOTA PARA CLAUDE CODE / próxima sesión:** este traspaso se redactó en el chat, que NO tenía a la vista el detalle cronológico completo del backlog acumulativo (vive en `_archivo/traspasos/traspaso_cierre_v01.md` y la consolidación v01+v02 quedó pendiente desde la sesión 2). **Deuda de consolidación heredada y aún abierta.** Antes de archivar este v03, Claude Code debe, con los archivos en disco:
> 1. Copiar íntegro el backlog acumulativo de v01 (objetivo del proyecto, nota metodológica, clasificación temática, resumen estadístico por sesión y detalle cronológico con numeración correlativa global).
> 2. Agregar al final las 7 entradas de la sesión 2 (sección 4 de v02), renumeradas de forma correlativa global continuando desde el último número de v01.
> 3. Agregar al final las 4 entradas de la sesión 3 (sección 4 de este v03), continuando la numeración.
> No reescribir, resumir ni renumerar entradas anteriores. Si el backlog consolidado aún no existe como documento único, esta es la oportunidad de crearlo.

**Delta del backlog (sesión 3):** 4 cambios conceptuales nuevos (baja de la política del repo público, metas Open Graph, tarjeta oficial del kit, kit editable a `_archivo/`). Sin refinamiento de taxonomía: los cuatro caen en categorías ya existentes ("gobernanza y estructura del repositorio", "identidad visual", "decisión de diseño / difusión").

## 6. Bugs de la sesión

No hubo bugs de runtime. Dos defectos de proceso evitados a tiempo por Claude Code (parada correcta antes de commitear):

- **`og-image.png` inexistente al primer intento de commit.** Síntoma: el `index.html` con metas OG apuntaba a `assets/og-image.png`, que no existía. Causa raíz: las metas se prepararon antes de tener la imagen. Claude Code se detuvo en vez de commitear metas que apuntarían a un 404. **Regla aprendida:** verificar que el activo referenciado existe en disco antes de commitear el HTML que lo referencia; commitear metas hacia un recurso ausente publica tarjetas rotas.
- **Supuesto desactualizado sobre commits sin pushear.** Síntoma: el prompt de la tarea de og-image asumía 2 commits locales (política + og-image); había solo 1. Causa raíz: el commit de la política (`b7df700`) ya se había pusheado en su propia tarea, cosa que el prompt no reflejó. Claude Code lo detectó y corrigió. **Regla aprendida:** no afirmar el número de commits pendientes desde el chat; verificar con `git log origin/main..HEAD --oneline` antes de basar instrucciones en ese conteo.

## 7. Aprendizajes y restricciones descubiertas

- **Sacar un archivo del repo público (commit nuevo) ≠ borrarlo del historial.** En un repo público, un `git rm --cached` + push saca el archivo del build de Pages (404 en la URL) pero el contenido persiste en commits viejos accesibles vía la interfaz de GitHub. Borrarlo del historial exige `git filter-repo` + `push --force` (destructivo, su propia sesión). Para sensibilidad media (marco normativo, no datos) el commit simple es aceptable; documentar la limitación, no asumir que "ya no es accesible".
- **El escáner excluye `_archivo/` de su árbol.** El inventario NO es fuente confiable para ubicar archivos movidos a `_archivo/` (la política, los traspasos, el kit). Para el estado real de lo versionado, `git ls-files` es la autoridad; para lo físico, `find` o `ls` directos.
- **Discrepancia documental detectada (sin corregir):** `CLAUDE.md` y el traspaso v02 afirman que los traspasos viven solo en `_archivo/traspasos/`, pero existen copias de trabajo más nuevas en `50_documentacion/traspasos/` (ambas ubicaciones gitignored, ninguna pública). No es riesgo de exposición. El usuario decidió no priorizar la corrección esta sesión. Anotado para constancia.
- **El kit de identidad es la fuente de verdad de la og-image.** Tiene reglas visuales no negociables (concepto del traspaso con barras, colores exactos, jerarquía tipográfica, sin ALLCAPS, español de Chile). Cualquier cambio futuro de la tarjeta se hace editando `tarjeta-editable.html` del kit y regenerando el PNG, no improvisando.

## 8. Decisiones de diseño

- **Repo se mantiene público; sin scrub de historial.** El usuario necesita GitHub Pages, que en cuenta Free no funciona con repos privados. Se descartó privatizar (rompería el sitio) y se descartó el scrub de historial (destructivo, desproporcionado para la sensibilidad). Implicancia: la política sigue en el historial público; aceptado como riesgo menor.
- **Imagen oficial del kit en vez de la generada en el chat.** Se generó una og-image provisional (cairosvg, adaptando el flujo viejo a papel puro) y se descartó al llegar el kit oficial, que trae un concepto narrativo deliberado y tipografías reales. No competir con el diseño institucional definitivo.
- **`og:description` acortada.** La meta description del sitio es larga; para la tarjeta social se redactó una versión breve que no se trunca en la previsualización.
- **Kit editable a `_archivo/`, solo el PNG al sitio.** La `tarjeta-editable.html` y sus fuentes son instrumental de regeneración, no parte del sitio. Solo `og-image.png` (lo único que el sitio necesita) se versiona y publica. Evita publicar herramientas internas vía Pages y no duplica las fuentes de la raíz.

## 9. Constantes y parámetros vigentes

| Constante | Valor | Archivo | Nota |
|---|---|---|---|
| Versión del sitio | 1.0 | `index.html` (footer) | Sin cambios |
| Variante de diseño | d2 / comfortable | `index.html` (`<body>`), `app.js` | "Papel puro", panel oculto |
| Campo de capturas | `imgs: []` | `data.js` | Sin cambios |
| Carpeta de capturas | `assets/proyectos/` | — | Sin cambios |
| Retención del escáner | 2 versiones fijas | `00_escanear_proyecto.R` | actual / anterior |
| URL de la og-image | `https://tomgc.github.io/slep_monitoreo/assets/og-image.png` | `index.html` (metas OG) | Absoluta, obligatoria para OG |
| Dimensiones og-image | 1200×630 | `assets/og-image.png` | Estándar Open Graph |
| Azul institucional | `#0062A0` | kit (`tarjeta-editable.html`, `:root --ocean`) | Barra llena + "SLEP Costa Central" + "Resultados Educativos", mismo azul |

## 10. Arquitectura de archivos

Estado al cierre en `50_documentacion/estructura/estructura_actual.md` (generado 2026-06-15 22:04, regenerar con `Rscript 00_escanear_proyecto.R`). Cambios de esta sesión: `assets/og-image.png` agregado (versionado); `50_documentacion/activa/POLITICA_PROYECTO.md` retirado del versionado (preservado en `_archivo/documentacion/`); kit de identidad en `_archivo/documentacion/kit-identidad/` (no versionado, no aparece en el escáner por la exclusión de `_archivo/`). Sitio en raíz, sin cambios estructurales.

## 11. Pendientes y ruta sugerida

**Inventario de pendientes:**

1. **[Validación — manual del usuario] Forzar scrapeo social.** Pegar `https://tomgc.github.io/slep_monitoreo/` en developers.facebook.com/tools/debug y dar "Scrape Again" para que WhatsApp/redes cacheen la tarjeta antes de difundir. No es trabajo de Claude; es el último paso antes de compartir el link. **Criterio de éxito:** la previsualización muestra la tarjeta correcta.
2. **[Decisión de diseño] ¿Barra de navegación?** (heredado, pendiente 4 de v02). `app.js` busca `#siteNav`, `#navToggle` y scrollspy, pero el HTML no tiene nav (código inerte con guardas). Decidir: implementar nav (útil en pantallas largas) o limpiar el código muerto. **Complejidad:** baja (limpiar) / media (implementar). **Enfoque sugerido:** revisar primero cuánto crece la página con el contenido real; si el scroll es largo, implementar; si no, limpiar.
3. **[Bug de contenido] `@font-face` roto.** (heredado, pendiente 5 de v02). `colors_and_type.css` referencia `fonts/MuseoSans-100.otf`, ausente. Nota relevante de esta sesión: el kit oficial trae solo gobCL (Light/Regular/Heavy) y Museo Sans (500/700), NO incluye MuseoSans-100 ni -300, lo que confirma que esos pesos no son parte de la identidad oficial. **Enfoque:** quitar el `@font-face` de MuseoSans-100 (y evaluar el de -300, que sí existe en disco pero no en el kit), actualizando las referencias. Cae al siguiente peso disponible, no degrada visiblemente.
4. **[Cosmético] Comentario huérfano en `data.js`.** (heredado, pendiente 6 de v02). Línea suelta en el bloque de comentario superior. Limpiar en la próxima pasada por el archivo.
5. **[Naming] Fuentes con naming mixto.** (heredado, pendiente 7 de v02). `fonts/` mezcla guion (`MuseoSans-300`) y guion bajo (`MuseoSans_500/700`). Bloqueado en raíz porque `colors_and_type.css` las referencia literalmente; renombrar exige actualizar los `@font-face` en la misma operación. Se puede resolver junto con el pendiente 3 (ambos tocan `colors_and_type.css` y `fonts/`).
6. **[Documentación] Discrepancia de ubicación de traspasos.** `CLAUDE.md` y v02 afirman que los traspasos viven solo en `_archivo/traspasos/`; hay copias más nuevas en `50_documentacion/traspasos/`. Sin riesgo de exposición (ambas gitignored). Corregir `CLAUDE.md` para reflejar la realidad, o consolidar los traspasos en una sola ubicación. Baja prioridad.
7. **[Deuda de proceso] Backlog acumulativo sin consolidar.** Arrastrado desde v02. La copia íntegra v01+v02+v03 debe hacerla Claude Code con los archivos en disco (ver nota en sección 5). Es la deuda más antigua abierta; conviene cerrarla en una pasada dedicada.

**Auditoría de cierre (política 5.6):** el pipeline (escáner) corre de cero; estructura en norma con excepciones declaradas; outputs reproducibles (la og-image se regenera desde `tarjeta-editable.html`); nombres sin tildes/ñ/espacios en lo versionado. Sin deuda nueva sin documentar. La deuda de consolidación del backlog (pendiente 7) sigue abierta y se reitera.

**Ruta sugerida para la sesión 4:** (1) consolidar el backlog acumulativo (pendiente 7, deuda de proceso más antigua, requiere a Claude Code con los archivos en disco); (2) resolver `@font-face` roto + naming de fuentes juntos (pendientes 3 y 5, misma zona: `colors_and_type.css` + `fonts/`); (3) decidir nav (pendiente 2). Diferir: cosmético de `data.js` y discrepancia de `CLAUDE.md` hasta una pasada de limpieza. Las capturas reales de proyectos (poblar `imgs` en `data.js`) siguen siendo trabajo manual del usuario y desbloquean la galería.

## 12. Instrucciones específicas para la próxima sesión

- ⚠️ NO versionar documentación interna (traspasos, política, kit) sin recordar que Pages publica todo lo versionado.
- ⚠️ NO mover los archivos del sitio fuera de la raíz: rompe el deploy de Pages.
- ⚠️ NO afirmar el número de commits sin pushear desde el chat: verificar con `git log origin/main..HEAD --oneline`.
- ✅ ANTES de commitear un HTML que referencia un activo (imagen, script), verificar que el activo existe en disco.
- ✅ ANTES de commitear tras operaciones que crean carpetas nuevas, stagear rutas explícitas (no `git add -A`).
- ✅ ANTES de editar la og-image, hacerlo en `tarjeta-editable.html` del kit (en `_archivo/documentacion/kit-identidad/`) y regenerar el PNG; respetar las reglas no negociables del `COMO-USAR.md`.
- 🔒 `git push` siempre requiere aprobación explícita del usuario.
- 🔒 Español neutro sin voseo en todo (código, comentarios, commits, contenido).
- 🔒 `data.js` nunca se edita para datos derivados: `imgs` se puebla con rutas reales a `assets/proyectos/`.
- 🔒 El repo se mantiene público (lo necesita Pages); no privatizar sin resolver el plan de cuenta primero.

## 13. Fragmentos de código de referencia

**Correr el escáner (regenera el inventario, esquema actual/anterior):**
```bash
Rscript 00_escanear_proyecto.R
```

**Verificar commits locales sin pushear (antes de basar instrucciones en el conteo):**
```bash
git log origin/main..HEAD --oneline
```

**Sacar un archivo trackeado del repo preservando copia local en `_archivo/`** (patrón usado con la política; útil si el archivo ya fue borrado del disco):
```bash
mkdir -p _archivo/documentacion
git show HEAD:RUTA_TRACKEADA > _archivo/documentacion/NOMBRE.md   # recupera desde el blob
git rm --cached RUTA_TRACKEADA                                    # desindexa
```

**Regenerar la og-image desde el kit (entorno con Node, según COMO-USAR.md):**
```javascript
// node + playwright — exporta og-image.png a 1200×630 exactos
const { chromium } = require('playwright');
(async () => {
  const b = await chromium.launch();
  const p = await b.newPage({ viewport: { width: 1200, height: 630 } });
  await p.goto('file://' + __dirname + '/tarjeta-editable.html');
  await p.addStyleTag({ content: '#card{transform:none!important}' });
  await p.waitForTimeout(500); // que carguen las fuentes
  await p.locator('#card').screenshot({ path: 'og-image.png' });
  await b.close();
})();
```

**Verificar que la og-image está publicada y la política fuera:**
```bash
curl -so /dev/null -w "%{http_code}\n" https://tomgc.github.io/slep_monitoreo/assets/og-image.png       # 200
curl -so /dev/null -w "%{http_code}\n" https://tomgc.github.io/slep_monitoreo/POLITICA_PROYECTO.md        # 404
```

## 14. Reapertura

- **Nombre del chat:** `slep_monitoreo, sesión 4 (Claude Opus 4.8)`
- **Mensaje de apertura pre-armado:** tipo CONTINUATION. El protocolo (política + settings operacionales) vive en la knowledge base del Project y se lee desde ahí. Se adjuntan los específicos de la sesión.
- **Documentos para la próxima sesión:**
  1. *Protocolo en knowledge base (NO se adjuntan, solo verificar que estén al día):* `POLITICA_PROYECTO.md`, `SETTINGS_Y_PROMPTS_OPERACIONALES.md`.
  2. *Opcionales según el foco:* `CLAUDE.md` (vive en el repo, en la raíz) si la sesión corre en Claude Code; `traspaso_cierre_v01.md` y `traspaso_cierre_v02.md` (en `_archivo/traspasos/`) SI se aborda la consolidación del backlog (pendiente 7); `colors_and_type.css` si se aborda el `@font-face` roto o el naming de fuentes.
  3. *Específicos de la sesión (SÍ se adjuntan):* este traspaso `traspaso_cierre_v03.md`; el inventario `50_documentacion/estructura/estructura_actual.md`.
- **Nota final:** si algún archivo listado cambió entre sesiones, adjuntar la versión más actualizada al abrir y avisarlo en el mensaje de apertura.
