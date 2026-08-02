# Traspaso de cierre — slep_monitoreo v13

> **Destino:** `50_documentacion/traspasos/traspaso_cierre_v13.md`
> **Protocolo:** `POLITICA_PROYECTO.md` v5.5 · `SETTINGS_Y_PROMPTS_OPERACIONALES.md` v15

---

## 1. Identificación

| Campo | Valor |
|---|---|
| Proyecto | `slep_monitoreo` |
| Versión del traspaso | v13 |
| Sesión | 13 |
| Fecha | 2026-08-01 |
| Modelo | Claude Opus 5 |
| Traspaso anterior | v12 (2026-07-31) |
| Entorno | macOS · Claude (chat) para planificación y autoría · Claude Code para ejecución en disco · Positron para R (no usado en esta sesión) |
| Raíz | `/Users/tomgc/Projects/slep_monitoreo` |

**Foco declarado al abrir:** correr el validador sobre el catálogo, versionar el trabajo de la sesión 12 y construir el tablero de dos mitades.

**Foco real al cerrar:** el validador corrió y el tablero se escribió, pero la sesión terminó con el titular suspendiendo la línea de trabajo completa para replantear la sección Formación desde su propósito.

**Archivos modificados:**

| Archivo | Estado al cierre |
|---|---|
| `docs/atlas.js` | Reescrito por completo, **sin commitear** (fuente: `git status --short docs/` → `M`) |
| `docs/atlas.css` | Reescrito por completo, **sin commitear** (fuente: idem) |
| `50_documentacion/andamios/20260731_maqueta_tablero.html` | Creado, no versionado (fuente: `estructura_actual.md` del 2026-08-01 09:16:36) |
| `docs/atlas_datos.js` | Sin cambios. Validado, no modificado |
| `docs/formacion.html` | Sin cambios en esta sesión |

---

## 2. Resumen ejecutivo

La sesión se propuso cerrar tres bloqueantes heredados y construir la representación nueva del atlas. Los bloqueantes se resolvieron: el validador canónico corrió sobre el catálogo de 9 instituciones y devolvió `exit=0`, confirmando las cifras que hasta ahora solo provenían de la transformación programática, y los cuatro archivos que el traspaso v12 daba por versionar resultaron estar ya commiteados en tres commits del cierre anterior, de modo que la premisa de la prioridad 2 era falsa y su encargo se canceló sin ejecutar. Sobre el foco de diseño, la sesión aplicó la corrección que el traspaso v12 había fijado tras su error E-04: en vez de entregar una representación terminada, entregó primero una maqueta desechable con tres variantes conmutables sobre el catálogo real, el titular aprobó la variante A, y recién entonces se escribió el código de producción, que reemplaza por completo `atlas.js` y `atlas.css` y pasa todas las verificaciones automáticas. El tablero nunca llegó a revisión visual. Antes de eso, el titular detuvo la línea de trabajo con un diagnóstico que ninguna de las tres representaciones descartadas había hecho visible: el problema no está en cómo se dibuja la sección Formación, sino en que nunca se definió para qué existe, cómo debe contar lo que cuenta y qué elementos la componen en qué orden. La sesión cierra con la sección suspendida, su código nuevo en el árbol de trabajo sin commitear, y una sesión siguiente dedicada íntegramente a planificar. El estado general es sano en lo técnico y replanteado en lo estratégico: no hay bugs activos, no hay bloqueantes, y el trabajo pendiente cambió de naturaleza.

---

## 3. Estado al cierre

### Qué funciona

| Componente | Evidencia de última ejecución exitosa |
|---|---|
| Catálogo `docs/atlas_datos.js` | `node 00_validar_atlas.js docs/atlas_datos.js` → `exit=0`, 5 avisos no bloqueantes (2026-08-01) |
| `docs/atlas.js` (tablero nuevo) | `node --check` → `exit=0`; cero declaraciones fuera de la IIFE; `setPointerCapture` ausente (2026-08-01) |
| `docs/formacion.js` (tabla filtrable) | `node --check` → `exit=0`; sin cambios desde v10 |
| `docs/app.js` (portafolio y lightbox) | `node --check` → `exit=0`; intocado |
| Orden de carga en `formacion.html` | `atlas_datos.js` (L160) → `formacion.js` (L161) → `atlas.js` (L162): los datos cargan antes de ambos consumidores |
| Escáner | Corrida del 2026-08-01 09:16:36, 16 carpetas y 97 archivos |

### Qué no funciona o queda sin verificar

