# Traspaso de cierre · v19

## 1. Identificación

| Campo | Valor |
|---|---|
| Proyecto | `slep_monitoreo`, sitio institucional del Área de Monitoreo, SLEP Costa Central |
| Versión | v19 |
| Fecha | 2026-10-07 (sesión abierta el 2026-09-26; fecha medida con `TZ=America/Santiago date +%F`) |
| Sesión | 19. Quinta de la ruta de la sección Formación. Hizo la primera maqueta animada de la pieza risograph (P13, luego diferida por el titular), integró a `main` local del repo hermano de la cartera el prototipo «Portafolio de Proyectos» y dejó aprobado el plan para fusionar los tres meta proyectos del Área en un repo nuevo y privado, `slep_area_monitoreo` |
| Modelo | Claude Opus 5.5 |
| Entorno | Chat (Cowork) en el Project «Portafolio monitoreo», con la carpeta del repo conectada, más Claude Code en la estación del titular |
| Archivos versionados modificados | `50_documentacion/activa/backlog_acumulativo.md` (commit propio previo al cierre: retiro del rótulo congelado de la línea 4) |
| Archivos producidos fuera de git (en `50_documentacion/andamios/`) | `20260926_errores_sesion19.md`, `20260926_maqueta_animacion_risograph.html`, `20261007_plan_fusion_slep_area_monitoreo.md` |
| Archivos producidos en otro repo | `slep_estado_proyectos_monitoreo`: `50_documentacion/andamios/20261007_encargo_integrar_portafolio.md` (sin seguimiento) y su log versionado `50_documentacion/andamios/logs/20261007_integracion_portafolio_log.md` |
| Gobernanza vigente al cierre (kit `herramientas_dev/gobernanza/`, leída el 2026-10-07) | `> **Versión 5.9 — vigente.** Documento maestro único de arquitectura y` y `> **Versión 39.** Emitida el 2026-09-30 junto con`. La knowledge base del Project y la copia de `activa/` seguían en 5.8 y 38; `/cierre` actualiza `activa/` desde el kit |
| `main` | `df85560`, previo al commit del backlog y al de cierre |

## 2. Resumen ejecutivo

La sesión partió con el foco que fijó el traspaso v18: aprobar el guion de la
animación risograph y producir su primera maqueta. El titular aprobó las cuatro
decisiones del guion (punto de trama, 30 s sin sonido, los seis textos y la
ubicación diferida) y se entregó una maqueta animada en canvas, revisada cuadro
a cuadro en Chromium, que el titular juzgó «bastante mejor» antes de diferir la
parte creativa. Luego la sesión giró a la cartera del Área: se trajo e integró a
`main` local de `slep_estado_proyectos_monitoreo` la rama de una sesión en la
nube con el prototipo «Portafolio de Proyectos» (merge `3b61b9f`, sin push), se
revisó el prototipo y se resolvieron sus decisiones D1 a D6. Con eso el titular
decidió fusionar `slep_monitoreo`, `slep_estado_proyectos_monitoreo` y
`slep_dashboard_personal_monitoreo` en un repo nuevo y privado,
`slep_area_monitoreo`, publicado en Cloudflare Pages con Access según el modelo
de `slep_reporte_emergencia` y `slep_servicio_educativo_regional`, y aprobó el
plan con sus seis decisiones. Se registraron diez errores del asistente (E5 a
E14), dos de ellos heredados de la sesión 18. No hay bugs activos ni bloqueantes.

## 3. Estado al cierre

### Qué funciona

- El sitio publicado sigue igual: ningún archivo de `docs/` se tocó.
- Candado 0bis medido a mano al abrir y luego por `/apertura` (commit
  `df85560`, sesión abierta en `MacBook-Pro-de-Tomas.local`).

### Qué no funciona

- Ninguna falla observable. El comportamiento en pantalla angosta del
  recorrido (P4) sigue igual.

### Delta respecto de v18

- P13 avanzó: guion aprobado y maqueta animada v1 entregada; el titular lo
  difirió.
- Pendiente nuevo P17: fusión en `slep_area_monitoreo`, con plan aprobado.
- Correcciones al backlog de la sesión 18 (fecha y modelo) y retiro del rótulo
  congelado de la línea 4.

## 4. Registro detallado de cambios

### 4.1 Corrección de la sesión 18 en el backlog

- **Archivo:** `50_documentacion/activa/backlog_acumulativo.md`.
- **Categoría:** Documentación.
- **Qué se hizo:** entrada correctiva nueva (la sesión 18 se cerró el
  2026-09-26 con Claude Opus 5.5, no el 2026-08-05 ni con modelo «No
  registrado») y retiro del texto «Actualizado hasta v10 (2026-07-30).» de la
  línea 4, en un commit propio previo al cierre.
- **Por qué:** decisión del titular. El eco de cada cierre ya informa la última
  entrada, y una nota congelada solo puede volver a mentir.
- **Verificación:** `sed -n 4p` y `git diff --stat` del commit propio.

### 4.2 Guion v1 de la animación aprobado

