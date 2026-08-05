# Traspaso de cierre — slep_monitoreo — v16

> **Destino:** `50_documentacion/traspasos/traspaso_cierre_v16.md`

---

## 1. Identificación

- **Proyecto:** `slep_monitoreo` — sitio institucional del Área de Monitoreo y
  Seguimiento de Procesos y Resultados Educativos, SLEP Costa Central.
- **Versión:** v16. **Sesión:** 16. **Fecha de cierre:** 2026-08-04.
- **Foco:** producir la maqueta desechable del elemento 2 de la sección Formación
  y dejar preparada su integración a producción. La maqueta se aprobó a la cuarta
  representación, tras dos descartes propios y un cambio de método.
- **Entorno:** macOS, repositorio en `/Users/tomgc/Projects/slep_monitoreo`,
  publicación por GitHub Pages desde `main`/`docs/`. Sitio en HTML, CSS y
  JavaScript vanilla, sin sistema de compilación ni dependencias externas.
- **Archivos principales modificados:** `.gitignore`, `00_escanear_proyecto.R`,
  `50_documentacion/andamios/20260803_spec_elemento2_vanilla.md`. Se crearon ocho
  andamios nuevos y se reubicaron dos paquetes de handoff. **`docs/` no se tocó**:
  ningún archivo de producción cambió en esta sesión.

---

## 2. Resumen ejecutivo

La sesión abrió con los cuatro textos de los elementos 1 a 4 redactados y sin
aprobar, y con el elemento 2 sin ninguna representación visual. El titular aprobó
las cinco decisiones marcadas de contenido y la sesión pasó a producir la maqueta
desechable que el fundamento §9 exige antes de escribir código de producción. Se
produjeron dos maquetas propias y las dos se descartaron: la primera por calidad
visual, la segunda porque el asistente recomendó encoger los nodos de 136 a 85
píxeles para caber en el contenedor de texto del sitio, lo que partió todos los
rótulos y volvió el recorrido ilegible. El titular derivó entonces el elemento a
Claude Design, que entregó un prototipo de alta fidelidad, y el método cambió: en
lugar de reinterpretar el diseño desde una especificación en prosa, se trasladó
mecánicamente su plantilla y su lógica a vanilla, y la verificación pasó a ser un
cotejo declaración por declaración contra un inventario de estilos extraído del
propio código fuente del prototipo. La maqueta resultante quedó aprobada tras una
sola corrección de geometría (el conector de retorno salía del paso 6 y debía
salir de la tarjeta del bucle). En paralelo se emitió el plan de integración a
producción, se sacó la salida del escáner del árbol versionado, se reubicaron los
dos paquetes de handoff a un directorio propio y se eliminaron 3,1 MB de
dependencias descargadas que el prototipo autónomo volvió innecesarias. Queda
pendiente el trabajo que importa: llevar el elemento 2 a `docs/formacion.html`,
que es la primera vez que este proyecto tocará producción en tres sesiones.

---

## 3. Estado al cierre

### Qué funciona

- El sitio publicado sigue sin bugs conocidos. `docs/` no se modificó en esta
  sesión, de modo que su estado es idéntico al de v15.
- La maqueta `20260803_maqueta_elemento2_v2.html` se abre con doble clic, sin
  servidor y sin red, y fue **revisada y aprobada por el titular en navegador**.
  Es la referencia de implementación.
- El prototipo de Claude Design en su versión standalone (291 148 bytes) es
  autónomo de verdad: React, ReactDOM y las cuatro tipografías están incrustados
  en su manifiesto comprimido (fuente: inspección de las claves del manifiesto
  contra `ext_resources`, ejecutada en la sesión).
- El escáner ya no versiona su propia salida y excluye el nuevo directorio de
  handoffs (fuente: commits `b721b9f` y `0104d2f`, reportados por Claude Code).

### Qué no funciona

- `50_documentacion/activa/50_contrato_atlas_datos.md`, línea 6, apunta a
  `design_handoff_atlas_celeste/atlas-data.js`, ruta que dejó de existir al mover
  los paquetes. Es archivo versionado y público (fuente: reporte de Claude Code
  de la tarea 3.5). Síntoma observable: la referencia no resuelve.
- `docs/atlas.js` y `docs/atlas.css` siguen siendo código muerto: la sección
  «Atlas» de `formacion.html` los carga y la metáfora celeste fue abandonada por
  el fundamento §5.
- Las tres capturas del paquete del elemento 2 son el mismo archivo bajo tres
  nombres (fuente: `shasum -a 256` ejecutado en la sesión): no documentan los tres
  estados que prometen.

### Delta respecto a v15

