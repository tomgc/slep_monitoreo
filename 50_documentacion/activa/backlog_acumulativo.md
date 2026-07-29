# Backlog acumulado — slep_monitoreo

> Documento único de memoria de largo plazo. Consolida sesión 1 (v01), 2 (v02), 3 (v03), 4 (v04), 5 (v05), 6 (v06) y 7 (v07). Numeración correlativa global y permanente: nunca se reinicia ni renumera. Entradas previas copiadas íntegras. Cierra la deuda de consolidación arrastrada desde v02.
> Generado: 2026-06-16. Origen: traspaso_cierre_v01/v02/v03. Actualizado hasta v07 (2026-07-27).

## 1. Objetivo del proyecto

El sitio `tomgc.github.io/slep_monitoreo` es una página estática institucional de presentación del Área de Monitoreo de Procesos y Resultados Educativos, dentro de la Subdirección de Apoyo Técnico Pedagógico del SLEP Costa Central. Es single-page, sin dependencias externas, alojado en GitHub Pages. Su propósito es comunicar qué hace el Área, su trayectoria, ejemplos de trabajo, su equipo y un glosario técnico. El desarrollo se inició el 2026-04-09 (commit base v1.2) y la primera sesión documentada con cierre de traspaso es el 2026-05-25 (esta).

## 2. Nota metodológica

Cada ítem del backlog cronológico representa una solicitud distinguible del usuario (no las acciones técnicas para implementarla). Cuando el usuario pide un lote (por ejemplo "aplica las mejoras 1, 2, 3, 4, 7, 8, 9"), cada sub-pedido se cuenta como un cambio. Los errores introducidos por el asistente y corregidos sin que el usuario los reporte no se contabilizan; sí se cuentan los bugfixes reportados por el usuario (por ejemplo, "timeline cortada" o "flecha al revés"). La clasificación temática es aproximada porque muchos cambios tocan más de una categoría: en esos casos se clasifica por la intención primaria del usuario al solicitarlo. Las fuentes del conteo son este documento y el historial de conversaciones; los commits de git son un proxy pero no son la unidad de cuenta.

## 3. Clasificación temática

Catálogo de 10 categorías de v01 (§5.3 original), recalculado sumando las 12 entradas nuevas (28-39) sobre la base de v01. Porcentajes sobre el total cronológico de 39 entradas.

| Categoría | N° | % sobre 39 | Descripción |
|---|---|---|---|
| Estructura de contenido | 4 | 10.3% | Secciones nuevas o reestructuradas del sitio: Trayectoria, Ejemplos enriquecidos, etc. |
| Identidad visual | 7 | 17.9% | Paleta, tipografía, fondos, branding del footer y del og-image. |
| Layout y composición | 5 | 12.8% | Decisiones de grilla, sidebar, hero, timeline horizontal/vertical, max-widths. |
| Interacción y JS | 4 | 10.3% | Scroll-spy, observers de entrada de elementos, fades dinámicos por scroll. |
| Responsive y accesibilidad | 1 | 2.6% | Breakpoints (900px, 700px), `prefers-reduced-motion`, `prefers-color-scheme`, modo impresión. |
| Meta social y SEO | 2 | 5.1% | Open Graph, Twitter Card, favicon. |
| Reproducibilidad y tooling | 3 | 7.7% | Script de regeneración del og-image, refactor a data-driven. |
| Documentación | 2 | 5.1% | README, changelog, comentarios. |
| Arquitectura del repositorio | 8 | 20.5% | Variantes en `/variants/`, promoción de variante a index, rename del repo. |
| UX copy y bugfixes reportados | 1 | 2.6% | Hint del timeline corregido. |
| **Total** | **37** | **94.9%** | |

> **Nota:** El conteo por categoría hereda la aproximación de v01 (§5.3 original, declarada "≈ 25"). La suma de categorías (37) es orientativa y no coincide exactamente con el total cronológico (39 entradas): la diferencia son 2 entradas de la sesión 1 que v01 nunca clasificó, conservadas sin recategorizar para no reescribir el backlog previo. La fuente de verdad del conteo es el detalle cronológico (§5), no esta tabla.

## 4. Resumen estadístico por sesión