- **Archivo:** `50_documentacion/andamios/20260805_guion_animacion_risograph.md` (sin cambios; la aprobación consta aquí).
- **Categoría:** Estructura de contenido.
- **Qué se hizo:** el titular aprobó el punto de trama como hilo conductor,
  30 s en bucle sin sonido, los seis textos literales y dejar la ubicación para
  después de ver la maqueta.

### 4.3 Maqueta animada v1

- **Archivo:** `50_documentacion/andamios/20260926_maqueta_animacion_risograph.html` (fuera de git).
- **Categoría:** Interacción y JS.
- **Qué se hizo:** canvas con cuatro pasadas de tinta (café, naranjo, azul,
  morado) compuestas en multiplicación, trama de puntos por tinta con ángulo
  propio, desregistro fijo de 1 a 3 px por semilla, grano de papel y motas.
  Seis escenas de 5 s con continuidad en los seis cortes y en el bucle. Texto en
  HTML fuera del canvas, lista para lectores de pantalla, botón de pausa con
  barra espaciadora, versión fija con `prefers-reduced-motion` y parámetro
  `?t=` para revisar un cuadro fijo.
- **Ajustes tras la revisión cuadro a cuadro:** reserva del naranjo bajo el
  punto azul; trazos de largo cero en el primer cuadro de las escenas 3 y 5;
  siluetas separadas para que el gráfico de la escena 6 no tape a la central.
- **Verificación:** unos 60 cuadros renderizados en Chromium sin errores de
  JavaScript; sin desplazamiento horizontal a 375 px.
- **Desvío del guion:** para que el bucle no tenga corte, el globo nace entre
  el segundo 29 y el 0, de modo que la primera reproducción parte con el globo a
  medio tamaño.
- **Estado:** el titular la juzgó «bastante mejor» y difirió la parte creativa.

### 4.4 Integración del prototipo «Portafolio de Proyectos» (repo hermano)

- **Repo:** `slep_estado_proyectos_monitoreo` (remoto `tomgc/slep_estado_area_monitoreo`).
- **Categoría:** Arquitectura del repositorio.
- **Qué se hizo:** encargo autónomo que trajo la rama
  `claude/serene-galileo-u9wu6w` (siete commits, 126 rutas agregadas) y la
  fusionó a `main` local (merge `3b61b9f`), con el log `f5429b6` y la
  reparación `423f7d5`. Sin push.
- **Verificación (fuente: log de la integración):** 18 pruebas del portafolio
  y 10 del orquestador aprobadas; cinco invariantes en PASA; veredicto de FASE
  R «APROBADO CON ADVERTENCIAS». El titular confirmó D-01 y D-02.
- **Registro detallado de ejecución:** `slep_estado_proyectos_monitoreo/50_documentacion/andamios/logs/20261007_integracion_portafolio_log.md`.

### 4.5 Revisión del prototipo y decisiones D1 a D6

- **Categoría:** Documentación.
- **Qué se hizo:** revisión en Chromium (tres vistas y 390 px) y lectura de
  `20261002_propuesta_portafolio.md`. Aprobado por el titular: D1 solo la
  cartera `slep_*`; D2 reemplazar el paso 36 tras paridad; D3 sin perfiles (un
  solo perfil completo, repo privado con Access); D4 lector tolerante; D5
  Panorama por defecto; D6 nombre «Portafolio de Proyectos».
- **Hallazgos para la etapa de diseño:** semáforo verde y naranjo para estados
  (prohibido por la convención del Área), distintivo «Demo» amarillo, desborde
  a 390 px (680 px de ancho), señal «posible abandono» visible sin modo
  presentación y la vista Mapa de poco valor para jefaturas.

### 4.6 Decisión de fusión y plan aprobado

- **Archivo:** `50_documentacion/andamios/20261007_plan_fusion_slep_area_monitoreo.md` (fuera de git).
- **Categoría:** Arquitectura del repositorio.
- **Qué se hizo:** el titular decidió crear `slep_area_monitoreo`, privado,
  que absorbe los tres meta proyectos; publicación por subida directa con
  `wrangler` y Cloudflare Access, copiada del modelo existente. Aprobó DF1 a
  DF6: subcarpetas por producto en la importación, desactivar ya el GitHub Pages
  de la cartera, `*.pages.dev`, Project nuevo «Área de Monitoreo», indicadores
  sin publicar hasta revisión, y Rama B (datos fuera del repo).

## 5. Backlog acumulativo

Seis entradas nuevas en `50_documentacion/activa/backlog_acumulativo.md`
(bloque `BACKLOG_ENTRADAS`). La tabla de clasificación temática declara una
población de 39 entradas frente a 138 en el archivo antes de este cierre, de
modo que el recuento temático viaja como `diferido`.

## 6. Bugs de la sesión

No hubo bugs de código: ningún archivo de `docs/` ni de `30_procesamiento/` se
modificó.

## 7. Aprendizajes y restricciones descubiertas

1. **El shell de la estación no borra archivos, y git escribe candados.**
   `git status` y `git fetch` crean `.git/index.lock` y
   `.git/objects/maintenance.lock`, que ese shell no puede borrar. Regla: desde
   ese shell, git solo con `--no-optional-locks` y nunca `fetch`; el candado lo
   mide `/apertura`. Ejemplo: E7.
