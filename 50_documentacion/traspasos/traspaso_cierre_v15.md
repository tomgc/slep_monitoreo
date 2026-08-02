# Traspaso de cierre — sesión 15

## 1. Identificación

| Campo | Valor |
|---|---|
| Proyecto | `slep_monitoreo` (sitio institucional del Área de Monitoreo, SLEP Costa Central) |
| Versión | v15 |
| Fecha | 2026-08-02 |
| Sesión | 15, tipo CONTINUATION |
| Foco | Primera sesión de la ruta de implementación de la sección Formación: redacción del contenido de los elementos 1, 2 y 4 y del caso del elemento 3, sin HTML, CSS ni JS. En paralelo, resolución de la verificación pendiente de `docs/atlas.*` y del renombre `ambito` → `desafio`. |
| Entorno | Claude conversacional (planificación y redacción) + Claude Code (ejecución en disco). Sitio estático vanilla, sin build. |
| Archivos principales creados o modificados | `50_documentacion/activa/50_contenido_seccion_formacion.md` (nuevo), `.gitignore`, `CLAUDE.md`, `50_documentacion/activa/ESTADO.md`, `50_documentacion/activa/50_contrato_atlas_datos.md`, `docs/atlas_datos.js`, `docs/atlas.js`, `docs/formacion.js`, `00_validar_atlas.js` |

---

## 2. Resumen ejecutivo

La sesión abrió con una verificación de estado que resultó ser lo contrario de lo que el traspaso v14 y el asistente suponían: `main` **nunca** tuvo el tablero experimental, y `wip/atlas_tablero_v3` es su única copia. Resuelto ese punto, se ejecutó el renombre `ambito` → `desafio` en los cuatro artefactos del atlas mediante un encargo autónomo, con el validador en `exit=0` y verificación funcional en navegador. El tercer bloque técnico fue la política de versionado de `traspasos/` y `andamios/logs/`, que se decidió con una corrección de fondo por el camino: el repositorio es público, de modo que versionar la memoria del proyecto no la respalda sino que la publica; el titular confirmó que el repositorio es público por diseño y la memoria se versiona a sabiendas. El grueso de la sesión fue redacción: los elementos 1, 2 y 4 de la sección Formación quedaron escritos y el elemento 3 se redactó con el caso del reporte de aprendizaje en educación parvularia, elegido por el titular tras corregir una elección del asistente hecha sin consultarlo. El texto del caso pasó por una ronda de corrección que eliminó dos afirmaciones fabricadas por el asistente. Al cierre no hay bugs activos ni bloqueantes; `main` está 29 commits por delante de `origin/main`, sin autorización de push. El paso siguiente es la maqueta desechable del elemento 2, previa aprobación de los textos.

---

## 3. Estado al cierre

**Qué funciona**

| Componente | Estado | Última verificación |
|---|---|---|
| `docs/formacion.html` con tabla filtrable | Carga 50 fuentes; filtro por desafío devuelve subconjunto y muestra la pregunta | Navegador, fase C del encargo de renombre (log `20260802_normalizacion_y_renombre_log.md`) |
| Atlas (`docs/atlas.js`) | Renderiza 9 instituciones, menú con 6 desafíos, vista de desafío con constelación | Idem |
| `docs/index.html` | Sin errores de consola | Idem |
| Validador `00_validar_atlas.js` | `exit=0`, conteos 9 / 25 / 50 / 6 / 124, idénticos a antes del renombre | Idem |
| Política de `.gitignore` | Traspasos y logs versionables sin `-f`; gobernanza y andamios sueltos ignorados | Log `20260802_politica_gitignore_log_v2.md` |

**Qué no funciona:** nada reportado.

**Delta respecto de v14**

1. La premisa de v14 sobre `docs/atlas.*` en `main` queda **refutada**, no confirmada.
2. El renombre de identificadores (tarea derivada 3 del fundamento) queda **cerrado**.
3. La memoria del proyecto (14 traspasos, 4 logs) queda versionada en local.
4. La sección Formación pasa de tener fundamento a tener **texto** para sus cuatro elementos de la etapa 1.
5. El desafío del elemento 3 queda fijado: **Educación parvularia**.

---

## 4. Registro detallado de cambios

### 4.1 Verificación y descarte de la premisa sobre `docs/atlas.*`

- **Archivos:** ninguno modificado.
- **Categoría:** Arquitectura del repositorio.
- **Qué se hizo:** se estableció, con historial y no con tamaños, que el commit del tablero (`6894986`) vive solo en `wip/atlas_tablero_v3` y que `main` fue tocado en `docs/atlas.*` por un único commit anterior (`8e823c7`, 2026-07-31) que no contiene el tablero.
- **Por qué:** el traspaso v14 dejó el punto abierto y el asistente lo cerró primero de forma incorrecta, infiriendo desde tamaños de archivo.
- **Cómo se verificó:** `git branch --contains 6894986` devuelve solo la rama `wip`; `git log` sobre los dos archivos.
- **Dependencias afectadas:** P7 (destino del tablero) sigue abierto y ahora consta que la rama `wip` es la única copia: borrarla destruiría el trabajo.

### 4.2 Renombre `ambito` → `desafio` en cuatro artefactos

