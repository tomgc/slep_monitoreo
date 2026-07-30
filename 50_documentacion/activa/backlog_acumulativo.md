# Backlog acumulado — slep_monitoreo

> Documento único de memoria de largo plazo. Consolida sesión 1 (v01), 2 (v02), 3 (v03), 4 (v04), 5 (v05), 6 (v06), 7 (v07), 8 (v08) y 9 (v09). Numeración correlativa global y permanente: nunca se reinicia ni renumera. Entradas previas copiadas íntegras. Cierra la deuda de consolidación arrastrada desde v02.
> Generado: 2026-06-16. Origen: traspaso_cierre_v01/v02/v03. Actualizado hasta v09 (2026-07-30).

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
| 8 | v08 | 5 | Claude Opus 5 | minuta Simce + encargo de rediseño a Claude Design |
| 9 | v09 | 11 | Claude Opus 5 | reconciliación del repo + pliego de capturas + encargo autónomo |
| **Total** | | **69** | | |

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

### Sesión 8 (Claude Opus 5) — 2026-07-29

Foco: construir la entrada del proyecto de minutas Simce 2025 (prioridad 1 heredada de v07) y encargar el rediseño del portafolio. Cierre anticipado por sesión paralela sobre el mismo repositorio.

54. **Entrada del proyecto de minutas Simce 2025** (`ed884ce`). Solicitud: construir el proyecto en `data.js` a partir de tres PDF (uno por ámbito: variación de puntajes, Estándares de Aprendizaje, IDPS). Se redactó `tipo`, `titulo`, `objetivo` y cinco párrafos de `sintesis` a partir del contenido de las minutas, respetando la terminología institucional ("establecimiento educacional" completo en la primera mención de cada párrafo). Se insertó como `orden: 3` para agruparlo con los tres motores Simce/IDPS/Categorías, renumerando programáticamente los proyectos 3-11 a 4-12 sin alterar su orden relativo. `estado: "vigente"` con `imgs: []`, a la espera de la decisión de gobernanza sobre las capturas. Validado con `node --check` y verificado en producción por `curl`. Categoría: Estructura de contenido.

55. **Registro documental del cierre de v07 versionado** (`70a4503`). Deuda heredada detectada al abrir: `ESTADO.md` (destilado de v07) y `backlog_acumulativo.md` (entradas 47-53) llevaban desde el 27 de julio modificados en el árbol de trabajo sin commitear. Se agruparon en un commit por ser un mismo cambio conceptual. En la misma pasada se absorbió por avance rápido la rama `gobernanza/v14` original (creada el 30 de junio, sin trabajo propio, donde había caído por error el commit del Simce) y se borró, y se subieron los cuatro commits acumulados desde el 30 de junio a `origin/main`. Categoría: Reproducibilidad y tooling.

56. **Encargo escrito del rediseño del portafolio** (`50_documentacion/activa/encargo_diseno_portafolio.md`). Solicitud: dar más protagonismo a las imágenes del portafolio y recorrer los proyectos uno por uno, en vez de una lista de solo texto. Se presentaron tres direcciones (carrusel de proyectos, grilla de mosaicos, banner invertido) con recomendación por el carrusel. El usuario optó por delegar la ejecución a Claude Design, de modo que el producto de esta sesión es el encargo, no el rediseño: contexto del sitio y audiencia, problema a resolver, dirección preferida y alternativas, datos del contenido (12 proyectos, 3 sin capturas, títulos largos, proporciones variables), restricciones técnicas (sin dependencias, tipografías locales, móvil, accesibilidad de teclado), qué queda fuera (lightbox y visor full-res) y entregable esperado. Categoría: por confirmar contra el catálogo de §3 del backlog; no se inventó una categoría nueva.

