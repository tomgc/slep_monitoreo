# Traspaso de Cierre — slep_monitoreo

- **Versión de traspaso:** v01
- **Fecha:** 2026-05-25
- **Sesión:** 1 — Diseño y desarrollo del sitio del Área de Monitoreo del SLEP Costa Central. Se partió de un repo heredado (v1.2 navy/azul), se iteró el diseño hasta v2.0 (bento + paleta SLEP) y se dejaron tres variantes alternativas. Cierre con sitio congelado a la espera de contenido real.
- **Modelo utilizado:** Sonnet 4.7
- **Entorno:** Web estático (HTML5 + CSS + JS inline) sobre GitHub Pages
- **Archivos principales modificados:**
  - `index.html` — sitio principal (v2.0 bento)
  - `variants/index.html` — galería de variantes
  - `variants/classic.html` — preservación de la v1.4 anterior
  - `variants/editorial.html` — variante long-form serifa
  - `variants/institucional.html` — variante documento oficial
  - `og-image.svg` y `og-image.png` — preview social rebrandeado
  - `scripts/regenerate-og-image.sh` — pipeline reproducible del og-image
  - `README.md` — stack, datasets editables, changelog 1.2 → 2.0
  - `docs/traspasos/traspaso-cierre-v01.md` — este documento

---

## 2. Resumen ejecutivo

La sesión partió clonando el repo `tomgc/monitoreo` (sitio v1.2 con diseño navy/azul) y se extendió a través de una serie de iteraciones lideradas por el usuario. Primero se agregaron secciones de contenido (Trayectoria, Ejemplos enriquecidos) y se llegó a v1.4 con mejoras transversales (meta social, modo oscuro, modo impresión, mini-mockups SVG, animaciones, fades en timeline). Luego se generaron tres variantes de diseño alternativas (Editorial, Dashboard/Bento, Institucional) en `variants/`, todas con la paleta oficial SLEP Costa Central. Tras varias iteraciones de pulido (compresión visual, fondo blanco fijo, sidebar izquierda en todas), el usuario eligió promover la variante Dashboard/Bento a sitio principal, generando la v2.0 con identidad SLEP completa (morado, crema, azul, gris, verde, beige, coral). El sitio anterior se preservó como `variants/classic.html`. La sesión cerró con ajustes finos al timeline (orden invertido, vertical en mobile) y la verificación posterior al rename del repo de `monitoreo` a `slep_monitoreo`. **Estado al cierre: sitio congelado en v2.0, publicado en `https://tomgc.github.io/slep_monitoreo/`, esperando contenido real del usuario para poblar las secciones.**

---

## 3. Estado del proyecto al cierre

### Qué funciona

- Sitio principal v2.0 publicado en `https://tomgc.github.io/slep_monitoreo/` (HTTP 200 verificado).
- Layout bento de 6 columnas con sidebar fija a la izquierda y scroll-spy.
- KPIs animados (Reporte AEL 92%, Aprobación 85%, Asistencia 78%) con barras que entran en viewport vía IntersectionObserver.
- Tres ámbitos de actuación en tarjetas multi-color (morado, azul, verde).
- Timeline horizontal invertida (2026 → 2017, scroll hacia el pasado), con vertical automático en viewports <700px.
- Cuatro tarjetas de productos con tag de categoría y mini-bar-chart inline.
- Sección equipo con avatares de iniciales (TG morado, JP azul).
- Glosario en chips compactos (10 siglas).
- Open Graph + Twitter Card con `og-image.png` (1200×630, morado/coral SLEP) accesible en la URL nueva.
- Tres variantes accesibles en `variants/`:
  - `classic.html` — el sitio anterior v1.4 (navy/azul) preservado íntegro.
  - `editorial.html` — long-form serifa, columna angosta, paleta cálida.
  - `institucional.html` — alto contraste con numerales romanos y tablas estrictas.
- Galería en `variants/index.html` con previews mini de las tres direcciones.
- Pipeline reproducible: `bash scripts/regenerate-og-image.sh` regenera el PNG desde `og-image.svg` usando Chrome headless.
- Workflow de GitHub Pages (`.github/workflows/static.yml`) intacto y deployando desde `main`.

### Qué no funciona

Ninguna funcionalidad rota al cierre. Todos los flujos verificados.

### Qué cambió respecto al traspaso anterior

No aplica. Este es el primer traspaso del proyecto.

---

## 4. Registro detallado de cambios realizados

### Cambio 1: Agregar sección "Trayectoria" con línea de tiempo

- **Archivo(s) afectado(s):** `index.html` (sobre la v1.2)
- **Categoría temática:** Estructura de contenido
- **Qué se hizo:** Sección nueva entre `¿Qué hace?` y `Ejemplos`, con timeline vertical de 6 hitos editables (Ley NEP 2017 → fortalecimiento 2026) renderizada desde un array `hitos`.
- **Por qué se hizo:** El usuario quería mostrar la trayectoria institucional del Área.
- **Cómo se verificó:** Renderizado correcto en preview, los 6 hitos visibles con fechas, títulos y descripciones.
- **Líneas o secciones clave:** Sección `<section id="trayectoria">`, array `const hitos` en el script inline, función `renderTimeline()`.
- **Dependencias afectadas:** Renumeración del nav lateral (4 → 5 ítems).

### Cambio 2: Enriquecer "Ejemplos de trabajo"

- **Archivo(s) afectado(s):** `index.html`
- **Categoría temática:** Estructura de contenido
- **Qué se hizo:** Grid de 4 productos (Reporte, Tablero, Análisis, Talleres) con placeholders SVG inline (íconos genéricos en gradiente light) + sub-sección "Indicadores destacados" con stat-card ampliado a 3 barras animadas.
- **Por qué se hizo:** La sección original tenía una sola tarjeta y comunicaba poco del valor del Área.
- **Cómo se verificó:** Renderizado de las 4 tarjetas y animación de barras al scrollear.
- **Líneas o secciones clave:** Arrays `productos` e `indicadores`, funciones `renderProductos()` y rendering del stat-card.

### Cambio 3: Footer con enlace al SLEP Costa Central

- **Archivo(s) afectado(s):** `index.html`
- **Categoría temática:** Identidad institucional
- **Qué se hizo:** Reemplazar `Versión 1.2 — SLEP Costa Central · 2026` por un footer con enlace a `https://slepcostacentral.gob.cl` (target=_blank, rel=noopener).
- **Por qué se hizo:** Mejorar la conexión con el sitio institucional padre.
- **Cómo se verificó:** Click sobre el enlace abre la página institucional.

### Cambio 4: Timeline horizontal con scroll y snap