- **Archivos:** `50_documentacion/activa/50_contrato_atlas_datos.md`, `docs/atlas_datos.js`, `00_validar_atlas.js`, `docs/atlas.js`, `docs/formacion.js`.
- **Categoría:** Reproducibilidad y tooling.
- **Qué se hizo:** renombre de identificadores internos (`ATLAS_AMBITOS` → `ATLAS_DESAFIOS`, claves, atributos de datos, selectores, mensajes del validador), con el contrato actualizado primero por ser la norma contra la que valida el validador.
- **Por qué:** el fundamento §5 resolvió la colisión terminológica con «ámbitos de actuación»; los identificadores quedaban como tarea derivada.
- **Cómo se verificó:** `node --check` sobre los tres `.js`, validador en `exit=0` con conteos idénticos a antes del renombre, `grep` final sin residuos, y recorrido en navegador que incluyó filtro por desafío, menú del atlas y vista de desafío.
- **Tensión resuelta:** el ejecutor detectó que `cambiar` contiene la subcadena `amb` y aplicó un mapa de tokens explícito con límites de palabra en vez de un reemplazo ciego, que habría corrompido `docs/atlas.js`.
- **Commits:** `4980b2c` (contrato), `5b1de70` (catálogo y validador), `9ae92ab` (consumidores).

### 4.3 Política de versionado de `traspasos/` y `andamios/logs/`

- **Archivos:** `.gitignore`, `CLAUDE.md`, `50_documentacion/activa/ESTADO.md`, más 18 archivos incorporados al índice.
- **Categoría:** Arquitectura del repositorio.
- **Qué se hizo:** reescritura de las reglas de `.gitignore` para que traspasos y logs de andamios sean versionables sin `git add -f`, manteniendo ignorados los encargos, las maquetas y los dos documentos de gobernanza; corrección de dos afirmaciones falsas sobre el alcance de GitHub Pages en `CLAUDE.md`; declaración en `ESTADO.md` de que la memoria versionada es pública.
- **Por qué:** dos cierres consecutivos toparon con la misma exclusión y la resolvían archivo por archivo con `-f`, es decir pasando por encima de una regla en vez de corregirla.
- **Cómo se verificó:** barrido de gobernanza previo (0 coincidencias identificatorias sobre 11 literales, todos la sigla RBD como concepto o el nombre de una codificación) y tabla de `git check-ignore` antes y después.
- **Commits:** `b93c71c` (19 archivos), `6fb317b` (`ESTADO.md`), `49c34b9` (log), `7a846a3` (`CLAUDE.md`).

### 4.4 Redacción del elemento 1 · Quiénes somos y qué hacemos

- **Archivo:** `50_documentacion/activa/50_contenido_seccion_formacion.md`.
- **Categoría:** Estructura de contenido.
- **Qué se hizo:** título, bajada, cuatro bloques (quiénes somos, los tres ámbitos de actuación en tabla, por qué publicamos esto, anuncio de la ruta en cuatro tramos) y verificación contra los siete criterios del fundamento §9.
- **Por qué:** el fundamento §9 exige descripción escrita aprobada antes de cualquier maqueta o código.
- **Decisión con carga:** el anuncio de la ruta declara cuatro tramos y no los siete elementos del inventario, porque los elementos 5 y 6 llegan en etapas posteriores y anunciarlos dejaría la ruta visiblemente incompleta.

### 4.5 Redacción del elemento 2 · Cómo contribuimos desde los datos

- **Archivo:** el mismo.
- **Categoría:** Estructura de contenido.
- **Qué se hizo:** texto de entrada y de cierre más la descripción escrita del recorrido: seis pasos y cuatro bifurcaciones recorribles, incluidas las ramas que no llevan al resultado esperado (la pregunta que ningún registro responde, el dato que no existe, la unión que no se puede hacer). Se introducen tres términos técnicos y no más: unidad de observación, dato agregado frente a microdato, identificador de unión.
- **Por qué:** es el elemento que carga con el criterio 7 (completitud narrativa) y el de mayor peso interactivo junto al 3 y al 6.
- **Cómo se verificó:** tabla de verificación contra los siete criterios, dentro del propio documento.
- **Deuda que abre:** las notas para la maqueta quedan escritas pero la maqueta no se hizo; es el pendiente P1 de la próxima sesión.

### 4.6 Redacción del elemento 4 y elección del desafío del elemento 3

- **Archivo:** el mismo.
- **Categoría:** Estructura de contenido.
- **Qué se hizo:** panorama de los seis desafíos, cada uno encabezado por su pregunta (no por su nombre) y con una frase sobre su dificultad propia, que es lo que evita que el elemento se lea como un índice.
- **Decisión revertida:** el asistente eligió *Asistencia y permanencia* para el elemento 3 por criterios de narración, sin preguntar qué proyectos del Área tenían trabajo real detrás. El titular corrigió la elección a **Educación parvularia**. La justificación anterior quedó degradada a apéndice derogado dentro del documento, como registro.

### 4.7 Redacción del elemento 3 · El caso de educación parvularia