- **El tablero no tiene verificación visual.** Todas sus comprobaciones son automáticas y sintácticas. Nadie lo ha visto renderizado, ni ha comprobado con eventos reales que el clic recíproco entre las dos caras funcione. El criterio de éxito que la propia sesión fijó quedó sin cumplir.
- **La sección Formación carece de fundamento declarado.** No es un defecto de código: es la ausencia de un documento de propósito, línea editorial e inventario de elementos. Es el hallazgo principal de la sesión.
- `formacion.html` conserva `role="application"` en `#atlasCeleste`, que describía el lienzo orbital y ya no describe lo que hay dentro (navegación por botones). No se corrigió porque tocar `formacion.html` no correspondía a esta sesión.
- `.fm-atlas-espera` y `.fm-atlas-foot` siguen huérfanas en `formacion.css` desde que el marcador «en desarrollo» fue reemplazado (deuda heredada de v12).

### Delta respecto de v12

v12 cerró con dos representaciones orbitales descartadas, cuatro archivos que creía sin commitear y un catálogo sin validar. v13 confirma que los archivos sí estaban commiteados, valida el catálogo, y produce una tercera representación siguiendo el proceso correcto (maqueta primero, aprobación, después código). El delta de fondo es otro: v12 atribuyó su fracaso a la metáfora visual elegida y v13 lo reatribuye a la ausencia de planificación de la sección. Ese cambio de diagnóstico es lo único de esta sesión que la siguiente no puede reconstruir por sí sola.

---

## 4. Registro detallado de cambios

### 4.1 Validación canónica del catálogo

- **Archivos:** `docs/atlas_datos.js` (leído, no modificado); `00_validar_atlas.js` (ejecutado).
- **Categoría temática:** Reproducibilidad y tooling. Backlog 95.
- **Qué se hizo:** se ejecutó el validador sobre el catálogo resultante del retiro de UNESCO · OECD, más un recuento programático independiente en el mismo turno.
- **Por qué:** la entrada 90 del backlog declaró explícitamente que sus cifras provenían de la transformación y no del validador, porque el clasificador de permisos de Claude Code cayó antes de ejecutarlo. Una cifra sin fuente canónica no es una cifra verificada, y el traspaso v12 la marcó como bloqueante.
- **Cómo se verificó:** `exit=0`. Recuento independiente coincidente: 9 instituciones, 25 bases, 50 datos, 124 relaciones, 6 ámbitos.
- **Avisos (5, no bloqueantes):** cuatro datos del MINEDUC con `desde` anterior al de su base (`rendimiento` 2002 vs 2004, `docentes` 2003 vs 2004, `establecimientos` 1992 vs 2004, `sned` 1996 vs 2008) y la colisión de `#FFC92E` con el color de interacción del atlas.
- **Dependencias afectadas:** ninguna. El archivo no cambió.

### 4.2 Maqueta desechable de tres variantes

- **Archivo:** `50_documentacion/andamios/20260731_maqueta_tablero.html` (26.3 KB, no versionado).
- **Categoría temática:** Layout y composición. Backlog 96.
- **Qué se hizo:** una página autónoma que lee `docs/atlas_datos.js` por ruta relativa y conmuta en caliente tres composiciones de la mitad izquierda: A (árbol de tres niveles y tarjetas), B (idéntica a A más trazo de curvas sobre una canaleta central) y C (mosaico con los 50 datos visibles a la vez).
- **Por qué:** el error E-04 de v12 fue entregar dos representaciones terminadas antes de acordar cómo se juzgarían. Una maqueta desechable cuesta un turno; una representación terminada costó media sesión, dos veces.
- **Cómo se verificó:** sintaxis del script inline validada con `new Function()` sobre el bloque extraído; el titular la abrió y eligió la variante A.
- **Tensión resuelta:** la maqueta usa los tokens del sitio pero no sus tipografías (las rutas de fuente son relativas a `docs/`), y se aceptó esa infidelidad porque lo que se estaba juzgando era composición y no tipografía.
- **Nota:** el archivo se creó inicialmente en `docs/` y el titular lo movió a `andamios/`. Ver §15, E-01.

### 4.3 Tablero de dos mitades enfrentadas