2. **Un encargo que se deposita en el árbol cambia el árbol que describe.** Las
   premisas de `git status` se escriben excluyendo el propio encargo, o se miden
   después de depositarlo. Ejemplo: E9.
3. **Un worktree no trae la librería de renv.** Toda prueba prescrita fuera de
   la raíz declara `RENV_PATHS_LIBRARY`. Ejemplo: E10.
4. **La calibración de un filtro de privacidad no lleva el literal que el
   filtro busca**, porque el log transcribe el comando. El caso plantado se
   construye en tiempo de ejecución. Ejemplo: E11.
5. **El mensaje de lanzamiento de un encargo nunca lleva `/effort`**
   (instrucción del titular; prevalece sobre la regla 4 de §2.12 del
   instrumento de encargos v1.6). Ejemplo: E8.
6. **`date +%F` en el shell de la estación devuelve la fecha UTC.** La fecha de
   cierre se mide con `TZ=America/Santiago date +%F`. Ejemplo: E5.

## 8. Decisiones de diseño

| Decisión | Alternativas | Justificación | Implicancia |
|---|---|---|---|
| Fusionar los tres meta proyectos en un repo nuevo y privado `slep_area_monitoreo` | Anfitrión `slep_monitoreo`; mantenerlos separados | Un repo nuevo nace privado: lo ya público no se despublica al cambiar la visibilidad | `slep_monitoreo` se cierra como proyecto activo tras la fusión y queda como redirección |
| Publicar en Cloudflare Pages con Access, copiando el modelo de `slep_reporte_emergencia` y `slep_servicio_educativo_regional` | Repo privado que publica en uno público; GitHub Pages pagado | El modelo ya está ejercido en la cartera; el artefacto no pasa por git | El sitio cambia de URL; GitHub Pages de `slep_monitoreo` queda como redirección |
| Importar cada repo en su subcarpeta (DF1) | Reestructurar a una sola numeración de inmediato | Fusión y reestructuración son dos cambios; juntos ocultan el origen de un error | La reestructuración es una sesión propia, con el protocolo §4.2 |
| No hacer push de la cartera | Push a `main` público | El repo es público y su Pages publicaba la cartera real | Sus commits locales viajan por `git subtree` desde la carpeta local |
| Maqueta animada: el globo nace entre el segundo 29 y el 0 | Globo completo en t=0 con corte en el bucle | El guion pide bucle sin corte | La primera reproducción parte con el globo a medio tamaño |

Decisión de peso arquitectónico: el plan de fusión se copia como primera
decisión del repo nuevo (no se crea archivo en `decisiones/` de este repo,
que se fusiona).

## 9. Constantes y parámetros

Sin cambios en código; las vigentes del sitio viven en `docs/formacion.css` y
`docs/colors_and_type.css`. Constantes decididas en la sesión que aún no viven
en producción (viven en la maqueta animada):

| Constante | Valor | Dónde vive | Motivo |
|---|---|---|---|
| `DURACION_ESCENA` | 5 s | Maqueta animada | Guion aprobado |
| `TOTAL` | 30 s | Maqueta animada | Guion aprobado |
| `DESREGISTRO_MIN` / `_MAX` | 1 / 3 px | Maqueta animada | Guion aprobado |
| `SEMILLA` | 19 | Maqueta animada | Dibujo determinista |
| `ANGULO_TRAMA` | café 0°, naranjo 45°, azul 15°, morado 75° | Maqueta animada | Un tambor por tinta |
| `CELDA_TRAMA` | 6 px | Maqueta animada | Trama de puntos |
| `K_MESA` | 0,42 | Maqueta animada | Escala del gráfico en la mesa (escena 6) |

## 10. Arquitectura de archivos

El escáner se regenera en este cierre (el ejecutor lo corre como último acto).
Sin cambio estructural versionado. El gatillo 4bis sigue encendido (no existe
`50_ordenacion_repositorio.md`) y el 4ter sigue bloqueado (no existe
`10_utils/`); ambos quedan absorbidos por la fusión (P17).

## 11. Pendientes y ruta sugerida

### 11.1 Inventario

**P1 · Elementos de la sección Formación.** Sin cambios respecto de v18: el
veredicto del titular sobre la maqueta del elemento 3 sigue pendiente. Criterio
de éxito: maqueta aprobada o descartada nombrando el criterio del §9.

**P2 · Movimientos del diagnóstico de ordenación.** Queda absorbido por la
fusión (P17, DF1): no se ejecuta en este repo.

**P4 a P12** sin cambios respecto de v18.

**P13 · Animación risograph.** Guion aprobado y maqueta v1 entregada; diferido
por el titular («dejemos esa parte creativa para más adelante»). Criterio de
éxito siguiente: veredicto en navegador (aprobada, ajustes por escena o
descartada con el criterio que falla) y decisión de ubicación, que fija también
el papel (`#F5F2EF` frente al `#FFF6E0` del sitio).

**P14 · Microcopia de la maqueta del elemento 3.** Sin cambios.

**P15 · Guarda de locale sin punto de arranque.** Absorbido por la fusión: la
guarda se instala en el repo nuevo.

