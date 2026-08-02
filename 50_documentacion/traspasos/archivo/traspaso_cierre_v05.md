# Traspaso de cierre — slep_monitoreo · v05

## 1. Identificación

- **Proyecto:** slep_monitoreo (sitio institucional estático, GitHub Pages).
- **Versión de traspaso:** v05.
- **Fecha:** 2026-06-26.
- **Sesión:** 5. Foco: limpieza de navegación muerta + poblado del portafolio con los 11 proyectos definitivos.
- **Modelo:** Claude Opus 4.8.
- **Entorno:** Claude (chat, planificación) + Claude Code (ejecución en disco). Repo en `/Users/tomgc/Projects/slep_monitoreo`, publicado en `https://tomgc.github.io/slep_monitoreo/`.
- **Archivos principales modificados:** `data.js`, `app.js`, `index.html`, `styles.css`, `CLAUDE.md`, `.gitignore`.

## 2. Resumen ejecutivo

La sesión despejó dos frentes de deuda diferida y luego ejecutó la tarea de mayor valor del proyecto. Primero se resolvió la decisión de navegación (opción A: limpiar las dos capas muertas de header/nav en `styles.css` y `app.js`, en vez de implementar una barra de navegación que el diseño congelado d2 no requiere) y se corrigieron dos rutas falsas en `CLAUDE.md`. Luego se pobló el portafolio: `data.js` se reescribió con los 11 proyectos definitivos provistos en un `.docx`, se agregaron los campos `orden` (orden de aparición) y `sintesis` (reseña del lightbox en párrafos), se adaptó el render, y se blindaron en `.gitignore` los dos documentos de protocolo interno que estaban desprotegidos. Todo quedó pusheado en tres commits (`194e8f8`, `f5e4155`, `a277319`) y verificado en producción: sitio 200, 11 proyectos publicados, protocolos dando 404. Pendiente principal: las capturas de producto de cada proyecto (los banners muestran el marcador "próximamente" hasta cargarlas), que es la prioridad 1 de la sesión 6.

## 3. Estado al cierre

- **Qué funciona:** el sitio carga los 11 banners ordenados (9 vigentes arriba por `orden` 1-9, 2 en desarrollo abajo `orden` 10-11); el lightbox abre la reseña con la síntesis en párrafos múltiples; el footer legal intacto. Última verificación exitosa: 2026-06-26 en producción (HTTP 200; `data.js` con 11 objetos `orden:`; `POLITICA_PROYECTO.md` y `SETTINGS_Y_PROMPTS_OPERACIONALES.md` → 404).
- **Qué no funciona / incompleto:** ningún proyecto tiene capturas (`imgs: []` en los 11), por lo que todos los banners muestran el placeholder "Próximamente" y el lightbox muestra la slide placeholder. No es un bug: es contenido pendiente.
- **Delta respecto a v04:** v04 dejó el sitio congelado en d2 sin chrome de variantes y con el portafolio vacío de contenido real (placeholders). v05 elimina la navegación muerta, puebla los 11 proyectos con texto definitivo, introduce `orden` y `sintesis`, y blinda los protocolos. Backlog 39 → 43 entradas.

## 4. Registro detallado de cambios

Ver backlog §5, sesión 5, entradas 40-43. Síntesis:

- **40 (`194e8f8`):** eliminación de las dos capas muertas de nav (CSS bloque Header + footer multicolumna en `styles.css`; sección NAV en `app.js`) y corrección de rutas de traspasos en `CLAUDE.md`. Neto −79 líneas.
- **41 (`f5e4155`):** reescritura total de `PROYECTOS` con los 11 proyectos definitivos; eliminación de la minuta Simce antigua; creación de `idps` y `rendimiento`; corrección de erratas de tipeo.
- **42 (`f5e4155`):** campos `orden` y `sintesis`; sort de dos criterios; render de síntesis multipárrafo; `#lbObj` de `<p>` a `<div>`; separación CSS entre párrafos.
- **43 (`a277319`):** blindaje de `POLITICA_PROYECTO.md` y `SETTINGS_Y_PROMPTS_OPERACIONALES.md` en `.gitignore`.

## 5. Backlog acumulativo

Mantenido en `backlog_acumulado.md` (gitignored). Cierra en la entrada 43. Esta sesión agregó 40-43 sin reescribir ni renumerar entradas previas.

## 6. Bugs de la sesión

Sin bugs nuevos. Se corrigieron dos defectos heredados de documentación (no de código):