| Sesión | Traspaso | N° de cambios | Modelo | Foco principal |
|---|---|---|---|---|
| 1 | v01 | ~25 | Sonnet 4.7 | Diseño y desarrollo del sitio v1.2 → v2.0 + variantes |
| 2 | v02 | 7 | No registrado | reemplazo del sitio, puesta en norma |
| 3 | v03 | 4 | No registrado | seguridad del repo, tarjeta Open Graph |
| 4 | v04 | 1 | Claude Opus 4.8 | eliminar chrome de variantes |
| 5 | v05 | 4 | Claude Opus 4.8 | limpieza de nav muerta + poblado de portafolio |
| 6 | v06 | 3 | Claude Opus 4.8 | capturas de producto + ajuste del visor del lightbox |
| 7 | v07 | 7 | Claude Opus 4.8 | visor full-res + lightbox dos columnas + limpieza de deuda diferida |
| **Total** | | **53** | | |

(El modelo de las sesiones 2 y 3 no figura en los traspasos de origen: "No registrado", sin inventar.)

## 5. Detalle cronológico de cambios por sesión

### Sesión 1 (Sonnet 4.7) — 2026-05-17 a 2026-05-25

Sesión inicial documentada. Foco: partir de la v1.2 heredada, iterar el diseño hasta v2.0 con identidad SLEP y dejar variantes alternativas. Numeración correlativa global desde 1.

**Bloque A — Estructura y v1.3**

1. Agregar sección "Trayectoria" con línea de tiempo vertical de 6 hitos.
2. Enriquecer "Ejemplos de trabajo" con grid de 4 productos y stat-card ampliado a 3 indicadores.
3. Agregar enlace al sitio SLEP en el footer.
4. Cambiar la línea de tiempo de vertical a horizontal con scroll y snap.

**Bloque B — Mejoras v1.4**

5. Open Graph + Twitter Card con og-image.png (1200×630, navy/blue).
6. Fades laterales en la timeline con `at-start`/`at-end` por JS.
7. Modo impresión (`@media print`) con grilla de timeline, glosario 2-col, ocultamiento de nav.
8. Mini-mockups SVG específicos por categoría de producto (reporte, dashboard, análisis, talleres).
9. Modo oscuro automático con `prefers-color-scheme: dark`.
10. Animación de entrada con stagger en los hitos.

**Bloque C — Principios de desarrollo**

11. Refactorizar stat-card de HTML hardcoded a render desde `const indicadores`.
12. Crear `scripts/regenerate-og-image.sh` reproducible con Chrome headless.
13. Expandir README con stack, datasets editables, regeneración del og.
14. Agregar changelog al README.

**Bloque D — Variantes alternativas**

15. Crear `variants/editorial.html` (long-form serifa).
16. Crear `variants/dashboard.html` (bento multi-color).
17. Crear `variants/institucional.html` (documento oficial brutalist).
18. Crear `variants/index.html` (galería de las tres).

**Bloque E — Paleta SLEP y minimalismo**

19. Reescribir las 3 variantes con la paleta oficial SLEP y formato comprimido.
20. Cambiar fondo de página a blanco en todas las variantes; crema queda como acento.
21. Agregar sidebar izquierda fija con scroll-spy a las 3 variantes (consistente con el original).

**Bloque F — Promoción a v2.0**

22. Promover `dashboard.html` a `index.html` (v2.0): rebrand del og-image con paleta SLEP, mover el index v1.4 a `variants/classic.html`, eliminar `variants/dashboard.html`, actualizar `variants/index.html` y README.

**Bloque G — Pulido del timeline**

23. Cambiar timeline a wrap-grid sin scroll (intento intermedio resuelto en 24).
24. Restaurar timeline horizontal **invertida** (2026 a la izquierda, scroll al pasado), con scrollbar visible siempre y fades dinámicos.
25. Items más angostos (132px) + fade más sutil (14px) + timeline vertical en viewport <700px.

**Bloque H — Correcciones finales**

26. Corregir hint del timeline: "← desplaza para ver al pasado" → "desplaza → para ver hitos anteriores".
27. Actualizar URLs tras rename del repo (`monitoreo` → `slep_monitoreo`): og:url, og:image, twitter:image, README, memoria, remote local.

### Sesión 2 (v02) — 2026-06-15

