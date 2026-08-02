# Traspaso de cierre — slep_monitoreo — v07

## 1. Identificación

- **Proyecto:** slep_monitoreo (sitio institucional estático del Área de Monitoreo del SLEP Costa Central).
- **Versión de traspaso:** v07.
- **Fecha:** 2026-07-27.
- **Sesión:** 7. Foco: agregar un visor de imagen a resolución completa sobre el lightbox y dar más protagonismo a la reseña; de paso, cerrar tres pendientes diferidos de v06.
- **Entorno:** desarrollo en Claude (chat) como asistente de Claude Code; ejecución en disco y Git por Claude Code en `/Users/tomgc/Projects/slep_monitoreo/`. Rama `main`, GitHub Pages.
- **Archivos principales modificados:** `app.js`, `styles.css`, `index.html`, `data.js`, `colors_and_type.css`.

## 2. Resumen ejecutivo

La sesión agregó un visor de imagen a resolución completa (`.lb-full`) que se abre al hacer click en cualquier captura del lightbox, con navegación por flechas y teclado sincronizada con el pasador de fondo, y cierre por X, click en el fondo y Esc. Se reorganizó el lightbox a dos columnas en desktop (captura 60% / reseña 40%) para darle protagonismo al texto, con reversión a columna apilada en móvil. Se corrigió que el click en la imagen de un banner no abría la reseña (eliminando un `stopPropagation` innecesario). En paralelo se cerraron tres pendientes diferidos de v06: la sección Trayectoria quedó oculta de forma reversible, se eliminó el campo `thumb` obsoleto de `data.js`, y se mapeó explícitamente el peso 400 de Museo Sans al `.otf` 500. Siete commits, todos desplegados y verificados en producción por el usuario. Quedan pendientes la minuta Simce (espera 3 PDF) y la optimización de las 26 capturas.

## 3. Estado al cierre

- **Qué funciona:** el sitio completo en producción (`https://tomgc.github.io/slep_monitoreo/`). Portafolio con 9 proyectos vigentes con capturas + 2 en desarrollo con placeholder. Lightbox de dos columnas en desktop, apilado en móvil. Visor full-res con navegación operativo. Click en imagen de banner y en captura del lightbox funcionando. Última verificación en producción: tras el push de `c6e19b3` (2026-07-27), con caché desactivada.
- **Qué no funciona:** nada reportado como roto.
- **Delta respecto a v06:** +visor full-res con navegación; lightbox de vertical a dos columnas; click en imagen del banner abre reseña; sección Trayectoria oculta; `thumb` eliminado; face 400 de Museo Sans mapeada. Tres pendientes diferidos de v06 cerrados.

## 4. Registro detallado de cambios

Ver backlog acumulativo §5, entradas 47-53 (cada commit documentado con causa raíz, verificación y categoría). Resumen:

| # | Commit | Cambio | Categoría |
|---|--------|--------|-----------|
| 47 | (full-res básico) | Visor full-res sobre el lightbox (X, fondo, Esc) | Interacción y JS |
| 48 | `e335539` | Navegación en el visor full-res (flechas + teclado) | Interacción y JS |
| 49 | `3b7d1bb` | Ocultar sección Trayectoria (reversible) | Estructura de contenido |
| 50 | `ac813e7` | Eliminar campo `thumb` obsoleto de `data.js` | Reproducibilidad y tooling |
| 51 | `0c48a06` | Mapeo explícito Museo Sans 400 → `.otf` 500 | Identidad visual |
| 52 | `3c10c3b` | Click en imagen del banner abre la reseña | Interacción y JS |
| 53 | `c6e19b3` | Lightbox a dos columnas en desktop | Layout y composición |

## 5. Backlog acumulativo

Actualizado a `50_documentacion/activa/backlog_acumulativo.md` (nombre y ubicación canónicos, POLITICA §10 / SETTINGS §2.2.5). Entradas nuevas 47-53. Total acumulado: 53 cambios en 7 sesiones. Sin reescritura ni renumeración de entradas previas. Sin cambios de taxonomía.

## 6. Bugs de la sesión

Un bug de comportamiento reportado por el usuario:

- **Bug (entrada 52):** click en la imagen de un banner no abría la reseña. **Causa raíz:** `stopPropagation` sobre `.banner-media` en `bannerEl` bloqueaba la burbuja al handler de apertura del nodo padre; el "doble disparo" que ese bloque pretendía evitar no existía (el handler no estaba en la imagen). **Solución:** eliminar el bloque (`app.js`). **Verificación:** click en imagen abre la reseña en producción. **Patrón general aprendido:** un `stopPropagation` defensivo sin un doble-handler real que lo justifique es deuda que rompe la interacción esperada; antes de blindar contra propagación, verificar que exista el doble disparo. **Estado:** resuelto.