| Dimensión | v15 | v16 |
|---|---|---|
| Elemento 2 | texto redactado, sin maqueta | maqueta aprobada y plan de integración emitido |
| Textos de los elementos 1 a 4 | redactados, sin aprobar | aprobados por el titular |
| Salida del escáner | trackeada, tres días desfasada | fuera del índice, ignorada |
| Paquetes de handoff | dos, mezclados en `andamios/` | dos, en `50_documentacion/handoffs/` |
| Commits sin pushear | 29 | 37 |
| Archivos en el inventario | 108 | 117 |

---

## 4. Registro detallado de cambios

### 4.1 Aprobación de los cuatro textos de los elementos 1 a 4

- **Archivos:** ninguno. Decisión del titular sobre
  `50_documentacion/activa/50_contenido_seccion_formacion.md`.
- **Categoría:** contenido.
- **Qué se hizo:** se presentaron las cinco decisiones que el redactor había
  marcado como revisables y el titular aprobó las cinco sin cambios.
- **Por qué:** el fundamento §9 fija la aprobación del texto como precondición de
  cualquier maqueta. Saltarla es lo que produjo los tres descartes de las sesiones
  13 y 14.
- **Cómo se verificó:** aprobación explícita en el chat.
- **Nota del titular:** el texto aprobado es la versión vigente y revisable, no un
  texto congelado. Puede mejorarse en sesiones futuras sin reabrir el fundamento.

### 4.2 Maqueta desechable propia, primera versión (descartada)

- **Archivo:** `50_documentacion/andamios/20260802_maqueta_elemento2.html`.
- **Categoría:** representación visual.
- **Qué se hizo:** un riel vertical de nueve nodos con panel de detalle lateral;
  luego, tras la primera observación del titular, un riel horizontal.
- **Por qué se descartó:** calidad visual insuficiente, señalada por el titular.
  No se nombró un criterio del fundamento §9 incumplido: fue un descarte por
  resultado, no por procedimiento.
- **Consecuencia:** el presupuesto de dos intentos del fundamento §10 quedó
  consumido y el elemento se derivó a Claude Design.

### 4.3 Brief para Claude Design

- **Archivo:** `50_documentacion/andamios/20260802_brief_claude_design_elemento2.md`.
- **Categoría:** encargo externo.
- **Qué se hizo:** brief con el contenido literal de los seis pasos, las tres
  decisiones y el bucle; requisitos funcionales en orden de importancia;
  restricciones técnicas; seis prohibiciones; los siete criterios de aceptación.
- **Por qué:** el elemento 2 concentra el mayor peso interactivo de la etapa 1 y
  el proyecto ya tenía un canal de diseño con precedente
  (`encargo_diseno_portafolio.md`).
- **Cómo se verificó:** Claude Design respetó el contenido literal casi por
  completo (fuente: cotejo de la función `d()` contra el brief, ejecutado por
  Claude Code).

### 4.4 Diagnóstico del primer paquete de handoff

- **Archivos leídos:** el paquete completo.
- **Categoría:** verificación.
- **Qué se hizo:** diagnóstico de solo lectura en seis preguntas: inventario,
  autonomía, fidelidad del contenido, mayúsculas sostenidas, compatibilidad con el
  sistema visual y patrones del sitio de destino.
- **Hallazgo bloqueante:** `support.js` cargaba React, ReactDOM y Babel desde
  `unpkg.com` y el `.dc.html` no definía `window.__resources`, de modo que el
  prototipo no era revisable con doble clic.
- **Hallazgos de contenido:** título alterado, bajada relativizada, caja «Acceso a
  los datos» no aprobada, y las tres capturas idénticas entre sí.
- **Hallazgos favorables:** cero mayúsculas sostenidas, cero colores nuevos (los
  catorce tokens ya existen en el sitio), ninguna tipografía inexistente.

### 4.5 Vendorizado del prototipo y especificación en prosa

- **Archivos:** `.../vendor/` (tres archivos) y
  `.../Elemento 2 - De la pregunta a la respuesta.local.html`; especificación en
  `50_documentacion/andamios/20260803_spec_elemento2_vanilla.md`.
- **Categoría:** habilitación y documentación.
- **Qué se hizo:** se descargaron React, ReactDOM y Babel al paquete y se creó una
  copia del prototipo con `window.__resources` apuntando a rutas locales; en
  paralelo se redactó una especificación de 506 líneas para reimplementar en
  vanilla.
- **Cómo se verificó:** los tres archivos coinciden con los hashes SRI que el
  propio `support.js` declara.
- **Estado final:** `vendor/` fue eliminado en el cierre de esta misma sesión, al
  llegar el standalone autónomo. La especificación quedó con sus secciones §5 y
  §7.1 marcadas como retiradas.

### 4.6 Maqueta vanilla, primera versión (descartada)

- **Archivo:** `50_documentacion/andamios/20260803_maqueta_elemento2_vanilla.html`.
- **Categoría:** representación visual.
- **Qué se hizo:** reimplementación en vanilla desde la especificación en prosa,
  con los anchos de nodo reducidos de 136/176/120 a 85/110/75 para caber en los
  1000 px de contenido del `.shell`.