- **Archivo:** el mismo.
- **Categoría:** Estructura de contenido.
- **Qué se hizo:** el caso en seis tramos mapeados a los seis pasos del método: la pregunta como llegó (conversación entre el Área de Mejora Continua y Acompañamiento Técnico Pedagógico y el Área de Monitoreo), qué se acordó observar (el aprendizaje tal como lo evalúan las propias educadoras, en los tres niveles, sin comparar), la fuente que no existía, la decisión metodológica (ordenar el reporte según la realidad de la educación parvularia y los principios de sus Bases Curriculares), el piloto con sus dos propósitos (evidencia de efectividad y usabilidad) y lo que abrió (escalar a todo el territorio y que sean las propias educadoras quienes capaciten a sus colegas).
- **Cómo se verificó:** ronda de confirmación con el titular sobre cinco puntos marcados como reconstrucción del redactor. Dos resultaron falsos y fueron eliminados (ver §15).
- **Tensión resuelta:** el desenlace del caso no es un producto sino un cambio de rol, lo que justifica que viva en la sección del tercer ámbito de actuación y no en el portafolio.

---

## 5. Backlog acumulativo

**Archivo canónico:** `50_documentacion/activa/backlog_acumulativo.md`. Las entradas siguientes se agregan al final del detalle cronológico, sin reescribir ni renumerar las anteriores. La numeración continúa desde la última entrada existente en el archivo; los números indicados asumen que la última es la 106 (hipótesis, verificar con: `grep -n "^10[0-9]\." 50_documentacion/activa/backlog_acumulativo.md | tail -3`).

### Sesión 15 (Claude Opus 5) — 2026-08-02

107. **Refutación de la premisa sobre `docs/atlas.*` en `main`** (`wip/atlas_tablero_v3`, commits `6894986` y `8e823c7`). El traspaso v14 dejó como verificación pendiente el estado de `atlas.js` y `atlas.css` en la rama publicada, y el asistente lo cerró primero de forma incorrecta infiriendo desde tamaños de archivo. La verificación por historial estableció lo contrario: `main` nunca tuvo el tablero, el escáner del 2026-08-01 midió el árbol sucio y no lo committeado, y la rama `wip` es la única copia del tablero. Consecuencia operativa: borrar esa rama destruiría el trabajo, de modo que el pendiente sobre su destino deja de ser una decisión cosmética. Categoría: Arquitectura del repositorio.

108. **Renombre de identificadores `ambito` → `desafio` en el atlas, el validador y sus consumidores** (`docs/atlas_datos.js`, `00_validar_atlas.js`, `docs/atlas.js`, `docs/formacion.js`, `50_contrato_atlas_datos.md`). Cierra la tarea derivada 3 del fundamento de la sección Formación. El contrato se actualizó primero por ser la norma contra la que valida el validador. El ejecutor detectó que la palabra `cambiar` contiene la subcadena `amb` y aplicó un mapa de tokens explícito con límites de palabra en vez de un reemplazo ciego. Validador en `exit=0` con conteos idénticos a los previos y los seis literales visibles conservados verbatim, porque el renombre es de identificadores y no de texto de interfaz. Categoría: Reproducibilidad y tooling.

109. **Política de versionado de la memoria del proyecto: traspasos y logs de andamios pasan a estar versionados** (`.gitignore`, `ESTADO.md`, `CLAUDE.md`). Dos cierres consecutivos habían topado con la misma exclusión y la resolvían con `git add -f`, es decir pasando por encima de una regla en vez de corregirla. La decisión se tomó con una corrección de fondo por el camino: el repositorio es público, de modo que versionar no respalda sino que publica. El titular confirmó que el repositorio es público por diseño y que la memoria se versiona a sabiendas. Se corrigieron además dos afirmaciones falsas sobre el alcance de GitHub Pages (sirve `main:/docs`, no todo el repositorio) y se declaró la condición de publicidad en `ESTADO.md`, para que ninguna sesión futura redacte un traspaso creyéndolo privado. Categoría: Arquitectura del repositorio.

110. **Hallazgo: `CLAUDE.md` y los cuatro archivos del escáner ya estaban versionados, no ignorados** (`.gitignore`, `50_documentacion/estructura/`). La regla interna «no se commitean» significaba que no se commitean sus modificaciones, no que estuvieran fuera del repositorio. Ninguna regla de `.gitignore` puede revertir eso, porque git no aplica reglas de ignore a archivos ya trackeados: escribirla habría producido una regla inerte que afirma algo falso. `CLAUDE.md` quedó corregido y commiteado; el estado de los cuatro archivos del escáner queda como pendiente de decisión. Categoría: Arquitectura del repositorio.

111. **Texto del elemento 1 de la sección Formación** (`50_contenido_seccion_formacion.md`). Primer producto de la ruta de implementación y primera aplicación de la verificación en dos pasos del fundamento §9: descripción escrita antes que maqueta, maqueta antes que código. Título, bajada, los tres ámbitos de actuación en tabla, la razón de publicar el método y el anuncio de la ruta en cuatro tramos y no en siete elementos, porque los elementos 5 y 6 llegan en etapas posteriores. Voz en primera persona plural, según la línea editorial del fundamento §5. Categoría: Estructura de contenido.

112. **Texto y descripción del recorrido del elemento 2** (`50_contenido_seccion_formacion.md`). Seis pasos y cuatro bifurcaciones, donde el fundamento §7 daba una sola de ejemplo. Las cuatro son decisiones reales del trabajo y todas son recorribles, incluidas las ramas que no llevan al resultado esperado: la pregunta que ningún registro responde, el dato que no existe, la unión de fuentes que no se puede hacer. Se introducen tres términos técnicos y no más (unidad de observación, dato agregado frente a microdato, identificador de unión), según el piso técnico del fundamento §2. Categoría: Estructura de contenido.

