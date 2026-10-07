# Traspaso de cierre · v18

## 1. Identificación

| Campo | Valor |
|---|---|
| Proyecto | `slep_monitoreo`, sitio institucional del Área de Monitoreo, SLEP Costa Central |
| Versión | v18 |
| Fecha | 2026-08-05 |
| Sesión | 18. Cuarta sesión de la ruta de implementación de la sección Formación. Cerró el desfase de gobernanza en disco (P3), dejó el texto del elemento 3 aprobado y su maqueta en revisión, y abrió un pendiente nuevo: una animación en estilo risograph con su guion v1 |
| Entorno | Chat en el Project «Portafolio monitoreo» más Claude Code en la estación del titular |
| Archivos versionados modificados | `50_documentacion/activa/ESTADO.md`, `50_documentacion/andamios/logs/20260805_sincronizacion_gobernanza_log.md` (nuevo) |
| Archivos producidos fuera de git | `50_documentacion/andamios/20260805_maqueta_elemento3.html`, `20260805_errores_sesion18.md`, `20260805_pendiente_animacion_risograph.md`, `20260805_guion_animacion_risograph.md`, `20260805_encargo_sincronizacion_gobernanza.md` (todos en `andamios/`, ignorados por git salvo `logs/`) |
| Gobernanza leída en la knowledge base al cierre | `> **Versión 5.8 — vigente.**` y `> **Versión 38.**` (ver §7, aprendizaje 3) |
| `main` | `34c1e89`, previo al commit de cierre |

## 2. Resumen ejecutivo

La sesión se propuso dos cosas: sincronizar las copias de gobernanza en disco y
avanzar el elemento 3 de la sección Formación. La primera se resolvió sin commit
de gobernanza, porque ambos documentos están en `.gitignore:21-22` por decisión
de cartera y ya estaban en v5.6 y v16 en disco. El encargo que se emitió para
commitearlos tenía premisas falsas y Claude Code se detuvo correctamente; el
cierre real fue corregir `ESTADO.md`, que afirmaba un desfase inexistente. El
texto del elemento 3 quedó aprobado por el titular y se produjo su maqueta
desechable (v2, tras corregir en la misma sesión un verde en una escala de
tramos y texto visible no aprobado); el titular la está revisando en navegador.
Se agregó un pendiente nuevo, una animación explicativa en estilo risograph
dibujada con JavaScript, con las tintas ya decididas (paleta institucional) y un
guion v1 a la espera de aprobación. Cuatro errores del asistente quedaron
registrados. Durante la sesión la gobernanza avanzó a POLITICA 5.8 y SETTINGS
38, y al cierre las copias en disco ya coinciden con el kit (fuente: F0.0 del
instrumento de cierre). No hay bugs activos ni bloqueantes.

## 3. Estado al cierre

### Qué funciona

- El sitio publicado sigue igual que al cierre de la sesión 17: ningún archivo
  de `docs/` se tocó en esta sesión.
- Árbol limpio y sin stash al último reporte de Claude Code, con `main`
  adelantado en seis commits respecto de `origin/main` (tres del cierre de la
  sesión 17 y tres de esta sesión), que viajan con este cierre.
- Escáner corrido en la sesión por Claude Code: 16 carpetas, 123 archivos, sus
  cuatro salidas ignoradas por `.gitignore:34`.

### Qué no funciona

- Ninguna falla observable. El comportamiento conocido en pantalla angosta del
  recorrido (P4) sigue igual.

### Delta respecto de v17

- P3 (desfase v5.5/v15) cerrado: el disco ya estaba en v5.6/v16, y al cierre
  ya está en 5.8/38, idéntico al kit.
- Texto del elemento 3 aprobado por el titular; maqueta v2 producida.
- Pendiente nuevo P13: animación risograph, con guion v1.
- `ESTADO.md` corregido y `sesion_actual` en v18.

## 4. Registro detallado de cambios

### 4.1 Cierre de P3 sin commit de gobernanza

- **Archivos:** `50_documentacion/activa/ESTADO.md` (commits `663fb40` y
  `34c1e89`), `50_documentacion/andamios/logs/20260805_sincronizacion_gobernanza_log.md`
  (commit `da44ad6`).