## 7. Aprendizajes y restricciones descubiertas

- **`[hidden]` necesita guard cuando el selector puede recibir `display` de autor** (reforzado, ya conocido de la entrada 39). Regla: toda clase que pueda recibir `[hidden]` lleva un guard `.clase[hidden]{display:none}`. Contexto: sin él, un `display` futuro sobre `.section` reviviría la sección oculta. Aplicado preventivamente en la entrada 49.
- **Font-matching silencioso oculta pesos ausentes.** Un `font-weight: 400` sin face 400 declarada no falla: resuelve al peso más cercano sin aviso. Regla: declarar explícitamente cada peso que el CSS usa, aunque sea mapeándolo a un `.otf` existente, para que la resolución sea visible y auditable.
- **En flexbox, un hijo con contenido absoluto necesita `min-height: 0` para poder encogerse.** El `.lb-stage` con `flex: 1 1 auto` requiere `min-height: 0` para que los dots hermanos no lo empujen fuera del contenedor. Contexto: sin él, el layout de dos columnas desbordaría en alturas ajustadas.

## 8. Decisiones de diseño

- **Visor full-res ajustado al viewport (contain) en vez de resolución real con scroll.** Elegido por el usuario. Alternativas: resolución real con scroll/zoom; ajustado con toggle a 100%. Justificación: lectura inmediata de la captura completa sin fricción de scroll.
- **Reparto 60/40 (captura/reseña) en el lightbox de dos columnas.** Elegido por el usuario sobre 50/50 y 40/60. La captura conserva prioridad visual y la reseña gana protagonismo respecto al layout vertical previo.
- **Ocultar Trayectoria con `hidden` en vez de borrar.** Elegido por el usuario ("quizás algún día la usemos"). Conserva markup, render y datos; revertir es quitar un atributo.
- **Mapeo Museo Sans 400 → `.otf` 500 (opción A)** sobre reasignar selectores (B) o conseguir la fuente real (C). Justificación: elimina hoy la resolución silenciosa sin cambiar el render ni exigir decisiones caso por caso; reversible ante la fuente real.

## 9. Constantes y parámetros vigentes

| Constante | Valor | Archivo | Nota |
|---|---|---|---|
| Ancho máx. lightbox (desktop) | 1040px | `styles.css` | antes 680px |
| Reparto columnas lightbox | 60% / 40% | `styles.css` | galería / reseña |
| Breakpoint apilado lightbox | 880px | `styles.css` | vuelve a columna |
| Alto stage apilado (móvil) | min(52vh, 420px) | `styles.css` | |
| Face 400 Museo Sans | → `MuseoSans_500.otf` | `colors_and_type.css` | mapeo deliberado, reversible |

## 10. Arquitectura de archivos

Sin cambios estructurales. Ver escáner al cierre: `50_documentacion/estructura/estructura_actual.md` (generado 2026-07-27 09:16:19; 9 carpetas, 64 archivos). El árbol respeta la estructura canónica. Nota: el backlog canónico es `50_documentacion/activa/backlog_acumulativo.md` (con "-tivo"), confirmado por el escáner; el traspaso v06 lo nombraba mal como `backlog_acumulado.md` (ver §15).

## 11. Pendientes y ruta sugerida

**Inventario:**

1. **Minuta Simce nueva (contenido).** Construir el proyecto en `data.js` a partir de 3 PDF (uno por ámbito) que aportará el usuario. Tareas: redactar objetivo + síntesis, asignar `id` (sugerido `simce_cc`) y `orden`, insertar, luego poblar capturas. **Tipo:** funcionalidad. **Dependencia:** los 3 PDF (bloqueante para arrancar). **Complejidad:** Media. **Criterio de éxito:** proyecto visible en el portafolio con reseña y capturas, desplegado.
2. **Optimización de las 26 capturas.** ~9 MB; varias sobre 400 KB (`parvularia-1.png` ≈ 720 KB). Comprimir PNG o migrar a WebP. **Tipo:** deuda técnica. **Complejidad:** Baja-Media. Si WebP: `git mv` + reescritura de rutas `imgs` en `data.js` en commit atómico. **Criterio de éxito:** payload reducido, portafolio idéntico visualmente, cero 404.