28. **Reemplazo total del sitio** (`d1e3710`). El handoff `handoff/site/` reemplazó al sitio v2.1. El v2.1 se respaldó en `_archivo/20260615_v2.1_pre_reemplazo/`. Footer fijado en 1.0 (primera versión del sitio nuevo). Se corrigió un voseo en comentario de `data.js` ("Reemplazá" → "Reemplaza"). `handoff/` quedó fuera de Git (gitignored).
29. **Papel puro fijado** (`a39cfde`). `<body>` a `data-variant="d2" data-density="comfortable"`. Botón y panel de variantes con `hidden`. `applyStored()` fija los valores en vez de leer localStorage. Estilos d1–d5 conservados.
30. **Galería en lightbox** (`ec35516`). Eliminado `image-slot.js` e `image-slots.state.json`. Banner usa `<img>` directo desde `imgs[0]` o placeholder. Lightbox con pasador (flechas, puntos, teclado, contador). Campo `imgs: []` agregado a los 10 proyectos. Carpeta `assets/proyectos/` creada.
31. **CI a Node 24** (`2f5f679`). Acciones del workflow actualizadas: `checkout@v6`, `configure-pages@v6`, `upload-pages-artifact@v5`, `deploy-pages@v5`. Mitiga el forzado de Node 24 del 16-jun-2026.
32. **Reorganización estructural** (`8a9196d`). `30_documentacion/` → `50_documentacion/`. Traspasos a snake_case. Decenas huérfanas `10_insumos/` y `20_procesamiento/` retiradas del árbol vivo (respaldadas en `_archivo/` e historial).
33. **Puesta en norma** (`ef7a097`). Creado `00_escanear_proyecto.R` (excepción de R declarada). Creado `CLAUDE.md`. `POLITICA_PROYECTO.md` reubicada a `50_documentacion/activa/`.
34. **Cierre** (`c5212c1`). Escáner migrado a esquema actual/anterior (excepción declarada a política 7.3-7.4). Traspasos movidos a `_archivo/traspasos/` (gitignored): no deben ser públicos vía Pages. `CLAUDE.md` actualizado con ambas excepciones. Inventario refrescado para reflejar el árbol sin traspasos.

### Sesión 3 (v03) — 2026-06-15

35. **Sacar `POLITICA_PROYECTO.md` del repo público** (`b7df700`). La política estaba trackeada en `50_documentacion/activa/POLITICA_PROYECTO.md` y su archivo físico ya había sido borrado del disco en una sesión previa (baja sin commitear). Procedimiento adaptado: `git show HEAD:50_documentacion/activa/POLITICA_PROYECTO.md > _archivo/documentacion/POLITICA_PROYECTO.md` (recuperar copia local desde el blob), `git rm --cached` (desindexar). Staging selectivo para no arrastrar el output del escáner sin commitear. Pusheado y verificado: 404 en la URL de Pages. Categoría: gobernanza y estructura del repositorio.
36. **Metas Open Graph + Twitter Card en `index.html`** (parte de `fc7da2f`). Bloque insertado en el `<head>` tras `theme-color`: `og:type`, `og:site_name`, `og:title`, `og:description` (acortada respecto al meta description largo para no truncar en la tarjeta), `og:url`, `og:image` + `width`/`height`/`alt`, `og:locale`; Twitter Card `summary_large_image` con `title`/`description`/`image`/`image:alt`. URLs absolutas al dominio de Pages. Categoría: decisión de diseño / difusión.
37. **Tarjeta para compartir oficial** (parte de `fc7da2f`). Se descartó una `og-image` provisional generada en el chat (adaptación del flujo viejo a la identidad v1.0) al llegar el kit oficial del usuario. La imagen oficial (`og-image.png`, 1200×630) implementa el concepto narrativo del traspaso (cuatro barras: contorno gris heredado → bosquejo azul claro → azul sólido consolidado) con tipografías reales gobCL + Museo Sans. Colocada en `assets/og-image.png` (versionada, pública). Categoría: identidad visual.
38. **Kit de identidad a `_archivo/`** (no versionado). `tarjeta-editable.html` (fuente de regeneración de la og-image), `COMO-USAR.md` y `fonts/` (5 otf) colocados en `_archivo/documentacion/kit-identidad/`. Instrumental de regeneración, no parte del sitio público. Categoría: gobernanza y estructura del repositorio.

### Sesión 4 (en curso) — 2026-06-16