- **Por qué se descartó:** a 85 px ningún rótulo entra en una línea. Ocho palabras
  desbordaban su caja y `overflow-wrap: break-word` las partió con guiones. El
  recorrido quedó convertido en un muro de columnas altas e ilegibles.
- **Causa raíz:** ver §15, error 3. La recomendación de encoger fue del asistente.

### 4.7 Cambio de método: traslado mecánico

- **Archivos:** `50_documentacion/andamios/20260803_inventario_estilos_elemento2.md`
  y `20260803_maqueta_elemento2_v2.html`.
- **Categoría:** representación visual y verificación.
- **Qué se hizo:** se abandonó la reinterpretación desde prosa. Un extractor
  programático recorrió la plantilla del prototipo y produjo un inventario de 57
  elementos y 335 declaraciones de estilo, 8 de ellas dependientes de la lógica.
  La maqueta se escribió trasladando método por método la clase del prototipo a
  una IIFE, y regla por regla los estilos en línea a CSS con `var(--token)`.
- **Por qué:** cada salto interpretativo (prototipo → prosa → reimplementación →
  reajuste) perdía fidelidad, y la lógica del prototipo ya era JavaScript plano:
  el traslado era mecánico y se había vuelto interpretativo.
- **Cómo se verificó:** cotejo declaración por declaración contra el inventario:
  290 con contraparte exacta, 36 fuera de alcance, 8 convertidas en clases
  modificadoras, 1 falso negativo del comparador por un espacio tras una coma.
  Cero omisiones reales (fuente: reporte de Claude Code de la tarea 3).
- **Tensión resuelta:** el objeto rompe el contenedor `.shell` de 1080 px y ocupa
  el ancho disponible, con la pista de 1536 px. Es lo que debió recomendarse en
  lugar de encoger los nodos.

### 4.8 Corrección del conector de retorno

- **Archivo:** `20260803_maqueta_elemento2_v2.html`.
- **Categoría:** geometría.
- **Qué se hizo:** el trazo salía de x=1340, el centro del paso 6, escrito a mano
  en el atributo `d` del `path`. Pasó a construirse en el script desde
  `bGeo()["loop"]` = 1476, el centro de la tarjeta «¿Cómo seguimos?».
- **Por qué:** el bucle lo declara la última tarjeta, no el paso 6.
- **Cómo se verificó:** ningún número de geometría queda en el marcado; el
  comprobante buscó `viewBox`, `<path>`, `<polyline>` y los literales 1536, 1476 y
  1340 en el cuerpo excluido el script, sin resultados. Aprobada por el titular en
  navegador.

### 4.9 Plan de integración a producción

- **Archivo:** `50_documentacion/andamios/20260803_plan_integracion_elemento2.md`.
- **Categoría:** documentación.
- **Qué se hizo:** siete puntos, del diff conceptual sobre `formacion.html` al
  orden de commits atómicos.
- **Verificado por comparación y no por suposición:** cero colisiones entre las 24
  clases `fm-` del sitio y las 50 `fm-ruta-` de la maqueta; los catorce tokens
  existen en el sitio con el mismo nombre y el mismo valor, de modo que el bloque
  `:root` de la maqueta se elimina entero al integrar.
- **Riesgo principal identificado:** `formacion.js` ya tiene una función
  `pintar()` para la tabla y la del recorrido choca dentro de la misma IIFE.

### 4.10 Salida del escáner fuera del árbol versionado

- **Archivos:** `.gitignore`, `50_documentacion/estructura/`.
- **Categoría:** deuda técnica.
- **Qué se hizo:** `git rm --cached` sobre los cuatro archivos del escáner y regla
  nueva en `.gitignore` línea 34. El `.gitkeep` se mantiene trackeado.
- **Por qué:** la versión pública declaraba 90 archivos cuando el árbol tenía 108,
  con tres días y cuatro sesiones de desfase.
- **Cómo se verificó:** `git check-ignore -v` sobre los cuatro y `git status
  --short` sin huérfanos. Commit `b721b9f`, 5 archivos, 11 inserciones y 514
  borrados.

### 4.11 Directorio propio para los paquetes de handoff

- **Archivos:** `50_documentacion/handoffs/`, `.gitignore` línea 39,
  `00_escanear_proyecto.R` línea 46.
- **Categoría:** deuda técnica.
- **Qué se hizo:** los dos paquetes de Claude Design pasaron de `andamios/` a
  `50_documentacion/handoffs/20260730_atlas_celeste/` y
  `.../20260803_elemento2_recorrido_datos/`. Se agregó `"handoffs"` al vector
  `excluir_dir` del escáner y la regla de ignorado con negación del `.gitkeep`.
- **Por qué:** `andamios/` es espacio de trabajo de sesión; los paquetes son
  entregables de un tercero con ciclo de vida propio. El inventario había saltado
  de 108 a 143 archivos al incluirlos.