**Auditoría de cierre (POLITICA 5.6, preguntas "Cierre"):**
- ¿Nombres de archivos y carpetas sin tildes/ñ/espacios? Sí.
- ¿Outputs reproducibles? N/A (sitio estático sin pipeline de datos).
- El resto de preguntas "Cierre" aplican a proyectos con pipeline R; este es un sitio estático. Sin deuda nueva detectada.

**Ruta sugerida para la sesión 8:** si el usuario trae los 3 PDF, prioridad 1 es la minuta Simce (contenido de alto valor). Si no, la optimización de capturas es una pasada de cosmética de bajo riesgo que cierra el último pendiente técnico. Diferir: nada más en cola.

## 12. Instrucciones específicas para la próxima sesión

- ⚠️ NO commitear los 4 archivos de `50_documentacion/estructura/*` (ruido permanente del escáner); staging siempre selectivo, nunca `git add -A`.
- ⚠️ NO ejecutar `git push` sin aprobación explícita del usuario.
- ✅ ANTES de afirmar estado del repo, verificar con `git log`/`git status` o salida de terminal del usuario; nunca asumir desde el chat.
- ✅ ANTES de editar un archivo, leerlo (pedirlo si no está); entregar el archivo completo, nunca fragmentos.
- ✅ ANTES de nombrar el backlog, usar `backlog_acumulativo.md` (con "-tivo"), ubicación `50_documentacion/activa/`.
- 🔒 La revisión de datos identificables en capturas y `data.js` es responsabilidad del usuario (gobernanza); Claude no ve el contenido de las capturas.

## 13. Fragmentos de código de referencia

Patrón de guard para ocultamiento reversible con `[hidden]` (la forma correcta en este proyecto):

```css
.section { padding: 48px 0; }
.section[hidden] { display: none; }  /* gana sobre cualquier display de autor futuro */
```

```html
<section class="section section--alt" id="trayectoria" hidden>
```

## 14. Reapertura

- **Nombre del chat:** `slep_monitoreo, sesión 8 (Claude Opus 4.8)`.
- **Mensaje de apertura pre-armado:** "Tipo CONTINUATION. El protocolo (POLITICA_PROYECTO.md + SETTINGS_Y_PROMPTS_OPERACIONALES.md) vive en la knowledge base del Project y se lee desde ahí. Adjunto el traspaso v07, el escáner actual, y —si el foco es la minuta Simce— los 3 PDF de origen."
- **Documentos para la próxima sesión:**
  1. *Protocolo en knowledge base (NO adjuntar, solo verificar que estén al día):* `POLITICA_PROYECTO.md`, `SETTINGS_Y_PROMPTS_OPERACIONALES.md`.
  2. *Opcionales según foco:* `CLAUDE.md` si se corre en Claude Code; `data.js` y `app.js` si se trabaja la minuta Simce.
  3. *Específicos de la sesión (SÍ adjuntar):* `traspaso_cierre_v07.md`; `estructura_actual.md`; para la minuta Simce, los 3 PDF de origen; para la optimización, el listado de `assets/proyectos/`.
- **Nota final:** si algún archivo listado cambió entre sesiones, adjuntar la versión más actualizada y avisarlo en la apertura.

## 15. Errores del asistente (POLITICA 0.5)

| momento | disparador | qué pasó | regla violada | causa raíz | salvaguarda presente | patrón |
|---|---|---|---|---|---|---|
| Apertura (acuse v06) y turnos siguientes | usuario lo señaló sin nombrarlo error ("se tiene que llamar igual en todas partes") | Se nombró el backlog como `backlog_acumulado.md` (sin "-tivo") y ubicado en `traspasos/`, arrastrando el nombre no-canónico del traspaso v06 heredado | POLITICA §10 y SETTINGS §2.2.5: nombre canónico `backlog_acumulativo.md`, ubicación `50_documentacion/activa/`, "no negociable" | El traspaso v06 traía el nombre viejo y se citó de memoria sin contrastarlo con el escáner (que sí mostraba el nombre correcto) hasta que el usuario lo marcó | POLITICA / SETTINGS (ambos con la regla explícita) | nuevo |
| Redacción del traspaso (repetido en varias respuestas de la sesión) | asistente lo señaló espontáneamente al cerrar | Se ofreció el cierre de sesión de forma reiterada en turnos donde el usuario aún pedía cambios, generando fricción | SETTINGS §3 (higiene): recomendar cierre ante síntomas concretos, no de forma repetitiva | Se interpretó "foco cumplido + commits sin volcar" como señal de cierre en cada turno, sin esperar señal del usuario | SETTINGS §3 | nuevo |