- **Categoría:** Documentación.
- **Qué se hizo:** se emitió un encargo para commitear POLITICA y SETTINGS
  sincronizadas. Claude Code se detuvo en la Fase 2: ambos archivos están en
  `.gitignore:21-22` («Gobernanza: viven en la knowledge base del Project, no en
  el repositorio») y `git ls-files` no los sigue. Además ya declaraban
  `Versión 5.6 — vigente` y `Versión 16` en disco. Se optó por la vía 1: P3 se
  cierra sin commit y se corrige `ESTADO.md`, que afirmaba el desfase.
- **Por qué:** la regla de cartera es deliberada; versionar la gobernanza
  contradice que viva en la knowledge base.
- **Verificación:** diff de `ESTADO.md` mostrado antes de cada commit; árbol
  vacío y divergencia `0 6` tras el último commit; ningún push.
- **Tensión resuelta:** el invariante 5 del encargo prohibía editar fuera de la
  gobernanza y el log; editar `ESTADO.md` lo autorizó el titular con el encargo
  ya detenido. El log lo registra como FALLA autorizada.

### 4.2 Maqueta desechable del elemento 3

- **Archivo:** `50_documentacion/andamios/20260805_maqueta_elemento3.html`
  (v2, fuera de git).
- **Categoría:** Estructura de contenido.
- **Qué se hizo:** el titular aprobó el texto del elemento 3 (paso 1 del
  fundamento §9) y se produjo la maqueta (paso 2). Seis tramos navegables con
  mapa de hitos, controles anterior/siguiente y teclado; columna «En el método»
  que liga cada tramo con su paso del elemento 2; tabla de correspondencia
  completa siempre visible (legible proyectada); tramo 3 con la bifurcación B y
  la rama «No existe» marcada como recorrida; tramo 4 con el esquema del reporte
  ordenado por los tres ámbitos y ocho núcleos de las Bases Curriculares de la
  Educación Parvularia, con datos ficticios declarados.
- **Corrección v1 → v2 en la misma sesión:** la categoría «Logrado» estaba en
  oliva (verde) y pasó a azul institucional; seis glosas redactadas por el
  asistente se reemplazaron por oraciones literales del elemento 2; las dos
  últimas oraciones del tramo 6, que se habían movido a un bloque de cierre
  inexistente, volvieron a su lugar.
- **Herencia:** clases y medidas del elemento 2 en producción
  (`docs/formacion.css` líneas 203 a 570). Tokens aproximados en un `:root` que
  se retira en el traslado.
- **Verificación:** pendiente, revisión del titular en navegador.

### 4.3 Pendiente nuevo: animación explicativa en estilo risograph

- **Archivo:** `50_documentacion/andamios/20260805_pendiente_animacion_risograph.md`
  (v2, fuera de git).
- **Categoría:** Estructura de contenido.
- **Qué se hizo:** a pedido del titular, se registró una animación breve que
  explique gráficamente el trabajo del Área, dibujada cuadro a cuadro con
  JavaScript sobre canvas, en estilo de impresión risograph. Referencias
  entregadas: publicación de Kevin Ngo en X y su hilo en r/ClaudeAI (ambos
  bloqueados para el asistente), la guía de RISOTTO Studio sobre el proceso
  risograph (leída), y una conversación del titular con otro asistente sobre
  transiciones por motivo recurrente.
- **Decisión tomada en la sesión:** tintas = paleta institucional como tintas
  planas, no las tintas risograph clásicas.

### 4.4 Guion v1 de la animación

- **Archivo:** `50_documentacion/andamios/20260805_guion_animacion_risograph.md`
  (fuera de git).