57. **Pendiente registrado: repositorio interno del Área** (sin ejecutar). Solicitud del usuario: una segunda salida consistente en un repositorio con documentación completa, scripts y todo lo necesario para que los profesionales del equipo de monitoreo puedan retomar cualquier proyecto del Área y seguir desarrollándolo. Se registró con la observación de que por alcance (todos los proyectos del Área), por gobernanza (contendría scripts que tocan datos de estudiantes, luego repositorio privado y rama B de POLITICA §8.3) y por ciclo de vida propio, no es una salida de `slep_monitoreo` sino un proyecto hermano que requiere sesión NEW PROJECT. Categoría: por confirmar contra el catálogo de §3 del backlog.

58. **Pendiente registrado: optimización de las 26 capturas, intentada y abortada** (sin ejecutar). Se preparó una pasada de recompresión PNG sin pérdida con `oxipng --opt max --strip safe --preserve`, como primer paso reversible antes de evaluar WebP. El comando falló al no encontrar `assets/proyectos`: el sitio había sido movido a `docs/` por la sesión paralela y el escáner con el que se trabajaba estaba desactualizado. Además `oxipng` no está instalado en la máquina. Pendiente vigente, ahora sobre `docs/assets/proyectos/`. Categoría: Reproducibilidad y tooling.

### Sesión 9 (Claude Opus 5) — 2026-07-29 a 2026-07-30

Foco: reconciliar el repositorio tras la sesión paralela, implementar el rediseño del portafolio entregado por Claude Design, y cerrar por encargo autónomo la deuda operativa acumulada.

**Bloque A — Repositorio y gobernanza**

59. **Reconciliación del repositorio tras la sesión paralela** (`bb5cf68`, `19d0b99`). Estado heredado: `main` local ocho commits atrás de `origin/main`, la rama `gobernanza/v14` dos commits adelante, y dos ramas `chore/pages-*` ya fusionadas por PR #4 y #5 pero vivas como residuo. No había divergencia real: la reconciliación fue lineal. Se commitearon el destilado de `ESTADO.md` y el encargo de rediseño heredados sin versionar, se commiteó por separado la salida del escáner (esta vez sí sustantiva: reflejaba el traslado del sitio a `docs/`, no una re-corrida idéntica), y se avanzó `main` por `merge --ff-only`. Las tres ramas residuales se borraron local y remotamente; `git branch -d` sobre `gobernanza/v14` falló porque Git compara contra el upstream y no contra `main`, y se resolvió con `-D` tras verificar que ningún commit quedaba huérfano. Categoría: Arquitectura del repositorio.

60. **Restauración del blindaje de los documentos de protocolo** (`d5b9f45`). El avance rápido de la entrada 59 trajo el commit `56f8dc7` de la sesión paralela ("deja de excluir la gobernanza in-repo"), que devolvió `POLITICA_PROYECTO.md` y `SETTINGS_Y_PROMPTS_OPERACIONALES.md` al repositorio público como archivos trackeados, revirtiendo de hecho las entradas 35 y 43 sin decisión declarada. Que GitHub Pages ahora publique solo `docs/` resuelve la exposición por el sitio pero no la exposición por GitHub. Se restauró el blindaje con `.gitignore` por nombre exacto más `git rm --cached`, que desindexa sin borrar del disco. Categoría: Arquitectura del repositorio.

61. **Blindaje del archivado de traspasos y archivado de los ocho traspasos superados** (`79b2579`). Al archivar los traspasos v01-v08 en `50_documentacion/traspasos/archivo/` apareció la carpeta como no trackeada: el patrón `50_documentacion/traspasos/*.md` cubre un solo nivel y dejaba `archivo/` fuera del blindaje, con los ocho traspasos legibles por cualquiera en un repositorio público. Se amplió a `50_documentacion/traspasos/**` y se verificó con `git check-ignore -v`. El archivado se hizo con `mv` plano y no con el `git mv` que exige SETTINGS §2.1, porque los traspasos nunca estuvieron trackeados; desviación declarada. Categoría: Arquitectura del repositorio.

**Bloque B — Rediseño del portafolio (pliego de capturas)**