- **Archivos:** `docs/atlas.js` (477 líneas), `docs/atlas.css` (430 líneas). Ambos reescritos por completo.
- **Categoría temática:** Interacción y JS. Backlog 97.
- **Qué se hizo:** sustitución total del render orbital. Cara izquierda con el árbol institución → base → dato; cara derecha con una tarjeta por ámbito; seleccionar cualquier pieza atenúa el resto y destaca sus contrapartes en la otra cara, abriendo una ficha en línea cuyo formato varía por nivel. Los cruces declarados en `relaciones` son navegables desde la ficha del dato.
- **Por qué:** implementa la dirección fijada en la entrada 94 del backlog y la variante A aprobada por el titular.
- **Cómo se verificó:** `node --check` → `exit=0`; `grep -nE '^(var|let|const|function) '` sin resultados, o sea ninguna constante global nueva; `setPointerCapture` presente solo en el comentario de cabecera; guardia `.atlas[hidden]{display:none}` en `atlas.css:42`; los dos únicos `border-radius: 50%` aplican a elementos de tamaño fijo en píxeles.
- **Líneas clave:** L47-52 guardia de catálogo ausente; L80-110 índices `AMB_DE_RUTA` y `RUTAS_DE_AMB`; L226-300 fichas por nivel; L390-410 deselección con replegado del árbol.
- **Dependencias afectadas:** ninguna. `formacion.js`, `formacion.html` y `styles.css` sin tocar.
- **Estado:** en el árbol de trabajo, sin commitear, sin revisión visual, y con destino probable de descarte.

### 4.4 Suspensión de la sección Formación

- **Archivos:** ninguno. Decisión del titular.
- **Categoría temática:** Documentación. Backlog 98.
- **Qué se hizo:** se detuvo toda escritura de código sobre la sección y se acordó dedicar la sesión siguiente exclusivamente a planificarla.
- **Por qué:** tres representaciones descartadas en dos sesiones no son tres errores de diseño independientes, sino el mismo error repetido: no existe un documento que declare qué debe lograr la sección, cómo debe contarlo y qué elementos la componen, de modo que cada iteración se juzgaba por gusto y no contra un criterio.
- **Cómo se verificó:** no aplica; es una decisión, no un cambio de código.
- **Tensión resuelta:** el costo hundido del tablero recién escrito contra el costo de seguir iterando sin criterio. El titular resolvió a favor de detenerse, y es la resolución correcta.

---

## 5. Backlog acumulativo

Archivo canónico: `50_documentacion/activa/backlog_acumulativo.md`, actualizado en este cierre con las entradas **95-98** (total 94 → 98). Las entradas 1-94 y el delta previo se copiaron íntegros y sin renumerar; verificado programáticamente por contención de cadena, no por lectura (fuente: comparación del archivo previo contra el emitido, esta sesión). Categorías de las nuevas: Reproducibilidad y tooling ×1, Layout y composición ×1, Interacción y JS ×1, Documentación ×1. La tabla §3 no se recalcula.

---

## 6. Bugs de la sesión

**Ninguno.** Ningún bug de código se detectó ni se introdujo. Todo el código emitido pasó sus verificaciones automáticas a la primera, y el código nuevo no llegó a ejecutarse en navegador, de modo que la ausencia de bugs es una afirmación sobre lo verificado y no sobre lo probado: un bug de render en el tablero sería indetectable con las comprobaciones que esta sesión alcanzó a hacer.

---

## 7. Aprendizajes y restricciones descubiertas

**A-01 · Una premisa heredada de un traspaso es hipótesis, no hecho.**
La prioridad 1 de la ruta se construyó sobre «hay cuatro archivos sin commitear», que el traspaso v12 afirmaba y que era falso. El encargo la llevaba marcada como hipótesis con su comando de verificación, y por eso el fallo costó cero. *Regla:* toda premisa tomada del traspaso anterior sobre estado de repositorio entra al encargo con marcador de hipótesis y con una regla de cancelación explícita que la verifique antes de actuar. *Principio:* POLITICA 0.6 y el marcador de fuente de `userPreferences`. *Qué pasa si se viola:* el encargo ejecuta `git commit` sobre un índice vacío y falla, o peor, actúa sobre un estado que ya no existe.

**A-02 · Una maqueta desechable es más barata que una implementación, por un factor grande.**
La maqueta costó un turno y produjo una decisión firme. Las dos representaciones de la sesión 12 costaron media sesión cada una y produjeron dos descartes. *Regla:* cuando el criterio de aceptación es estético o de composición, el primer artefacto es siempre desechable y comparativo, nunca de producción. *Ejemplo de la sesión:* tres variantes conmutables sobre el mismo catálogo y la misma interacción, de modo que lo único variable fuese lo que se estaba juzgando.

**A-03 · Una maqueta valida la forma, no el fundamento, y confundirlas es el error caro.**
La maqueta hizo exactamente lo que prometía y aun así el trabajo se descartó, porque preguntaba «¿cuál de estas tres composiciones prefieres?» cuando la pregunta abierta era «¿debe existir esta pieza y para qué?». *Regla:* antes de ofrecer variantes de forma, verificar que exista un documento que declare el propósito de lo que se está formando; si no existe, ese documento es el entregable, no las variantes. *Principio:* es la generalización de la corrección de E-04 de v12, que se quedó a mitad de camino. *Qué pasa si se viola:* se producen decisiones bien tomadas sobre preguntas que no importaban.