- **Categoría:** Estructura de contenido.
- **Qué se hizo:** descripción escrita a aprobar antes de dibujar (fundamento
  §9, paso 1). Contenido esencial (el traspaso es su respaldo, porque el archivo
  no viaja por git):
  - **Qué cuenta:** el método del Área en seis escenas, en el orden de los seis
    pasos del elemento 2, en bucle: la respuesta abre una nueva pregunta.
  - **Hilo conductor propuesto:** el punto de trama. Nace como el punto de un
    signo de interrogación, se vuelve lente, se multiplica en fichas, se alinea,
    se ordena en un gráfico y vuelve a ser pregunta.
  - **Tintas:** azul `#0062A0` (principal y extremo alto de toda escala),
    morado `#4A2746` (contornos y texto), naranjo `#E88663` (la pregunta), café
    claro `#BCA493` (tramo medio), papel `#F5F2EF` con grano. Sin verde ni rojo.
    Una pasada por tinta, desregistro de uno a tres píxeles, sobreimpresión.
  - **Escenas (5 s cada una, 30 s en total):** 1 la pregunta sobre una mesa de
    trabajo; 2 la lente que enfoca quién, qué y cuándo sobre un patio escolar
    esquemático; 3 una estantería de fichas con una vacía que obliga a dibujar un
    instrumento propio; 4 fichas desregistradas que se alinean en una marca común
    (metáfora no nombrada del identificador de unión); 5 la trama se ordena en
    barras sin valores y un punto errado se corrige; 6 las siluetas leen el
    gráfico y nace una nueva pregunta, que es la de la escena 1.
  - **Textos en pantalla propuestos:** «Todo empieza con una pregunta» · «La
    traducimos a algo que se pueda observar» · «Buscamos dónde vive el dato. A
    veces hay que levantarlo» · «Revisamos que la fuente sirva, y que las piezas
    calcen» · «Ordenamos, calculamos y desconfiamos de los resultados» · «Lo
    leemos con quienes preguntaron. Y casi siempre, abre otra pregunta».
  - **Formato:** sin sonido, textos también en HTML, versión fija con
    `prefers-reduced-motion`, botón de pausa, un HTML con canvas y JavaScript
    vanilla sin dependencias, dibujo determinista por semilla.
- **Decisiones abiertas:** hilo conductor, duración y sonido, los seis textos, y
  ubicación en el sitio (si va a Formación, antes se enmienda el fundamento §7).

## 5. Backlog acumulativo

Cuatro entradas nuevas de la sesión 18 en
`50_documentacion/activa/backlog_acumulativo.md`, bloque `BACKLOG_ENTRADAS` de
este paquete. La tabla de clasificación temática declara una población de 39
entradas frente a 134 en el archivo, de modo que el recuento temático viaja como
`diferido`.

## 6. Bugs de la sesión

No hubo bugs de código en esta sesión: ningún archivo de `docs/` ni de
`30_procesamiento/` se modificó.

## 7. Aprendizajes y restricciones descubiertas

1. **La gobernanza no se versiona en este repositorio.** `POLITICA_PROYECTO.md` y
   `SETTINGS_Y_PROMPTS_OPERACIONALES.md` están en `.gitignore:21-22`.
   Sincronizarlas es reemplazo en disco y no deja commit. Ningún encargo las
   stagea ni espera verlas modificadas en `git status`. Principio: POLITICA 0.6,
   verificar antes de afirmar. Ejemplo: el encargo de sincronización de esta
   sesión.
2. **`andamios/` no viaja por git, salvo `andamios/logs/`.** Maquetas, guiones,
   pendientes y registros de errores quedan solo en la estación donde se
   guardaron. Lo que la sesión siguiente necesita de ellos va escrito en el
   traspaso o se adjunta al abrir. Ejemplo: el guion de la animación, respaldado
   en §4.4.
3. **La gobernanza puede cambiar dentro de una sesión.** Al abrir se leyó
   v5.6 y v16; al cerrar, la knowledge base declara `> **Versión 5.8 — vigente.**`
   y `> **Versión 38.**`, y el instrumento de cierre comprueba que las copias en
   disco son idénticas a las del kit. Toda cita de versión se transcribe del
   encabezado leído en el mismo turno que la usa, y el estado del disco se mide,
   no se hereda.
4. **Una maqueta prueba un texto aprobado; no lo redacta.** Toda cadena visible
   que no esté literal en `50_contenido_seccion_formacion.md` se lista como
   microcopia a aprobar. Ejemplo: error E4 de §15.
5. **Un pendiente heredado es una afirmación fechada, no un estado.** Antes de
   encargar su resolución se mide el estado actual. Ejemplo: error E1 de §15.

## 8. Decisiones de diseño

