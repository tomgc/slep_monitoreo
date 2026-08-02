# Fundamento de la sección Formación

> **Destino:** `50_documentacion/activa/50_fundamento_seccion_formacion.md`
> **Versión 1.** Generado en la sesión 14 de `slep_monitoreo`, sesión de
> planificación sin producción de código.
> **Por qué existe:** tres representaciones del atlas fueron descartadas en dos
> sesiones (fuente: `traspaso_cierre_v13.md`, leído en la sesión que genera este
> documento). El diagnóstico del titular no fue que la metáfora visual estuviera
> mal elegida, sino que la sección nunca declaró para qué existe, cómo debe
> contar lo que cuenta y qué elementos la componen en qué orden. Sin ese
> documento, cada iteración se juzgaba por gusto y no contra un criterio.

Este documento es la fuente de verdad de la sección Formación. Toda
representación futura se juzga contra él. Si una decisión de diseño lo
contradice, se cambia el documento primero y por escrito, no la decisión sobre
la marcha.

---

## 1. Propósito

La sección Formación demuestra el método del Área de Monitoreo (cómo convierte
las preguntas y desafíos que le plantea el Servicio Local en respuestas basadas
en datos, contribuyendo desde los datos disponibles en el sistema educativo
chileno a espacios de trabajo interdisciplinares) y, mediante esa demostración,
forma: presenta de manera instruccional y narrativa una forma de abordar
desafíos en materia de datos educativos, replicable por quien la lee.

El catálogo de fuentes es evidencia y material del método, no el producto de la
sección.

**Ubicación institucional.** El Área tiene tres ámbitos de actuación:

1. Monitoreo de procesos y resultados de establecimientos y jardines infantiles.
2. Monitoreo de procesos y resultados del SLEP.
3. Fortalecimiento de capacidades para la toma de decisiones basada en datos.

La sección Formación pertenece al tercero. El portafolio (`index.html`) muestra
el trabajo de los dos primeros.

**Consecuencia estructural.** El elemento organizador de la sección no es la
institución productora de datos, sino el desafío educativo: las fuentes
aparecen porque una pregunta las convoca.

---

## 2. Audiencia y situación de uso

**Destinatario primario**

- Equipos directivos y técnicos de establecimientos y jardines infantiles.
- Áreas y subdirecciones del Servicio Local con las que se comparten los
  espacios de trabajo interdisciplinar.
- Pares externos (otros SLEP, Mineduc, DEP), con énfasis en áreas de monitoreo
  de instalación más reciente.

**Destinatario secundario.** Cualquier persona interesada en cómo trabaja un
Servicio Local y, específicamente, su área de monitoreo.

**Llegada doble.** En frío, desde la dirección en la firma de correo de los
profesionales del Área: sin contexto previo y sin facilitador presente. Y
proyectada o compartida en talleres y reuniones con otras áreas.

**Piso técnico.** Se supone familiaridad con el contexto educativo nacional y
ninguna competencia en procesamiento de datos. Se pueden nombrar Simce,
matrícula, IVE o PME sin glosarlos. No se puede suponer que alguien sabe qué es
un microdato, un identificador de unión o una base longitudinal: ese vocabulario
se introduce.

**Tensión que esto crea.** La narración debe sostenerse sola (llegada en frío) y
a la vez ser proyectable (bloques legibles a distancia, no párrafos densos).
Ambas condiciones son criterios de aceptación, no aspiraciones.

---

## 3. Alcance y no-alcance

**Alcance**

- Entender qué fuentes de datos existen en el sistema educativo chileno y cómo
  se articulan en un método de trabajo.
- Espacio en crecimiento, declarado como tal: se agregarán contenidos formativos
  por etapas.
- Presenta el método en abstracto y casos reales del Área, estos últimos siempre
  en términos conceptuales: la pregunta, las fuentes convocadas, las variables,
  el criterio metodológico.

**No-alcance**

- No enseña a descargar, cruzar ni calcular indicadores.
- No publica código ni fragmentos de código.
- No nombra establecimientos ni sus identificadores, ni difunde datos privados o
  resultados atribuibles a una comunidad concreta.
- No es el catálogo interno de trabajo del Área: publica lo que corresponde
  publicar según la sección 8, no el archivo completo.

---

## 4. Relación con el portafolio

**Dos registros deliberadamente distintos.**

| | Portafolio (`index.html`) | Formación (`formacion.html`) |
|---|---|---|
| Registro | Vitrina institucional | Narración instruccional |
| Unidad | Proyecto cerrado, captura, reseña | Recorrido con secuencia |
| Estado | Obra terminada | Espacio en crecimiento |
| Ámbitos de actuación | 1 y 2 | 3 |