**P16 · Microcopia de la maqueta animada (nuevo).** Tipo: documentación. Las
etiquetas accesibles del botón, «Pausar animación» y «Reanudar animación».
Criterio de éxito: aprobadas o reemplazadas.

**P17 · Fusión en `slep_area_monitoreo` (nuevo).** Tipo: arquitectura.
Contexto: §4.6 y el plan aprobado. Impacto: alto (los tres meta proyectos).
Dependencias: DF2 (desactivar el Pages de la cartera, tarea del titular en
GitHub); cerrar `slep_estado_proyectos_monitoreo` con su propio traspaso (F1);
crear el repo privado (F2). Complejidad: alta. Precauciones: Museo Sans no se
versiona (fuente comercial); el panel de indicadores maneja datos sensibles
(Rama B); `git subtree` desde las carpetas locales, para que viajen los commits
sin push de la cartera. Enfoque: sesión NEW PROJECT del repo nuevo con F3 como
encargo. Criterio de éxito: F3 terminada con la historia de los tres repos
visible por `git log -- <carpeta>` y sus pruebas en verde.

**P18 · Enmienda del instrumento de encargos (nuevo).** Tipo: gobernanza, en
`herramientas_dev` (sesión BIBLIOTECA). La regla 4 de §2.12 y el ítem 20 de la
checklist 2.10 de `encargo_autonomo_claude_code_v1.md` exigen `/effort` en el
mensaje de entrega, contra la instrucción del titular. Criterio de éxito:
instrumento enmendado y repropagado.

**P19 · Propuesta de dashboard en la raíz del repo (nuevo).** Tipo:
documentación. El titular dejó `20261007_propuesta_dashboard/` (exportación del
2026-06-15, con `site/` y fuentes Museo Sans) en la raíz del repo; antes del
cierre se traslada a `50_documentacion/andamios/`, ignorada por git. Falta saber si sigue vigente o la reemplaza el prototipo de
la cartera. Criterio de éxito: decisión del titular registrada en el repo nuevo.

**P20 · Museo Sans versionada en un repo público (nuevo).** Tipo: gobernanza.
`docs/fonts/MuseoSans_300.otf`, `_500.otf` y `_700.otf` están en el índice de git
(fuente: `git ls-files docs/fonts`, 3 archivos), y Museo Sans es una fuente
comercial cuya redistribución `slep_reporte_emergencia` ya retiró de su
historial. Criterio de éxito: decisión del titular sobre retirarla del sitio
público y de la historia, resuelta dentro de la fusión (P17).

**P21 · Expediente de encargos (nuevo).** Tipo: gobernanza. POLITICA 5.9 §1.3.2
y el instrumento de encargos v1.7 mueven los encargos a
`50_documentacion/encargos/`; el encargo de esta sesión nació en `andamios/` del
repo de la cartera. Criterio de éxito: el repo nuevo nace con `encargos/` y
migra el legado de los tres repos según la regla 1.3.2.

### 11.2 Evaluación de deuda técnica

Sin cambios en código. Zona frágil de proceso: los artefactos de `andamios/`
no viajan por git, y esta sesión produjo tres que el repo nuevo necesitará (la
maqueta animada, el plan de fusión y el registro de errores).

### 11.3 Auditoría de cierre (política 5.6)

| # | Pregunta | Respuesta |
|---|---|---|
| 2 | ¿El pipeline corre de cero sin intervención manual? | No medido: la sesión no tocó `30_procesamiento/` |
| 5 | ¿Cada transformación crítica tiene check de validación? | No aplica: sin transformaciones de datos |
| 6 | ¿Outputs reproducibles e idempotentes? | Sí; el sitio no cambió. La maqueta animada es determinista por semilla |
| 7 | ¿Decisiones metodológicas como constantes nombradas? | Sí en la maqueta (§9) |
| 8 | ¿Nombres sin tildes, ñ ni espacios? | Sí en lo generado; la carpeta del titular trae `LÉEME-DESPLIEGUE.md`, fuera de git y en `andamios/` |
| 9 | ¿La guarda `asegurar_locale_utf8()` está instalada? | No: no existe `10_utils/`. Pasa al repo nuevo (P15, P17) |

### 11.4 Salida de la compuerta de dudas

| # | supuesto | predicado | medicion |
|---|---|---|---|
| D1 | El candado huérfano del `fetch` no estorba | `.git/objects/maintenance.lock` ya no existe | `ls -la /Users/tomgc/Projects/slep_monitoreo/.git/objects/maintenance.lock` |
| D2 | El GitHub Pages de la cartera quedó desactivado (DF2) | La API de Pages del repo responde 404 | `gh api repos/tomgc/slep_estado_area_monitoreo/pages` |
| D3 | `slep_monitoreo` es público y publica por GitHub Pages desde `main/docs` | La API de Pages del repo responde con `source.path` = `/docs` | `gh api repos/tomgc/slep_monitoreo/pages --jq .source` |
| D4 | La maqueta animada se ve igual fuera de Chromium | En Safari y Firefox los seis cortes y el bucle se ven sin saltos | Revisión del titular con `?t=4.9`, `?t=9.95`, `?t=14.8`, `?t=19.99`, `?t=24.99` y `?t=29.99` |
| D5 | `git subtree` desde la carpeta local trae los commits sin push de la cartera | `git log --oneline -- cartera/` en el repo nuevo lista `423f7d5`, `f5429b6` y `3b61b9f` | Ese comando, en F3 |