113. **Texto del elemento 4 y corrección de la elección del desafío del elemento 3** (`50_contenido_seccion_formacion.md`). El panorama de los seis desafíos encabeza cada uno por su pregunta y no por su nombre, y agrega a cada uno una frase sobre su dificultad propia, que es lo que impide que se lea como un índice. El asistente eligió *Asistencia y permanencia* para el elemento 3 por criterios de narración, sin preguntar qué proyectos del Área tenían trabajo real detrás; el titular corrigió a **Educación parvularia**, por ser un proyecto ejemplar en uso de datos, rigor metodológico y participación de las comunidades. Categoría: Estructura de contenido.

114. **Texto del elemento 3: el caso del reporte de aprendizaje en educación parvularia** (`50_contenido_seccion_formacion.md`). El caso en seis tramos mapeados a los seis pasos del método. Su rasgo demostrativo es que el dato no existía en ninguna fuente pública: estaba en las evaluaciones que las educadoras ya realizan, sin sistematizar. La decisión metodológica del caso es cómo se ordena el resultado, no qué se mide: el reporte adopta la organización de las Bases Curriculares de la Educación Parvularia en vez de imponer una estructura genérica de reportería. El piloto con directoras y educadoras tuvo dos propósitos, evidencia de efectividad y usabilidad previa al lanzamiento territorial. El desenlace no es un producto sino un cambio de rol del Área, hacia que sean las propias educadoras quienes capaciten a sus colegas. Categoría: Estructura de contenido.

**Delta del backlog — Sesión 15 (v15):** 8 entradas nuevas (107-114), sin reescritura ni renumeración de las anteriores. Resumen estadístico a actualizar (fila sesión 15, total 106 → 114). Sin cambios de taxonomía. Categorías de las nuevas: Estructura de contenido ×4 (111, 112, 113, 114), Arquitectura del repositorio ×3 (107, 109, 110), Reproducibilidad y tooling ×1 (108). Primera sesión de la ruta de implementación de la sección Formación y primera aplicación efectiva de la verificación en dos pasos del fundamento: los cuatro elementos de la etapa 1 existen como texto y ninguno como maqueta. Tres de las ocho entradas registran trabajo de repositorio ejecutado por encargos autónomos, dos de los cuales se detuvieron correctamente al encontrar premisas falsas del redactor. La tabla §3 no se recalcula (su fuente de verdad es el detalle cronológico §5).

---

## 6. Bugs de la sesión

**Ninguno.** No se detectó ningún bug de código en esta sesión. El renombre del atlas se verificó con validador y navegador sin hallazgos, y no se tocó ningún otro componente ejecutable. Las tres desviaciones relevantes de la sesión son errores del asistente, registrados en §15, no bugs de código.

---

## 7. Aprendizajes y restricciones descubiertas

1. **El tamaño de archivo no es evidencia del estado de una rama.** El escáner mide el árbol de trabajo, que puede estar sucio; el historial mide lo committeado. Regla: toda afirmación sobre qué contiene una rama se sostiene con `git log`, `git branch --contains` o `git show`, nunca con `ls -l` ni con un inventario de estructura. Qué pasa si se viola: se propone revertir un commit que no existe, como ocurrió al inicio de esta sesión.
2. **`.gitignore` no afecta a archivos ya trackeados.** Agregar una regla para un archivo versionado produce una regla inerte que afirma algo falso. Regla: antes de escribir una exclusión, comprobar con `git ls-files` si el archivo ya está en el índice; si lo está, la salida real es `git rm --cached` o aceptar que está versionado.
3. **Versionar en un repositorio público es publicar.** La distinción entre respaldo y publicación no es retórica y cambia la decisión. Regla: cualquier encargo que incorpore archivos al índice declara primero la visibilidad del remoto, verificada con `gh repo view`, no supuesta.
4. **Una negación de `.gitignore` no funciona si el directorio padre está excluido a nivel de carpeta.** La exclusión debe escribirse a nivel de archivos (`carpeta/*`) para que una negación posterior surta efecto.
5. **Elegir un caso real es una decisión del titular, no del redactor.** Los criterios de narración ordenan candidatos; solo el titular sabe qué proyectos existen, cuáles tienen rigor detrás y cuáles conviene mostrar. Regla: cuando un texto deba apoyarse en trabajo efectivamente realizado, la elección se pregunta antes de redactar, aunque los criterios de selección sean defendibles.

---

## 8. Decisiones de diseño