- **Rutas falsas en `CLAUDE.md`:** afirmaba que los traspasos vivían en `_archivo/traspasos/` y que `50_documentacion/traspasos/` quedaba vacía. **Causa raíz:** documentación escrita en una sesión previa que no se actualizó cuando los traspasos se movieron a `50_documentacion/traspasos/` (gitignored vía `*.md`). **Verificación:** escáner muestra los 4 traspasos + backlog dentro de esa carpeta. **Regla aprendida:** la documentación de rutas en `CLAUDE.md` debe cruzarse contra el escáner real, no contra la memoria de sesiones anteriores. **Estado:** resuelto (entrada 40).
- **Protocolos desprotegidos en `.gitignore`:** ni `POLITICA_PROYECTO.md` ni `SETTINGS_*` estaban ignorados por nombre; la política solo no se publicaba porque su archivo físico no estaba en disco. **Causa raíz:** el blindaje de la sesión 3 (entrada 35) desindexó la política pero no agregó una regla preventiva al `.gitignore`. **Regla aprendida:** desindexar un archivo sensible (`git rm --cached`) no basta; hay que agregar la regla al `.gitignore` o un `git add -A` futuro lo reintroduce. **Estado:** resuelto (entrada 43).

## 7. Aprendizajes y restricciones descubiertas

- **Capas muertas vienen en grupos.** Al evaluar dead code de una feature ausente, revisar TODAS las capas (markup, CSS, JS), no solo la mencionada. La nav muerta tenía CSS + JS esperando un markup que nunca existió; limpiar solo una habría dejado la otra huérfana. (Principio C.10 transparencia / B.3 quirúrgico.)
- **`grep -c` sobre un campo cuenta también los comentarios.** El conteo de `orden:` dio 12 en vez de 11 porque la línea de documentación del campo contiene la palabra. Para contar objetos reales, anclar el patrón a la forma exacta (`^\s+orden: [0-9]+,`). (Principio B.4: el check de éxito debe ser inequívoco.)
- **No inventar datos heredados.** El nombre falso "Análisis del Entorno y los Logros" para AEL venía arrastrado en un `objetivo` viejo; al reescribir, se confió en él hasta que el usuario corrigió (AEL = Anótate en la Lista). Regla: los datos heredados de `data.js` no son fuente de verdad; confirmar con el usuario ante cualquier expansión de sigla o nombre propio. (Principio B.1.)
- **`<p>` no puede contener `<p>`.** Para texto multipárrafo inyectado por JS, el contenedor debe ser `<div>`, no `<p>`. (Restricción HTML.)

## 8. Decisiones de diseño

- **Navegación: limpiar en vez de implementar (opción A).** Alternativas: (A) eliminar las capas muertas; (B) implementar header + nav + scroll-spy; (C) diferir. Se eligió A porque el sitio es single-page corto con diseño congelado d2 y sin chrome por decisión previa; mantener CSS/JS especulativo viola B.2/C.10. Implicancia: si los banners (con capturas) alargan la página y justifican navegación, se reimplementa con el largo real a la vista; el scroll-spy eliminado se recupera de Git (`194e8f8^`).
- **`sintesis` como arreglo de párrafos.** Alternativa: un solo string con separadores. Se eligió arreglo porque es explícito, fácil de editar y el render mapea 1:1 a `<p>`. Implicancia: el editor de `data.js` agrega párrafos como elementos del arreglo.
- **`orden` separado de `estado`.** El orden visual es jerárquico: primero el grupo (`estado`), luego `orden` dentro del grupo. Implicancia: cambiar un proyecto a "desarrollo" lo manda al final aunque su `orden` sea bajo; el `orden` no necesita renumerarse al cambiar estados.
- **Blindaje por nombre exacto, no por patrón.** Alternativa: `activa/*.md`. Se eligió nombre exacto para no bloquear documentación pública legítima futura en `activa/` (p. ej. `documentacion_tecnica_vN.md`).

## 9. Constantes y parámetros vigentes

| Constante | Valor | Archivo | Nota |
|---|---|---|---|
| `grupo` (orden de estados) | `{vigente:0, desarrollo:1}` | `app.js` `renderBanners()` | vigentes primero |
| Campos de proyecto | `orden, tipo, titulo, objetivo, sintesis, estado, thumb, imgs` | `data.js` | `sintesis` y `orden` nuevos en v05 |
| Convención de capturas | `assets/proyectos/<id>-N.png` | (acordado) | sin tildes/ñ/espacios; `-1` = portada |
| Ignorados nuevos | `POLITICA_PROYECTO.md`, `SETTINGS_Y_PROMPTS_OPERACIONALES.md` | `.gitignore` L16-18 | por nombre exacto |