**A-04 · El descarte reiterado de entregables es un síntoma de planificación ausente, no de ejecución deficiente.**
Tres descartes consecutivos sobre la misma pieza no se corrigen mejorando la pieza. *Regla:* al segundo descarte consecutivo de un mismo artefacto, detener la producción y proponer explícitamente una fase de planificación, en vez de ofrecer una tercera variante. *Qué pasa si se viola:* lo que ocurrió en esta sesión, donde el asistente ofreció la tercera variante y fue el titular quien tuvo que detener el ciclo.

---

## 8. Decisiones de diseño

**D-01 · Variante A (árbol y tarjetas) sobre B (puente) y C (mosaico).**
*Alternativas:* B añadía trazos de curva entre las contrapartes; C mostraba los 50 datos simultáneamente sin jerarquía intermedia.
*Justificación:* la jerarquía de tres niveles es lo que el contrato modela y lo que la tabla filtrable no muestra; C la perdía. El trazo de B compite con la única señal que importa, que es qué se enciende al otro lado.
*Implicancia:* queda registrada como decisión del titular, pero pierde vigencia si la planificación de la sección concluye que el atlas no va. Es una decisión sobre una pieza cuya existencia está en revisión.

**D-02 · Las utilidades compartidas no se extraen a `docs/atlas_util.js` todavía.**
*Alternativas:* extraer `esc`, `porId`, `plural` y `buscar` a un archivo propio que consuman `atlas.js` y `formacion.js`.
*Justificación:* la extracción real exige migrar también `formacion.js`, y no conviene tocar un componente que funciona dentro del commit que sustituye uno rechazado. Además, la política §1.4 exige duplicación real antes de migrar a utils, y `esc` duplicada entre dos archivos es precisamente esa duplicación: la condición ya se cumple, lo que falta es el momento oportuno.
*Implicancia:* pendiente P5 de esta sesión.

**D-03 · El traspaso registra el tablero aunque su destino probable sea el descarte.**
*Alternativas:* omitirlo por ser trabajo muerto.
*Justificación:* el backlog cuenta solicitudes distinguibles del titular, no artefactos sobrevivientes, y la próxima sesión necesita saber que ese código existe en el árbol de trabajo para decidir qué hacer con él.

---

## 9. Constantes y parámetros

Ninguna constante cambió de valor. Las del render nuevo son tokens de CSS declarados en `docs/atlas.css`: `--at-acento` (hereda de `--accent-active`) y `--at-atenuado` (`0.28`, opacidad de las piezas no seleccionadas). La fuente canónica de los tokens del sitio sigue siendo `docs/colors_and_type.css`; la del catálogo, `docs/atlas_datos.js`; la del esquema, `50_documentacion/activa/50_contrato_atlas_datos.md`.

---

## 10. Arquitectura de archivos

Escáner de referencia: `50_documentacion/estructura/estructura_actual.md`, corrida del **2026-08-01 09:16:36**, 16 carpetas y 97 archivos.

Único cambio estructural: `50_documentacion/andamios/20260731_maqueta_tablero.html` (26.3 KB). Cumple la política §2 (snake_case, sin tildes ni espacios, con prefijo de fecha como el resto de `andamios/`) y queda fuera del repositorio público por la exclusión ya declarada de `andamios/**`.

**Advertencia de consumo de la corrida diaria:** el escáner ya corrió dos veces el 2026-07-31 y una el 2026-08-01. La instrucción ⚠️ de una corrida por sesión sigue vigente y la del 2026-08-01 ya está consumida.

---

## 11. Pendientes y ruta sugerida

### Inventario

**P1 · Planificar la sección Formación (foco declarado de la próxima sesión)**
- *Descripción:* producir el documento de fundamento que la sección nunca tuvo: propósito, línea editorial, inventario y orden de elementos, más las decisiones adicionales que el asistente proponga.
- *Contexto:* decisión del titular al cierre de esta sesión, tras tres representaciones descartadas.
- *Tipo:* documentación.
- *Impacto:* alto. Bloquea toda escritura de código sobre la sección.
- *Dependencias:* ninguna técnica. Requiere al titular como fuente: el método acordado es una entrevista.
- *Complejidad:* media, por extensión y por número de decisiones, no por dificultad técnica.
- *Principios relevantes:* A-03 y A-04 de esta sesión; POLITICA 0.4 (recomendar, no ofrecer alternativas neutras).
- *Precauciones:* la sesión es de planificación y **no** produce código, maquetas ni variantes visuales. Si el asistente se descubre proponiendo una forma, es señal de que volvió al modo que causó los tres descartes. El material existente (`atlas.js` nuevo, maqueta, contrato del atlas, tabla filtrable) es insumo para decidir, no base a preservar.
- *Enfoque sugerido:* primero proponer el conjunto completo de decisiones que la planificación debe cerrar, para que el titular lo apruebe o lo corrija; después la entrevista, por bloques temáticos; al final, un documento único de fundamento en `50_documentacion/activa/`.
- *Criterio de éxito:* existe un documento aprobado por el titular que permite juzgar cualquier propuesta futura de la sección contra un criterio declarado, y del cual se derive un inventario ordenado de elementos.