Ninguna se cierra en sesión: ninguna esconde una operación irreversible ni una
cifra publicada. D1 quedó resuelta antes del cierre: Claude Code eliminó el
candado en el mismo paso que hizo el commit `f57bafd`.

### 11.5 Ruta sugerida para la próxima sesión

**Prioridad 1 · P17, F3 de la fusión.** En una sesión NEW PROJECT de
`slep_area_monitoreo`, con DF2 y F1 y F2 hechas. Criterio de éxito: el de P17.

**Conviene diferir:** P1, P4 a P14 y P16 (se retoman en el repo nuevo), P18
(sesión BIBLIOTECA de `herramientas_dev`), P19 (después de F3).

## 12. Instrucciones específicas para la próxima sesión

- ⚠️ **NO** emitir un encargo sobre un pendiente heredado sin medir antes su
  estado actual en disco y en git.
- ⚠️ **NO** incluir en un encargo copias, movimientos ni descargas de archivos:
  el traslado es del equipo.
- ⚠️ **NO** entregar copias de POLITICA ni SETTINGS.
- ⚠️ **NO** escribir en una maqueta texto visible que no esté literal en el
  documento de contenido o el guion aprobado.
- ⚠️ **NO** usar verde ni rojo en ninguna escala o estado; el extremo alto va en
  azul `#0062A0`.
- ⚠️ **NO** poner `/effort` en el mensaje de lanzamiento de un encargo.
- ⚠️ **NO** correr git desde el shell de la estación sin `--no-optional-locks`,
  ni `git fetch` desde ese shell.
- ⚠️ **NO** afirmar plazos ni fechas que el titular no fijó.
- ✅ **ANTES** de citar una versión de gobernanza, transcribir su encabezado
  leído en el mismo turno.
- ✅ **ANTES** de fijar un conteo de `git status` en un encargo, descontar el
  propio encargo que se depositará en el árbol.
- ✅ **ANTES** de prescribir R fuera de la raíz del repo (worktree), declarar
  `RENV_PATHS_LIBRARY`.
- ✅ **ANTES** de calibrar un filtro de privacidad, construir el caso plantado en
  tiempo de ejecución, sin el literal en el comando.
- ✅ **ANTES** de declarar `fecha_cierre`, medirla con `TZ=America/Santiago date +%F`.
- 🔒 Museo Sans no entra a ningún repo nuevo ni a ningún commit nuevo (fuente comercial); `docs/fonts/` de este repo ya la trae versionada (P20).
- 🔒 La rama `wip/atlas_tablero_v3` es la única copia del tablero.
- 🔒 Ningún `--force`, `reset --hard` ni tag sin autorización explícita.
- 🔒 Nunca `git add -A` ni `git add -f`; staging selectivo siempre.
- 🔒 Ninguna cadena visible en mayúsculas sostenidas.
- 🔒 El sitio no nombra establecimientos, personas ni identificadores, y no
  publica código.
- 🔒 No se hace push de `slep_estado_proyectos_monitoreo`: sus commits viajan
  por `git subtree`.

## 13. Fragmentos de código de referencia

Sin patrones nuevos en producción. La maqueta animada introduce un patrón
reutilizable: una capa de canvas por tinta, compuestas en `multiply` con
desregistro fijo, trama por `createPattern` con ángulo por tinta, y la función
`reservar()` (borrado `destination-out`) para el papel que queda sin tinta. Su
código de referencia es el propio archivo de la maqueta.

## 14. Reapertura

**Mensaje de apertura pre-armado:**

```
Tipo NEW PROJECT (migración por fusión). El protocolo (POLITICA_PROYECTO.md y
SETTINGS_Y_PROMPTS_OPERACIONALES.md) vive en la knowledge base del Project; al
cierre de la sesión 19 de slep_monitoreo el kit declaraba «Versión 5.9 — vigente»
y «Versión 39» (la knowledge base seguía en 5.8 y 38). Verifica que la knowledge
base esté al día con el kit y transcribe sus encabezados.

Esta es la primera sesión de slep_area_monitoreo, el repo nuevo y privado que
absorbe tres meta proyectos del Área: slep_monitoreo (sitio institucional),
slep_estado_proyectos_monitoreo (cartera y Portafolio de Proyectos) y
slep_dashboard_personal_monitoreo (indicadores). Adjunto el traspaso v19 de
slep_monitoreo, que es el antecedente, y el plan de fusión aprobado.

Lo decidido en la sesión 19:
1. Repo nuevo y privado; cada repo entra con git subtree en su subcarpeta
   (DF1), con historia completa y sin reestructurar.
2. Publicación por subida directa con wrangler y Cloudflare Access, copiando el
   modelo de slep_reporte_emergencia y slep_servicio_educativo_regional: sitio
   público en un proyecto de Pages, portafolio tras Access en otro, vistas
   previas también tras Access, versión de wrangler fijada.
3. El panel de indicadores maneja datos sensibles: Rama B y sin publicar hasta
   revisar qué muestra (DF5, DF6).
4. La cartera tiene commits locales sin push (merge 3b61b9f del prototipo,
   log f5429b6 y reparación 423f7d5): viajan por subtree desde la carpeta local.

Estado: sin bugs activos. Hechos del titular antes de abrir: GitHub Pages de la
cartera desactivado (DF2), cierre de slep_estado_proyectos_monitoreo (F1) y repo
privado tomgc/slep_area_monitoreo creado (F2).

Foco propuesto: F3, importar los tres repos con git subtree mediante un encargo
a Claude Code.
```