| Decisión | Alternativas | Justificación | Implicancia |
|---|---|---|---|
| P3 se cierra sin commit de gobernanza (vía 1) | Quitar la gobernanza del `.gitignore` y versionarla | La regla de cartera es deliberada y está documentada en el propio `.gitignore` | La sincronización futura es siempre manual en disco y sin rastro en git |
| Maqueta del elemento 3 con eje vertical | Banda horizontal con globo, como el elemento 2 | Repetir la banda haría leer el caso como copia del método y no como su aplicación | El traslado a producción no reutiliza la geometría del recorrido |
| Mapeo tramo a paso uno a uno (4→4, 5→5, 6→6) | Tramo 4 en el paso 5, porque este dice «ordenar» | El texto aprobado exige recorrer los mismos seis pasos; la alternativa deja el paso 4 sin tramo | Queda a la vista del titular en el panel de revisión de la maqueta |
| Tintas de la animación = paleta institucional | Tintas risograph clásicas (rosa fluorescente, amarillo, azul) | La pieza debe ser del Área y no una cita de estilo; además cumple la regla de no usar semáforo | El guion v1 y toda maqueta posterior usan solo esas cinco tintas |
| Los seis commits locales viajan con el cierre | Pushear los tres de la sesión 17 a mitad de sesión | Un solo push evita dos autorizaciones para el mismo tipo de contenido | `push_autorizado: si` en este paquete |

## 9. Constantes y parámetros

Sin cambios en código; las vigentes del sitio viven en `docs/formacion.css` y
`docs/colors_and_type.css`. Constantes decididas en la sesión que aún no viven
en código:

| Constante | Valor | Dónde aterrizará | Motivo |
|---|---|---|---|
| Tintas de la animación | `#0062A0`, `#4A2746`, `#E88663`, `#BCA493`, papel `#F5F2EF` | Futuro HTML de la animación | Decisión de tintas de la sesión |
| Duración de la animación (propuesta) | 30 s, seis escenas de 5 s | Ídem | Guion v1, pendiente de aprobación |
| Desregistro entre pasadas (propuesto) | 1 a 3 px | Ídem | Guion v1 |
| Columna «En el método» de la maqueta del elemento 3 | 300 px | Futuro bloque del elemento 3 en `formacion.css` | Maqueta v2 |

## 10. Arquitectura de archivos

Escáner corrido en la sesión por Claude Code: 16 carpetas y 123 archivos. El
ejecutor lo regenera como último acto antes del commit de cierre. Cambio
estructural versionado: solo el log nuevo en `andamios/logs/`. Los archivos
nuevos de `andamios/` están fuera de git (§7, aprendizaje 2). El gatillo 4bis
sigue encendido: `traspasos/*.md` cuenta 1, `archivo/` cuenta 16 y no existe
`50_ordenacion_repositorio.md`. El gatillo 4ter sigue bloqueado: no existe
`10_utils/`.

## 11. Pendientes y ruta sugerida

### 11.1 Inventario

**P1 · Elementos de la sección Formación (estado corregido)**
Tipo: funcionalidad. Estado real: texto de los elementos 1, 2, 3, 4 y 7
redactado en `50_contenido_seccion_formacion.md` v6; el 2 en producción; el 3
con texto aprobado en esta sesión y maqueta v2 en revisión del titular; el 4 en
revisión; el 6 sin redactar (etapa 3 del fundamento §8). Precaución: la
cabecera del documento de contenido todavía dice que el elemento 3 está en
revisión; la aprobación consta en este traspaso y se registra en el documento en
la próxima edición. Criterio de éxito siguiente: maqueta del elemento 3 aprobada
en navegador o descartada nombrando el criterio del §9 que falla.

**P2 · Decisión sobre los nueve movimientos del diagnóstico de ordenación**
Sin cambios respecto de v17, con una precondición nueva: el diagnóstico se hizo
contra v5.5/v15 y la gobernanza vigente ya es 5.8/38 (también en disco), de modo
que debe recontrastarse antes de ejecutar. Criterio de éxito: `vigentes=1` y el marcador
`50_ordenacion_repositorio.md` creado.

**P3 · Desfase de gobernanza en disco: cerrado.** El disco estaba en v5.6/v16 al
abrir la sesión y está en 5.8/38 al cierre, idéntico al kit (fuente: F0.0 del
instrumento de cierre, «normativos: al día»). Sale del inventario.

**P4 a P12** sin cambios respecto de v17: recorrido en pantalla angosta (P4),
`index.html` a primera persona plural (P5), barra de navegación por mandatos
(P6, depende de P5), renombre `ambito` → `desafio` en identificadores internos
(P7), 38 fuentes pendientes del catálogo, bloqueante de difusión (P8), destino
del tablero en `wip/atlas_tablero_v3` (P9), payload de capturas sobre 400 KB
(P10), entrada Simce 2025 en el portafolio (P11), peso Museo Sans 400 ausente
(P12).