## 10. Arquitectura de archivos

Sin cambios estructurales de carpetas. El sitio sigue en la raíz (restricción Pages). Escáner de referencia al cierre: `estructura_actual.md` (regenerar antes de abrir la sesión 6, ya que `data.js`/`app.js`/`index.html`/`styles.css`/`CLAUDE.md`/`.gitignore` cambiaron). Estructura conforme a la aplicación pragmática documentada en `CLAUDE.md`.

## 11. Pendientes y ruta sugerida

### Inventario de pendientes

1. **Capturas de producto de los 11 proyectos** (prioridad 1 sesión 6).
   - **Tipo:** funcionalidad / contenido. **Impacto:** alto (los banners lucen vacíos sin ellas).
   - **Dependencias:** el usuario sube las capturas al chat; Claude las revisa (gobernanza + recorte) y entrega el array `imgs`; el usuario coloca los archivos en `assets/proyectos/` con nombre `<id>-N.png`.
   - **Complejidad:** media (es serie de 11, cada una con revisión de datos sensibles).
   - **Precauciones (🔴 gobernanza):** ninguna captura puede mostrar nombres de estudiantes, RUT ni establecimientos identificables. Varios productos (minutas, resguardo, CostaPresente) muestran datos individuales por diseño; revisar cada una antes de publicar.
   - **Criterio de éxito:** cada proyecto con 3-4 capturas en `imgs`, banner con portada real, lightbox con pasador funcional, sin datos sensibles, verificado en producción.
   - **ids:** `asistencia, resguardo, estandares, idps, categorias, parvularia, inicial, costapresente, ael, desvinculacion, rendimiento`.

2. **Minuta Simce antigua: reemplazo por nueva versión basada en 3 PDF.**
   - **Tipo:** contenido. **Impacto:** medio. El proyecto "Minutas de resultados de las pruebas Simce" se eliminó de `data.js`; el usuario aportará 3 PDF (uno por ámbito de resultados) para construir objetivo y síntesis de una nueva versión. **Enfoque:** pedir los 3 PDF, redactar objetivo + síntesis, asignar `id` (sugerido `simce_cc`), insertar con su `orden`.

3. **Face 400 de Museo Sans ausente** (deuda menor heredada).
   - **Tipo:** deuda visual. Los `font-weight: 400` resuelven a 500 por font-matching. Conseguir el `.otf` 400 o normalizar los pesos. Baja prioridad.

4. **Campo `thumb` obsoleto** (deuda menor).
   - Una vez que todos los proyectos tengan `imgs`, `thumb` queda inerte. Evaluar su eliminación en una pasada de limpieza.

### Auditoría de cierre (política §5.6)

- **¿Outputs reproducibles/idempotentes?** Sitio estático sin pipeline; N/A.
- **¿Nombres sin tildes/ñ/espacios?** Sí (archivos del sitio y convención de capturas).
- **¿Decisiones metodológicas como constantes?** Sí (orden de estados, convención de capturas documentada en `data.js` y `CLAUDE.md`).
- Sin respuestas "no" que generen pendientes nuevos.

### Ruta sugerida sesión 6

1. **Capturas, proyecto por proyecto** (criterio de priorización: funcionalidad de alto valor + input ya disponible). Empezar por un proyecto, cerrar el ciclo completo (revisión → `imgs` → edición `data.js` → preview → commit) y luego serie.
2. **Minuta Simce nueva** si el usuario trae los 3 PDF.
3. Diferir: face 400, limpieza de `thumb` (sesión dedicada de cosmética).

## 12. Instrucciones específicas para la próxima sesión

- 🔒 Sitio en la RAÍZ del repo: no mover `index.html`, `app.js`, `data.js`, `styles.css`, `colors_and_type.css`, `.nojekyll`, `assets/`, `fonts/`.
- 🔒 Español neutro sin voseo (código, comentarios, contenido, commits).
- 🔒 `backlog_acumulado.md` es la fuente de verdad del conteo; entradas previas no se reescriben ni renumeran (cierra en 43).
- 🔒 `git push` siempre requiere aprobación explícita del usuario.
- 🔴 GOBERNANZA: ninguna captura con datos identificables de estudiantes/establecimientos antes de subir. Revisar cada una.
- ✅ ANTES de commitear: staging selectivo (`git add <archivos>`, nunca `git add -A`); los 4 `50_documentacion/estructura/*` son ruido permanente del escáner y quedan fuera.
- ✅ ANTES de afirmar estado de commits: verificar con `git log`, nunca desde el chat.
- ✅ Convención de capturas: `assets/proyectos/<id>-N.png`, `-1` es la portada del banner.
- ⚠️ El renombrado/colocación de archivos de captura es tarea manual del usuario; Claude entrega el array `imgs` y el nombre, no scripts para mover archivos.
- ⚠️ No inventar nombres ni expansiones de siglas heredadas de `data.js`; confirmar con el usuario.