- **Cómo se verificó:** el escáner posterior reporta 117 archivos y `handoffs/` no
  aparece; el conteo se verificó de forma independiente con las mismas
  exclusiones. Commits `1f36451` y `0104d2f`.
- **Nombres internos:** se conservaron los originales, espacios incluidos, porque
  son entregables de un tercero y renombrarlos rompería las referencias de su
  propio README.

### 4.12 Eliminación de `vendor/`

- **Archivo:** `.../design_handoff_elemento2_recorrido_datos/vendor/`.
- **Categoría:** limpieza.
- **Qué se hizo:** se borraron los 3,1 MB de Babel, 131 KB de ReactDOM y 11 KB de
  React descargados en §4.5.
- **Por qué:** el standalone de la segunda vuelta trae todo incrustado y volvió
  innecesario el prototipo sobre React.
- **Cómo se verificó:** `git status --short` vacío tras el borrado, confirmando
  que no generó cambio versionado.

---

## 5. Backlog acumulativo

Trece entradas nuevas, numeradas 115 a 127, agregadas a
`50_documentacion/activa/backlog_acumulativo.md`. Total acumulado: 127 cambios en
16 sesiones. El detalle vive en el archivo canónico; este traspaso no lo duplica.

---

## 6. Bugs de la sesión

Ninguno. No se escribió ni se modificó código de producción en esta sesión, de
modo que no hubo superficie donde pudiera aparecer un bug del sitio. Los dos
defectos corregidos (los anchos de la maqueta vanilla y el origen del conector)
son de artefactos desechables y están registrados en §4.6 y §4.8.

---

## 7. Aprendizajes y restricciones descubiertas

1. **Un prototipo de diseño se traslada, no se reinterpreta.** Cuando la lógica
   del prototipo ya es código plano, escribir una especificación en prosa
   intermedia introduce pérdida en cada salto. La regla: extraer la especificación
   del código fuente de forma programática y cotejar contra ella, no redactarla de
   memoria. *Qué pasa si se viola:* se pierde lo que la prosa no nombró, y lo que
   no se nombra son justamente los elementos que hacen que un diseño funcione (en
   este caso, la página crema, la tarjeta blanca que enmarca y las fichas sin
   caja). *Ejemplo:* §4.6 frente a §4.7.
2. **Un ancho de nodo no es un parámetro libre: es la medida en que el texto cabe
   en una línea.** Antes de reducir un ancho heredado de un diseño, hay que
   comprobar contra el contenido real qué rótulos dejan de caber. *Qué pasa si se
   viola:* aparece `overflow-wrap` como parche y el objeto queda ilegible.
3. **`overflow-wrap: break-word` y `hyphens: auto` son señales de alarma, no
   soluciones.** Disimulan un problema de dimensionamiento en vez de mostrarlo. En
   una maqueta de verificación deben estar prohibidos.
4. **Un objeto ancho puede romper el contenedor de texto.** El `.shell` de 1080 px
   está pensado para prosa; un mapa horizontal no es prosa. La técnica correcta es
   anidar un `.shell` propio para los textos y dejar el objeto libre, nunca
   modificar la regla `.shell`, que usan todas las secciones de ambas páginas.
5. **Un paquete de handoff no vive en el espacio de trabajo de sesión.** Tiene
   ciclo de vida propio, pesa cientos de kilobytes y trae recursos de terceros.
   Directorio propio, excluido del escáner e ignorado por git.
6. **La regla de mayúsculas sostenidas también es una regla de CSS.** Cumplirla en
   el texto escrito y violarla con `text-transform` es violarla.

---

## 8. Decisiones de diseño

| Decisión | Alternativas consideradas | Justificación | Implicancia |
|---|---|---|---|
| El título del elemento es «De la pregunta a la respuesta» | el del prototipo, «Cómo abordamos los desafíos desde el uso de datos educativos» | es el del contenido aprobado y el del brief | el prototipo se desvía y se corrige al trasladar |
| La bajada conserva «siempre el mismo recorrido» | la reformulación del prototipo, que relativiza a «un camino parecido» | la afirmación de método es el argumento del elemento | — |
| Se retira la caja «Acceso a los datos» del paso 4 | aprobarla como texto nuevo | introduce una afirmación sobre cómo sale el dato del Área que ninguna fuente aprobada respalda | si se quiere, entra por el documento de contenido, no por el prototipo |
| El bucle 6 → 1 se dibuja como conector visible | conservar solo la tarjeta «¿Cómo seguimos?» | es lo que distingue este objeto de una línea de tiempo | geometría derivada de `bGeo()`, no escrita a mano |
| El objeto rompe el `.shell` | encoger los nodos hasta caber | el criterio de aceptación 1 exige ver el recorrido completo | se anida un `.shell` propio para los textos |
| Los paquetes de handoff van a `50_documentacion/handoffs/` | dejarlos en `andamios/` | ciclo de vida propio y peso | el escáner los excluye |
| La salida del escáner sale del índice | dejarla o regenerarla en cada cierre | su versión pública desinformaba durante días | el inventario público desaparece; hoy nadie lo consume |