**P2 · Decidir el destino de `docs/atlas.js` y `docs/atlas.css` sin commitear**
- *Descripción:* el tablero está en el árbol de trabajo, modificado y sin commitear. Las opciones son commitearlo como punto de guardado, dejarlo tal cual hasta que P1 concluya, o revertirlo.
- *Tipo:* deuda técnica.
- *Impacto:* medio. Un árbol de trabajo sucio indefinidamente entorpece cualquier trabajo futuro sobre `docs/`.
- *Dependencias:* la decisión depende de P1, pero no debe esperar a que P1 termine: puede resolverse al inicio de la próxima sesión.
- *Complejidad:* trivial.
- *Precauciones:* no revertir sin respaldo. Si se decide no conservarlo, `git stash` o un commit en rama son preferibles a `checkout --`.
- *Criterio de éxito:* `git status --short docs/` sin líneas, por la vía que el titular elija.

**P3 · Revisión de contenido del catálogo por el titular (heredado, bloqueante de difusión)**
- *Descripción:* el catálogo `docs/atlas_datos.js` no ha sido revisado en cuanto a veracidad. La validación verifica forma e integridad referencial, no hechos.
- *Contexto:* contrato del atlas §6, paso 4. Heredado desde v10.
- *Tipo:* bloqueante.
- *Impacto:* alto. **El sitio no se difunde hasta que se resuelva.**
- *Complejidad:* alta en tiempo del titular.
- *Nota nueva de esta sesión:* los 5 avisos del validador son un punto de partida concreto para esta revisión (cuatro fechas `desde` anteriores a su base y una colisión de color).

**P4 · Resolución de las 38 fuentes pendientes en `solicitudes_al_titular.md` (heredado)**
- *Tipo:* funcionalidad. Requiere descargas, revisión en navegador o credenciales institucionales del titular.

**P5 · Extraer las utilidades compartidas a `docs/atlas_util.js` (nuevo)**
- *Descripción:* `esc`, `porId`, `plural` y `buscar` están duplicadas entre `atlas.js` y `formacion.js`. La política §1.4 exige duplicación real para migrar a utils; ya existe.
- *Tipo:* deuda técnica.
- *Impacto:* bajo.
- *Dependencias:* depende de P1, porque si el atlas desaparece de la sección la duplicación desaparece con él.

**P6 · Deudas menores de `formacion.html` y `formacion.css` (heredado y ampliado)**
- `role="application"` en `#atlasCeleste` ya no describe el contenido.
- `.fm-atlas-espera` y `.fm-atlas-foot` huérfanas en `formacion.css`.
- *Tipo:* deuda técnica y accesibilidad. *Impacto:* bajo. Se resuelven en el mismo commit que toque esos archivos.

**P7 · `50_documentacion/activa/50_ordenacion_repositorio.md` no existe (deuda heredada)**
- El gatillo 4bis de la auditoría de estructura sigue encendido desde v12.

**P8 a P11 · Heredados sin cambios de v12**
- Entrada de Simce 2025 en el portafolio; optimización del payload de capturas (~9 MB); peso Museo Sans 400 ausente; repositorio de documentación interna del Área.

### Evaluación de deuda técnica

*Zonas frágiles:* la principal no es de código sino de proceso, y es la que esta sesión hizo visible: `docs/` acumula piezas decididas una por una sin un documento de fundamento que las ordene, y el resultado es que la única forma de descubrir que una pieza no sirve es construirla entera. La segunda es el árbol de trabajo sucio de P2. La tercera, menor, es la duplicación de utilidades de P5.

*Oportunidades:* la planificación de P1, si produce un documento reutilizable, sirve de plantilla para el resto del sitio, que tiene el mismo déficit y no lo ha manifestado porque el portafolio nunca fue cuestionado.

### Auditoría de cierre (política 5.6)