## 13. Fragmentos de código de referencia

Render del portafolio (la forma correcta de ordenar, en `app.js`):

```javascript
function renderBanners() {
  bannerList.innerHTML = "";
  var grupo = { vigente: 0, desarrollo: 1 };
  var list = PROYECTOS.slice().sort(function (a, b) {
    var g = (grupo[a.estado] || 0) - (grupo[b.estado] || 0);
    if (g !== 0) return g;
    return (a.orden || 0) - (b.orden || 0);
  });
  list.forEach((p, i) => bannerList.appendChild(bannerEl(p, i)));
}
```

Render de la síntesis multipárrafo en el lightbox (en `app.js`):

```javascript
const lbObj = $("#lbObj");
lbObj.innerHTML = "";
const parrafos = (p.sintesis && p.sintesis.length) ? p.sintesis : [p.objetivo];
parrafos.forEach((txt) => lbObj.appendChild(el("p", null, esc(txt))));
```

Estructura de un proyecto en `data.js` (con capturas, para cuando se pueblen):

```javascript
{
  orden: 1,
  tipo: "Minuta · Dirección Ejecutiva",
  titulo: "Minuta de asistencia mensual",
  objetivo: "…",            // snippet del banner
  sintesis: [ "…", "…" ],   // párrafos de la reseña
  estado: "vigente",
  thumb: "olive",
  imgs: ["assets/proyectos/asistencia-1.png", "assets/proyectos/asistencia-2.png"]
}
```

## 14. Reapertura

- **Nombre del chat:** `slep_monitoreo, sesión 6 (Claude Opus 4.8)`.
- **Mensaje de apertura pre-armado:**

  > Continuación del proyecto slep_monitoreo (sitio en https://tomgc.github.io/slep_monitoreo/). Tipo: CONTINUATION (protocolo de apertura en la knowledge base). Adjunto `traspaso_cierre_v05.md`, `estructura_actual.md`, `backlog_acumulado.md`, `data.js`, `app.js` y `index.html`. La prioridad 1 es poblar las capturas de producto de los proyectos: tengo las imágenes y las iré pasando proyecto por proyecto. Recuerda que los traspasos y `backlog_acumulado.md` son gitignored y se adjuntan a mano.

- **Documentos para la próxima sesión:**
  1. *Protocolo en knowledge base (NO se adjuntan, verificar que estén al día):* `POLITICA_PROYECTO.md`, `SETTINGS_Y_PROMPTS_OPERACIONALES.md`.
  2. *Opcionales según foco:* `CLAUDE.md` (la sesión correrá parte en Claude Code); `styles.css` si hay que ajustar el banner con imágenes reales.
  3. *Específicos de la sesión (SÍ se adjuntan):* `traspaso_cierre_v05.md`; `estructura_actual.md` (regenerar antes de abrir); `backlog_acumulado.md`; `data.js`, `app.js`, `index.html` (los que se editan al poblar `imgs`).
- **Nota final:** si algún archivo cambió entre sesiones, adjuntar la versión más reciente al abrir y avisarlo. Regenerar el escáner antes de abrir, porque seis archivos cambiaron en v05.

---

## Reapertura (copia para pegar al cerrar el chat)

**Nombre del chat:** `slep_monitoreo, sesión 6 (Claude Opus 4.8)`

**Mensaje de apertura:**

> Continuación del proyecto slep_monitoreo (sitio en https://tomgc.github.io/slep_monitoreo/). Tipo: CONTINUATION (protocolo de apertura en la knowledge base). Adjunto `traspaso_cierre_v05.md`, `estructura_actual.md`, `backlog_acumulado.md`, `data.js`, `app.js` y `index.html`. La prioridad 1 es poblar las capturas de producto de los proyectos: tengo las imágenes y las iré pasando proyecto por proyecto. Recuerda que los traspasos y `backlog_acumulado.md` son gitignored y se adjuntan a mano.

**Adjuntar:** `traspaso_cierre_v05.md`, `estructura_actual.md` (regenerado), `backlog_acumulado.md`, `data.js`, `app.js`, `index.html`. Opcional: `CLAUDE.md`, `styles.css`.