**Documentos para la próxima sesión:**

1. *Protocolo en knowledge base (no se adjuntan; verificar que estén al día):*
   `POLITICA_PROYECTO.md` (5.9), `SETTINGS_Y_PROMPTS_OPERACIONALES.md` (39),
   `encargo_autonomo_claude_code_v1.md` (v1.7, con expediente de encargo).
2. *Opcionales según el foco:* `CLAUDE.md` de los tres repos.
3. *Específicos de la sesión (se adjuntan):*
   - `traspaso_cierre_v19.md` (este)
   - el eco completo del cierre que imprime Claude Code
   - `50_documentacion/andamios/20261007_plan_fusion_slep_area_monitoreo.md`
   - el traspaso de cierre de `slep_estado_proyectos_monitoreo` que produzca F1
   - `slep_estado_proyectos_monitoreo/50_documentacion/andamios/logs/20261007_integracion_portafolio_log.md`

**Nota final:** si algún archivo listado cambió entre sesiones, adjuntar la
versión más reciente y avisarlo en el mensaje de apertura. Los archivos de
`andamios/` no viajan por git: la maqueta animada, el plan y el registro de
errores se llevan a mano si la sesión se abre en otra estación.

## 15. Errores del asistente

E5 y E6 se cometieron en la sesión 18 y se detectaron en el eco de su cierre;
el titular pidió registrarlos aquí. Se corrigen con la entrada nueva del
backlog, sin reescribir las anteriores.

### E5 · Fecha de cierre declarada sin medirla

| Campo | Contenido |
|---|---|
| `momento` | Sesión 18, redacción del paquete de cierre v18 (`fecha_cierre`) y del traspaso v18 §1 |
| `disparador` | Usuario lo corrigió (detectado en el eco del cierre v18 y trasladado a la apertura de la sesión 19) |
| `que_paso` | El paquete declaró `fecha_cierre: 2026-08-05` cuando la fecha real era 2026-09-26, y en vez de medirla la dejó como duda D1 |
| `regla_violada` | userPreferences y SETTINGS §1.2.6, marcador de fuente (premisa de hecho sin comando del mismo turno); SETTINGS §2.1, compuerta de dudas (una duda medible con un comando se cierra antes de consumar) |
| `causa_raiz` | La fecha se heredó del nombre de los archivos de la sesión y del traspaso anterior en vez de leerse del reloj; registrarla como duda se sintió equivalente a verificarla |
| `salvaguarda_presente` | Más de uno: userPreferences y SETTINGS |
| `patron` | PAT-01, fecha de cierre heredada y no medida |
| `gatillo_observable` | cifras-datos: `fecha_cierre` escrita sin `date` ejecutado en la sesión |
| `intentos_previos` | 0 |
| `costo` | Fecha falsa en el traspaso v18, en `ESTADO.md` (`ultima_actividad`, `insumos_verificados`) y en el encabezado de la sesión 18 del backlog; una entrada correctiva en el cierre v19 |

### E6 · Modelo de la sesión 18 no declarado

| Campo | Contenido |
|---|---|
| `momento` | Sesión 18, redacción del traspaso v18 y del paquete de cierre |
| `disparador` | Usuario lo corrigió (detectado en el eco del cierre v18) |
| `que_paso` | El traspaso no declaró el modelo de la sesión (Claude Opus 5.5) y el backlog registró la sesión 18 como «No registrado» |
| `regla_violada` | SETTINGS §2.2.5, resumen estadístico por sesión con columna modelo |
| `causa_raiz` | El campo lo compone el ejecutor desde el traspaso, y el redactor no lo puso en ninguna sección que el ejecutor lee |
| `salvaguarda_presente` | SETTINGS |
| `patron` | PAT-07, columna modelo exigida por §2.2.5 no propagada al traspaso |
| `gatillo_observable` | restriccion-no-propagada: traspaso sin modelo de la sesión en §1 |
| `intentos_previos` | 0 |
| `costo` | Una fila del resumen estadístico y un encabezado del detalle cronológico con «No registrado»; una entrada correctiva en el cierre v19 |

### E7 · Candados de git huérfanos dejados por comandos del asistente

