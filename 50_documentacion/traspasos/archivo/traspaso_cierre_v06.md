# Traspaso de cierre — slep_monitoreo · v06

## 1. Identificación

- **Proyecto:** slep_monitoreo (sitio institucional estático, GitHub Pages).
- **Versión de traspaso:** v06.
- **Fecha:** 2026-06-26.
- **Sesión:** 6. Foco: poblar las capturas de producto de los proyectos vigentes (prioridad 1 de v05) y ajustar el visor del lightbox para que cada captura se vea completa.
- **Modelo:** Claude Opus 4.8.
- **Entorno:** Claude (chat, planificación) + Claude Code (ejecución en disco). Repo en `/Users/tomgc/Projects/slep_monitoreo`, publicado en `https://tomgc.github.io/slep_monitoreo/`.
- **Archivos principales modificados:** `data.js` (campo `imgs` poblado), `styles.css` (visor del lightbox); 26 capturas nuevas en `assets/proyectos/`.

## 2. Resumen ejecutivo

La sesión ejecutó la prioridad 1 heredada y resolvió un defecto visual reportado sobre la marcha. Primero se poblaron las capturas de producto: el usuario produjo y colocó 26 capturas en `assets/proyectos/` con la convención `<id>-N.png`, y se editó `data.js` poblando el campo `imgs` de los 9 proyectos vigentes (los 2 en desarrollo quedan con `imgs: []` y su placeholder). El commit `8126b58` agrupó las 26 PNG + `data.js` con staging selectivo y quedó verificado en producción (9 portadas, pasador funcional, cero 404). Luego, al revisar el sitio en vivo, el usuario reportó que las capturas se veían "entrecortadas" en el lightbox; la causa raíz fue el `aspect-ratio: 16/9` fijo más `object-fit: cover` del visor, que recortaba toda captura de proporción distinta a 16:9. Se ajustó a altura fija con `contain` (opción A, letterbox con franjas cream), commit `3411bdb`, verificado en producción. Quedan tres pendientes diferidos, todos cosméticos y no bloqueantes (optimización de las capturas ~9 MB, face 400 de Museo Sans, campo `thumb` obsoleto). El portafolio está completo y desplegado para los 9 proyectos vigentes.

## 3. Estado al cierre

- **Qué funciona:** el sitio muestra los 9 banners vigentes con su portada real (captura `-1`) y los 2 en desarrollo con el placeholder "Próximamente"; el lightbox abre la reseña con la síntesis multipárrafo y el pasador navega entre capturas, mostrando cada una completa (sin recorte) sobre franjas cream, con altura de visor estable. Última verificación exitosa: 2026-06-26 en producción (HTTP 200; `styles.css` desplegado con `object-fit: contain` y `height: min(58vh, 460px)`, sin `aspect-ratio: 16/9`; capturas de resguardo 200).
- **Qué no funciona / incompleto:** nada roto. Los 2 proyectos en desarrollo (`desvinculacion`, `rendimiento`) no tienen capturas por diseño (siguen en desarrollo). Tres pendientes diferidos (ver §11), todos cosméticos.
- **Delta respecto a v05:** v05 dejó el portafolio poblado de texto pero sin capturas (los 9 vigentes con `imgs: []` y placeholder). v06 puebla las capturas de los 9 vigentes y corrige el recorte del visor del lightbox. Backlog 43 → 46 entradas.

## 4. Registro detallado de cambios

Ver backlog §5, sesión 6, entradas 44-46. Síntesis:

- **44 (`8126b58`):** poblado del campo `imgs` de los 9 proyectos vigentes con las 26 capturas (`asistencia` 4, `resguardo` 4, `estandares` 3, `idps` 4, `categorias` 3, `parvularia` 3, `inicial` 3, `costapresente` 1, `ael` 1). Commit único con las 26 PNG + `data.js`, staging selectivo.
- **45 (`3411bdb`):** ajuste del visor del lightbox de `aspect-ratio: 16/9` + `cover` a `height: min(58vh, 460px)` + `contain`. Banner de la grilla conservado en `cover`.
- **46:** pendiente de optimización de las capturas registrado (sin ejecutar).

## 5. Backlog acumulativo

Mantenido en `backlog_acumulado.md` (gitignored). Cierra en la entrada 46. Esta sesión agregó 44-46 sin reescribir ni renumerar entradas previas. Resumen estadístico actualizado (fila sesión 6, total 43 → 46).

## 6. Bugs de la sesión

Un defecto visual reportado por el usuario, resuelto:

- **Capturas recortadas en el lightbox.** **Síntoma observable:** las capturas se veían "entrecortadas" (recortadas) al abrir la reseña. **Causa raíz:** `.lb-stage` con `aspect-ratio: 16/9` fijo y `.lb-slide img` con `object-fit: cover`; toda captura de proporción distinta a 16:9 (las hay verticales 1082×1540 y apaisadas) se recortaba para llenar el marco. **Solución exacta:** en `styles.css`, `.lb-stage` `aspect-ratio: 16/9` → `height: min(58vh, 460px)`; `.lb-slide img` `object-fit: cover` → `contain`. **Verificación:** producción con fetch no-store muestra las reglas nuevas y `aspect-ratio` ausente; altura 460px estable entre las 4 slides de resguardo. **Patrón general aprendido:** un visor de galería con contenido de proporciones heterogéneas no debe fijar `aspect-ratio` ni usar `object-fit: cover`; usar altura acotada + `contain` para mostrar cada pieza completa. El recorte uniforme con `cover` solo es deseable donde la consistencia de la grilla importa más que ver la pieza entera (el banner). **Principios:** C.10 (transparencia: el recorte ocultaba contenido), B.3 (cambio quirúrgico: solo el visor, el banner intacto). **Estado:** resuelto (entrada 45).

## 7. Aprendizajes y restricciones descubiertas

- **`object-fit: cover` recorta; `contain` muestra completo.** Regla: para mostrar una imagen entera de proporción desconocida, `contain` + un contenedor de altura acotada; `cover` solo cuando llenar un marco de proporción fija importa más que ver todo (grilla uniforme). Contexto: si se viola, se pierde contenido sin aviso. Ejemplo: el visor del lightbox de esta sesión.
- **Altura de un visor fijo vs. `max-height` del card.** Al fijar la altura del visor (`min(58vh, 460px)`), considerar el `max-height: 90vh` del contenedor padre: un visor demasiado alto comprime el texto que va debajo (la síntesis). El techo en píxeles (`460px`) evita el aplastamiento en pantallas bajas. (Principio B.1: anticipar la interacción entre reglas, no asumir que cada una vive aislada.)
- **Caché de stylesheet en preview/navegador.** El `<link>` puede servir una copia cacheada del CSS aunque el archivo en disco/servidor esté actualizado; `reload(true)` no siempre la purga. Verificar el CSS *aplicado* (vía `document.styleSheets` o fetch con `cache: 'no-store'`), no solo el archivo. En producción, el redeploy con contenido distinto invalida la caché para visitantes nuevos. (Aplica al verificar cualquier cambio de CSS.)
- **El `id` de proyecto no es un campo de `data.js`.** Es solo la convención del nombre de archivo de las capturas (`<id>-N.png`). El render no lo usa; el mapeo orden→id vive en el traspaso. No introducir un campo `id` esperando que el código lo consuma.

## 8. Decisiones de diseño

- **Visor del lightbox: altura fija con letterbox (opción A).** Alternativas: (A) altura estable + `contain`, franjas cream donde sobra; (B) el visor se adapta a la proporción de cada captura. Se eligió A porque las capturas son heterogéneas (verticales y apaisadas) y B haría "saltar" el alto del visor al pasar entre slides. Implicancia: una captura muy alta o muy ancha deja franjas cream; es el costo aceptado a cambio de un pasador estable.
- **Un commit para las 26 capturas + `data.js`.** Alternativa: dos commits (imágenes / código). Se eligió uno porque conforman un solo cambio conceptual ("portafolio con capturas reales"); separarlos dejaría un commit intermedio con `data.js` apuntando a archivos aún no versionados. El ajuste del visor sí fue a commit aparte (cambio conceptual distinto).
- **Techo en píxeles para la altura del visor (`min(58vh, 460px)`).** Alternativa: `60vh` plano. Se eligió el `min()` para que en monitores bajos el visor no se coma la pantalla y deje aire a la síntesis bajo el `max-height: 90vh` del card.

## 9. Constantes y parámetros vigentes

| Constante | Valor | Archivo | Nota |
|---|---|---|---|
| `grupo` (orden de estados) | `{vigente:0, desarrollo:1}` | `app.js` `renderBanners()` | vigentes primero |
| Campos de proyecto | `orden, tipo, titulo, objetivo, sintesis, estado, thumb, imgs` | `data.js` | sin cambios desde v05 |
| Convención de capturas | `assets/proyectos/<id>-N.png` | (acordado) | `-1` = portada; 26 archivos en disco |
| Altura del visor del lightbox | `min(58vh, 460px)` | `styles.css` `.lb-stage` | nuevo en v06 (antes `aspect-ratio: 16/9`) |
| `object-fit` del slide | `contain` | `styles.css` `.lb-slide img` | nuevo en v06 (antes `cover`) |
| `object-fit` del banner | `cover` | `styles.css` `.banner-shot` | sin cambios (recorte uniforme de grilla) |