---

## 9. Constantes y parámetros

| Constante | Valor anterior | Valor nuevo | Archivo | Motivo |
|---|---|---|---|---|
| `excluir_dir` | `c(".git", "_archivo", "handoff", ".claude", "node_modules")` | agrega `"handoffs"` | `00_escanear_proyecto.R:46` | el directorio nuevo de handoffs no debe inventariarse |

Constantes del elemento 2 decididas y aún no en producción: ancho de pista 1536,
ficha de paso 136, columna de decisión 176, tarjeta de bucle 120, gap 8, globo
560, acotamiento de la muesca [14, 534]. Viven en
`20260803_maqueta_elemento2_v2.html` y en el prototipo; este traspaso es su
respaldo hasta que aterricen en `docs/`.

---

## 10. Arquitectura de archivos

Escáner al cierre: 2026-08-04 07:03:55, 16 carpetas y 117 archivos (fuente:
reporte de Claude Code de la tarea 5). El conteo se verificó de forma
independiente con las mismas exclusiones y coincide.

Cambio estructural: se creó `50_documentacion/handoffs/` con sus dos paquetes.
La estructura sigue conforme a la política; el directorio nuevo es del mismo
orden que `andamios/` y `estructura/`, con `.gitkeep` versionado y contenido
ignorado.

---

## 11. Pendientes y ruta sugerida

### Inventario

| # | Pendiente | Contexto | Tipo | Impacto | Dependencias | Complejidad | Precauciones | Criterio de éxito |
|---|---|---|---|---|---|---|---|---|
| P1 | Integrar el elemento 2 a `docs/formacion.html` | maqueta aprobada y plan emitido | Funcionalidad | Es la etapa 1 de la sección | Ninguna | Alta | Colisión de `pintar()` en `formacion.js`; verificación visual antes de commitear | Elemento en producción, revisado en navegador |
| P2 | Retirar la metáfora celeste de `formacion.html`: sección «Atlas», su bajada y la etiqueta «Ámbito de indagación» | fundamento §5 la abandonó | Deuda heredada | El sitio contradice su propio fundamento | P1 | Media | No borrar `atlas.js` ni `atlas.css` de paso: mencionarlos, no eliminarlos | Ninguna metáfora celeste visible |
| P3 | Corregir la referencia de `50_contrato_atlas_datos.md:6` a la ruta nueva del paquete | los paquetes se movieron | Documentación | Archivo público con ruta rota | Ninguna | Baja | Revisar si hay otras referencias versionadas entre las 14 detectadas | Referencia resuelta |
| P4 | Redacción del elemento 7, cierre | único elemento de la etapa 1 sin texto | Funcionalidad | La etapa 1 no cierra sin él | Ninguna | Baja | Es cierre, no llamada comercial (fundamento §6) | Texto verificado contra los siete criterios |
| P5 | Descripción escrita de los elementos 1, 3 y 4 como objetos | fundamento §9 exige texto aprobado antes de maqueta | Funcionalidad | Sin ella se repite el error de saltar a la forma | Ninguna | Media | Dos intentos por elemento (fundamento §10) | Descripciones aprobadas por el titular |
| P6 | Reescribir `index.html` a primera persona plural | tarea derivada 1 del fundamento | Deuda heredada | El sitio hablaría con dos voces | Ninguna | Media | No armonizar los registros: solo la voz | Portafolio en primera persona plural |
| P7 | Barra de navegación que exprese mandatos y no secciones | tarea derivada 2 del fundamento | Deuda heredada | Menor | P6 | Baja | Cambio de etiquetas visibles: revisar en navegador | Etiquetas aprobadas |
| P8 | Decidir el destino del tablero en `wip/atlas_tablero_v3` | es la única copia | Deuda técnica | Alto si se borra por error | Ninguna | Baja | 🔒 No borrar la rama sin decisión explícita | Decisión registrada |
| P9 | Resolver o retirar las 38 fuentes pendientes del catálogo | regla de difusión del fundamento §8 | Deuda de datos | Bloquea la difusión | Ninguna | Alta | Requiere credenciales o navegador del titular | Catálogo sin pendientes visibles |
| P10 | Ordenación del repositorio (POLITICA §4.7) | falta `50_documentacion/activa/50_ordenacion_repositorio.md` | Documentación | Bajo | Ninguna | Media | Mueve archivos: requiere aprobación previa | Documento emitido y estructura conforme |
| P11 | Autorizar el push de `main` | 37 commits locales | Bloqueante | El sitio publicado no refleja cuatro sesiones | P1 | Baja | 🔒 Push solo con autorización explícita | Push ejecutado |
| P12 | Regenerar las tres capturas del paquete del elemento 2 | las tres son el mismo archivo | Documentación | Bajo | Ninguna | Baja | Requiere volver a Claude Design | Tres capturas distintas |
| P13 | Decidir el destino de `docs/atlas.js` y `docs/atlas.css` | código muerto tras P2 | Deuda técnica | Bajo | P2 | Baja | No eliminar sin decisión del titular | Decisión registrada |