39. **Eliminar de raíz el botón/panel de variantes de diseño (chrome de desarrollo)** (`4c7424a`). Causa raíz: el atributo `[hidden]` del botón quedó inerte porque `.variants-fab` definía `display: inline-flex`, una regla de autor que vence el `display: none` que el user-agent aplica a `[hidden]` en la cascada (autor > user-agent); mismo patrón que el bug del lightbox de una sesión previa. Se eliminaron las tres capas: el markup en `index.html` (botón `variants-fab` + panel `variants-panel`), la sección VARIANTS PANEL en `app.js` (incluido `applyStored()`, redundante porque el `<body>` ya trae `data-variant="d2" data-density="comfortable"` hardcodeados), y las reglas `.variants-fab`/`.variants-panel`/`.vp-*` en `styles.css`. Se conservaron las reglas de diseño `[data-variant]`/`[data-density]`. Verificado en preview (botón ausente, sin errores de consola) y en producción (grep sin coincidencias tras el deploy). Categoría: Interacción y JS.

### Sesión 5 (Claude Opus 4.8) — 2026-06-26

Foco: cerrar deuda diferida (navegación muerta, documentación desfasada) y poblar el portafolio con los textos definitivos de los 11 proyectos. Capturas de producto quedan como prioridad 1 de la sesión 6.

**Bloque A — Limpieza de navegación muerta (opción A)**

40. **Eliminar las dos capas muertas de navegación** (`194e8f8`). El markup de header/nav nunca existió en `index.html`, pero quedaban dos capas que lo esperaban: el CSS (bloque `Header` completo en `styles.css`: `.site-header`, `.brand-*`, `.site-nav`, `.nav-toggle`, media query de nav mobile, `body.nav-open`, más reglas de footer multicolumna sin markup `.grid`/`.flogo`/`h4`/`ul`/`.addr`) y el JS (sección NAV en `app.js`: toggle mobile + scroll-spy + IntersectionObserver). Se eliminaron ambas; se conservaron `.site-footer` y `.footer-legal` (vivos). También se corrigieron dos afirmaciones falsas en `CLAUDE.md`: los traspasos y `backlog_acumulado.md` viven en `50_documentacion/traspasos/` (gitignored vía `*.md`), no en `_archivo/traspasos/`, y la carpeta no está vacía. Decisión de tres capas resuelta como "limpiar" en vez de "implementar nav" porque el sitio es single-page corto con diseño congelado d2; si los banners alargan la página, la nav se reimplementa con el largo real (el scroll-spy se recupera de Git). Neto −79 líneas. Verificado en producción (HTTP 200, grep sin coincidencias de nav). Categoría: Interacción y JS.

**Bloque B — Poblado del portafolio**

41. **Reescritura total de `PROYECTOS` en `data.js`** (`f5e4155`). Reemplazo del contenido con los 11 proyectos definitivos provistos por el usuario en un `.docx`. Cambios: títulos definitivos (varios reescritos, p. ej. AEL pasó a "Sistema de alertas de Anótate en la Lista" tras aclararse que AEL = Anótate en la Lista, no "Análisis del Entorno y los Logros" que era un dato inventado heredado del `objetivo` viejo); se eliminó la minuta Simce antigua ("Minutas de resultados de las pruebas Simce", sin texto en el `.docx`, queda pendiente su reemplazo por una nueva versión basada en 3 PDF); se crearon dos proyectos nuevos (`idps`, `rendimiento`). Se corrigieron erratas de tipeo de los textos fuente ("territorio territorio", "contruido", "dirigido todos", "resulta fundamentales", "prepara, una", "propósito caracterizar", "prueblos", comillas rectas → tipográficas). Categoría: Estructura de contenido.

42. **Nuevos campos `orden` y `sintesis`** (`f5e4155`). `orden` (entero 1-11) define el orden de aparición; el render ordena primero por `estado` (vigentes arriba) y luego por `orden`, de modo que los dos proyectos en desarrollo (`desvinculacion`, `rendimiento`) quedan siempre al final aunque su número sea consecutivo. `sintesis` es un arreglo de párrafos que se muestra en el lightbox al abrir la reseña. Render adaptado en `app.js` (`renderBanners()` con sort de dos criterios; `openLightbox()` pinta `sintesis` como múltiples `<p>` con fallback a `objetivo`); `#lbObj` en `index.html` pasó de `<p>` a `<div>` para alojar varios párrafos sin HTML inválido; `styles.css` con separación vertical entre párrafos (`.lb-obj p + p`). Categoría: Interacción y JS.