## 10. Arquitectura de archivos

Sin cambios estructurales de carpetas. El sitio sigue en la raíz (restricción Pages). `assets/proyectos/` pasó de vacía (solo `.gitkeep`) a 26 PNG versionadas. Regenerar `estructura_actual.md` antes de abrir la sesión 7, ya que `data.js`, `styles.css` y `assets/proyectos/` cambiaron.

## 11. Pendientes y ruta sugerida

### Inventario de pendientes

1. **Minuta Simce nueva: construir desde 3 PDF.**
   - **Tipo:** contenido. **Impacto:** medio. El proyecto "Minutas de resultados de las pruebas Simce" se eliminó de `data.js` en v05; el usuario aportará 3 PDF (uno por ámbito de resultados) para construir objetivo y síntesis de una nueva versión.
   - **Enfoque:** pedir los 3 PDF, redactar objetivo + síntesis, asignar `id` (sugerido `simce_cc`), insertar con su `orden`; luego sus capturas siguiendo el flujo de la entrada 44.
   - **Criterio de éxito:** proyecto insertado en `data.js` con objetivo, síntesis y orden coherente; capturas pobladas; verificado en producción.

2. **Optimización de las 26 capturas** (deuda menor, entrada 46).
   - **Tipo:** reproducibilidad / tooling. Las capturas suman ~9 MB; varias sobre 400 KB (`parvularia-1.png` ≈ 720 KB). Comprimir los PNG o migrar a WebP. No bloqueante.
   - **Precaución:** si se migra a WebP, hay que actualizar las rutas `imgs` en `data.js` (extensión) y los nombres de archivo en disco, en un commit atómico (mismo criterio que cualquier renombrado de assets: `git mv` + reescritura de rutas juntos).

3. **Face 400 de Museo Sans ausente** (deuda menor heredada de v05).
   - **Tipo:** deuda visual. Los `font-weight: 400` resuelven a 500 por font-matching. Conseguir el `.otf` 400 o normalizar los pesos. Baja prioridad.

4. **Campo `thumb` obsoleto** (deuda menor heredada de v05).
   - Con los 9 vigentes ya con `imgs`, `thumb` queda inerte para ellos (los 2 en desarrollo aún lo tendrían como referencia de color del placeholder; verificar antes de eliminar). Evaluar su retiro en una pasada de limpieza.

### Auditoría de cierre (política §5.6)

- **¿Outputs reproducibles/idempotentes?** Sitio estático sin pipeline; N/A.
- **¿Nombres sin tildes/ñ/espacios?** Sí (las 26 capturas siguen la convención `<id>-N.png`).
- **¿Decisiones metodológicas como constantes?** Sí (altura del visor, `object-fit` por contexto, documentadas en §9).
- Sin respuestas "no" que generen pendientes nuevos.

### Ruta sugerida sesión 7

1. **Minuta Simce nueva** si el usuario trae los 3 PDF (contenido de alto valor, input pendiente del usuario).
2. **Pasada de cosmética dedicada:** optimización de capturas (pendiente 2) + face 400 (pendiente 3) + limpieza de `thumb` (pendiente 4), agrupadas en una sesión, cada una en su commit. Conviene juntarlas porque son todas de bajo riesgo y ninguna bloquea contenido.
3. Diferir: nada nuevo pendiente.

## 12. Instrucciones específicas para la próxima sesión

- 🔒 Sitio en la RAÍZ del repo: no mover `index.html`, `app.js`, `data.js`, `styles.css`, `colors_and_type.css`, `.nojekyll`, `assets/`, `fonts/`.
- 🔒 Español neutro sin voseo (código, comentarios, contenido, commits). Nota: el agente de Claude Code emite mensajes con voseo en el chat; revisar su configuración de idioma para que no se filtre a commits ni comentarios del repo.
- 🔒 `backlog_acumulado.md` es la fuente de verdad del conteo; entradas previas no se reescriben ni renumeran (cierra en 46).
- 🔒 `git push` siempre requiere aprobación explícita del usuario.
- 🔴 GOBERNANZA: ninguna captura con datos identificables de estudiantes/establecimientos antes de subir. La revisión del contenido de las imágenes es del usuario (Claude solo ve los nombres de archivo).
- ✅ ANTES de commitear: staging selectivo (`git add <archivos>`, nunca `git add -A`); los 4 `50_documentacion/estructura/*` son ruido permanente del escáner y quedan fuera.
- ✅ ANTES de afirmar estado de commits: verificar con `git log`, nunca desde el chat.
- ✅ Si se migran las capturas a WebP: `git mv` + reescritura de rutas en `data.js` en un commit atómico.
- ⚠️ El renombrado/colocación de archivos de captura es tarea manual del usuario; Claude entrega el array `imgs` y el nombre, no scripts para mover archivos.
- ⚠️ No inventar nombres ni expansiones de siglas heredadas de `data.js`; confirmar con el usuario.
- ⚠️ Al verificar cambios de CSS: comprobar el CSS aplicado (no solo el archivo), por la caché del `<link>`.