| # | Decisión | Alternativas consideradas | Justificación | Implicancia |
|---|---|---|---|---|
| 1 | Versionar traspasos y logs, dejando encargos y maquetas fuera | Dejar todo local; remoto privado aparte; volver privado el repositorio | La memoria del proyecto es del mismo tipo que el backlog, ya público; los encargos caducan al ejecutarse | Todo traspaso futuro nace público y se redacta bajo esa condición, declarada en `.gitignore` y en `ESTADO.md` |
| 2 | Cuatro bifurcaciones en el elemento 2, no una | La sola bifurcación de ejemplo del fundamento §7 | Una bifurcación en seis pasos se lee como adorno; las cuatro son decisiones reales | Si resultan muchas en la maqueta, la primera candidata a retirarse es la D, representable solo como bucle de retorno |
| 3 | La rama que termina sin respuesta se muestra | Mostrar solo recorridos exitosos | Un área que solo exhibe éxitos no está mostrando cómo trabaja | Es el argumento central del elemento 2 y condiciona la maqueta |
| 4 | El desafío del elemento 3 es Educación parvularia | Asistencia y permanencia (elección inicial del asistente), Equidad territorial, Aprendizaje y bienestar | Es un proyecto ejemplar del Área en uso de datos, rigor y participación de las comunidades, con piloto realizado | El elemento 4 describe parvularia como el desafío con menos información pública: el caso es la demostración de esa escasez y conviene enlazarlos |
| 5 | El piloto ocupa un tramo propio del caso | Repartirlo entre los pasos 5 y 6 del método | Es el rasgo más distintivo del proyecto y perdía peso disuelto | El caso tiene seis tramos que no calzan uno a uno con los seis pasos, sino por correspondencia |

---

## 9. Constantes y parámetros

Sin cambios de constantes de datos. El único cambio de identificadores es el renombre `ATLAS_AMBITOS` → `ATLAS_DESAFIOS` y sus derivados, registrado en §4.2. La fuente canónica del esquema del atlas es `50_documentacion/activa/50_contrato_atlas_datos.md`, actualizada en esta sesión.

---

## 10. Arquitectura de archivos

Escáner de referencia: `50_documentacion/estructura/estructura_actual.md`, generado el 2026-08-02 19:07 (16 carpetas, 111 archivos).

Cambios de estructura en la sesión:

1. Cinco logs en `50_documentacion/andamios/logs/` (dos nuevos de esta sesión) y cuatro encargos nuevos en `50_documentacion/andamios/`.
2. **Desvío detectado en el escáner de cierre:** `50_documentacion/activa/` contiene cinco archivos de contenido de la sección (`50_contenido_seccion_formacion.md` más las variantes `_v2` a `_v5`). El nombre canónico es uno solo, sin sufijo de versión; las variantes son entregas intermedias del asistente que no debieron nombrarse así. Consolidarlas es parte del cierre (§11, P0).
3. **Desvío detectado en el escáner de cierre:** `50_documentacion/traspasos/` contiene `traspaso_cierre_v12.md` y `traspaso_cierre_v14.md` en su raíz, cuando la política 1.3.1 exige un solo traspaso vigente. Archivar el v12 y el v14 es parte de este cierre.

---

## 11. Pendientes y ruta sugerida

### Inventario

| # | Pendiente | Tipo | Contexto | Impacto | Dependencias | Complejidad | Precauciones | Criterio de éxito |
|---|---|---|---|---|---|---|---|---|
| P0 | Consolidar el archivo de contenido en `50_contenido_seccion_formacion.md` y archivar traspasos v12 y v14 | Deuda técnica | Cinco variantes en `activa/`, dos traspasos vigentes | Ruido en la fuente de verdad del contenido | Ninguna | Baja | `git mv`, nunca `cp` + `rm`; la versión válida es la que contiene el caso de parvularia corregido | Un solo archivo de contenido y un solo traspaso vigente |
| P1 | Aprobación de los cuatro textos y maqueta desechable del elemento 2 | Funcionalidad | El fundamento §9 exige maqueta antes de código de producción | Es el camino crítico de la etapa 1 | P0 | Media | Dos intentos por elemento (fundamento §10); si se descarta, nombrar el criterio incumplido | Maqueta revisada en navegador y aprobada o descartada con criterio nombrado |
| P2 | Redacción del elemento 7 (cierre hacia portafolio y contacto) | Funcionalidad | Falta el único elemento de la etapa 1 sin texto | La etapa 1 no está completa sin él | P1 | Baja | Es cierre, no llamada comercial (fundamento §6) | Texto verificado contra los siete criterios |
| P3 | Reescribir `index.html` a primera persona plural | Deuda heredada | Tarea derivada 1 del fundamento | El sitio hablaría con dos voces | Ninguna | Media | No armonizar los dos registros: solo la voz | Portafolio en primera persona plural, sin cambios de registro |
| P4 | Revisar la barra de navegación para que exprese mandatos y no secciones | Deuda heredada | Tarea derivada 2 del fundamento | Menor | P3 | Baja | Cambio de etiquetas visibles: revisar en navegador | Etiquetas aprobadas por el titular |
| P5 | Decidir el destino del tablero en `wip/atlas_tablero_v3` | Deuda técnica | Ahora consta que es la única copia | Alto si se borra por error | Ninguna | Baja | 🔒 No borrar la rama sin decisión explícita | Decisión registrada en el traspaso siguiente |
| P6 | Decidir el estado de los cuatro archivos del escáner, hoy trackeados | Deuda técnica | Su versión pública es un snapshot congelado que nunca coincide con el árbol | Desinforma a quien lea el repositorio | Ninguna | Baja | `git rm --cached` los saca del árbol pero no del historial | Estado decidido y ejecutado |
| P7 | Resolver o retirar las 38 fuentes pendientes del catálogo | Deuda de datos | Regla de difusión del fundamento §8 | Bloquea la difusión de la dirección | Ninguna | Alta | Requiere credenciales o navegador del titular | Catálogo sin pendientes visibles antes de difundir |
| P8 | Ordenación del repositorio (POLITICA §4.7) | Documentación | Falta `50_documentacion/activa/50_ordenacion_repositorio.md` | Bajo | Ninguna | Media | Mueve archivos: requiere aprobación previa | Documento emitido y estructura conforme |
| P9 | Autorizar el push de `main` | Bloqueante para publicación | 29 commits locales | El sitio publicado no refleja el trabajo de tres sesiones | P0, P1 | Baja | 🔒 Push solo con autorización explícita | Push ejecutado con autorización |

