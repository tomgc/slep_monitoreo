/* ============================================================
 *  Un paper al día — base de datos
 * ------------------------------------------------------------
 *  Para añadir un paper, copia la plantilla del final de este
 *  archivo y agrégalo al array `PAPERS`. Mantén el slug único
 *  (recomendado: AAAA-MM-DD-apellido-palabra-clave).
 *
 *  Campos:
 *    slug          → identificador único en URLs e enlaces
 *    title         → título del paper
 *    authors       → array de autores
 *    year          → año de publicación
 *    read_date     → fecha en que lo leíste (AAAA-MM-DD)
 *    category      → categoría temática principal
 *    subcategory   → subcategoría
 *    tags          → array de etiquetas transversales
 *    journal       → revista o conferencia (opcional)
 *    volume,issue,pages → datos bibliográficos (opcionales)
 *    source        → URL al paper
 *    doi           → DOI sin prefijo (opcional)
 *    references    → array de slugs de otros papers que cita
 *    body          → síntesis en Markdown (template literal)
 * ============================================================ */

window.PAPERS = [
  {
    slug: "2026-04-08-ahl-motivation-adult-education",
    title: "Motivation in adult education: a problem solver or a euphemism for direction and control?",
    authors: ["Helene Ahl"],
    year: 2006,
    read_date: "2026-04-08",
    category: "Educación",
    subcategory: "Educación de adultos",
    tags: ["motivación", "análisis del discurso", "Foucault", "pedagogía crítica", "gubernamentalidad"],
    journal: "International Journal of Lifelong Education",
    volume: "25",
    issue: "4",
    pages: "385-405",
    source: "https://doi.org/10.1080/02601370600772384",
    doi: "10.1080/02601370600772384",
    references: [],
    body: `## TL;DR
Helene Ahl somete la noción de **motivación** en la educación de adultos a un análisis crítico del discurso desde una mirada foucaultiana. Argumenta que, lejos de ser un constructo neutro, la motivación funciona como un eufemismo para *encauzar y controlar* a los aprendices adultos, individualizando lo que con frecuencia son problemas estructurales.

## Idea central
La autora examina cómo el concepto de motivación, dado por sentado en gran parte de la literatura sobre educación de adultos, opera como un dispositivo discursivo. Quien "carece de motivación" es construido como alguien deficiente que requiere intervención; rara vez se interroga si los objetivos a los que debería motivarse son legítimos o deseables para el propio aprendiz.

## Argumentos principales
1. **La motivación como problema individual.** La literatura tiende a ubicar el déficit en el estudiante, ignorando barreras económicas, culturales o de diseño curricular.
2. **Universalidad sospechosa.** Las teorías motivacionales asumen metas comunes —típicamente vinculadas a la productividad y la empleabilidad— como si fuesen incontestables.
3. **Gubernamentalidad foucaultiana.** Motivar es una técnica de gobierno suave: produce sujetos autodisciplinados que internalizan los fines del sistema sin necesidad de coerción explícita.
4. **Resistencia recodificada.** Lo que podría leerse como resistencia legítima de los aprendices —no presentarse, abandonar, no comprometerse— es traducido al lenguaje clínico de "falta de motivación".
5. **El educador como técnico.** El rol docente queda reducido a aplicar técnicas para corregir el déficit motivacional, despolitizando la práctica pedagógica.

## Por qué importa (y cómo conecta con el monitoreo educativo)
Para cualquier sistema de monitoreo educativo, la pregunta de Ahl es incómoda y necesaria: cuando medimos *compromiso*, *asistencia* o *participación*, ¿estamos diagnosticando a las personas o estamos evaluando si nuestros objetivos institucionales merecen su tiempo? El paper invita a **desnaturalizar indicadores** que parecen obvios y a considerar la perspectiva del aprendiz como agente, no como objeto de intervención.

## Marco teórico
- Foucault: gubernamentalidad y poder disciplinario.
- Análisis crítico del discurso aplicado a literatura académica del campo.
- Diálogo implícito con la pedagogía crítica (Freire, Giroux).

## Para leer en diálogo con
- Paulo Freire — concientización y pedagogía del oprimido.
- Gert Biesta — la función de subjetivación de la educación.
- Literatura sobre *dropout* adulto y barreras estructurales al aprendizaje.

## Limitaciones o tensiones
- El énfasis crítico puede leerse como rechazo al concepto mismo de motivación; el desafío que deja abierto es **reformularlo, no descartarlo**.
- El corpus es la propia literatura académica: faltan voces empíricas de aprendices adultos.

## Cita destacada
> *(pendiente de transcribir tras la lectura completa)*

## Preguntas que me deja
- ¿Qué pasaría si los indicadores de "participación" incluyeran la posibilidad de *no participar* como dato significativo, y no como déficit?
- ¿Cómo distinguimos, en la práctica, una intervención motivacional emancipadora de una disciplinaria?
`
  }

  /* ------------------------------------------------------------
   * PLANTILLA — copia esto para añadir un nuevo paper
   * ------------------------------------------------------------
   * ,{
   *   slug: "AAAA-MM-DD-apellido-tema",
   *   title: "",
   *   authors: [""],
   *   year: 0,
   *   read_date: "AAAA-MM-DD",
   *   category: "",
   *   subcategory: "",
   *   tags: [],
   *   journal: "",
   *   source: "",
   *   doi: "",
   *   references: [],
   *   body: \`## TL;DR
   *
   * ## Idea central
   *
   * ## Argumentos principales
   *
   * ## Por qué importa
   *
   * ## Notas
   * \`
   * }
   * ------------------------------------------------------------ */
];