## 13. Fragmentos de código de referencia

Estructura de un proyecto poblado en `data.js` (la forma correcta tras v06):

```javascript
{
  orden: 2,
  tipo: "Reporte · Directores/as",
  titulo: "Reportes del Modelo de Resguardo de la Asistencia Educativa del Territorio",
  objetivo: "…",            // snippet del banner
  sintesis: [ "…", "…" ],   // párrafos de la reseña
  estado: "vigente",
  thumb: "plum",
  imgs: [
    "assets/proyectos/resguardo-1.png",   // -1 = portada del banner
    "assets/proyectos/resguardo-2.png",
    "assets/proyectos/resguardo-3.png",
    "assets/proyectos/resguardo-4.png"
  ]
}
```

Visor del lightbox adaptado a la proporción de cada captura (en `styles.css`):

```css
.lb-stage {
  background: var(--cream); height: min(58vh, 460px); position: relative;
  display: flex; align-items: center; justify-content: center; overflow: hidden;
}
.lb-slide { position: absolute; inset: 0; display: none; }
.lb-slide.active { display: flex; align-items: center; justify-content: center; }
.lb-slide img, img.lb-slide { width: 100%; height: 100%; object-fit: contain; }

/* El banner de la grilla conserva el recorte uniforme: */
.banner-shot { width: 100%; height: 100%; min-height: 104px; object-fit: cover; border-radius: 6px; }
```

## 14. Reapertura

- **Nombre del chat:** `slep_monitoreo, sesión 7 (Claude Opus 4.8)`.
- **Mensaje de apertura pre-armado:**

  > Continuación del proyecto slep_monitoreo (sitio en https://tomgc.github.io/slep_monitoreo/). Tipo: CONTINUATION (protocolo de apertura en la knowledge base). Adjunto `traspaso_cierre_v06.md`, `estructura_actual.md`, `backlog_acumulado.md`, `data.js`, `styles.css` e `index.html`. Recuerda que los traspasos y `backlog_acumulado.md` son gitignored y se adjuntan a mano. [Si traigo los 3 PDF de la minuta Simce, los adjunto también.]

- **Documentos para la próxima sesión:**
  1. *Protocolo en knowledge base (NO se adjuntan, verificar que estén al día):* `POLITICA_PROYECTO.md`, `SETTINGS_Y_PROMPTS_OPERACIONALES.md`.
  2. *Opcionales según foco:* `CLAUDE.md` (la sesión correrá parte en Claude Code); `colors_and_type.css` si se aborda el face 400 de Museo Sans; los 3 PDF si se construye la minuta Simce.
  3. *Específicos de la sesión (SÍ se adjuntan):* `traspaso_cierre_v06.md`; `estructura_actual.md` (regenerar antes de abrir); `backlog_acumulado.md`; `data.js`, `styles.css`, `index.html` (los que se editan al insertar la minuta Simce o en la pasada de cosmética).
- **Nota final:** si algún archivo cambió entre sesiones, adjuntar la versión más reciente al abrir y avisarlo. Regenerar el escáner antes de abrir, porque `data.js`, `styles.css` y `assets/proyectos/` cambiaron en v06.

---

## Reapertura (copia para pegar al cerrar el chat)

**Nombre del chat:** `slep_monitoreo, sesión 7 (Claude Opus 4.8)`

**Mensaje de apertura:**

> Continuación del proyecto slep_monitoreo (sitio en https://tomgc.github.io/slep_monitoreo/). Tipo: CONTINUATION (protocolo de apertura en la knowledge base). Adjunto `traspaso_cierre_v06.md`, `estructura_actual.md`, `backlog_acumulado.md`, `data.js`, `styles.css` e `index.html`. Recuerda que los traspasos y `backlog_acumulado.md` son gitignored y se adjuntan a mano. [Si traigo los 3 PDF de la minuta Simce, los adjunto también.]

**Adjuntar:** `traspaso_cierre_v06.md`, `estructura_actual.md` (regenerado), `backlog_acumulado.md`, `data.js`, `styles.css`, `index.html`. Opcional: `CLAUDE.md`, `colors_and_type.css`, los 3 PDF de la minuta Simce.