**P13 · Animación explicativa en estilo risograph (nuevo)**
Tipo: funcionalidad. Contexto: §4.3 y §4.4. Impacto: medio a alto; puede ser la
pieza de entrada del sitio o de la sección. Dependencias: aprobación del guion
v1; ubicación en el sitio (si va a Formación, enmienda previa del fundamento
§7). Complejidad: alta (dibujo procedural, transiciones, textura de impresión,
accesibilidad). Precauciones: sin semáforo, sin establecimientos ni datos
reales, sin mayúsculas sostenidas, sin dependencias, dos intentos por pieza.
Enfoque: guion aprobado → maqueta animada que el asistente renderiza y revisa
cuadro a cuadro en su entorno antes de entregarla → revisión del titular en
navegador → producción. Criterio de éxito siguiente: guion aprobado con sus
cuatro decisiones resueltas.

**P14 · Microcopia de la maqueta del elemento 3 (nuevo)**
Tipo: documentación. Siete cadenas de interfaz que no están en el texto
aprobado: «Tramo n de 6», «Paso n del método», «En el método», «rama recorrida»,
«Cómo queda ordenado el reporte», la nota de datos ficticios y «El caso, tramo a
tramo, junto al método». Más las categorías del esquema (Logrado, En desarrollo,
Por iniciar), declaradas ficticias. Criterio de éxito: aprobadas o reemplazadas
por el titular, y agregadas al documento de contenido.

### 11.2 Evaluación de deuda técnica

Sin cambios respecto de v17 (dos unidades en `formacion.js`, geometría del
recorrido en tres números acoplados, `_archivo/` no versionado). Se agrega una
zona frágil de proceso: los artefactos de `andamios/` no viajan por git, y la
sesión 18 produjo cinco.

### 11.3 Auditoría de cierre (política 5.6)

| # | Pregunta | Respuesta |
|---|---|---|
| 5 | ¿Cada transformación crítica tiene check de validación? | No aplica en esta sesión: no hubo transformaciones de datos ni cambios en el sitio |
| 6 | ¿Los outputs son reproducibles e idempotentes? | Sí; el sitio no cambió |
| 7 | ¿Decisiones metodológicas como constantes nombradas? | Parcial: las constantes de la animación y de la maqueta solo viven en §9 hasta aterrizar en código |
| 8 | ¿Nombres sin tildes, ñ ni espacios? | Sí en todo lo generado en la sesión |
| 9 | ¿La guarda `asegurar_locale_utf8()` sigue instalada en el punto de arranque? | No: no existe `10_utils/` ni la guarda (0 archivos la contienen, fuente: reporte de Claude Code). Gatillo 4ter bloqueado por decisión pendiente del titular; se agrega como P15 |

**P15 · Guarda de locale sin punto de arranque.** Tipo: deuda de gobernanza.
Decisión del titular: dónde vive el punto de arranque en un proyecto sin
`10_utils/`, o si el invariante aplica a tres scripts sueltos. Criterio de
éxito: decisión registrada y, si aplica, guarda copiada desde
`herramientas_dev/plantillas/10_locale.R` y vista fallar.

### 11.4 Salida de la compuerta de dudas

| # | supuesto | predicado | medicion |
|---|---|---|---|
| D1 | La fecha de cierre 2026-08-05 coincide con la de la estación | `date +%F` en la estación devuelve 2026-08-05 | `date +%F` |
| D2 | Los cinco archivos de la sesión están guardados en `andamios/` | Los cinco nombres de §1 existen en `50_documentacion/andamios/` | `ls -1 /Users/tomgc/Projects/slep_monitoreo/50_documentacion/andamios/20260805_*` |
| D3 | La maqueta v2 del elemento 3 se comporta como se describe | En navegador, el bloque de bifurcación aparece solo en el tramo 3 y el esquema solo en el tramo 4, y las flechas del teclado recorren los seis tramos | Revisión del titular en navegador |
| D4 | `ventana_insumos: ./20_insumos` resuelve con contenido | I9 del verificador de cierre pasa | `Rscript "$HERRAMIENTAS_DEV_PATH/plantillas/95_verificar_cierre.R" /Users/tomgc/Projects/slep_monitoreo` |