### Evaluación de deuda técnica

- **Zona frágil 1:** `formacion.js` concentrará dos objetos con estados
  independientes en una sola IIFE. Viola el principio de una responsabilidad por
  unidad. Conviene resolverlo al integrar y no después.
- **Zona frágil 2:** el sitio carga `atlas.js` y `atlas.css` sin usarlos. Cuesta
  poco y desinforma a quien lea el repositorio.
- **Oportunidad:** el inventario de estilos extraído programáticamente es un
  patrón reutilizable para cualquier handoff futuro de Claude Design.

### Auditoría de cierre (política 5.6)

| # | Pregunta | Respuesta |
|---|---|---|
| 5 | ¿Cada transformación crítica tiene check de validación? | Sí para el traslado del prototipo (cotejo contra inventario). El pipeline de R del catálogo no se tocó |
| 6 | ¿Los outputs son reproducibles e idempotentes? | La maqueta sí: es estática y sin red. No verificado para el pipeline de R |
| 7 | ¿Decisiones metodológicas como constantes nombradas? | Parcial: la geometría de la maqueta vive en un bloque `GEO`; los anchos siguen en CSS. Se resuelve al integrar |
| 8 | ¿Nombres sin tildes, ñ ni espacios? | No: los archivos internos de los dos paquetes de handoff tienen espacios. Se conservan por ser entregables de terceros. Pendiente aceptado, no corregible |

### Ruta sugerida para la próxima sesión

1. **P1 con P2 en la misma tanda.** Tocan el mismo archivo y la maqueta aprobada
   es lo único que puede enfriarse. *Criterio de éxito:* elemento 2 visible en
   `formacion.html`, revisado en navegador, sin metáfora celeste.
2. **P3.** Una línea, y es archivo público.
3. **P4.** Cierra la etapa 1 y es texto puro.
4. **P11 al final**, cuando la etapa 1 esté completa.

**Conviene diferir:** P5 hasta que P1 esté cerrado; P6 y P7 hasta que la sección
esté completa; P8, P9, P10, P12 y P13, que no bloquean nada.

---

## 12. Instrucciones específicas para la próxima sesión

- ⚠️ **NO** escribir código de producción de un elemento de la sección Formación
  antes de que su maqueta desechable esté revisada en navegador (fundamento §9).
- ⚠️ **NO** reinterpretar un prototipo de diseño desde una descripción en prosa
  cuando su código fuente está disponible: se traslada mecánicamente y se coteja
  contra un inventario extraído del propio código.
- ⚠️ **NO** reducir un ancho heredado de un diseño sin comprobar antes qué
  rótulos dejan de caber en una línea.
- ⚠️ **NO** usar `overflow-wrap: break-word` ni `hyphens: auto` para resolver un
  desbordamiento: disimulan un problema de dimensionamiento.
- ⚠️ **NO** afirmar estado de commits, ramas o archivos sin `git log`,
  `git status` o `git ls-files`.
- ✅ **ANTES** de integrar, leer `20260803_plan_integracion_elemento2.md` y
  resolver la colisión de `pintar()` en `formacion.js`.
- ✅ **ANTES** de tocar `formacion.html`, tener presente que la sección «Atlas» y
  la etiqueta «Ámbito de indagación» son restos de una metáfora abandonada.
- ✅ **ANTES** de modificar la regla `.shell`, recordar que la usan las dos
  páginas: para un objeto ancho se anida un `.shell` propio para los textos.
- 🔒 La rama `wip/atlas_tablero_v3` es la única copia del tablero: no se borra ni
  se reescribe sin decisión explícita.
- 🔒 Ningún `git push`, `--force`, `reset --hard` ni tag sin autorización
  explícita del titular.
- 🔒 Nunca `git add -A` ni `git add -f`; staging selectivo siempre.
- 🔒 Ninguna cadena de texto visible en mayúsculas sostenidas, ni escrita ni por
  `text-transform`. Solo siglas.
- 🔒 El texto de la sección no nombra establecimientos, personas ni
  identificadores, y no publica código.

---

## 13. Fragmentos de código de referencia

**Patrón nuevo: extraer la especificación de estilos desde el código fuente del
prototipo.** El extractor recorre la plantilla, junta cada elemento con su
atributo `style`, y produce la lista contra la cual se coteja la reimplementación.
Es la salvaguarda que reemplaza al juicio del asistente.