### Evaluación de deuda técnica

**Zonas frágiles:** el archivo de contenido duplicado en cinco variantes viola el principio de fuente única y es la deuda más urgente por ser reciente y barata de cerrar. Los cuatro archivos del escáner versionados violan el mismo principio de otra forma: publican un estado que nunca es el real. La deuda estable heredada sigue vigente: funciones duplicadas entre `atlas.js` y `formacion.js` (`esc`, `porId`, `plural`, `buscar`), ausencia del peso Museo Sans 400 y payload de capturas cercano a 9 MB.

**Oportunidades de mejora:** los dos encargos autónomos que se detuvieron por premisas falsas del redactor demuestran que la regla de detención funciona. Conviene mantener el patrón de declarar premisas verificables y explícitas en cada encargo, porque es lo que permite que el ejecutor las refute.

### Auditoría de cierre

| Pregunta | Respuesta |
|---|---|
| ¿El traspaso queda materializado como archivo en la ruta canónica? | Sí, `50_documentacion/traspasos/traspaso_cierre_v15.md` |
| ¿El traspaso anterior queda archivado? | Pendiente de ejecución en el encargo de cierre (P0): v12 y v14 a `archivo/` |
| ¿El backlog vive como archivo independiente y canónico? | Sí; las entradas 107-114 se agregan en el encargo de cierre |
| ¿Se ejecutó el escáner al cierre? | Sí, 2026-08-02 19:07 |
| ¿Hay bugs activos? | No |
| ¿Hay afirmaciones de estado sin verificación? | No en este traspaso; las tres de la sesión fueron refutadas y registradas en §15 |
| ¿Se respetó la prohibición de push? | Sí, `main` queda 29 commits por delante de `origin/main` |
| ¿Quedó `ESTADO.md` actualizado? | Pendiente de ejecución en el encargo de cierre |

### Ruta sugerida para la próxima sesión

1. **P0** primero, por ser barato y por dejar limpia la fuente de verdad del contenido.
2. **P1**: aprobación de los cuatro textos y maqueta desechable del elemento 2, que es el camino crítico de la etapa 1. Criterio de éxito: maqueta revisada en navegador, aprobada o descartada nombrando el criterio incumplido.
3. **P2**: redacción del elemento 7, corto y necesario para cerrar la etapa 1.

**Conviene diferir:** P3 y P4 (dependen de que la sección esté cerrada), P7 (requiere trabajo del titular con credenciales), P8 (no aporta al camino crítico) y P9 (el push conviene hacerlo con la etapa 1 completa).

---

## 12. Instrucciones específicas para la próxima sesión

- ⚠️ **NO** afirmar el contenido de una rama sin `git log`, `git branch --contains` o `git show`. El escáner y `ls -l` miden el árbol de trabajo, no lo committeado.
- ⚠️ **NO** escribir código de producción de la sección Formación antes de que la maqueta desechable del elemento correspondiente esté revisada en navegador (fundamento §9).
- ⚠️ **NO** elegir por cuenta propia qué proyecto del Área ilustra un contenido: la elección es del titular.
- ✅ **ANTES** de redactar cualquier texto de la sección, leer `50_fundamento_seccion_formacion.md` completo y `50_contenido_seccion_formacion.md` consolidado.
- ✅ **ANTES** de incorporar archivos al índice, verificar visibilidad del remoto y estado de trackeo con `git ls-files`.
- ✅ **ANTES** de descartar una representación, nombrar el criterio del fundamento §9 que incumple. El gusto justifica ajustes, nunca descartes.
- 🔒 La rama `wip/atlas_tablero_v3` es la **única copia** del tablero: no se borra ni se reescribe sin decisión explícita.
- 🔒 Ningún `git push`, `--force`, `reset --hard` ni tag sin autorización explícita del titular.
- 🔒 Nunca `git add -A` ni `git add -f`. Staging selectivo; si un archivo requiere `-f`, la regla de `.gitignore` está mal escrita.
- 🔒 El texto de la sección no nombra establecimientos, personas ni identificadores, y no publica código.

---

## 13. Fragmentos de código de referencia

Patrón nuevo de esta sesión: **verificación de exclusión archivo por archivo**, útil para comprobar que una regla de `.gitignore` hace lo que dice antes de commitear.

```bash
cd /Users/tomgc/Projects/slep_monitoreo && \
  for f in <lista de rutas>; do \
    printf "%-70s " "$f"; git check-ignore -q "$f" && echo "IGNORADO" || echo "versionable"; \
  done
```

Segundo patrón: **comprobación de que una rama contiene un commit**, que sustituye la inferencia por tamaños.