| # | Pregunta | Respuesta |
|---|---|---|
| 1 | ¿Datos crudos aislados e inmutables? | Sí. Sin cambios respecto de la apertura. |
| 2 | ¿El pipeline corre de cero sin intervención manual? | Parcialmente, con la excepción declarada en `CLAUDE.md`. En `docs/`, sí: `node --check` y `node 00_validar_atlas.js` corren de cero y ambos dieron `exit=0` en esta sesión. |
| 3 | ¿Paquetes, rutas y constantes al inicio de cada script? | Sí. `atlas.js` declara sus dependencias globales en las primeras líneas de la IIFE. |
| 4 | ¿La estructura respeta la política? | Sí, con las dos excepciones declaradas en `CLAUDE.md`. **No** en el gatillo 4bis: falta `50_ordenacion_repositorio.md`, registrado como P7. |
| 5 | ¿Verificación observable de cada entregable? | Parcialmente. El tablero tiene verificación sintáctica completa y **cero** verificación de comportamiento. Es la brecha declarada de esta sesión. |
| 8 | ¿Nombres sin tildes, ñ ni espacios? | Sí en los 97 archivos (fuente: `estructura_actual.md` del 2026-08-01). |

Toda respuesta parcial o negativa quedó registrada como pendiente: P7 para la 4, y para la 5 la precaución explícita de P2 (el tablero no se commitea como funcional).

### Ruta sugerida para la próxima sesión

1. **P2 primero, en un turno.** Decidir el destino del código sin commitear. Es trivial, deja el árbol limpio y evita que la sesión de planificación arrastre una decisión técnica pendiente.
2. **P1 como foco único.** Proponer al titular el conjunto de decisiones que la planificación debe cerrar; una vez aprobado ese índice, conducir la entrevista por bloques; cerrar con el documento de fundamento.
3. **Diferir todo lo demás.** P3 y P4 dependen del titular fuera de sesión. P5, P6 y P7 dependen de decisiones que P1 puede invalidar. P8-P11 no compiten con el foco.

**Criterio de éxito de la sesión:** un documento de fundamento aprobado. No código, no maquetas, no variantes.

---

## 12. Instrucciones específicas para la próxima sesión

- ⚠️ **NO** producir código, maquetas, wireframes ni variantes visuales de la sección Formación mientras P1 no haya concluido con un documento aprobado. La próxima sesión es de planificación y su entregable es prosa estructurada.
- ⚠️ **NO** tratar el tablero de `docs/atlas.js` como base a continuar. Es insumo descartable, y presuponer su continuidad reintroduce el error que causó la suspensión.
- ⚠️ **NO** ofrecer una cuarta variante de representación si la conversación se estanca. Al segundo descarte consecutivo, la respuesta correcta es detenerse y planificar (A-04).
- ⚠️ **NO** commitear `docs/atlas_datos.js` sin haber corrido antes `node 00_validar_atlas.js docs/atlas_datos.js` con `exit=0`.
- ⚠️ **NO** correr `00_escanear_proyecto.R` más de una vez por sesión, y verificar antes si una sesión paralela ya lo corrió ese día. La corrida del 2026-08-01 ya está consumida.
- ⚠️ **NO** ejecutar `git push` sin autorización explícita del titular en el turno inmediatamente anterior. La autorización no se hereda entre encargos.
- ⚠️ **NO** agrupar `git push` con verificaciones en un mismo bloque de comandos: el clasificador bloquea el bloque completo.
- ⚠️ **NO** incluir tareas manuales de traslado de archivos (copiar, mover, descargar, reemplazar) en un encargo ni en un mensaje para Claude Code.
- ⚠️ **NO** lanzar el Tramo 2 del encargo `20260730_encargo_sesion11.md` tal como está: su tabla de movimientos se construyó sobre un escáner que no conocía las tres decenas nuevas.
- ✅ **ANTES** de tomar como hecho cualquier afirmación del traspaso sobre estado de repositorio, marcarla como hipótesis en el encargo y darle una regla de cancelación que la verifique (A-01).
- ✅ **ANTES** de ofrecer variantes de forma, verificar que exista un documento que declare el propósito de lo que se está formando (A-03).
- ✅ **ANTES** de declarar que un render funciona, verificar con eventos reales en navegador. Las comprobaciones sintácticas no lo son.
- ✅ **ANTES** de agregar cualquier constante global a un script de `docs/`, verificar que no colisione con `PROYECTOS`, `HITOS`, `EQUIPO`, `ATLAS_INSTITUCIONES`, `ATLAS_AMBITOS` ni `ATLAS_FRASES`.
- ✅ **ANTES** de tomar una cifra del catálogo, recontarla programáticamente en el mismo turno.
- ✅ **ANTES** de entregar varios artefactos en un turno, dar a cada uno su línea de destino propia (E-01 de esta sesión).
- 🔒 `docs/app.js` no se toca. El lightbox y el visor se enganchan por fuera, por envoltura.
- 🔒 `.lb-text .banner-type` de `docs/styles.css` no se toca: es del lightbox.
- 🔒 `POLITICA_PROYECTO.md`, `SETTINGS_Y_PROMPTS_OPERACIONALES.md`, `50_documentacion/traspasos/**` y `50_documentacion/andamios/**` permanecen fuera del repositorio público.
- 🔒 Los bundles de `_archivo/20260730/ramas_claude/` y los originales de `_archivo/20260729/capturas_originales/` no se borran jamás.
- 🔒 El catálogo `docs/atlas_datos.js` sigue sin revisión de contenido del titular: **el sitio no se difunde** hasta que P3 se resuelva.