Ninguna se cierra en sesión: ninguna esconde una operación irreversible ni una
cifra publicada.

### 11.5 Ruta sugerida para la próxima sesión

**Prioridad 1 · P13, guion y maqueta de la animación risograph.** Es el foco que
el titular pidió para una sesión fresca. Criterio de éxito: guion aprobado con
sus cuatro decisiones, y una primera maqueta animada revisada en navegador.

**Prioridad 2 · P1 y P14, veredicto de la maqueta del elemento 3.** Si el titular
ya la revisó, su veredicto entra al inicio (aprobación, ajuste o descarte
nombrando el criterio). Criterio de éxito: maqueta aprobada y microcopia
resuelta, que habilita el encargo de integración a producción.

**Conviene diferir:** P2 (sesión propia; recontrastar el diagnóstico contra 5.8
y 38 antes de ejecutar), P4, P5, P6, P7, P8, P9,
P10, P11, P12 y P15.

## 12. Instrucciones específicas para la próxima sesión

- ⚠️ **NO** emitir un encargo sobre un pendiente heredado sin medir antes su
  estado actual en disco y en git. E1 de esta sesión y cuatro errores de la
  sesión 17 tienen esa causa.
- ⚠️ **NO** incluir en un encargo copias, movimientos ni descargas de archivos:
  el traslado es del equipo.
- ⚠️ **NO** entregar copias de POLITICA ni SETTINGS: son estándar de cartera y
  viven en la knowledge base y en `herramientas_dev`.
- ⚠️ **NO** escribir en una maqueta texto visible que no esté literal en el
  documento de contenido; lo nuevo se lista como microcopia a aprobar.
- ⚠️ **NO** usar verde ni rojo en ninguna escala de tramos; el extremo alto va
  en azul `#0062A0`.
- ⚠️ **NO** dibujar un cuadro de la animación antes de que el guion esté
  aprobado.
- ✅ **ANTES** de citar una versión de gobernanza, transcribir su encabezado
  leído en el mismo turno.
- ✅ **ANTES** de dar por disponible un archivo de `andamios/`, confirmar que el
  titular lo adjuntó o que está en disco: no viaja por git.
- ✅ **ANTES** de entregar la maqueta de la animación, renderizar y revisar sus
  cuadros en el entorno del asistente.
- 🔒 La rama `wip/atlas_tablero_v3` es la única copia del tablero.
- 🔒 Ningún `--force`, `reset --hard` ni tag sin autorización explícita.
- 🔒 Nunca `git add -A` ni `git add -f`; staging selectivo siempre.
- 🔒 `docs/atlas_datos.js` no se toca sin verificar que la tabla sigue trayendo
  sus filas.
- 🔒 Ninguna cadena visible en mayúsculas sostenidas.
- 🔒 El sitio no nombra establecimientos, personas ni identificadores, y no
  publica código.

## 13. Fragmentos de código de referencia

Sin patrones nuevos en código de producción; los estables viven en `CLAUDE.md` y
en `docs/formacion.js`. La maqueta del elemento 3 introduce, para el futuro
traslado, un recorrido por tramos con mapa de hitos, columna de correspondencia
y tabla siempre visible; su código de referencia es el propio archivo de
maqueta.

## 14. Reapertura

**Mensaje de apertura pre-armado:**