```bash
cd /Users/tomgc/Projects/slep_monitoreo && git branch --contains <hash>
```

Los patrones estables del proyecto viven en `CLAUDE.md` y en `POLITICA_PROYECTO.md`; este traspaso no los re-copia.

---

## 14. Reapertura

**Mensaje de apertura pre-armado:**

> Tipo CONTINUATION. El protocolo (`POLITICA_PROYECTO.md` v5.6 + `SETTINGS_Y_PROMPTS_OPERACIONALES.md` v16) vive en la knowledge base del Project; verifica que estén al día antes de empezar. Adjunto el traspaso v15, el escáner, el backlog, el fundamento de la sección Formación y el contenido redactado.
> Esta sesión es la número 2 de la ruta de implementación de la sección Formación. El objetivo es la maqueta desechable del elemento 2 (el recorrido de seis pasos y cuatro bifurcaciones), previa aprobación de los cuatro textos redactados en la sesión anterior. La maqueta es desechable: no es código de producción.
> Estado: sin bugs activos, sin bloqueantes, 29 commits locales sin pushear. Pendiente de consolidación el archivo de contenido si el encargo de cierre no alcanzó a ejecutarse.
> Documentos a adjuntar: `traspaso_cierre_v15.md`, `estructura_actual.md`, `backlog_acumulativo.md`, `50_fundamento_seccion_formacion.md`, `50_contenido_seccion_formacion.md`, `docs/formacion.html`, `docs/formacion.css`.

**Documentos para la próxima sesión**

1. *Protocolo en knowledge base (no se adjuntan, solo se verifica que estén al día):* `POLITICA_PROYECTO.md`, `SETTINGS_Y_PROMPTS_OPERACIONALES.md`.
2. *Opcionales según el foco:* `CLAUDE.md` si la sesión correrá encargos en Claude Code.
3. *Específicos de la sesión (sí se adjuntan):* `traspaso_cierre_v15.md`; `estructura_actual.md`; `backlog_acumulativo.md`; `50_fundamento_seccion_formacion.md` (fuente de verdad de la sección, imprescindible); `50_contenido_seccion_formacion.md` (los cuatro textos, voluminoso pero crítico); `docs/formacion.html` y `docs/formacion.css` (destino de la maqueta).

**Nota final:** si alguno de estos archivos cambió entre sesiones, adjuntar la versión más actualizada y avisarlo en el mensaje de apertura. El archivo de contenido cambia de nombre si el encargo de cierre consolidó las variantes.

---

## 15. Errores del asistente

| Campo | Error 1 |
|---|---|
| `momento` | Primer turno de la sesión, al resolver la verificación P2 del traspaso v14 |
| `disparador` | Usuario lo corrigió indirectamente al pegar la salida del comando de reversión, que no produjo cambios |
| `que_paso` | Se afirmó que `main` contenía el tablero committeado, infiriéndolo de los tamaños de archivo del escáner y del árbol limpio, sin consultar el historial |
| `regla_violada` | `userPreferences`, marcador de fuente: toda afirmación de estado del repositorio exige fuente leída o comando ejecutado en la sesión; POLITICA, verificación de estado del repositorio |
| `causa_raiz` | Se tomó una coincidencia numérica (tamaños del escáner iguales a los del árbol) como prueba de estado committeado, cuando el escáner mide el árbol de trabajo. La regla se aplicó en la forma (se citó una fuente) pero no en el fondo (la fuente citada no era evidencia de lo afirmado) |
| `salvaguarda_presente` | `userPreferences` y POLITICA |
| `patron` | PAT-01, sobre estado de rama inferido desde metadatos de archivo |
| `gatillo_observable` | `estado-git`: afirmar qué contiene una rama sin `git log`, `git branch --contains` ni `git show` |
| `intentos_previos` | 0 |
| `costo` | Dos turnos: un comando de reversión inútil y un encargo con una fase A escrita sobre la premisa equivocada |

| Campo | Error 2 |
|---|---|
| `momento` | Redacción del encargo v1 de política de `.gitignore` |
| `disparador` | Claude Code lo detuvo en fase A y lo reportó |
| `que_paso` | El encargo justificó versionar la memoria del proyecto como respaldo de archivos «sin respaldo remoto», sin verificar la visibilidad del repositorio, que es pública, y pese a que `.gitignore:13` declaraba explícitamente lo contrario |
| `regla_violada` | `userPreferences`, marcador de fuente: toda premisa fáctica de un encargo lleva fuente o marca de hipótesis |
| `causa_raiz` | La premisa se heredó del marco con que el propio asistente había presentado la opción al titular («respaldo»), y no se revisó al convertirla en encargo. Un marco conversacional pasó a premisa operativa sin verificación intermedia |
| `salvaguarda_presente` | `userPreferences` y el propio patrón de encargos (`encargo_autonomo_claude_code_v1.md`, contrato de premisas) |
| `patron` | PAT-01, sobre premisa de encargo no verificada |
| `gatillo_observable` | `encargos-premisas`: afirmar la condición de publicación de un remoto sin `gh repo view` |
| `intentos_previos` | 0 |
| `costo` | Un encargo completo desechado y reescrito (v2), más dos turnos |