---

## 13. Fragmentos de código de referencia

**Patrón nuevo · Regla de cancelación por premisa heredada en un encargo autónomo.** Surge de A-01. Se escribe al tope del encargo, antes de cualquier fase de escritura:

```
REGLA DE CANCELACIÓN. Si la Fase 1 no termina con exit=0 en el validador,
DETENTE ahí, reporta la salida completa y NO ejecutes la Fase 2.
```

**Patrón nuevo · Verificación de ausencia de globales en un script de `docs/`.** Ejecutable tal cual desde la raíz:

```bash
grep -nE '^(var|let|const|function) ' docs/atlas.js || echo "ninguna (todo dentro de la IIFE)"
```

Depende de que el archivo entero viva en una IIFE y de que la indentación interna sea de al menos dos espacios: cualquier declaración a columna 0 es, por construcción, global.

Los patrones estables del proyecto (staging selectivo, commits atómicos, encargo autónomo) viven en `CLAUDE.md` y en `encargo_autonomo_claude_code_v1.md`; no se re-copian aquí.

---

## 14. Reapertura

### Mensaje de apertura pre-armado

> Tipo CONTINUATION. El protocolo (`POLITICA_PROYECTO.md` v5.5 + `SETTINGS_Y_PROMPTS_OPERACIONALES.md` v15) vive en la knowledge base del Project; verifica que estén al día antes de empezar. Adjunto el traspaso v13, el escáner, el backlog y los archivos actuales de la sección de formación.
>
> Esta sesión es **solo de planificación** de la sección Formación del portafolio del Área de Monitoreo. No se escribe código, ni maquetas, ni variantes visuales. Tres representaciones del atlas fueron descartadas en dos sesiones y el diagnóstico es que la sección nunca tuvo un fundamento declarado: no se definió su propósito, su línea editorial ni el orden de sus elementos.
>
> Quiero cerrar en esta sesión, como mínimo: el propósito de la sección (¿qué queremos lograr?), la línea editorial (¿cómo queremos contarlo?) y la organización de los elementos (¿qué va y en qué orden?). Antes de empezar, propón qué otras decisiones debe cerrar esta planificación; una vez que apruebe ese índice, condúceme una entrevista por bloques. El entregable es un documento de fundamento.
>
> Hay una decisión técnica menor que conviene resolver primero, en un turno: `docs/atlas.js` y `docs/atlas.css` están modificados y sin commitear.

### Documentos para la próxima sesión

1. **Protocolo en knowledge base** (no se adjuntan; solo verificar que estén al día): `POLITICA_PROYECTO.md`, `SETTINGS_Y_PROMPTS_OPERACIONALES.md`.
2. **Opcionales según el foco:** ninguno. La sesión no ejecuta en Claude Code ni emite encargos, así que `CLAUDE.md` y `encargo_autonomo_claude_code_v1.md` no se necesitan. Si aparece la decisión de qué hacer con el código sin commitear, basta con el output de `git status`.
3. **Específicos (sí se adjuntan):**
   - `traspaso_cierre_v13.md`
   - `estructura_actual.md`
   - `backlog_acumulativo.md` (voluminoso, ≈69 KB, crítico)
   - `docs/formacion.html` — la sección tal como existe hoy
   - `docs/index.html` — **nuevo en esta lista:** el portafolio es el hermano de la sección que se va a planificar y fija la línea editorial vigente del sitio
   - `docs/data.js` — el contenido del portafolio, por la misma razón
   - `50_documentacion/activa/50_contrato_atlas_datos.md` — para decidir qué del catálogo sobrevive a la planificación
   - `40_salidas/solicitudes_al_titular.md` — **opcional:** solo si la planificación llega a discutir el alcance del catálogo