43. **Blindar documentos de protocolo en `.gitignore`** (`a277319`). `POLITICA_PROYECTO.md` y `SETTINGS_Y_PROMPTS_OPERACIONALES.md` se agregaron al `.gitignore` por nombre exacto. Detectado al aparecer `SETTINGS_Y_PROMPTS_OPERACIONALES.md` sin trackear en `50_documentacion/activa/`: GitHub Pages publica todo el repo, y el `.gitignore` no protegía ningún documento de protocolo por nombre (la política solo no se publicaba porque su archivo físico ya no estaba en disco desde la sesión 3, no por blindaje). Mismo criterio que la entrada 35. Verificado en producción: ambas URLs dan 404. Categoría: Arquitectura del repositorio.


### Sesión 6 (Claude Opus 4.8) — 2026-06-26

Foco: poblar las capturas de producto de los proyectos vigentes (prioridad 1 heredada de v05) y ajustar el visor del lightbox para que cada captura se vea completa. Las dos tareas quedaron desplegadas y verificadas en producción.

**Bloque A — Capturas de producto**

44. **Poblar el campo `imgs` de los 9 proyectos vigentes** (`8126b58`). El usuario produjo las 26 capturas de producto (no del sitio) y las colocó en `assets/proyectos/` con la convención `<id>-N.png` acordada en v05 (`-1` = portada del banner). Distribución: `asistencia` 4, `resguardo` 4, `estandares` 3, `idps` 4, `categorias` 3, `parvularia` 3, `inicial` 3, `costapresente` 1, `ael` 1. Los dos proyectos en desarrollo (`desvinculacion`, `rendimiento`) quedan con `imgs: []` (placeholder "Próximamente"). Se editó `data.js` poblando los 9 arreglos `imgs` (validación: 26 rutas únicas, formato canónico `assets/proyectos/[a-z]+-[0-9]+\.png`, coincidencia 1:1 con los 26 archivos en disco). Commit único (cambio conceptual único: portafolio con capturas reales) con las 26 PNG + `data.js`, staging selectivo (`git add data.js assets/proyectos/`), escáner fuera. Verificado en producción: 9 portadas 200, pasador del lightbox funcional (resguardo 4 slides, contador 1/4→4/4), 2 placeholders intactos, cero 404. 🔴 Gobernanza: la revisión de datos identificables de las capturas la realizó el usuario (Claude solo recibió los nombres de archivo, no el contenido). Categoría: Estructura de contenido.

**Bloque B — Ajuste del visor del lightbox**

45. **Visor del lightbox adaptado a la proporción de cada captura** (`3411bdb`). Síntoma reportado: las capturas se veían "entrecortadas" (recortadas) en el lightbox. Causa raíz: `.lb-stage` tenía `aspect-ratio: 16/9` fijo y `.lb-slide img` tenía `object-fit: cover`, lo que recortaba toda captura con proporción distinta a 16:9 (las capturas son heterogéneas: minutas verticales 1082×1540, dashboards anchos). Solución (opción A, altura fija con letterbox): `aspect-ratio: 16/9` → `height: min(58vh, 460px)` (altura estable, con techo en px para no comprimir la síntesis bajo el visor dado el `max-height: 90vh` del `.lb-card`), y `object-fit: cover` → `contain` (captura entera, franjas cream donde sobra). El `.banner-shot` de la grilla se conservó en `cover` (recorte uniforme deseable para la fila de banners). Verificado en producción (fetch no-store): CSS desplegado con las reglas nuevas, `aspect-ratio` viejo ausente, capturas verticales 200, altura 460px estable entre slides. Nota de proceso: el navegador del preview cacheó el `styles.css` viejo; resuelto con cache-bust en local, y en producción el redeploy invalida la caché. Categoría: Interacción y JS.

**Bloque C — Deuda registrada**

46. **Pendiente de optimización de las capturas** (sin ejecutar, registrado para sesión futura). Las 26 capturas suman ~9 MB; varias superan 400 KB (p. ej. `parvularia-1.png` ≈ 720 KB). Funcionan sin problema, pero engrosan el repo y el payload del deploy. Pendiente diferido: comprimir los PNG o migrar a WebP en una pasada de cosmética dedicada, junto con los otros diferidos (face 400 de Museo Sans, campo `thumb` obsoleto). No bloqueante. Categoría: Reproducibilidad y tooling.