62. **Implementación del pliego de capturas** (`0c9adee`). El handoff `design_handoff_portafolio_pliego/` de Claude Design entregó `portafolio.css`, `portafolio.js` e `index-portafolio.html` como código listo para pegar. Se integró tras detectar seis trampas que el README no menciona: `.estado` vivía dentro del bloque de `styles.css` que el handoff manda reemplazar y `portafolio.css` no lo redefine (se conservó en subsección propia); `portafolio.js` redeclaraba `estadoLabel`, ya presente en `app.js`, lo que habría producido `SyntaxError`; el código del handoff empieza en el ámbito global mientras `app.js` es un IIFE; `.pl-foot` tenía CSS sin markup que lo emitiera (omitido); los tokens `--banner-*` y las reglas `body[data-variant] .banner` quedaron huérfanas (deuda inerte declarada); y las 26 capturas pasaron de estar tras un click a renderizarse en página, lo que reclasificó el pendiente de optimización. La franja quedó en `grid-template-columns: 240px 1fr` con las capturas a altura normalizada (266px escritorio, 176px móvil) y ancho natural, sin `object-fit` ni `aspect-ratio`. Se aplicó el parche de `openLightbox(p, startIndex)` para abrir la reseña en la captura clickeada. Categoría: Layout y composición.

63. **Ajustes de legibilidad y discreción del pliego** (parte de `0c9adee`). Cuatro correcciones pedidas sobre la primera implementación: se eliminó el conteo "N capturas" (`conteoLabel()` y `.pl-count`); se quitó el doble truncado del resumen (el JS cortaba a 170 caracteres y el CSS a cuatro líneas con `-webkit-line-clamp`, y el CSS cortaba primero, de modo que la corrección del tope no se veía); se agregó un indicador de desplazamiento horizontal; y el campo de los proyectos sin capturas perdió el fondo azul `--ocean-20` del handoff por fondo transparente con hairline y textos neutros, para que pase desapercibido. Categoría: Interacción y JS.

64. **Estado sobre el título y columna de texto ensanchada** (parte de `0c9adee`). El chip de estado se movió del pie de la columna a la posición inmediatamente bajo el número y el tipo de proyecto, y la columna de texto pasó de 240px a 320px. Se eliminó `resumenCorto()` por completo: la franja imprime el `objetivo` íntegro, sin tope de caracteres, sin puntos suspensivos y sin `line-clamp`, porque ningún mecanismo de corte podía garantizar que no cortara. La primera oración más larga de `data.js` tiene 315 caracteres. Categoría: Layout y composición.

65. **Pasador de capturas convertido en carrusel operable** (parte de `0c9adee`). El indicador de desplazamiento se había construido como señal decorativa (`<span>` con `pointer-events: none`), cuando lo pedido era un control. Se reemplazó por dos `<button>` reales, uno por sentido, con `aria-label` y avance hasta el borde de la captura siguiente en vez de una cantidad fija de píxeles (los anchos son distintos porque lo normalizado es la altura). Además: el glifo tipográfico `›` se cambió por un SVG con trazo de 2,4px, ilegible como carácter de Museo Sans a 20px; el fondo pasó de `rgba(255,255,255,0.72)` a `--paper` opaco con sombra, porque sobre capturas claras el semitransparente desaparecía; y se agregó la condición de que el control no aparezca con menos de dos capturas, ya que una captura sola más ancha que la franja también satisface `scrollWidth > clientWidth` pero no tiene "más capturas" que anunciar. Categoría: Interacción y JS.

**Bloque C — Encargo autónomo y deuda operativa**