- **Archivo(s) afectado(s):** `index.html`
- **Categoría temática:** Layout y composición
- **Qué se hizo:** Cambio del timeline vertical (cambio 1) a horizontal con `grid-auto-flow: column`, scroll-snap, fades laterales por scroll y dots conectados por línea.
- **Por qué se hizo:** El usuario solicitó tarjetas horizontales en lugar de la línea vertical.
- **Cómo se verificó:** Scroll horizontal con snap funciona, dots se conectan visualmente.
- **Dependencias afectadas:** Estructura del HTML `.timeline-wrapper > .timeline > .timeline-track > .timeline-item`.

### Cambio 5 a 11: Mejoras v1.4 (lote)

- **Archivo(s) afectado(s):** `index.html`, `og-image.svg`, `og-image.png` (nuevo)
- **Categoría temática:** múltiple — ver subcategorías abajo
- **Qué se hizo:** Lote unificado de mejoras solicitadas por el usuario:
  - **5.** Meta social: Open Graph + Twitter Card con `og-image.png` generado desde un SVG navy/blue con barras + título institucional (1200×630).
  - **6.** Fades laterales en la timeline con clases `at-start`/`at-end` toggleadas por scroll JS.
  - **7.** Modo impresión `@media print`: oculta nav y barra de progreso, expande main, convierte timeline a grilla 2×3, glosario a 2 columnas, fuerza fondos blancos.
  - **8.** Mini-mockups SVG específicos por categoría de producto (filas de un reporte, bar chart de dashboard, curva ascendente, presentador con audiencia).
  - **9.** Modo oscuro automático con `prefers-color-scheme: dark` (incluye overrides de tooltips, miniaturas, theme-color).
  - **10.** Animación de entrada con stagger en items de la timeline (`opacity: 0 → 1` + `translateY(14px) → 0`, transition-delay por nth-child, observer + fallback `prefers-reduced-motion`).
  - **11.** Footer enriquecido con enlace al SLEP.
- **Por qué se hizo:** El usuario eligió aplicar 7 de las 9 mejoras que yo había sugerido tras pulir las secciones nuevas.
- **Cómo se verificó:** Cada feature se vio en el preview panel mientras se editaba; el og-image se renderizó con Chrome headless y se inspeccionó como imagen.
- **Líneas o secciones clave:** Cabecera del HTML para meta tags, `@media (prefers-color-scheme: dark)` y `@media print` en el CSS, `.timeline-wrapper::before/::after` para fades, `ICONS.{report,chart,trend,users}` con SVGs en JS.
- **Tensiones entre principios:** Lote grande vs. B.3 (cambios quirúrgicos) — se justificó porque el usuario pidió las 7 mejoras juntas, alcance acotado y consistente.

### Cambio 12: Aplicar principios de desarrollo

- **Archivo(s) afectado(s):** `index.html`, `scripts/regenerate-og-image.sh` (nuevo), `README.md`
- **Categoría temática:** Reproducibilidad y tooling + Refactor
- **Qué se hizo:** Tras leer el documento `principios_desarrollo_v3.md` del usuario, se declaró qué principios aplican al proyecto y se ejecutaron tres aplicaciones concretas:
  - Refactor del stat-card de hardcoded HTML a renderizado desde `const indicadores` (consistente con equipo/glosario/hitos/productos) — aplica C.5 (modularidad) y C.11 (transparencia).
  - Creación de `scripts/regenerate-og-image.sh` que reproduce el PNG desde el SVG con Chrome headless — aplica C.2 (reproducibilidad) y C.7 (portabilidad).
  - Expansión del README de 2 líneas a una guía completa (stack, datasets editables, regeneración del og, paleta) — aplica F (auditoría de apertura).
- **Por qué se hizo:** El usuario solicitó "aplica los principios que consideres pertinentes". Se declararon explícitamente las omisiones (C.1, C.3, C.4, C.8, C.10, C.13) por no aplicar a un sitio estático.
- **Cómo se verificó:** El script `regenerate-og-image.sh` se ejecutó end-to-end y produjo un PNG 1200×630 idéntico al previamente generado ad-hoc.
- **Tensiones entre principios:** C.10 (JSON separado para web) vs B.2 (simplicidad) → ganó B.2 dado el volumen de datos (~30 ítems totales).

### Cambio 13: README con changelog

- **Archivo(s) afectado(s):** `README.md`
- **Categoría temática:** Documentación
- **Qué se hizo:** Agregar sección "Changelog" con entradas para v1.2, v1.3 y v1.4.
- **Por qué se hizo:** El usuario pidió un changelog corto para no tener que reconstruirlo de los commits.

### Cambio 14: Generación de tres variantes de diseño

- **Archivo(s) afectado(s):** `variants/editorial.html`, `variants/dashboard.html`, `variants/institucional.html`, `variants/index.html` (todos nuevos)
- **Categoría temática:** Arquitectura del repositorio + Identidad visual
- **Qué se hizo:** Tres archivos single-file con direcciones visuales claramente distintas, sin modificar `index.html`:
  - Editorial: long-form serifa, columna 680px centrada, drop cap, timeline vertical estilo notas al margen.
  - Dashboard/Bento: grid 12-col, KPIs prominentes en azul/verde/ámbar, nav superior pegado, paleta multi-color.
  - Institucional: alto contraste B/N + rojo, geométrico sin border-radius, numerales romanos, tablas estrictas.
- **Por qué se hizo:** El usuario solicitó "3 variantes de diseño sin modificar el original".
- **Cómo se verificó:** Cada variante se abrió en el preview y se comparó con su intención de diseño declarada.

### Cambio 15: Aplicar paleta oficial SLEP a las variantes