### Sesión 7 (Claude Opus 4.8) — 2026-07-27

Foco: agregar un visor de imagen a resolución completa sobre el lightbox y darle más protagonismo a la reseña; de paso, cerrar tres de los pendientes diferidos de v06 (Trayectoria oculta, `thumb`, face 400). Siete solicitudes distinguibles, siete commits, todos desplegados y verificados en producción.

**Bloque A — Visor de imagen a resolución completa**

47. **Visor full-res sobre el lightbox** (commit del full-res básico). Solicitud: al hacer click en una captura del lightbox, verla a tamaño completo con una X para cerrar. Se agregó un overlay propio (`.lb-full`), creado una sola vez en `app.js` y reutilizado, con la imagen ajustada al viewport (`object-fit: contain`, sin scroll), botón X en la esquina superior derecha, y cierre por click en el fondo y por tecla Esc. Trampa resuelta: el handler global de Esc del lightbox debía cerrar primero el full-res si está abierto (guard `if (fsViewer.classList.contains("open"))` con `stopPropagation`), para no cerrar el lightbox de fondo. Las slides-imagen recibieron `cursor: zoom-in`. El placeholder "próximamente" no es clickeable. Categoría: Interacción y JS.

48. **Navegación dentro del visor full-res** (`e335539`). Solicitud: poder navegar entre fotos dentro del zoom, con flechas y teclado. El visor pasó de mostrar un `src` suelto a conocer el arreglo de capturas (`fsShots`) y compartir el índice `lbIndex` con el lightbox, de modo que navegar en el full-res mueve también el slide de fondo (`fsGo()` llama a `fsRender()` + `lbRender()`). Flechas prev/next (`.lb-full-nav`, ocultas si hay una sola captura) y teclas ←/→ en modo full-res; Esc sigue cerrando. Categoría: Interacción y JS.

**Bloque B — Cierre de deuda diferida de v06**

49. **Ocultar la sección Trayectoria/Hitos** (`3b7d1bb`). Solicitud: quitar la sección del sitio, con intención de quizás reutilizarla más adelante. Resuelto como ocultamiento reversible en vez de borrado: atributo `hidden` en el `<section id="trayectoria">` de `index.html` más un guard `.section[hidden]{display:none}` en `styles.css` (blindaje ante la trampa conocida: `[hidden]` es inerte si una regla de autor fija `display` sobre `.section`; aquí `.section` solo fija `padding`, pero el guard previene reactivaciones futuras). El render del timeline en `app.js` y el arreglo `HITOS` en `data.js` se conservan intactos (corren en un nodo oculto, sin costo ni error). Revertir = quitar el atributo `hidden`. Categoría: Estructura de contenido.

50. **Eliminar el campo `thumb` obsoleto de `data.js`** (`ac813e7`). Deuda heredada: el campo `thumb` (valores `plum`/`ocean`/`olive`/`coral`/`sand`) definía el tono del placeholder de captura, pero dejó de consumirse cuando los proyectos pasaron a tener capturas reales. Verificado que no se lee en `app.js` (el render `bannerEl` no lo referencia) ni en CSS (las coincidencias `scrollbar-thumb` y `.banner-thumb` no tienen relación con el campo). Se eliminaron los 11 campos `thumb` de los proyectos más la línea del comentario de cabecera que los documentaba. `node --check` verde. Cero impacto visual (código muerto). Categoría: Reproducibilidad y tooling.

51. **Mapeo explícito de Museo Sans 400 → `.otf` 500** (`0c48a06`). Deuda heredada (defecto visual): `colors_and_type.css` no declara face 400 de Museo Sans (solo 300/500/700), así que todo `font-weight: 400` sobre `--font-body` resolvía a 500 por font-matching silencioso del navegador. Se agregó un `@font-face` de peso 400 apuntando a `MuseoSans_500.otf`, con comentario que lo declara mapeo deliberado y reversible cuando exista `MuseoSans_400.otf` real. Se eligió esta opción (A) sobre reasignar los 6 selectores `--font-body`+400 a 300/500 explícito (B, que habría cambiado el render y exigido decisiones de diseño caso por caso) y sobre conseguir la fuente real (C, requiere el archivo). Cero cambio visual: esos textos ya se veían en 500; ahora es explícito, no silencioso. Categoría: Identidad visual.