| Campo | Contenido |
|---|---|
| `momento` | Sesión 19, apertura: 0bis medido a mano desde el shell de la estación (`git fetch`, `git status`) |
| `disparador` | Usuario lo señaló sin nombrarlo error (Claude Code encontró el `index.lock` huérfano y lo eliminó) |
| `que_paso` | `git status` y `git fetch` crearon `.git/index.lock` y `.git/objects/maintenance.lock`, que ese shell no puede borrar; se ignoraron las dos advertencias `unable to unlink` y el acuse atribuyó el bloqueo a la estación |
| `regla_violada` | SETTINGS §1.2.6, «Ningún comando asume el entorno»; descripción de la herramienta: el shell de la estación no puede borrar archivos |
| `causa_raiz` | Se trató la medición del candado como lectura pura sin considerar que `status` y `fetch` escriben en `.git/`, y la advertencia se leyó como ruido |
| `salvaguarda_presente` | SETTINGS |
| `patron` | PAT-03, comando de git que escribe en `.git/` desde un shell sin permiso de borrado |
| `gatillo_observable` | comando-entorno: salida con `unable to unlink '.git/...lock'` no tratada como falla |
| `intentos_previos` | 0 |
| `costo` | Un commit de `/apertura` bloqueado hasta la eliminación manual; `.git/objects/maintenance.lock` sigue en disco |

Salvaguarda adoptada en la sesión: desde el shell de la estación, git solo con `--no-optional-locks` y sin `fetch`; el candado lo mide `/apertura`.

### E8 · `/effort` incluido en el mensaje de lanzamiento del encargo

| Campo | Contenido |
|---|---|
| `momento` | Sesión 19, entrega del encargo `20261007_encargo_integrar_portafolio.md` (slep_estado_proyectos_monitoreo) |
| `disparador` | Usuario lo corrigió |
| `que_paso` | El bloque «→ Claude Code:» abrió con la línea `/effort xhigh`, que el titular no quiere en el mensaje de lanzamiento |
| `regla_violada` | Instrucción permanente del titular: el mensaje de lanzamiento de un encargo nunca lleva `/effort` |
| `causa_raiz` | Se aplicó la regla 4 de §2.12 de `encargo_autonomo_claude_code_v1.md` v1.6 (y el ítem 20 de su checklist), que exige el `/effort` en el mensaje de entrega, por encima de la instrucción del titular |
| `salvaguarda_presente` | Instrucción del titular; el instrumento v1.6 la contradice |
| `patron` | PAT-07, instrucción del titular no propagada al mensaje de lanzamiento |
| `gatillo_observable` | restriccion-no-propagada: bloque «→ Claude Code:» cuya primera línea es `/effort` |
| `intentos_previos` | 0 |
| `costo` | Un mensaje de lanzamiento corregido |

Pendiente derivado: enmendar en `herramientas_dev` la regla 4 de §2.12 y el ítem 20 de la checklist 2.10 de `encargo_autonomo_claude_code_v1.md` (sesión BIBLIOTECA).

### E9 · Premisa del árbol medida antes de depositar el propio encargo

| Campo | Contenido |
|---|---|
| `momento` | Sesión 19, redacción de `20261007_encargo_integrar_portafolio.md` (slep_estado_proyectos_monitoreo), §2 y regla de detención 2 |
| `disparador` | Asistente lo señaló espontáneamente, al leer la desviación D-01 del log de Claude Code |
| `que_paso` | El encargo fijó «exactamente cuatro líneas `??`» medidas antes de escribir el propio encargo en `andamios/`, que agregó la quinta; la regla 2 ordenaba detener la sesión por un estado que causó el redactor |
| `regla_violada` | `encargo_autonomo_claude_code_v1.md` §2.2 regla 3 y SETTINGS §1.2.6, marcador de fuente: la premisa debía valer en el estado en que el encargo se ejecuta |
| `causa_raiz` | El estado del árbol se midió en un momento y se usó como premisa después de un acto propio que lo cambiaba |
| `salvaguarda_presente` | Más de uno: SETTINGS y el instrumento de encargos |
| `patron` | PAT-12, encargo desfasado por su propio depósito en el árbol |
| `gatillo_observable` | encargos-premisas: encargo que se escribe dentro de `andamios/` y fija un conteo exacto de `git status` medido antes de escribirlo |
| `intentos_previos` | 0 |
| `costo` | Una desviación (D-01) que Claude Code resolvió fuera del contrato y que queda por confirmar |

### E10 · Pruebas prescritas en un worktree sin la librería de renv

| Campo | Contenido |
|---|---|
| `momento` | Sesión 19, mismo encargo, T2 paso 4 |
| `disparador` | Asistente lo señaló espontáneamente, al leer la desviación D-02 del log |
| `que_paso` | El encargo mandó correr las pruebas en un worktree temporal sin prever que `renv/library` está ignorado y no viaja al worktree; el primer intento falló por entorno y la regla 7 habría congelado la fusión |
| `regla_violada` | SETTINGS §1.2.6, «Ningún comando asume el entorno» |
| `causa_raiz` | No se inspeccionó el `.Rprofile` ni el `.gitignore` del repo antes de prescribir dónde correr R |
| `salvaguarda_presente` | SETTINGS |
| `patron` | PAT-03, worktree sin librería renv |
| `gatillo_observable` | comando-entorno: `Rscript` prescrito en un worktree de un repo con `renv/` sin declarar `RENV_PATHS_LIBRARY` |
| `intentos_previos` | 0 |
| `costo` | Un intento de pruebas fallido y una desviación (D-02) por confirmar |

### E11 · Literal de calibración incompatible con el control de privacidad del log