```
Tipo CONTINUATION. El protocolo (POLITICA_PROYECTO.md y
SETTINGS_Y_PROMPTS_OPERACIONALES.md) vive en la knowledge base del Project; al
cierre de la sesión 18 declaraban «Versión 5.8 — vigente» y «Versión 38».
Verifica que sigan al día antes de empezar y transcribe sus encabezados.

Esta es la sesión 19 de slep_monitoreo, quinta de la ruta de implementación de
la sección Formación. Adjunto el traspaso v18, el eco del cierre y los archivos
de la sesión anterior que no viajan por git.

Qué pasó en la sesión 18, para que no dependas de leerlo entre líneas:

1. Gobernanza. El P3 de v17 decía que el disco tenía POLITICA v5.5 y SETTINGS
   v15. Era falso: ya estaban en v5.6 y v16. Además esos dos archivos están en
   .gitignore (líneas 21 y 22) por decisión de cartera: se sincronizan en disco
   y nunca se commitean. Un encargo que intentó commitearlos se detuvo solo. Se
   corrigió ESTADO.md. Durante la sesión la gobernanza avanzó a 5.8 y 38, y al
   cierre el disco ya coincidía con el kit: P3 quedó cerrado.

2. Elemento 3 de Formación (el caso de educación parvularia). Aprobé el texto
   tal como está en 50_contenido_seccion_formacion.md v6, líneas 420 a 566, aunque
   la cabecera de ese documento aún diga «en revisión». Se hizo la maqueta
   desechable v2 (andamios/20260805_maqueta_elemento3.html): eje vertical, seis
   tramos, correspondencia uno a uno con los seis pasos del elemento 2, bifurcación
   B en el tramo 3 y el esquema del reporte por ámbitos y núcleos de las Bases
   Curriculares en el tramo 4, con datos ficticios. Pendiente mío: el veredicto en
   navegador, siete cadenas de microcopia nueva y las categorías reales del
   reporte (hoy «Logrado / En desarrollo / Por iniciar», ficticias).

3. Animación risograph (pendiente nuevo P13, foco de esta sesión). Una animación
   breve, dibujada cuadro a cuadro con JavaScript sobre canvas, que explique lo
   que hace el Área con datos educativos, en estilo de impresión risograph.
   Referencias: la pieza de Kevin Ngo en X y su hilo en r/ClaudeAI (tú no puedes
   abrirlos), y la guía de RISOTTO Studio sobre el proceso risograph. Decidido:
   las tintas son la paleta institucional (azul #0062A0, morado #4A2746, naranjo
   #E88663, café claro #BCA493, papel #F5F2EF), no las tintas risograph clásicas.
   Hay un guion v1 (andamios/20260805_guion_animacion_risograph.md): seis escenas
   de cinco segundos, una por paso del método, en bucle, sin sonido, con el punto
   de trama como hilo conductor. Su contenido completo también está en el §4.4
   del traspaso. Falta que yo apruebe cuatro cosas: el hilo conductor, la
   duración y el sonido, los seis textos en pantalla y la ubicación en el sitio.

4. Errores. Cuatro errores del asistente quedaron en la §15 del traspaso: un
   encargo con premisas de git no medidas, copias de gobernanza emitidas desde el
   chat, verde en una escala de tramos y texto visible no aprobado en una maqueta.
   Las instrucciones ⚠️ de la §12 son su salvaguarda.

Estado: sin bugs activos, sin bloqueantes. Todo lo local se publica con este
cierre.

Foco propuesto: P13, aprobar el guion de la animación risograph y producir su
primera maqueta animada, revisada por ti cuadro a cuadro antes de mostrármela.
Si ya revisé la maqueta del elemento 3, parto por darte ese veredicto.
```

**Documentos para la próxima sesión:**

1. *Protocolo en knowledge base (no se adjuntan; verificar que estén al día):*
   `POLITICA_PROYECTO.md`, `SETTINGS_Y_PROMPTS_OPERACIONALES.md`.
2. *Opcionales según el foco:* `docs/colors_and_type.css` (tokens reales del
   sitio, que la maqueta del elemento 3 aproximó y que la animación debe usar).
3. *Específicos de la sesión (se adjuntan):*
   - `traspaso_cierre_v18.md`
   - el eco completo del cierre que imprime Claude Code
   - `50_documentacion/andamios/20260805_guion_animacion_risograph.md`
   - `50_documentacion/andamios/20260805_pendiente_animacion_risograph.md`
   - `50_documentacion/andamios/20260805_maqueta_elemento3.html`
   - `50_documentacion/activa/50_contenido_seccion_formacion.md`
   - `50_documentacion/activa/50_fundamento_seccion_formacion.md`

**Nota final:** si algún archivo listado cambió entre sesiones, adjuntar la
versión más reciente y avisarlo en el mensaje de apertura. Los tres archivos de
`andamios/` no viajan por git: si la sesión se abre en otra estación, hay que
llevarlos a mano.

## 15. Errores del asistente

### E1 · Encargo de sincronización con premisas de git no medidas