66. **Optimización de las 26 capturas, ejecutada** (sin commitear al cierre). Resuelve los pendientes de las entradas 46 y 58, abiertos desde la sesión 6. Ejecutada dentro del encargo autónomo con respaldo previo íntegro en `_archivo/20260729/capturas_originales/`. `oxipng` no está instalado en la máquina, así que la pasada sin pérdida no corrió y la recompresión fue toda con pérdida vía `pngquant --quality=70-92 --speed 1` sobre los 24 archivos que superaban 250 KB. Resultado: 9,21 MB → 2,39 MB (−74%), ningún archivo sobre 250 KB, dimensiones en píxeles idénticas verificadas por dos vías independientes (`sips` y lectura cruda del chunk IHDR). Los dos archivos ya bajo el umbral (`resguardo-2.png`, `asistencia-1.png`) no se tocaron. Hallazgo no anticipado: en `parvularia-2.png` (−84%) el acento naranja del ítem activo de la barra lateral pierde su color por cuantización a paleta; el texto y las cifras quedaron idénticamente legibles. Categoría: Reproducibilidad y tooling.

67. **Encargo autónomo a Claude Code e inventario de las ramas `claude/*`** (`50_documentacion/andamios/20260729_encargo_cierre_sesion09.md`). Se agruparon en un solo encargo dirigido por meta los pendientes mecánicos de la sesión (commits, archivado del handoff, regeneración del escáner, inventario de ramas y optimización de capturas), redactado según `encargo_autonomo_claude_code_v1.md` v1.1: contrato de entorno, nueve invariantes, fases ordenadas de lo determinista a lo convergente, panel adversarial y log de diez apartados. El inventario reveló que cuatro de las cinco ramas remotas `claude/*` pertenecen a proyectos ajenos (organigrama ×2, colección de películas, resúmenes de papers) y tocan rutas de la raíz, es decir preceden al traslado del sitio a `docs/`: un merge accidental sobrescribiría el docroot histórico. La quinta, `improve-portfolio-site-4tPUA`, está completamente absorbida (cero commits fuera de `main`). Ninguna se tocó: es gate del titular. Categoría: Reproducibilidad y tooling.

68. **Encargo del catálogo de Project Cards** (`e790582`, `84a415b`). Solicitud: analizar un documento editorial que propone reemplazar las presentaciones por diapositivas por un catálogo físico de tarjetas A5, una por proyecto. Hallazgo central del análisis: el contenido de las tarjetas es casi el mismo de `data.js`, y el sitio ya cubre los niveles 3 a 5 de la escala de evolución que el propio documento define, de modo que el riesgo real es duplicar la fuente. Se decidió la arquitectura de fuente única (`data.js` extendido, más `cards.html` con `@page` A5 impreso a PDF desde el navegador) sobre el diseño manual y sobre un proyecto hermano en R con Quarto o typst. El encargo fija taxonomía propuesta con seis categorías y códigos permanentes, once campos nuevos, un enum de madurez separado de `estado`, la política de códigos QR y sus prerrequisitos, la gobernanza de la impresión y cinco fases con dos proyectos piloto. Se corrigió en `84a415b` un supuesto errado: `data.js` no tiene campo `id`, y los slugs que el backlog usa desde la sesión 6 viven solo en los nombres de archivo de las capturas. Categoría: Estructura de contenido.

69. **Pendiente registrado: atlas de datos educativos** (sin ejecutar). Solicitud: una segunda página del sitio con dos propósitos, un repositorio de fuentes de datos educativos y sus interrelaciones (representado como un objeto interactivo tipo atlas celeste más una tabla filtrable con enlaces), y un espacio de formación en el uso de datos educativos para la toma de decisiones basada en evidencia. Se aclaró con el titular que los enlaces apuntan solo a las páginas públicas de cada emisor (por ejemplo, la sección de la Agencia de Calidad donde se consultan los IDPS) y que la sección es meramente informativa, con lo que la clasificación de acceso deja de ser bloqueante. Riesgo residual identificado: las descripciones de cómo se cruzan las fuentes sí son método interno, y se resuelve al redactar, no en el esquema. Decisión estructural señalada y no resuelta: el sitio es hoy single-page sin navegación, así que una segunda página obliga a definir la navegación del sitio y a duplicar a mano el `<head>`, el Open Graph y el footer (aceptable con dos páginas, insostenible desde cuatro). Categoría: Estructura de contenido.

---

## 6. Delta del backlog