No se armonizan entre sí. Lo que los une es el sistema visual (tipografía,
paleta, barra de navegación, pie) y el anclaje compartido: educación como tema,
sistema educativo chileno como contexto, Área de Monitoreo como voz, SLEP Costa
Central como institución.

**Capas paralelas, no jerarquía.** Ninguna se entra desde la otra ni supone la
otra leída. Responden a mandatos distintos del Área. La audiencia que llega en
frío desde una firma de correo entra directo a Formación.

**Deuda que esto abre.** La barra de navegación dice hoy "Portafolio / Formación
en datos", que se lee como dos secciones de un sitio y no como dos mandatos de
un área (fuente: `index.html` y `formacion.html`, leídos en la sesión que genera
este documento). Revisarla es tarea posterior, fuera de este documento.

---

## 5. Línea editorial

**Voz.** Primera persona plural: nosotros, el Área de Monitoreo. Aplica a todo el
sitio. El portafolio está hoy en tercera persona, de modo que su reescritura es
una tarea derivada de esta decisión y entra al backlog.

**Metáfora celeste.** Se abandona. Lenguaje llano. No queda prohibida a futuro:
podrá volver como un recurso entre otros para narrar un contenido específico,
nunca como vocabulario estructural de la sección. La metáfora fue el vocabulario
común a las tres representaciones descartadas.

**Forma.** Bloques cortos de texto intercalados con objetos interactivos. El
objeto interactivo no ilustra el texto: es el lugar donde se demuestra el paso a
paso, los criterios y las decisiones metodológicas mediante ejemplos didácticos.
La didáctica manda sobre la estética y sobre la completitud del catálogo.

**Terminología.** Dos términos casi idénticos no conviven en la misma página:

| Término | Significado | Origen |
|---|---|---|
| Ámbito de actuación | Los tres mandatos del Área | Orientaciones ministeriales, no se altera |
| Desafío educativo | Agrupador del catálogo, antes "ámbito de indagación" | Renombrado en esta sesión |

El renombre aplica de inmediato a la etiqueta visible. Los identificadores
internos (`ATLAS_AMBITOS` en `atlas_datos.js`, el esquema de
`50_contrato_atlas_datos.md` §2.4, el validador) se renombran en una tarea de
código posterior.

---

## 6. Promesa de uso

**Promesa acumulativa y ampliable.** Quien recorre la sección se lleva:

- comprender un método replicable de abordaje de desafíos con datos;
- saber a quién preguntar en su propio establecimiento o servicio;
- poder identificar qué fuente responde a una pregunta suya.

La lista es abierta: los contenidos formativos futuros pueden agregar promesas,
no reemplazar estas.

**Cierre.** La sección termina remitiendo al portafolio (los desafíos ya
abordados) y al contacto del Área. No es una llamada comercial: es la conexión
entre los mandatos del Área.

**Modo de recorrido.** Lineal de arriba abajo como diseño primario, con la ruta
visible desde el comienzo: la persona ve el mapa del recorrido y puede saltar.
Esto exige un índice o indicador de progreso persistente. No es un adorno: es lo
que permite que convivan la llegada en frío (recorrido completo) y el uso en
taller (salto a un bloque).

---

## 7. Inventario y orden de los elementos

| # | Elemento | Qué hace | Peso interactivo |
|---|---|---|---|
| 1 | Quiénes somos y qué hacemos | Los tres ámbitos de actuación; esta sección pertenece al tercero. Anuncia la ruta completa | Bajo |
| 2 | Cómo contribuimos desde los datos | El método: la pregunta llega desde un espacio interdisciplinar y el Área contribuye desde los datos disponibles | **Alto** |
| 3 | Un desafío educativo en detalle | El más ilustrativo, recorrido con un caso real del Área en términos conceptuales | **Alto** |
| 4 | Todos los desafíos educativos | Panorama: cada desafío invita a analizar datos distintos | Medio |
| 5 | Catálogo de fuentes | Repertorio completo, tabla filtrable. Amplía la mirada sobre lo que existe públicamente | Consulta |
| 6 | El cruce | Qué fuentes consultar para abordar qué desafío, y qué problemas de análisis plantea cada uno | **Alto** |
| 7 | Cierre | Portafolio y contacto del Área | Nulo |