**Nota obligatoria:** si alguno de estos archivos cambia antes de abrir, adjuntar la versión más reciente y avisarlo en el mensaje de apertura. `estructura_actual.md` y `backlog_acumulativo.md` cambian en cada cierre, así que se adjuntan siempre en su versión nueva.

---

## 15. Errores del asistente

### E-01 · Artefactos con destinos distintos entregados en un solo bloque

| Campo | Contenido |
|---|---|
| `momento` | Turno de entrega de la maqueta y, después, de `atlas.js` y `atlas.css` |
| `disparador` | Usuario lo corrigió (movió el archivo por su cuenta) y el asistente lo detectó después en `git status` |
| `que_paso` | La maqueta terminó en `docs/` en vez de `50_documentacion/andamios/`, pese a que su línea de destino era correcta, porque se entregó agrupada con dos archivos cuyo destino sí era `docs/` |
| `regla_violada` | `userPreferences`, edición de código: «MATERIALISATION IS NOT OPTIONAL … con su destino declarado como "→ destino: `<ruta completa desde la raíz>`"». La regla se cumplió por archivo pero no por entrega |
| `causa_raiz` | La entrega agrupada de tres archivos con un solo bloque de destinos hace que el destino mayoritario actúe como default implícito; el asistente optimizó la brevedad del mensaje por sobre la trazabilidad de cada ruta |
| `salvaguarda_presente` | `userPreferences` (única) |
| `patron` | Sobre entrega sin destino explícito por artefacto (hipótesis, verificar con: lectura de `herramientas_dev/gobernanza/catalogo_patrones_errores_v3.md`; el conjunto válido es `PAT-01` a `PAT-13` y no está disponible en esta sesión) |
| `gatillo_observable` | `entrega-sin-destino-o-nombre`: más de un artefacto en un turno con rutas de destino distintas y un solo bloque de destino |
| `intentos_previos` | 0 |
| `costo` | Un traslado manual del titular; ningún artefacto rehecho |

### E-02 · Tercera iteración de forma sobre una pieza sin fundamento declarado

| Campo | Contenido |
|---|---|
| `momento` | Toda la sesión, desde la ruta de desarrollo propuesta en la apertura hasta la entrega del tablero |
| `disparador` | Usuario lo señaló sin nombrarlo error («no hemos planificado bien … estamos tirando objetos sin estructura ni estrategia») |
| `que_paso` | El asistente diagnosticó el fracaso de la sesión 12 como falta de criterio de aceptación estético y lo corrigió con una maqueta comparativa, sin advertir que la pregunta abierta no era cuál composición elegir sino para qué existe la sección |
| `regla_violada` | POLITICA 0.4 (recomendar, no producir alternativas neutras) y el aprendizaje E-04 del traspaso v12, cuya generalización correcta era detenerse a planificar y no iterar mejor |
| `causa_raiz` | El traspaso v12 entregó la dirección de diseño («tablero de dos mitades») como acuerdo cerrado, y el asistente la trató como requisito dado en vez de preguntar de dónde salía; heredar una dirección sin fundamento y optimizar dentro de ella se siente como respetar el traspaso, y es lo contrario |
| `salvaguarda_presente` | POLITICA (0.4) y el propio traspaso v12 (E-04). Ninguna de las dos formulaba el caso «dos descartes consecutivos» como gatillo de detención, que es la brecha real |
| `patron` | Sobre iteración de forma sin fundamento declarado, escalando tras descartes sucesivos (hipótesis, verificar con: lectura de `herramientas_dev/gobernanza/catalogo_patrones_errores_v3.md`) |
| `gatillo_observable` | `iteracion-sin-criterio`: dos o más entregables consecutivos descartados por el titular sobre el mismo objeto, sin documento de propósito de ese objeto |
| `intentos_previos` | 2 (representación orbital oscura y orbital clara, ambas de la sesión 12, ambas descartadas por el titular tras verlas renderizadas) |
| `costo` | 907 líneas de código de producción con destino probable de descarte, más una maqueta de 26 KB; una sesión completa de foco redirigida |

**Salvaguarda propuesta a partir de E-02** (para `SETTINGS_Y_PROMPTS_OPERACIONALES.md`, si el patrón se repite en otro proyecto de la cartera): al segundo descarte consecutivo de un mismo artefacto por parte del titular, el asistente **no** propone una tercera versión; propone explícitamente una fase de planificación y nombra qué decisiones faltan. Es una regla de forma del output (qué produce el asistente en ese estado), no una prohibición de disciplina, porque el fallo no fue saltarse una regla conocida sino aplicar la corrección de menor alcance disponible.