Este documento consolida 4 sesiones (entradas 1-39), creado en la sesión 4, cerrando la deuda de consolidación abierta desde v02. Mapeo de renumeración aplicado: v02 local 1-7 → global 28-34; v03 local 1-4 → global 35-38; sesión 4 → 39. Sin reescritura de entradas previas: las entradas 1-27 se copiaron textuales de v01 §5.5 y los cuerpos de 28-38 se copiaron de v02/v03 §4 cambiando solo el número correlativo.

**Sesión 5 (v05):** 4 entradas nuevas (40-43), sin reescritura ni renumeración de las anteriores. Resumen estadístico actualizado (fila sesión 5, total 39 → 43). Sin cambios de taxonomía. Las categorías de las entradas nuevas (Interacción y JS ×2, Estructura de contenido ×1, Arquitectura del repositorio ×1) usan el catálogo existente; la tabla de clasificación temática §3 conserva la aproximación heredada y no se recalcula (su fuente de verdad es el detalle cronológico §5, no la tabla).

**Sesión 6 (v06):** 3 entradas nuevas (44-46), sin reescritura ni renumeración de las anteriores. Resumen estadístico actualizado (fila sesión 6, total 43 → 46). Sin cambios de taxonomía. Categorías de las nuevas: Estructura de contenido ×1 (capturas), Interacción y JS ×1 (visor del lightbox), Reproducibilidad y tooling ×1 (pendiente de optimización registrado, sin ejecutar). La tabla §3 no se recalcula.

**Sesión 7 (v07):** 7 entradas nuevas (47-53), sin reescritura ni renumeración de las anteriores. Resumen estadístico actualizado (fila sesión 7, total 46 → 53). Sin cambios de taxonomía. Categorías de las nuevas: Interacción y JS ×3 (visor full-res básico, navegación del visor, click en imagen), Estructura de contenido ×1 (Trayectoria oculta), Reproducibilidad y tooling ×1 (`thumb` eliminado), Identidad visual ×1 (mapeo Museo Sans 400), Layout y composición ×1 (lightbox dos columnas). Con esta sesión se cerraron tres de los pendientes diferidos de v06 (Trayectoria, `thumb`, face 400); quedan pendientes la minuta Simce (espera 3 PDF del usuario) y la optimización de las 26 capturas. La tabla §3 no se recalcula (su fuente de verdad es el detalle cronológico §5).

**Sesión 8 (v08):** 5 entradas nuevas (54-58), sin reescritura ni renumeración de las anteriores. Resumen estadístico actualizado (fila sesión 8, total 53 → 58). Sin cambios de taxonomía. Las dos categorías que v08 dejó "por confirmar contra el catálogo de §3" se confirman en este cierre, ya con el catálogo a la vista: la entrada 56 (encargo de rediseño) queda en **Documentación** y la 57 (repositorio interno del Área) en **Documentación**, por ser ambas productos escritos que especifican trabajo futuro y no cambios al sitio. La tabla §3 no se recalcula.

**Sesión 9 (v09):** 11 entradas nuevas (59-69), sin reescritura ni renumeración de las anteriores. Resumen estadístico actualizado (fila sesión 9, total 58 → 69). Sin cambios de taxonomía. Categorías de las nuevas: Arquitectura del repositorio ×3 (59, 60, 61), Layout y composición ×2 (62, 64), Interacción y JS ×2 (63, 65), Reproducibilidad y tooling ×2 (66, 67), Estructura de contenido ×2 (68, 69). Con esta sesión se cierran los pendientes de optimización de capturas abiertos en las entradas 46 y 58, arrastrados desde la sesión 6. **Corrección de numeración provisional:** durante la sesión se anunciaron en el chat los números 59 (catálogo de Project Cards), 60 (blindaje) y 61 (atlas) antes de fusionar el backlog; la numeración definitiva es la de este documento (68, 60 y 69 respectivamente), fijada en orden cronológico. La tabla §3 no se recalcula (su fuente de verdad es el detalle cronológico §5).