| Campo | Error 3 |
|---|---|
| `momento` | Redacción del encargo v2, sección de invariantes |
| `disparador` | Claude Code lo señaló en su reporte sin nombrarlo error |
| `que_paso` | La sección 3 afirmó que `CLAUDE.md` y los cuatro archivos del escáner «siguen ignorados», cuando estaban trackeados desde antes; la regla propuesta habría sido inerte |
| `regla_violada` | `userPreferences`, marcador de fuente; e invariante propio del encargo v2, que exigía verificar antes de afirmar |
| `causa_raiz` | Se leyó la regla operativa del proyecto («los cuatro del escáner nunca se commitean») como si describiera el estado del índice, cuando describía una conducta. Regla de conducta confundida con estado verificable |
| `salvaguarda_presente` | `userPreferences` |
| `patron` | PAT-01, sobre estado de trackeo inferido desde una regla de conducta |
| `gatillo_observable` | `estado-git`: afirmar trackeo o exclusión sin `git ls-files` |
| `intentos_previos` | 1 (el error 2, sobre el mismo encargo) |
| `costo` | Ninguno operativo: el ejecutor lo detectó y documentó. Costo latente evitado: una regla falsa en `.gitignore` |

| Campo | Error 4 |
|---|---|
| `momento` | Elección del desafío del elemento 3 |
| `disparador` | Usuario lo corrigió: «siento que elegiste sin preguntarme» |
| `que_paso` | Se eligió *Asistencia y permanencia* como caso del elemento 3 por criterios de narración, sin preguntar qué proyectos del Área tenían trabajo real detrás, siendo que el caso debía ser real |
| `regla_violada` | `userPreferences`, autonomía: interrumpir cuando se necesita una decisión estratégica que define la continuidad del trabajo; fundamento §7, que exige un caso real del Área |
| `causa_raiz` | Se clasificó la elección como decisión de redacción (autónoma) cuando era una decisión sobre hechos que solo el titular conoce. La regla de autonomía se aplicó a un caso que su excepción cubría |
| `salvaguarda_presente` | `userPreferences` y el fundamento del proyecto |
| `patron` | PAT-NUEVO-eleccion-factual-como-editorial: tratar como decisión de estilo una elección que depende de hechos que solo el titular posee. Propuesta de entrada nueva al catálogo, porque los `PAT-NN` vigentes cubren afirmaciones no verificadas y no la clasificación errónea del tipo de decisión |
| `gatillo_observable` | `otro`: elegir entre alternativas cuyo criterio decisivo es un hecho no disponible para el asistente |
| `intentos_previos` | 0 |
| `costo` | Un elemento redactado y reescrito por completo, más tres turnos |

| Campo | Error 5 |
|---|---|
| `momento` | Redacción del elemento 3, versión 4 del documento de contenido |
| `disparador` | Usuario lo corrigió: «¿de dónde sacaste eso?» |
| `que_paso` | Se atribuyó al Área una posición institucional que nadie enunció («un dato que sirve para acompañar y un dato que sirve para rankear rara vez son el mismo dato») y una decisión metodológica que no ocurrió (haber optado entre construir un instrumento nuevo y sistematizar las evaluaciones existentes) |
| `regla_violada` | `userPreferences`, marcador de fuente: toda premisa fáctica lleva fuente o marca de hipótesis; POLITICA, gobernanza de contenido publicable |
| `causa_raiz` | El molde narrativo del elemento 3, que exige un tramo de decisión metodológica, se rellenó con una decisión plausible en vez de dejarse vacío o marcado como faltante. La forma del texto generó su contenido. Cinco de las afirmaciones sí se marcaron como reconstrucción, pero la frase sobre acompañar y rankear se coló sin marca, que es lo que la vuelve grave: quedó con estatus de voz del Área |
| `salvaguarda_presente` | `userPreferences` y POLITICA |
| `patron` | PAT-01, sobre atribución de posición institucional no enunciada |
| `gatillo_observable` | `otro`: escribir en voz institucional una afirmación que ninguna fuente de la sesión respalda |
| `intentos_previos` | 0 |
| `costo` | Un elemento reescrito y una ronda de verificación de seis puntos con el titular. Costo evitado: la frase habría llegado al sitio público como posición del Área |

| Campo | Error 6 |
|---|---|
| `momento` | Entregas sucesivas del documento de contenido |
| `disparador` | Escáner de cierre |
| `que_paso` | El documento de contenido se entregó con sufijos de versión en el nombre del archivo (`_v2` a `_v5`) pese a declarar como destino el nombre canónico sin sufijo, lo que produjo cinco copias en `50_documentacion/activa/` |
| `regla_violada` | SETTINGS §2.1, convención de nombres canónicos; `userPreferences`, materialización con destino declarado |
| `causa_raiz` | El nombre del archivo entregado se usó para distinguir iteraciones dentro de la conversación, función que corresponde al encabezado del documento y no a su nombre. El destino se declaró correcto en el texto y el archivo salió con otro nombre |
| `salvaguarda_presente` | SETTINGS y `userPreferences` |
| `patron` | PAT-01, sobre nombre de entrega divergente del destino declarado |
| `gatillo_observable` | `entrega-sin-destino-o-nombre`: el nombre del archivo entregado no coincide con la ruta de destino declarada |
| `intentos_previos` | 0 |
| `costo` | Cuatro archivos duplicados en la carpeta canónica, a limpiar en el encargo de cierre |