**Sobre el elemento 2.** Texto breve más un diagrama de flujo interactivo del
paso a paso: lineal en tramos y con bifurcaciones reales. Ejemplo de
bifurcación: si el dato existe en el sistema, se consulta la fuente oficial; si
no existe, se evalúa la factibilidad de levantarlo con un instrumento propio.

**Sobre el elemento 3.** Un caso real es el ejemplo que retrata el abordaje de un
desafío educativo. Va antes del catálogo: demuestra y motiva la consulta
posterior.

**Sobre el elemento 5.** Su función es ampliar la mirada sobre la información y
los datos disponibles de forma pública en el sistema educacional chileno. Es
consulta, no recorrido: no interrumpe la narración porque llega después de ella.

**Sobre el elemento 6.** Es la síntesis de 4 y 5 y el objeto protagonista de la
sección. El protagonista no es el catálogo como inventario de filas, sino el
catálogo leído desde los desafíos educativos: una pregunta convoca fuentes de
instituciones distintas. Ese es el itinerario narrativo de la sección completa.

---

## 8. Qué se publica y cuándo

**Publicación por etapas.**

| Etapa | Contenido | Estado |
|---|---|---|
| 1 (mínimo publicable) | Elementos 1 a 4, más el cierre (7) | Siguiente objetivo |
| 2 | Elemento 5, catálogo de fuentes | Después de la etapa 1 |
| 3 | Elemento 6, el cruce | Después de la etapa 2 |

**Catálogo mientras el sitio no está difundido.** Se publica con las fuentes
pendientes visibles, con la nota de catálogo en revisión que ya existe en
`formacion.html`. La audiencia real hoy es solo el Área, y ver lo que falta es
útil para el trabajo.

**Regla de difusión (vence la flexibilidad anterior).** Antes de difundir la
dirección (firma de correo, talleres), las pendientes dejan de ser visibles: o se
resuelven, o las fuentes no verificadas se retiran del catálogo público. Una
sección que demuestra método no puede exhibir un catálogo con huecos declarados
ante su audiencia externa.

**Sin fecha forzada.** Ningún hito externo obliga a publicar. La decisión es del
Área.

---

## 9. Criterios de aceptación

Toda representación futura se juzga contra estos siete criterios, antes de
juzgarla por gusto.

1. **Se sostiene sin facilitador.** Alguien que llega en frío desde una firma de
   correo entiende la sección sin que nadie se la explique.
2. **Es legible proyectada.** Bloques cortos, jerarquía fuerte, sin párrafos
   densos que exijan lectura de cerca.
3. **Funciona de arriba abajo con ruta visible.** Recorrido lineal primario, con
   el mapa del recorrido a la vista y salto posible.
4. **Introduce el vocabulario técnico de datos y da por sabido el educativo.**
   Nada de glosar Simce o PME; nada de suponer microdato o identificador de
   unión.
5. **No expone establecimientos ni código.** Ni nombres, ni identificadores, ni
   datos privados, ni fragmentos de código.
6. **Concentra el peso interactivo donde corresponde.** Elementos 2, 3 y 6. El
   resto es texto o consulta.
7. **Completitud narrativa.** Un lector externo puede decir con sus propias
   palabras cómo trabaja el Área después de recorrer la sección.

**Verificación en dos pasos, en este orden.**

1. Descripción escrita del elemento, aprobada por el titular contra los siete
   criterios.
2. Maqueta desechable revisada en navegador.

Recién después se escribe código de producción. Este orden es la corrección
formal del error que produjo los tres descartes.

---

## 10. Regla de descarte y presupuesto de iteración

- **Dos intentos por elemento.** No tres.
- **La detención es obligatoria ante un criterio de la sección 9 incumplido.** El
  gusto es motivo legítimo de ajuste y nunca de descarte: si algo se descarta,
  se nombra el criterio que falla.
- **Tras el segundo descarte de un elemento, se vuelve a este documento antes de
  probar una tercera forma.** Tres formas fallidas ya demostraron una vez que el
  problema no estaba en la forma.

---

## 11. Tareas derivadas (fuera del alcance de este documento)

| # | Tarea | Origen |
|---|---|---|
| 1 | Reescribir `index.html` a primera persona plural | Sección 5, voz |
| 2 | Revisar la barra de navegación para que exprese mandatos y no secciones | Sección 4 |
| 3 | Renombrar los identificadores internos de `ambito` a `desafio` en `atlas_datos.js`, el contrato y el validador | Sección 5, terminología |
| 4 | Resolver o retirar las fuentes pendientes del catálogo antes de difundir | Sección 8 |
| 5 | Decidir el destino definitivo del tablero en `wip/atlas_tablero_v3` | Sesión 14, P2 |