```
1. Aislar el bloque de plantilla del prototipo.
2. Por cada elemento con atributo style, emitir: selector propuesto +
   lista de declaraciones, incluidos style-hover y style-focus.
3. Marcar las declaraciones cuyo valor depende de una variable de la
   lógica: esas pasan a clases modificadoras, no a valores calculados.
4. Tras reimplementar, cotejar declaración por declaración y reportar
   faltantes. Una omisión deliberada exige una línea de motivo.
```

**Patrón nuevo: geometría derivada, nunca escrita a mano.** Ningún número de
geometría queda en el marcado; el script fija `viewBox`, `width`, `height` y el
trazo desde la función que ya calcula los centros. La comprobación es buscar los
literales en el cuerpo excluido el script y no encontrarlos.

Los patrones estables del proyecto viven en `CLAUDE.md` y en
`POLITICA_PROYECTO.md`; este traspaso no los re-copia.

---

## 14. Reapertura

**Mensaje de apertura pre-armado:**

> Tipo CONTINUATION. El protocolo (`POLITICA_PROYECTO.md` v5.6 +
> `SETTINGS_Y_PROMPTS_OPERACIONALES.md` v16) vive en la knowledge base del
> Project; verifica que estén al día antes de empezar. Adjunto el traspaso v16, el
> escáner, el backlog, el plan de integración del elemento 2, la maqueta aprobada
> y los tres archivos de la página de destino.
> Esta sesión es la número 3 de la ruta de implementación de la sección Formación.
> El objetivo es integrar el elemento 2 a `docs/formacion.html` y retirar en la
> misma tanda los restos de la metáfora celeste.
> Estado: sin bugs activos, sin bloqueantes, 37 commits locales sin pushear.
> Documentos a adjuntar: `traspaso_cierre_v16.md`, `estructura_actual.md`,
> `backlog_acumulativo.md`, `20260803_plan_integracion_elemento2.md`,
> `20260803_maqueta_elemento2_v2.html`, `docs/formacion.html`,
> `docs/formacion.css`, `docs/formacion.js`.

**Documentos para la próxima sesión**

1. *Protocolo en knowledge base (no se adjuntan; se listan para verificar que
   esté al día):* `POLITICA_PROYECTO.md`, `SETTINGS_Y_PROMPTS_OPERACIONALES.md`.
2. *Opcionales según el foco:* `CLAUDE.md`, porque la sesión correrá tareas en
   Claude Code.
3. *Específicos de la sesión (sí se adjuntan):*
   - `traspaso_cierre_v16.md`
   - `estructura_actual.md`
   - `backlog_acumulativo.md` (voluminoso pero crítico)
   - `20260803_plan_integracion_elemento2.md`
   - `20260803_maqueta_elemento2_v2.html` (la referencia aprobada)
   - `docs/formacion.html`, `docs/formacion.css`, `docs/formacion.js`
   - `50_fundamento_seccion_formacion.md`, si se tocará el contenido

**Nota final:** si alguno de estos archivos cambió entre sesiones, adjuntar la
versión más actualizada al abrir y avisarlo en el mensaje de apertura.

---

## 15. Errores del asistente

### Error 1

| Campo | Contenido |
|---|---|
| `momento` | Primera entrega de la maqueta desechable del elemento 2 |
| `disparador` | usuario lo corrigió |
| `que_paso` | La maqueta usó `text-transform: uppercase` en cuatro selectores, produciendo texto en mayúsculas sostenidas en la interfaz |
| `regla_violada` | `userPreferences` e instrucción explícita reiterada del titular: prohibición de mayúsculas sostenidas fuera de siglas |
| `causa_raiz` | La regla se trató como regla de redacción y no como regla de estilo visual: se cumplió en el texto escrito y se violó por CSS. No estaba escrita en ningún documento del proyecto, de modo que dependía de la memoria del asistente entre sesiones, soporte que no existe |
| `salvaguarda_presente` | `userPreferences` e historial conversacional; ningún documento del proyecto |
| `patron` | `PAT-01`, aplicado a una restricción cumplida en la forma e incumplida en el medio |
| `gatillo_observable` | `restriccion-no-propagada`: presencia de `text-transform: uppercase` o de cadenas en mayúsculas sostenidas en cualquier artefacto entregado |
| `intentos_previos` | Reincidencia señalada por el titular; ocurrencias exactas no contabilizadas en este proyecto |
| `costo` | Una entrega rechazada y un turno de corrección |

### Error 2