| Campo | Contenido |
|---|---|
| `momento` | Sesión 19, mismo encargo, T2 paso 6 |
| `disparador` | Asistente lo señaló espontáneamente, al leer el hallazgo R-16 del log |
| `que_paso` | La calibración del grep de privacidad usó un RUT ficticio literal; el log lo transcribió y reprobó su propio control de FASE L |
| `regla_violada` | `encargo_autonomo_claude_code_v1.md` §4.3 regla 1 y §2.8 paso 4: el log no lleva patrones de RUT |
| `causa_raiz` | El caso plantado se diseñó para el paso que calibra y no se contrastó con la regla del log que transcribe todo comando literal |
| `salvaguarda_presente` | El instrumento de encargos |
| `patron` | PAT-07, regla de privacidad del log no propagada al diseño de la calibración |
| `gatillo_observable` | restriccion-no-propagada: comando de calibración con un RUT literal en un encargo cuyo log transcribe comandos y se audita con ese mismo patrón |
| `intentos_previos` | 0 |
| `costo` | Un commit `fix(auditoria)` posterior al `docs(log)` (R-16, `423f7d5`) |

### E12 · Plazo inventado para la migración

| Campo | Contenido |
|---|---|
| `momento` | Sesión 19, evaluación del log de integración, recomendación sobre el push |
| `disparador` | Asistente lo señaló espontáneamente, al revisar su propio mensaje |
| `que_paso` | Se afirmó que los commits «en dos semanas» migran a `slep_area_monitoreo`; ningún plan ni decisión fija ese plazo |
| `regla_violada` | userPreferences y SETTINGS §1.2.6, marcador de fuente: premisa de hecho sin fuente |
| `causa_raiz` | Se agregó un plazo para dar concreción al argumento, sin que el titular lo hubiera fijado |
| `salvaguarda_presente` | Más de uno: userPreferences y SETTINGS |
| `patron` | PAT-01, plazo afirmado sin fuente |
| `gatillo_observable` | afirmar-sin-leer: fecha o plazo en una recomendación sin decisión ni documento que lo fije |
| `intentos_previos` | 0 |
| `costo` | Ninguno medible; afirmación retirada en el turno siguiente |

### E13 · Tarea mecánica sencilla delegada al titular pudiendo hacerla el asistente

| Campo | Contenido |
|---|---|
| `momento` | Sesión 19, preparación del cierre: traslado de `20261007_propuesta_dashboard/` desde la raíz del repo a `andamios/` |
| `disparador` | Usuario lo corrigió |
| `que_paso` | Se pidió dos veces al titular mover la carpeta, cuando el asistente podía hacerlo con `mv -n` en la carpeta conectada; no era crítico ni urgente, y el titular terminó pidiendo los comandos |
| `regla_violada` | Instrucción de operación de la sesión: una tarea mecánica dentro de una carpeta conectada la hace el asistente con su shell, sin entregar comandos al titular |
| `causa_raiz` | Se aplicó la regla «el traslado es del equipo» sin distinguir entre un traslado que exige un acto del titular y uno que el shell de la sesión ejecuta directo |
| `salvaguarda_presente` | Instrucciones de operación de la sesión |
| `patron` | PAT-05, traslado delegado al titular pudiendo ejecutarlo el asistente |
| `gatillo_observable` | otro: mensaje que pide al titular mover o renombrar archivos dentro de una carpeta conectada con shell disponible |
| `intentos_previos` | 0 |
| `costo` | Dos turnos del titular y un `/cierre` lanzado antes del traslado, que lo detuvo (bloqueo 2) |

### E14 · Paquete de cierre redactado contra una SETTINGS ya superada en el kit

| Campo | Contenido |
|---|---|
| `momento` | Sesión 19, redacción de `paquete_cierre_v19.md` (`settings_version`) |
| `disparador` | Asistente lo señaló al leer el eco del cierre (detención en F0.6) |
| `que_paso` | Se transcribió el encabezado de SETTINGS desde la copia de `activa/` (Versión 38) sin leer el kit, que desde el 2026-09-30 está en Versión 39 con POLITICA 5.9 |
| `regla_violada` | SETTINGS §2.1, cita de versión transcrita del encabezado vigente; aprendizaje 3 del traspaso v18 («la gobernanza puede cambiar dentro de una sesión») |
| `causa_raiz` | Se tomó la copia de `activa/` y la knowledge base como fuente vigente, cuando la fuente que gobierna es `gobernanza/` del kit, que `/cierre` sincroniza |
| `salvaguarda_presente` | Más de uno: SETTINGS y el traspaso v18 |
| `patron` | PAT-12, paquete desfasado por gobernanza que cambió durante la sesión |
| `gatillo_observable` | afirmar-sin-leer: `settings_version` transcrita sin leer `gobernanza/SETTINGS_Y_PROMPTS_OPERACIONALES.md` del kit en el mismo turno |
| `intentos_previos` | 0 |
| `costo` | Un `/cierre` detenido en F5 y un paquete reemitido |

### Fricciones

- friccion: acuse y respuestas por sobre el tope de forma en la apertura → el titular pidió decisiones «en una línea» y se ajustó.