**Bloque C — Ajustes de interacción del lightbox**

52. **Click en la imagen del banner abre la reseña** (`3c10c3b`). Síntoma reportado: al hacer click en la captura de una tarjeta, no pasaba nada. Causa raíz: un bloque en `bannerEl` (`app.js`) aplicaba `stopPropagation` a click/mousedown/keydown sobre `.banner-media` para "evitar que un clic sobre el área de imagen dispare el lightbox dos veces", pero el handler de apertura vive en el nodo padre (la tarjeta), no había doble disparo real, y el `stopPropagation` solo bloqueaba la apertura desde la imagen. Se eliminó el bloque (−4 líneas); ahora el click en la imagen burbujea al handler de la tarjeta y abre la misma reseña. Categoría: Interacción y JS.

53. **Lightbox reorganizado a dos columnas en desktop** (`c6e19b3`). Solicitud: la reseña quedaba con poco protagonismo, pequeña bajo la captura; mostrarla lado a lado. Solo CSS: `.lb-card` pasó de columna a fila (`flex-direction: row`) con `max-width` de 680→1040px; galería a la izquierda (`flex: 0 0 60%`, con `border-right` en vez de `border-bottom`), reseña a la derecha (`flex: 1 1 40%`) con scroll propio. El `.lb-stage` dejó la altura fija `min(58vh,460px)` por altura flexible (`flex: 1 1 auto; min-height: 0`, clave para que los dots no lo empujen fuera). Breakpoint `@media (max-width: 880px)` revierte a columna apilada (galería arriba con `min(52vh,420px)`, texto abajo) preservando el comportamiento móvil previo. `index.html` y `app.js` intactos. Categoría: Layout y composición.

---

## 6. Delta del backlog

Este documento consolida 4 sesiones (entradas 1-39), creado en la sesión 4, cerrando la deuda de consolidación abierta desde v02. Mapeo de renumeración aplicado: v02 local 1-7 → global 28-34; v03 local 1-4 → global 35-38; sesión 4 → 39. Sin reescritura de entradas previas: las entradas 1-27 se copiaron textuales de v01 §5.5 y los cuerpos de 28-38 se copiaron de v02/v03 §4 cambiando solo el número correlativo.

**Sesión 5 (v05):** 4 entradas nuevas (40-43), sin reescritura ni renumeración de las anteriores. Resumen estadístico actualizado (fila sesión 5, total 39 → 43). Sin cambios de taxonomía. Las categorías de las entradas nuevas (Interacción y JS ×2, Estructura de contenido ×1, Arquitectura del repositorio ×1) usan el catálogo existente; la tabla de clasificación temática §3 conserva la aproximación heredada y no se recalcula (su fuente de verdad es el detalle cronológico §5, no la tabla).

**Sesión 6 (v06):** 3 entradas nuevas (44-46), sin reescritura ni renumeración de las anteriores. Resumen estadístico actualizado (fila sesión 6, total 43 → 46). Sin cambios de taxonomía. Categorías de las nuevas: Estructura de contenido ×1 (capturas), Interacción y JS ×1 (visor del lightbox), Reproducibilidad y tooling ×1 (pendiente de optimización registrado, sin ejecutar). La tabla §3 no se recalcula.

**Sesión 7 (v07):** 7 entradas nuevas (47-53), sin reescritura ni renumeración de las anteriores. Resumen estadístico actualizado (fila sesión 7, total 46 → 53). Sin cambios de taxonomía. Categorías de las nuevas: Interacción y JS ×3 (visor full-res básico, navegación del visor, click en imagen), Estructura de contenido ×1 (Trayectoria oculta), Reproducibilidad y tooling ×1 (`thumb` eliminado), Identidad visual ×1 (mapeo Museo Sans 400), Layout y composición ×1 (lightbox dos columnas). Con esta sesión se cerraron tres de los pendientes diferidos de v06 (Trayectoria, `thumb`, face 400); quedan pendientes la minuta Simce (espera 3 PDF del usuario) y la optimización de las 26 capturas. La tabla §3 no se recalcula (su fuente de verdad es el detalle cronológico §5).