| Campo | Contenido |
|---|---|
| `momento` | Segunda entrega de la maqueta desechable del elemento 2 |
| `disparador` | usuario lo corrigió |
| `que_paso` | Se produjo una segunda representación visual insuficiente, agotando el presupuesto de dos intentos del fundamento §10 sin obtener una maqueta aprobada |
| `regla_violada` | Ninguna regla formal: falla de resultado, no de procedimiento. Se registra por POLITICA 0.5, disparador exhaustivo |
| `causa_raiz` | El asistente asumió la ejecución visual de un elemento declarado de peso interactivo alto, existiendo en el proyecto un canal específico de diseño con precedente (`encargo_diseno_portafolio.md`). Quién ejecuta la maqueta nunca se planteó en la Fase C |
| `salvaguarda_presente` | Ninguna: el fundamento §9 fija que debe existir una maqueta, no quién la produce |
| `patron` | `PAT-NUEVO-canal-omitido`: ejecutar internamente una tarea para la que el proyecto ya definió un canal externo especializado. Propuesta de entrada nueva al catálogo |
| `gatillo_observable` | `otro`: producir una representación visual de un elemento de peso interactivo alto sin evaluar antes si corresponde derivarla al canal de diseño |
| `intentos_previos` | 1: la primera maqueta, rechazada por mayúsculas y por disposición |
| `costo` | Dos entregas desechadas y el presupuesto de iteración del elemento consumido |

### Error 3

| Campo | Contenido |
|---|---|
| `momento` | Recomendación de anchos previa a la maqueta vanilla |
| `disparador` | usuario lo corrigió, en términos severos |
| `que_paso` | Se recomendó reducir los nodos de 136/176/120 a 85/110/75 para caber en el `.shell`, lo que partió ocho rótulos con guiones y volvió el recorrido ilegible |
| `regla_violada` | `userPreferences`, recomendación obligatoria: la opción recomendada debe ser la que sirve al objetivo. También el criterio de aceptación 1 del propio brief, que exige ver el recorrido completo |
| `causa_raiz` | Se trató el ancho como un parámetro libre en vez de como la medida en que el texto cabe en una línea, y no se comprobó contra el contenido real antes de recomendar. El origen más profundo es haber interpuesto una especificación en prosa entre el prototipo y la reimplementación: cada salto perdió fidelidad y la geometría quedó desligada de su motivo |
| `salvaguarda_presente` | El brief del propio asistente contenía el criterio que la recomendación incumplía |
| `patron` | `PAT-01`, sobre parámetro geométrico heredado tratado como ajustable |
| `gatillo_observable` | `otro`: modificar una medida heredada de un diseño sin verificar contra el contenido real qué deja de caber |
| `intentos_previos` | 2: las dos maquetas anteriores |
| `costo` | Una maqueta completa rehecha desde cero, dos turnos y pérdida de confianza explícita del titular |

### Error 4

| Campo | Contenido |
|---|---|
| `momento` | Encargo de cierre a Claude Code |
| `disparador` | Claude Code lo señaló antes de ejecutar |
| `que_paso` | El encargo pedía `git rm --cached` sobre el `.gitkeep` si estaba trackeado y a la vez que el `.gitkeep` no quedara huérfano: dos instrucciones mutuamente excluyentes |
| `regla_violada` | `userPreferences`, encargos: toda premisa de un encargo debe ser verificable y consistente |
| `causa_raiz` | Se redactó la precaución («que no quede huérfano») sin comprobar que fuera compatible con la acción pedida en el paso anterior del mismo encargo |
| `salvaguarda_presente` | `userPreferences` |
| `patron` | `PAT-01`, sobre premisa interna de un encargo |
| `gatillo_observable` | `encargos-premisas`: dos pasos del mismo encargo que no pueden cumplirse a la vez |
| `intentos_previos` | 0 |
| `costo` | Un turno de consulta antes de ejecutar; ningún trabajo perdido, porque Claude Code lo detectó a tiempo |

### Error 5

| Campo | Contenido |
|---|---|
| `momento` | Redacción del encargo de cierre, tras la caída del clasificador |
| `disparador` | usuario lo corrigió |
| `que_paso` | Se redactó el encargo dando por ejecutadas tareas que nunca se habían enviado |
| `regla_violada` | `userPreferences`, marcador de fuente: toda afirmación sobre estado del repositorio requiere fuente verificada en la sesión |
| `causa_raiz` | Se confundió haber redactado un encargo con haberlo ejecutado, y se construyó el encargo siguiente sobre ese supuesto sin verificarlo |
| `salvaguarda_presente` | `userPreferences` y las instrucciones heredadas del traspaso v15 |
| `patron` | `PAT-01`, sobre estado de ejecución |
| `gatillo_observable` | `estado-git`: afirmar que una tarea se ejecutó sin salida de terminal que lo respalde |
| `intentos_previos` | 0 |
| `costo` | Un encargo interrumpido y reescrito |

### Fricciones

- `friccion: respuestas largas cuando el titular pedía una decisión → se pasó a respuestas de una línea y a listas con recomendación explícita.`
- `friccion: la maqueta se entregó sin indicar la ruta que había que abrir → se pasó a entregar la ruta absoluta sola, en su propia línea.`