- **Archivo(s) afectado(s):** `variants/editorial.html`, `variants/dashboard.html`, `variants/institucional.html`, `variants/index.html`
- **Categoría temática:** Identidad visual
- **Qué se hizo:** El usuario compartió la paleta oficial SLEP (7 colores: #4A2746 morado, #FFF6E0 crema, #0062A0 azul, #747474 gris, #75924E verde, #BCA493 beige, #E88663 coral). Se reescribieron las 3 variantes adoptando estas variables CSS en `:root` con alias semánticos.
- **Por qué se hizo:** El usuario explicitó que la paleta oficial es la del SLEP, no las paletas exploratorias previas.
- **Cómo se verificó:** Cada hex se vio reflejado en el preview; la galería incluye una tira de swatches con los 7 colores.
- **Dependencias afectadas:** Se actualizó la memoria del proyecto (`project_paleta_slep.md`) para uso transversal.

### Cambio 16: Compresión visual de las variantes

- **Archivo(s) afectado(s):** `variants/editorial.html`, `variants/dashboard.html`, `variants/institucional.html`
- **Categoría temática:** Layout y composición
- **Qué se hizo:** El usuario pidió que las variantes adopten el minimalismo del sitio original (más angostas, menos espacio entre secciones). Reducciones:
  - Editorial: 680px → 580px, padding hero 80px → 50px, h1 3.4rem → 2.4rem.
  - Dashboard: 1180px → 860px, grid 12-col → 6-col, gap 18px → 12px.
  - Institucional: 1080px → 720px, padding seccion 60px → 36px.
- **Por qué se hizo:** Las variantes iniciales eran demasiado amplias para el tono institucional acotado.

### Cambio 17: Fondo blanco fijo en todas las variantes

- **Archivo(s) afectado(s):** `variants/editorial.html`, `variants/dashboard.html`, `variants/institucional.html`, `variants/index.html`
- **Categoría temática:** Identidad visual
- **Qué se hizo:** Cambiar `--paper: var(--cream)` por `--paper: #ffffff` en las cuatro páginas. El crema queda como tinte de acento (fondos de mini-charts en dashboard, chips de glosario).
- **Por qué se hizo:** Decisión explícita del usuario: fondo blanco siempre. Se actualizó la memoria del proyecto.

### Cambio 18: Sidebar izquierda en las tres variantes

- **Archivo(s) afectado(s):** `variants/editorial.html`, `variants/dashboard.html`, `variants/institucional.html`
- **Categoría temática:** Layout y composición + Interacción JS
- **Qué se hizo:** Patrón consistente con el original: nav lateral fija de 220px con scroll-spy. Body en grid 2 columnas, sidebar sticky con altura completa, contenido a la derecha. Cada variante con su carácter tipográfico (editorial mixta serif/sans, dashboard pills modernas, institucional monoespaciada con romanos I-V).
- **Por qué se hizo:** El usuario solicitó "mantén el menu de navegación a la izquierda en todos los diseños como el original".
- **Cómo se verificó:** Sidebar visible en cada variante con sus 5 ítems; scroll-spy actualiza el item activo al scrollear.
- **Dependencias afectadas:** En dashboard se reemplazó la nav superior previa; en institucional el banner pasó a contenido informativo (sin links).

### Cambio 19: Promover Dashboard a `index.html` (v2.0)

- **Archivo(s) afectado(s):** `index.html` (reescrito), `variants/classic.html` (nuevo, ex-index), `variants/dashboard.html` (eliminado), `variants/index.html`, `og-image.svg`, `og-image.png`, `README.md`
- **Categoría temática:** Arquitectura del repositorio + Identidad visual
- **Qué se hizo:** Bump mayor a v2.0:
  - El index.html anterior (v1.4 navy/azul) se preservó como `variants/classic.html` con un nav-top de variante.
  - El contenido de `variants/dashboard.html` se promovió a `index.html` con ajustes de "sitio principal": título sin sufijo de variante, OG/Twitter meta completos, favicon en barras moradas+azul, link a `variants/` en el footer, bump de versión a 2.0.
  - `variants/dashboard.html` eliminado (ya no hace sentido como variante).
  - `og-image.svg` regenerado con paleta SLEP (bg morado, barras cream/coral, texto en blanco/cream).
  - `og-image.png` regenerado vía el script.
  - Galería `variants/index.html` actualizada a Clásico/Editorial/Institucional con preview del clásico.
  - README con changelog 2.0 + nueva estructura.
- **Por qué se hizo:** Al preguntar "qué pendiente queda" y "qué hacer ahora", el usuario eligió "promover el dashboard a index reemplazando el original".
- **Cómo se verificó:** Tras el push, el sitio respondió 200 con el nuevo layout. El og-image se inspeccionó visualmente.

### Cambio 20: Timeline en wrap-grid (intento intermedio)

- **Archivo(s) afectado(s):** `index.html`
- **Categoría temática:** Layout y composición + Bugfix
- **Qué se hizo:** El usuario reportó "línea del tiempo cortada" — el scroll horizontal no se notaba en macOS por la scrollbar oculta. Se reemplazó por una grilla con `repeat(auto-fit, minmax(110px, 1fr))` que muestra los 6 hitos sin scroll, wrapeando a 2 filas si hace falta.
- **Por qué se hizo:** El usuario veía solo 1 hito y no sabía que podía hacer scroll.
- **Cómo se verificó:** Los 6 hitos visibles. Decisión revertida en el cambio 21 a pedido del usuario.

### Cambio 21: Timeline horizontal invertida con scroll al pasado

- **Archivo(s) afectado(s):** `index.html`
- **Categoría temática:** Layout y composición + Interacción JS
- **Qué se hizo:** El usuario pidió volver al scroll horizontal pero **con orden invertido**: el hito más reciente (2026) visible primero, scroll a la derecha revela hitos anteriores. Implementación:
  - `[...hitos].reverse()` en el render JS.
  - Scrollbar siempre visible (`scrollbar-width: thin` + custom `::-webkit-scrollbar`).
  - Fades laterales con clases `at-start`/`at-end` toggleadas por JS según `scrollLeft`.
  - Hint chico en el header: "← desplaza para ver al pasado" (después corregido en cambio 23).
- **Por qué se hizo:** El usuario prefirió la narrativa "lo más reciente primero, scrollea al pasado" en lugar de "todos visibles" o "del más antiguo al más nuevo".
- **Cómo se verificó:** Los 6 hitos están en orden 2026 → 2017, scroll funciona con fades.

### Cambio 22: Timeline items más angostos + mobile vertical

- **Archivo(s) afectado(s):** `index.html`
- **Categoría temática:** Responsive + Bugfix
- **Qué se hizo:** El usuario reportó nuevamente "cortada" al ver el sitio en viewport angosto. Soluciones:
  - Ítems 152px → 132px (caben más).
  - Fade lateral 24px → 14px (menos obstrucción).
  - `@media (max-width: 700px)`: timeline pasa a vertical (flex column, dot + línea a la izquierda, sin scroll). El hint del header se oculta en vertical.
- **Por qué se hizo:** En cards angostas (especialmente mobile) la timeline horizontal seguía recortando contenido.
- **Cómo se verificó:** A <700px todos los hitos visibles en columna; a >700px scroll horizontal con buena cantidad de items visibles.

### Cambio 23: Hint del timeline corregido

- **Archivo(s) afectado(s):** `index.html`
- **Categoría temática:** UX copy + Bugfix
- **Qué se hizo:** "← desplaza para ver al pasado" → "desplaza → para ver hitos anteriores". Dos correcciones:
  - Dirección de la flecha: el scroll para ver hitos anteriores es a la derecha, así que la flecha debía ser →.
  - Texto más preciso: "al pasado" reemplazado por "hitos anteriores".
- **Por qué se hizo:** El usuario detectó ambos errores en la copy.

### Cambio 24: Actualización de URL tras rename del repo

- **Archivo(s) afectado(s):** `index.html`, `README.md`, memoria del proyecto, git remote local
- **Categoría temática:** Arquitectura del repositorio + Bugfix
- **Qué se hizo:** El usuario renombró el repo en GitHub de `monitoreo` a `slep_monitoreo`. Pages dejó de funcionar en la URL vieja (404) y la nueva ya estaba activa pero las meta tags sociales apuntaban a la URL vieja. Correcciones:
  - `git remote set-url origin https://github.com/tomgc/slep_monitoreo.git`
  - `index.html`: og:url, og:image, twitter:image → `tomgc.github.io/slep_monitoreo/...`
  - `README.md`: URL de publicación.
  - `memory/project_monitoreo_scope.md`: referencias.
- **Por qué se hizo:** Tras el rename, los previews sociales rompían (og:image apuntaba a un PNG en URL 404).
- **Cómo se verificó:** `curl -sI https://tomgc.github.io/slep_monitoreo/og-image.png` → 200. Workflow de Pages corrió tras el push y deployó el HTML con meta tags actualizadas.

---

## 5. Backlog acumulativo del proyecto

### 5.1 Objetivo del proyecto

El sitio `tomgc.github.io/slep_monitoreo` es una página estática institucional de presentación del Área de Monitoreo de Procesos y Resultados Educativos, dentro de la Subdirección de Apoyo Técnico Pedagógico del SLEP Costa Central. Es single-page, sin dependencias externas, alojado en GitHub Pages. Su propósito es comunicar qué hace el Área, su trayectoria, ejemplos de trabajo, su equipo y un glosario técnico. El desarrollo se inició el 2026-04-09 (commit base v1.2) y la primera sesión documentada con cierre de traspaso es el 2026-05-25 (esta).

### 5.2 Nota metodológica

Cada ítem del backlog cronológico representa una solicitud distinguible del usuario (no las acciones técnicas para implementarla). Cuando el usuario pide un lote (por ejemplo "aplica las mejoras 1, 2, 3, 4, 7, 8, 9"), cada sub-pedido se cuenta como un cambio. Los errores introducidos por el asistente y corregidos sin que el usuario los reporte no se contabilizan; sí se cuentan los bugfixes reportados por el usuario (por ejemplo, "timeline cortada" o "flecha al revés"). La clasificación temática es aproximada porque muchos cambios tocan más de una categoría: en esos casos se clasifica por la intención primaria del usuario al solicitarlo. Las fuentes del conteo son este documento y el historial de conversaciones; los commits de git son un proxy pero no son la unidad de cuenta.

### 5.3 Clasificación temática

| Categoría | N° aprox. | % | Descripción |
|---|---|---|---|
| Estructura de contenido | 3 | 12% | Secciones nuevas o reestructuradas del sitio: Trayectoria, Ejemplos enriquecidos, etc. |
| Identidad visual | 5 | 20% | Paleta, tipografía, fondos, branding del footer y del og-image. |
| Layout y composición | 5 | 20% | Decisiones de grilla, sidebar, hero, timeline horizontal/vertical, max-widths. |
| Interacción y JS | 2 | 8% | Scroll-spy, observers de entrada de elementos, fades dinámicos por scroll. |
| Responsive y accesibilidad | 1 | 4% | Breakpoints (900px, 700px), `prefers-reduced-motion`, `prefers-color-scheme`, modo impresión. |
| Meta social y SEO | 1 | 4% | Open Graph, Twitter Card, favicon. |
| Reproducibilidad y tooling | 2 | 8% | Script de regeneración del og-image, refactor a data-driven. |
| Documentación | 2 | 8% | README, changelog, comentarios. |
| Arquitectura del repositorio | 3 | 12% | Variantes en `/variants/`, promoción de variante a index, rename del repo. |
| UX copy y bugfixes reportados | 1 | 4% | Hint del timeline corregido. |

(Conteo aproximado — algunos cambios se contaron parcialmente en más de una categoría por su naturaleza compuesta. Total ≈ 25.)

### 5.4 Resumen estadístico por sesión

| Sesión | Traspaso | N° de cambios | Modelo | Foco principal |
|---|---|---|---|---|
| 1 | v01 | ~25 | Sonnet 4.7 | Diseño y desarrollo del sitio v1.2 → v2.0 + variantes |

**Total de cambios solicitados: ~25**

### 5.5 Detalle cronológico de cambios por sesión

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

---

### 5.6 Cambios respecto a la versión anterior del backlog

No aplica. Este es el primer traspaso del proyecto.

---

## 6. Bugs encontrados y su resolución

### Bug 1: Timeline percibida como "cortada" en macOS y mobile

- **Síntoma observable:** El usuario veía solo 1 hito visible dentro del card de Trayectoria. No se notaba que había más contenido scrolleable a la derecha.
- **Causa raíz:** macOS oculta la scrollbar horizontal por defecto. El layout original (`grid-auto-flow: column; grid-auto-columns: 152px`) tenía los 6 hitos en una fila pero solo 1-2 cabían en el ancho visible. Sin indicador visual, los hitos restantes parecían inexistentes.
- **Solución aplicada:** Tres correcciones acumuladas:
  1. Reducir el ancho de cada item (152px → 132px).
  2. Reducir el ancho de los fades laterales (24px → 14px) para que no obstruyan contenido.
  3. Hacer la scrollbar visible siempre (`scrollbar-width: thin` + custom `::-webkit-scrollbar`).
  4. Agregar fade dinámico que se desactiva en los extremos (`at-start`/`at-end`).
  5. Bajo 700px de viewport, pasar el timeline a vertical (sin scroll horizontal).
- **Criterio de verificación (B.4):** En viewport ancho (>900px): se ven al menos 4-5 hitos al mismo tiempo y el scrollbar es visible. En viewport <700px: todos los hitos se ven verticalmente.
- **Patrón general aprendido:** En layouts con scroll horizontal en macOS, asumir que la scrollbar no se ve. Hay que hacer la affordance de scroll explícita por otro medio (visible scrollbar, fades, hint textual).
- **Principios involucrados:** B.4 (criterio de éxito definido), B.1 (no asumir que el usuario sabrá que puede scrollear).
- **Estado:** Resuelto.

### Bug 2: Hint del timeline con flecha en dirección equivocada y texto impreciso

- **Síntoma observable:** Hint decía "← desplaza para ver al pasado" pero el scroll para ver hitos anteriores es a la derecha (→), no a la izquierda. Además "al pasado" era abstracto.
- **Causa raíz:** Al implementar el orden invertido del timeline (2026 a la izquierda → 2017 a la derecha), no se actualizó la dirección de la flecha del hint. El texto "al pasado" describía la dirección temporal, no la acción del usuario.
- **Solución aplicada:** Cambiar el hint a "desplaza → para ver hitos anteriores".
- **Criterio de verificación (B.4):** El hint comunica claramente que el scroll va a la derecha y que lo que se encuentra son hitos del pasado del Área.
- **Patrón general aprendido:** En cambios de orden visual (reverse, sort), revisar todos los affordances que comuniquen dirección (flechas, labels, hints).
- **Principios involucrados:** C.11 (transparencia del cambio: actualizar la documentación visual cuando cambia el comportamiento).
- **Estado:** Resuelto.

### Bug 3: URLs rotas tras rename del repo (`monitoreo` → `slep_monitoreo`)

- **Síntoma observable:** El usuario reportó "pages no funciona". La URL vieja `tomgc.github.io/monitoreo/` daba 404. Los meta tags OG seguían apuntando a la URL vieja, lo que rompía los previews sociales (WhatsApp, Slack, etc.).
- **Causa raíz:** Tras renombrar un repo en GitHub, la URL de Pages cambia y la vieja no redirige automáticamente. Los meta tags hardcoded en el HTML y el remote local del git no se actualizan solos.
- **Solución aplicada:** Cuatro cambios:
  1. `git remote set-url origin https://github.com/tomgc/slep_monitoreo.git`
  2. Buscar y reemplazar `tomgc.github.io/monitoreo` → `tomgc.github.io/slep_monitoreo` en `index.html`, `README.md` y la memoria del proyecto.
  3. Commit y push al nuevo remote.
  4. Verificar `curl -sI https://tomgc.github.io/slep_monitoreo/og-image.png` → 200 tras el redeploy del workflow.
- **Criterio de verificación (B.4):** `curl` a la nueva URL devuelve 200; `grep "monitoreo" index.html` ya no encuentra referencias hardcoded fuera del path local.
- **Patrón general aprendido:** Antes de renombrar un repo con GitHub Pages, listar todas las URLs hardcoded (OG, Twitter, README, sitemap si existe) y actualizarlas en el mismo commit que ajusta el remote local.
- **Principios involucrados:** C.7 (portabilidad — no hardcodear URLs específicas más allá de lo necesario), C.11 (trazabilidad de los puntos a actualizar).
- **Estado:** Resuelto.

---

## 7. Aprendizajes y restricciones técnicas descubiertas

- **Regla:** Toda variable CSS de paleta debe declararse con su valor crudo (`--purple: #4A2746`) y luego con alias semánticos (`--ink: var(--purple)`). Así, cuando cambia la identidad visual, basta con redefinir alias.
  - **Principio relacionado:** C.11 (transparencia: el alias documenta el rol del color).
  - **Contexto:** En la transición de paleta navy/azul a paleta SLEP, los archivos con alias semánticos (variantes y v2.0) fueron triviales de cambiar; los archivos con hex hardcoded requirieron búsquedas extensivas.
  - **Ejemplo:** En `variants/dashboard.html`, redefinir `--ink: var(--purple)` cambió todos los textos primarios sin tocar nada más.

- **Regla:** Para layouts con scroll horizontal, hacer la scrollbar visible siempre y agregar fades dinámicos que se desactivan en los extremos.
  - **Principio relacionado:** B.1 (no asumir que el usuario sabrá lo que puede hacer), B.4 (criterio de éxito).
  - **Contexto:** macOS oculta scrollbars; sin indicadores visuales explícitos, los usuarios no descubren contenido scrolleable.
  - **Ejemplo:** Bug 1 en el timeline.

- **Regla:** En proyectos web estáticos sin build steps, Chrome headless es el método pragmatic para convertir SVG → PNG.
  - **Principio relacionado:** C.2 (reproducibilidad), C.12 (gestión explícita de dependencias).
  - **Contexto:** En macOS, ni `rsvg-convert` ni ImageMagick están instalados por defecto. `qlmanage` produce thumbnails pero con tamaño y aspect erráticos. Chrome headless es exacto.
  - **Ejemplo:** `scripts/regenerate-og-image.sh` busca Chrome en rutas conocidas y produce un PNG 1200×630 idéntico cada vez.

- **Regla:** En un sitio multi-variante (sitio principal + alternativas), cada archivo debe ser self-contained con su propia copia de los datos.
  - **Principio relacionado:** Tensión entre C.5 (modularidad, que sugeriría compartir un `data.js`) y B.2 (simplicidad: el proyecto no va a crecer). Se priorizó B.2.
  - **Contexto:** Compartir datos vía `fetch()` requiere CORS, manejo de errores, JavaScript adicional. Para 4 archivos estáticos con ~30 ítems totales, no se justifica.
  - **Ejemplo:** `equipo`, `glosario`, `hitos`, `productos`, `indicadores` están replicados en `index.html` y en las 3 variantes.

- **Regla:** Cuando se cambia el orden visual de un elemento (reverse, sort), revisar todas las copys que describen dirección.
  - **Principio relacionado:** C.11 (trazabilidad del cambio).
  - **Contexto:** Bug 2: el orden del timeline se invirtió pero el hint no.

- **Regla:** Renombrar un repo en GitHub no redirige automáticamente Pages. Las URLs hardcoded en OG/Twitter meta deben actualizarse explícitamente.
  - **Principio relacionado:** C.7 (portabilidad: minimizar URLs hardcoded).
  - **Contexto:** Bug 3.

- **Regla:** En un layout responsive con grilla compleja, considerar un layout completamente distinto para mobile (no solo escalado).
  - **Principio relacionado:** B.2 (simplicidad: a veces es más simple cambiar el layout que ajustarlo).
  - **Contexto:** El timeline horizontal con scroll funciona en desktop pero seguía siendo problemático en mobile. La solución fue cambiar a layout vertical bajo 700px, no ajustar el horizontal.

- **Regla:** Para "promover" un sub-archivo a archivo principal (ej. una variante a `index.html`), preservar el `index.html` anterior moviéndolo a la galería de variantes con un nav-top que vuelva al índice de variantes.
  - **Principio relacionado:** B.3 (cambios quirúrgicos: no destruir, mover).
  - **Contexto:** Cambio 22 (promoción v2.0).

---

## 8. Decisiones de diseño tomadas

### Decisión: Patrón single-file estricto (HTML + CSS + JS inline)

- **Alternativas consideradas:** Separar CSS a `styles.css`, JS a `script.js`, datos a `data.json` con `fetch()`.
- **Justificación:** El proyecto no va a crecer (confirmado por el usuario). El volumen de datos es ~30 ítems totales. Separar archivos agregaría complejidad sin beneficio para el alcance acotado.
- **Tensiones entre principios:** C.5 (modularidad) vs. B.2 (simplicidad). Ganó B.2.
- **Implicancia:** Cada archivo (index.html y las 3 variantes) replica los datasets. Cambios de contenido requieren propagación manual a las 4 ubicaciones.

### Decisión: Paleta oficial SLEP como sistema de diseño

- **Alternativas consideradas:** Mantener paleta navy/azul original, paleta con tints exploratorios.
- **Justificación:** El usuario explicitó que la paleta SLEP es la oficial. Usarla como sistema único (no como variantes paralelas) da coherencia de marca.
- **Implicancia:** Variables CSS declaradas con nombres crudos (`--purple`, `--cream`, ...) + alias semánticos (`--ink: var(--purple)`, `--accent: var(--coral)`). Cualquier rebranding futuro toca solo los alias.

### Decisión: Diseño bento como sitio principal (sobre el clásico)

- **Alternativas consideradas:** Mantener el clásico navy/azul como principal y el bento como variante; descartar el clásico.
- **Justificación:** El usuario explicitó preferencia por el bento; la identidad SLEP completa solo se aplicó al bento.
- **Implicancia:** El clásico se preserva como variante (`variants/classic.html`) en caso de querer volver. El bento es la v2.0 oficial.

### Decisión: Fondo de página siempre blanco

- **Alternativas consideradas:** Usar crema (#FFF6E0) como fondo institucional cálido.
- **Justificación:** El usuario lo explicitó. El crema queda como tinte de acento para fondos de tarjetas chicas y mini-charts.
- **Implicancia:** Las variantes que usaban `--paper: var(--cream)` se cambiaron a `--paper: #ffffff`. Se actualizó la memoria de paleta del proyecto.

### Decisión: Timeline horizontal invertida con scroll al pasado

- **Alternativas consideradas:** Timeline vertical, timeline horizontal en orden cronológico (2017 → 2026), grid wrap sin scroll.
- **Justificación:** El usuario quiere narrativa "lo más reciente visible primero, scrollea al pasado". Esto invierte la metáfora típica de timeline pero refleja el flujo de información de un newsfeed.
- **Implicancia:** El array `hitos` sigue en orden cronológico (2017 → 2026) por claridad de edición; el render hace `[...hitos].reverse()`. En mobile el timeline pasa a vertical para no recortar.

### Decisión: Sidebar izquierda fija en todas las variantes y en el principal

- **Alternativas consideradas:** Nav superior (como tenía el dashboard inicialmente), sin nav (como editorial inicial).
- **Justificación:** El usuario solicitó consistencia con el original. La sidebar permite scroll-spy y mantiene la navegación siempre visible.
- **Implicancia:** Body en grid de 2 columnas (220px + 1fr) en desktop; bajo 900px la sidebar se oculta.

---

## 9. Constantes, configuraciones y parámetros vigentes

### Paleta oficial SLEP (declarada en `:root` de `index.html` y las 3 variantes)

| Variable | Hex | Rol |
|---|---|---|
| `--purple` | #4A2746 | Texto principal, brand, ink |
| `--cream` | #FFF6E0 | Tinte de acento (no bg de página) |
| `--blue` | #0062A0 | Primario, enlaces, KPI azul |
| `--gray` | #747474 | Muted, texto secundario |
| `--green` | #75924E | KPI positivo |
| `--beige` | #BCA493 | Hairlines, líneas suaves |
| `--coral` | #E88663 | Acento cálido, KPI naranja, fades |

### Versiones suaves (tints) en `index.html`

| Variable | Hex |
|---|---|
| `--purple-soft` | #ece0e9 |
| `--blue-soft` | #d6e7f3 |
| `--green-soft` | #e0e9d3 |
| `--beige-soft` | #ede4dc |
| `--coral-soft` | #fbe1d4 |

### Layout

| Constante | Valor | Archivo | Nota |
|---|---|---|---|
| `body` grid | `220px 1fr` | index.html y variantes | Sidebar 220px + contenido fluido |
| `.container` max-width | 860px | index.html | Centrado en la columna de contenido |
| Bento grid | `repeat(6, 1fr)` con gap 12px | index.html | 6 columnas, spans 2/3/4/6 |
| Card padding | 16px | index.html | Padding interno de cada `.card` |
| Border radius general | 10px (`--radius`) | index.html | Aplica a todas las tarjetas |
| Container variants (editorial) | 580px | variants/editorial.html | Long-form angosto |
| Container variants (institucional) | 720px | variants/institucional.html | Documento institucional |

### Breakpoints

| Breakpoint | Comportamiento |
|---|---|
| `max-width: 900px` | Sidebar se oculta; body en `display: block` |
| `max-width: 760px` | Spans del bento colapsan a `span-6` (full width) |
| `max-width: 700px` | Timeline pasa a layout vertical |
| `max-width: 500px` | Container con padding reducido |

### Datasets editables (vívidos en `<script>` de cada HTML)

| Array | Cantidad de items | Campos |
|---|---|---|
| `equipo` | 2 | nombre, cargo, mail, color, iniciales |
| `glosario` | 10 | sigla, def |
| `hitos` | 6 | fecha, titulo, desc |
| `productos` | 4 | tag, color, barColor, titulo, desc, bars[] |
| `indicadores` | 1 título + 3 items | titulo, items[{label, valor 0-100}] |

### Versionado

- **Versión actual:** 2.0 (visible en footer y en el hero meta).
- **Convención:** bump menor por cambios visuales o contenido; bump mayor por reescrituras o cambios de identidad.

---

## 10. Arquitectura de archivos relevante

Estructura al cierre (ver `README.md` sección "Stack" para versión narrativa):

```
slep_monitoreo/
├── .github/
│   └── workflows/
│       └── static.yml          # Deploy a GitHub Pages desde main
├── docs/
│   └── traspasos/
│       └── traspaso-cierre-v01.md   # Este documento
├── scripts/
│   └── regenerate-og-image.sh  # Regenera og-image.png con Chrome headless
├── variants/
│   ├── index.html              # Galería de variantes
│   ├── classic.html            # Sitio v1.4 anterior (navy/azul) preservado
│   ├── editorial.html          # Variante long-form serifa
│   └── institucional.html      # Variante documento oficial
├── index.html                  # Sitio principal v2.0 (bento + SLEP)
├── og-image.svg                # Fuente del preview social
├── og-image.png                # 1200×630 generado vía script
└── README.md                   # Stack, datasets, paleta, changelog
```

**Notas:**
- No se sigue la estructura completa de la sección D de los principios (`data/raw/`, `R/`, `scripts/`, `output/`, `docs/`) porque no aplica a un sitio web estático single-page. Se adoptó solo `scripts/` y `docs/traspasos/`.
- `tmp/` no se usa porque no hay archivos intermedios.
- No hay `data/` porque los datos viven inline en los HTML como `const`.

---

## 11. Tareas pendientes, próximos pasos y ruta sugerida

### 11.1 Inventario de pendientes

#### Pendiente 1: Poblar contenido real

- **Descripción:** Reemplazar los datos placeholder en los arrays `hitos`, `productos`, `indicadores`, `equipo` por el contenido institucional real del Área.
- **Contexto:** El usuario explicitó "el área no va a crecer" y "lo dejamos congelado en este modelo hasta que tenga contenido para ir poblando las secciones".
- **Tipo:** Funcionalidad nueva (contenido).
- **Impacto:** Crítico para que el sitio sirva su propósito comunicacional real.
- **Dependencias:** Requiere input del usuario con el contenido real (no se puede hacer sin él).
- **Complejidad estimada:** Baja (solo editar arrays).
- **Principios relevantes:** C.11 (trazabilidad: documentar de dónde viene cada dato).
- **Precauciones:** Cualquier cambio debe propagarse manualmente a las 4 ubicaciones (`index.html`, `variants/classic.html`, `variants/editorial.html`, `variants/institucional.html`). Si los avatares del equipo cambian (colores o iniciales), también ajustar.
- **Sugerencia de enfoque:** Cuando el usuario traiga el contenido, hacer un solo bloque de edits: actualizar el array en index, luego propagar a las 3 variantes con `cp` parcial o ediciones espejo. Verificar visualmente en el preview.
- **Criterio de éxito sugerido (B.4):** Las 5 secciones (¿Qué hace?, Trayectoria, Ejemplos, Equipo, Glosario) muestran datos reales del Área, no placeholders. El usuario confirma que los datos son correctos.

#### Pendiente 2: Capturas reales en lugar de mini-mockups SVG

- **Descripción:** Reemplazar los mini-mockups SVG inline (en `index.html` y `variants/classic.html`) por capturas o ilustraciones reales de los productos del Área (reportes, dashboards, etc.).
- **Contexto:** Los mini-mockups SVG son funcionales como referencia visual pero genéricos. Se etiquetan como "Imagen referencial".
- **Tipo:** Mejora visual.
- **Impacto:** Medio. Eleva credibilidad institucional sin ser bloqueante.
- **Dependencias:** Requiere capturas o ilustraciones del usuario.
- **Complejidad estimada:** Baja-media (cambiar el SVG en el `ICONS` por una imagen `<img>` o un SVG más específico).
- **Sugerencia de enfoque:** Si el usuario tiene capturas (PNG/JPG), agregarlas a `assets/` y referenciarlas desde el HTML. Quitar la etiqueta "Imagen referencial" cuando sean reales.

#### Pendiente 3: Accesibilidad por teclado en tabs (variante clásica)

- **Descripción:** `variants/classic.html` tiene `role="tablist"` y `aria-selected` pero no navegación con flechas ←/→ ni Home/End como espera el patrón WAI-ARIA.
- **Tipo:** Deuda técnica + accesibilidad.
- **Impacto:** Bajo (solo afecta la variante clásica, no el sitio principal).
- **Complejidad estimada:** Baja.
- **Sugerencia de enfoque:** Agregar listener `keydown` en el `.tab-menu` con flechas, Home, End.

#### Pendiente 4: Modo oscuro con toggle manual

- **Descripción:** Actualmente el modo oscuro solo responde a `prefers-color-scheme` del sistema. Algunos usuarios prefieren toggle explícito.
- **Tipo:** Mejora UX.
- **Impacto:** Bajo.
- **Complejidad estimada:** Media (necesita persistencia en `localStorage` y un botón).

#### Pendiente 5: Cambio de equipo o foco narrativo → regenerar og-image

- **Descripción:** Si el equipo o el foco del sitio cambia, regenerar el `og-image.png` para que el preview social refleje el cambio.
- **Tipo:** Mejora de reproducibilidad ya implementada — solo recordar ejecutar el script.
- **Sugerencia de enfoque:** Editar `og-image.svg` y correr `bash scripts/regenerate-og-image.sh`.

### 11.2 Evaluación de deuda técnica

- **Zona frágil:** Replicación manual de datasets entre `index.html` y las 3 variantes. Es la fuente más probable de inconsistencias si los datos del contenido real son distintos en cada lado. La memoria del proyecto declara que la separación a JSON con fetch no se justifica por el alcance acotado, pero si el contenido cambia frecuentemente, podría reconsiderarse.
  - **Oportunidad de mejora:** Si tras 2-3 actualizaciones de contenido aparece divergencia entre las copias, evaluar mover los arrays a un `data.js` compartido cargado con `<script src="data.js">` (sin necesidad de `fetch`).

- **Zona frágil:** El timeline tuvo 4 iteraciones (vertical → horizontal → wrap-grid → horizontal invertida + vertical-mobile). Cada cambio agregó lógica. Está estable ahora pero conviene no tocarlo sin necesidad.
  - **Oportunidad de mejora:** Si en el futuro se quiere otra variación, considerar refactorizar primero a un componente más limpio antes de seguir parchando.

### 11.3 Auditoría de cierre (sección F)

- **¿Cada bloque de transformación tiene un check de validación? (C.8)** → No aplica. El sitio no realiza transformaciones de datos: los arrays se renderizan tal cual. La función `escapeHtml()` cumple el rol de validar input para inyección segura en `innerHTML`.

- **¿Los outputs son reproducibles e idempotentes? (C.2, C.3)** → Sí. El `og-image.png` se reproduce vía `scripts/regenerate-og-image.sh`. El sitio HTML es estático e idempotente por naturaleza. El workflow de Pages despliega desde `main` sin estado.

- **¿Hay decisiones metodológicas documentadas como constantes con nombre? (C.11)** → Sí. La paleta SLEP está en `:root` con nombres semánticos. Los breakpoints están en variables o `@media` con valores explícitos. Los datasets son `const` con nombres descriptivos. Las decisiones de diseño están en este traspaso (sección 8).

### 11.4 Ruta de desarrollo sugerida para la próxima sesión

Asumiendo que la próxima sesión es la de "poblar contenido":

1. **Recibir contenido real del usuario** — el usuario va a traer los datos reales (hitos verdaderos del Área, lista de productos reales, indicadores actualizados, equipo completo si hay más de 2 personas). Esto es input externo.

2. **Actualizar datasets en `index.html`** — editar los arrays `hitos`, `productos`, `indicadores`, `equipo`. Si el equipo crece a más de 2-3 personas, evaluar ajustes del grid de la sección Equipo.

3. **Propagar a `variants/classic.html`** — el clásico también renderiza desde arrays. Replicar los cambios.

4. **Propagar a `variants/editorial.html` e `variants/institucional.html`** — mismos cambios, manteniendo el estilo de cada variante (descripciones pueden adaptarse en tono editorial vs. institucional).

5. **Verificación visual** — el usuario confirma que los datos se ven correctos en el preview / en producción tras el push.

6. **Si cambia el branding visual del Área** — regenerar `og-image.svg` con los nuevos elementos y correr el script.

7. **Bump de versión** — si el cambio es solo contenido, bump a 2.1. Si hay cambios visuales, bump a 2.x mayor.

**Diferir para sesión posterior:**

- Pendiente 3 (keyboard nav en tabs del clásico): solo si se decide promover el clásico a un uso renovado.
- Pendiente 4 (modo oscuro con toggle): solo si llega un pedido explícito.

---

## 12. Instrucciones específicas para la próxima sesión

- ⚠️ **NO modificar el patrón single-file** (HTML + CSS + JS inline). El proyecto está congelado en este patrón. No proponer separar a `.css` o `.js` ni mover datos a `.json` con `fetch`. Ver memoria `project_monitoreo_scope.md`.
- 🔒 **Mantener la paleta oficial SLEP** sin agregar colores nuevos. Si una sección necesita un acento que no está en la paleta, primero consultar al usuario. Los 7 colores: `#4A2746`, `#FFF6E0`, `#0062A0`, `#747474`, `#75924E`, `#BCA493`, `#E88663`.
- 🔒 **Fondo de página siempre blanco** (#ffffff). El crema solo como tinte de acento.
- ✅ **Antes de cambiar contenido**: confirmar con el usuario qué datos son reales y cuáles son aún placeholders.
- ✅ **Tras cambiar datasets**: propagar manualmente a `index.html`, `variants/classic.html`, `variants/editorial.html`, `variants/institucional.html`. Verificar en el preview que las 4 muestran lo mismo.
- ✅ **Si se regenera `og-image.png`**: usar `bash scripts/regenerate-og-image.sh` desde la raíz del repo (requiere Chrome instalado).
- ✅ **Antes de hacer `git push`**: verificar que el remote apunta a `https://github.com/tomgc/slep_monitoreo.git`.
- ⚠️ **Si el usuario reporta "timeline cortada" otra vez**: leer la sección 6 (Bug 1) de este traspaso antes de tocar. Las correcciones acumuladas son delicadas.
- ⚠️ **Si el repo se renombra de nuevo**: actualizar las 3 URLs hardcoded en `index.html` (og:url, og:image, twitter:image) + el README + el remote local + la memoria. Ver sección 6 (Bug 3).

---

## 13. Fragmentos de código de referencia

### Patrón: array de datos al inicio del `<script>`

```js
// Editable: hitos de la trayectoria (orden cronológico, se invierte en el render)
const hitos = [
    { fecha: "2017", titulo: "Promulgación de la Ley NEP", desc: "..." },
    { fecha: "2024", titulo: "Inicio operativo del SLEP", desc: "..." },
    // ... más items
];
```

### Patrón: render seguro con `escapeHtml`

```js
const esc = s => s.replace(/[&<>"']/g, c =>
    ({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c])
);

document.getElementById('timeline').innerHTML = [...hitos].reverse().map(h => `
    <div class="timeline-item">
        <div class="year">${esc(h.fecha)}</div>
        <div class="titulo">${esc(h.titulo)}</div>
        <div class="desc">${esc(h.desc)}</div>
    </div>
`).join('');
```

### Patrón: paleta CSS con alias semánticos

```css
:root {
    /* Crudos */
    --purple: #4A2746;
    --cream:  #FFF6E0;
    --blue:   #0062A0;
    --coral:  #E88663;
    /* Alias semánticos */
    --ink: var(--purple);
    --accent: var(--coral);
    --line: var(--beige-soft);
}
```

### Patrón: scroll-spy con IntersectionObserver

```js
const navObserver = new IntersectionObserver(entries => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            const id = entry.target.id;
            document.querySelectorAll('.nav-item').forEach(link => {
                link.classList.toggle('active-nav',
                    link.getAttribute('href') === `#${id}`);
            });
        }
    });
}, { rootMargin: '-30% 0px -60% 0px' });
document.querySelectorAll('section').forEach(s => navObserver.observe(s));
```

### Patrón: fades dinámicos en scroll horizontal

```js
const tlList = document.getElementById('timeline');
const tlFrame = tlList.parentElement;
const updateTlFades = () => {
    const max = tlList.scrollWidth - tlList.clientWidth;
    const x = tlList.scrollLeft;
    tlFrame.classList.toggle('at-start', x <= 2);
    tlFrame.classList.toggle('at-end', x >= max - 2);
};
updateTlFades();
tlList.addEventListener('scroll', updateTlFades, { passive: true });
window.addEventListener('resize', updateTlFades);
```

CSS asociado:
```css
.timeline-frame::before, .timeline-frame::after {
    content: "";
    position: absolute;
    top: 0; bottom: 10px;
    width: 14px;
    pointer-events: none;
    transition: opacity 0.2s;
}
.timeline-frame.at-start::before { opacity: 0; }
.timeline-frame.at-end::after { opacity: 0; }
```

### Patrón: regenerar og-image

```bash
# Desde la raíz del repo:
bash scripts/regenerate-og-image.sh
# Requiere Chrome instalado. Genera og-image.png (1200x630) desde og-image.svg.
```

---

## 14. Reapertura de la sesión

### 14.1 Nombre sugerido del chat

**Nombre sugerido del chat:** `SLEP Monitoreo, sesión 2 (Opus)`

(Reemplazar "Opus" por el modelo que vayas a usar; recomendado Opus para sesión de poblamiento de contenido y verificación visual.)

### 14.2 Mensaje de apertura listo para copiar

**Mensaje de apertura:**

> Continuación de sesión sobre el proyecto **SLEP Monitoreo** (sitio en `https://tomgc.github.io/slep_monitoreo/`).
>
> Tipo: CONTINUATION. Adjunto el traspaso `traspaso-cierre-v01.md` con todo el contexto de la sesión anterior. La próxima tarea es **poblar el contenido real** del sitio en las secciones de hitos, productos, indicadores y equipo.
>
> Por favor lee el traspaso, identifica los pendientes de la sección 11 y propóneme un plan de trabajo en el formato: Estado al cierre / Pendientes / Ruta propuesta / Decisiones que necesitas de mí.