| Campo | Contenido |
|---|---|
| `momento` | Redacción de `20260805_encargo_sincronizacion_gobernanza.md` v1, Fases 0 a 2 |
| `disparador` | Usuario lo corrigió, tras la detención de Claude Code |
| `que_paso` | La Fase 2 ordenaba commitear dos archivos ignorados por git, sobre un desfase que ya no existía, y la Fase 0 esperaba verlos modificados |
| `regla_violada` | POLITICA 0.6 y userPreferences, marcador de fuente: premisa de encargo tomada del traspaso v17 §11.1 sin verificarla ni marcarla como hipótesis |
| `causa_raiz` | El pendiente heredado se leyó como estado vigente y no como afirmación fechada |
| `salvaguarda_presente` | Más de uno: POLITICA, userPreferences y la instrucción ⚠️ del traspaso v17 §12 |
| `patron` | PAT-01, sobre estado de ignorado y de sincronía en disco |
| `gatillo_observable` | estado-git: encargo que ordena stagear rutas sin `git check-ignore` ni `git ls-files` en la sesión |
| `intentos_previos` | 0 |
| `costo` | Un encargo ejecutado hasta su detención (cero commits), una ronda correctiva de tres commits |

### E2 · Copias de gobernanza emitidas y traslado ordenado en un encargo

| Campo | Contenido |
|---|---|
| `momento` | Primera entrega de la sesión y encargo v2 |
| `disparador` | Usuario lo corrigió |
| `que_paso` | Se entregaron POLITICA y SETTINGS desde el chat como tercera copia sin autoridad, y el encargo v2 ordenaba a Claude Code copiarlas desde `herramientas_dev` |
| `regla_violada` | userPreferences, Autonomía: las tareas mecánicas de traslado son del equipo; y no entregar archivos sin destino ni uso claro |
| `causa_raiz` | Se diseñó la solución antes de preguntar dónde vive la copia canónica y quién la reparte |
| `salvaguarda_presente` | userPreferences |
| `patron` | PAT-05, traslado de archivos asignado al asistente |
| `gatillo_observable` | entrega-sin-destino-o-nombre: archivo normativo de cartera entregado desde el chat |
| `intentos_previos` | 0 |
| `costo` | Dos archivos emitidos y retirados; un encargo v2 redactado y descartado sin ejecutar |

### E3 · Verde en el extremo alto de una escala de tramos

| Campo | Contenido |
|---|---|
| `momento` | Maqueta del elemento 3 v1, esquema del tramo 4 |
| `disparador` | Asistente lo señaló espontáneamente, al releer el estado del proyecto a pedido del titular |
| `que_paso` | La categoría «Logrado» se pintó en oliva dentro de una escala de tres tramos |
| `regla_violada` | Convención de diseño del Área: sin colores de semáforo en tramos; extremo alto en azul |
| `causa_raiz` | Se heredó el token `--olive` de `formacion.css` sin contrastarlo con la convención de paleta |
| `salvaguarda_presente` | Convención de diseño del Área |
| `patron` | PAT-07, convención de paleta no propagada a la maqueta |
| `gatillo_observable` | restriccion-no-propagada: escala ordinal con un verde en un extremo |
| `intentos_previos` | 0 |
| `costo` | Un artefacto rehecho (maqueta v2), compartido con E4 |

### E4 · Texto visible no aprobado en la maqueta

| Campo | Contenido |
|---|---|
| `momento` | Maqueta del elemento 3 v1 |
| `disparador` | Asistente lo señaló espontáneamente, en la misma relectura |
| `que_paso` | Se redactaron seis glosas nuevas y se movieron dos oraciones del tramo 6 a un bloque de cierre que no existe en el texto aprobado |
| `regla_violada` | Fundamento §9 (texto aprobado antes de maqueta) e instrucción ⚠️ del traspaso v17 §12 sobre traslado mecánico |
| `causa_raiz` | Se trató la maqueta como lugar de redacción y no como prueba de un texto aprobado |
| `salvaguarda_presente` | Más de uno: fundamento de la sección y traspaso v17 |
| `patron` | PAT-07, regla de traslado literal no propagada a la maqueta |
| `gatillo_observable` | restriccion-no-propagada: cadena visible en la maqueta que no aparece literal en el documento de contenido |
| `intentos_previos` | 0 |
| `costo` | El mismo artefacto rehecho que E3; siete cadenas de microcopia quedan por aprobar (P14) |