### 14.3 Documentos a adjuntar

**Documentos para la próxima sesión:**

#### Documentos de protocolo (knowledge base del usuario, si aplica)

Si la próxima sesión es dentro de un Project de Claude con knowledge base, estos no requieren adjuntarse:
- `principios_desarrollo_v3.md` (vive en `~/Desktop/`)

Si la próxima sesión es chat suelto sin Project, adjuntarlo manualmente.

#### Documento de traspaso (se adjunta al nuevo chat)

- `docs/traspasos/traspaso-cierre-v01.md` — este documento. Contiene todo el contexto necesario.

#### Archivos del proyecto críticos (se adjuntan al nuevo chat)

- `index.html` — sitio principal v2.0 (necesario para editar datasets).
- `README.md` — documentación de stack, datasets editables, paleta.
- `variants/classic.html` — para propagar cambios de contenido.
- `variants/editorial.html` — para propagar cambios de contenido.
- `variants/institucional.html` — para propagar cambios de contenido.

#### Datos o referencias externas (cuando los traigas)

- Contenido real del Área: hitos verdaderos con fechas y descripciones, lista de productos reales con sus nombres y descripciones, indicadores actualizados con valores numéricos, equipo completo con nombres/cargos/mails.

### 14.4 Nota sobre archivos modificados entre sesiones

> **Nota:** si algún archivo de los listados cambió después de este cierre (entre sesiones), adjunta la versión más actualizada al abrir y avísalo explícitamente en el mensaje de apertura.
