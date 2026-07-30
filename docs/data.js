/* ===========================================================
   Área de Monitoreo — Datos del sitio
   Edite estos arreglos para agregar/quitar contenido.
   El portafolio se construye solo a partir de PROYECTOS.
   =========================================================== */

/* Estado: "vigente" | "desarrollo"
   id: llave estable y única del proyecto. Es la llave de la URL
       (#p=<id> abre la reseña de ese proyecto) y el prerrequisito de los
       códigos QR del catálogo impreso. NO se cambia una vez publicado:
       cualquier enlace ya compartido dejaría de resolver. `orden` no
       sirve para esto porque se renumera al insertar proyectos.
   orden: número de aparición en el sitio. Los proyectos "vigente" se
          muestran primero, ordenados por este número; los "desarrollo"
          van siempre al final, también ordenados entre sí por este número.
   imgs: arreglo de rutas a capturas del proyecto (ej. ['assets/proyectos/x-1.png']).
         La primera es la portada del banner; el lightbox las muestra todas en un pasador.
         Si el arreglo está vacío, se muestra el marcador 'próximamente'.
   sintesis: arreglo de párrafos que se muestra en la reseña (lightbox). */
const PROYECTOS = [
  {
    id: "asistencia",
    orden: 1,
    tipo: "Minuta · Dirección Ejecutiva",
    titulo: "Minuta de asistencia mensual",
    objetivo: "Reporte dirigido al Director Ejecutivo cuyo propósito es informar respecto a los principales indicadores que se desprenden de esta variable, segmentándola a nivel de territorio, comuna, tipo de enseñanza, establecimiento y nivel educativo.",
    sintesis: [
      "La asistencia escolar es uno de los principales barómetros de la trayectoria educativa de un estudiante. En este contexto, la minuta mensual de asistencia surge a partir de una necesidad concreta para la gestión del servicio educativo gestionado por el SLEP Costa Central en el territorio.",
      "En este reporte, dirigido al Director Ejecutivo y construido a partir del análisis de los registros de asistencia diaria de cada estudiante del territorio, se le informa respecto a los principales indicadores que se desprenden de esta variable, segmentándola a nivel de territorio, comuna, tipo de enseñanza, establecimiento y nivel educativo, entre otros. Contiene una selección de alertas de inasistencia priorizadas para la toma de decisiones, así como una proyección de la asistencia anual basada en años anteriores."
    ],
    estado: "vigente",
    imgs: [
      "assets/proyectos/asistencia-1.png",
      "assets/proyectos/asistencia-2.png",
      "assets/proyectos/asistencia-3.png",
      "assets/proyectos/asistencia-4.png"
    ]
  },
  {
    id: "resguardo",
    orden: 2,
    tipo: "Reporte · Directores/as",
    titulo: "Reportes del Modelo de Resguardo de la Asistencia Educativa del Territorio",
    objetivo: "Dirigido a cada director y directora de los establecimientos del SLEP Costa Central, este reporte entrega información pertinente, oportuna, precisa y accionable sobre la asistencia de su unidad educativa. Tiene una frecuencia mensual e incluye, además de indicadores con distintos grados de segmentación, el detalle de cada estudiante que gatilla una de las alertas definidas como críticas para el resguardo de su trayectoria educativa.",
    sintesis: [
      "El Plan para el Fortalecimiento de la Asistencia Educativa del SLEP Costa Central fija como uno de sus objetivos establecer un marco institucional de trabajo en materia de asistencia para todos los establecimientos del territorio. Lo anterior se materializa a través del Modelo de Resguardo de la Asistencia Educativa del Territorio, el cual, además de orientaciones, planes de acción y actividades de socialización, evaluación y mejora, tiene como uno de sus componentes un reporte sobre esta temática dirigido a todos los directores y directoras del SLEP.",
      "Este reporte entrega información pertinente, oportuna, precisa y accionable sobre la asistencia de cada establecimiento. Tiene una frecuencia mensual e incluye, además de indicadores con distintos grados de segmentación, el detalle de cada estudiante que gatilla una de las alertas definidas como críticas para el resguardo de su trayectoria educativa."
    ],
    estado: "vigente",
    imgs: [
      "assets/proyectos/resguardo-1.png",
      "assets/proyectos/resguardo-2.png",
      "assets/proyectos/resguardo-3.png",
      "assets/proyectos/resguardo-4.png"
    ]
  },
  {
    id: "simce",
    orden: 3,
    tipo: "Minuta · Resultados Simce",
    titulo: "Minutas de resultados Simce 2025 del territorio",
    objetivo: "Serie de tres minutas que sistematiza los resultados del Simce 2025 de los establecimientos educacionales del SLEP Costa Central. Cada minuta aborda un ámbito distinto de la entrega de la Agencia de Calidad de la Educación: la variación de los puntajes, la distribución de los estudiantes en los Estándares de Aprendizaje y el comportamiento de los Indicadores de Desarrollo Personal y Social (IDPS).",
    sintesis: [
      "La Agencia de Calidad de la Educación publicó en marzo de 2026 los resultados del Simce 2025, aplicado a estudiantes de 4° básico, 8° básico y 2° medio. Contar con estos datos al inicio del año escolar abre una ventana breve para convertirlos en decisiones pedagógicas. Para aprovecharla, elaboramos una serie de tres minutas que traduce la entrega nacional a la escala del territorio y a las preguntas que efectivamente se hace el Servicio.",
      "La primera minuta presenta el panorama de los establecimientos educacionales del territorio según la variación de sus puntajes en las pruebas de Lectura y Matemática de 4° básico y 2° medio, distinguiendo qué establecimientos mejoraron o retrocedieron de forma estadísticamente significativa respecto de la aplicación anterior y cómo se comparan con su grupo socioeconómico (GSE) de referencia.",
      "La segunda minuta profundiza en los Estándares de Aprendizaje, que clasifican el logro de los estudiantes en tres niveles (Adecuado, Elemental e Insuficiente). Presenta la distribución de estudiantes por establecimiento educacional, segmentada por GSE y contrastada con la medición anterior, poniendo el foco en la proporción que alcanza el nivel Adecuado como indicador de logro.",
      "La tercera minuta cubre los Indicadores de Desarrollo Personal y Social (autoestima académica y motivación escolar, clima de convivencia escolar, participación y formación ciudadana, y hábitos de vida saludable), consolidando los cuatro indicadores en una sola vista por establecimiento educacional para identificar cambios transversales y perfiles heterogéneos.",
      "En conjunto, la serie entrega al Servicio una lectura completa y comparable de sus resultados, con las precauciones metodológicas declaradas de forma explícita, de modo que la conversación con cada comunidad educativa parta de evidencia común."
    ],
    estado: "vigente",
    imgs: []
  },
  {
    id: "estandares",
    orden: 4,
    tipo: "Motor de comparación",
    titulo: "Motor de comparación interactivo de los resultados de los estándares de aprendizaje medidos por las pruebas Simce",
    objetivo: "Herramienta interactiva que organiza los resultados actuales e históricos de los estándares de aprendizaje medidos a través de las pruebas Simce, a escala nacional, permitiendo navegarlos por establecimiento, comuna, SLEP, región y nivel nacional, a lo largo de todos los años para los cuales existen resultados.",
    sintesis: [
      "Desarrollamos un motor de comparación interactivo de los resultados de las pruebas Simce expresados según los estándares de aprendizaje, que clasifican el logro de los estudiantes en tres niveles: Adecuado, Elemental e Insuficiente.",
      "La herramienta organiza esta información a escala nacional, ponderando los resultados de cada prueba según el número de estudiantes que la rindió, permitiendo recorrer los resultados por establecimiento, comuna, SLEP, región y nivel nacional, a lo largo de todos los años para los cuales existen resultados.",
      "Su pantalla única de visualización pone especial atención en el nivel Adecuado (el más exigente) como indicador de logro, con la mirada puesta en cómo evoluciona en cada territorio y cómo se compara entre grupos socioeconómicos equivalentes."
    ],
    estado: "vigente",
    imgs: [
      "assets/proyectos/estandares-1.png",
      "assets/proyectos/estandares-2.png",
      "assets/proyectos/estandares-3.png"
    ]
  },
  {
    id: "idps",
    orden: 5,
    tipo: "Motor de comparación",
    titulo: "Motor de comparación interactivo de los resultados en los Indicadores de Desarrollo Personal y Social (IDPS)",
    objetivo: "Desarrollamos un motor de comparación interactivo que organiza y visualiza los resultados de los Indicadores de Desarrollo Personal y Social (IDPS) de todo el país y desde el inicio de su medición. De esta forma, es posible navegar por los resultados actuales e históricos de un establecimiento, además de explorar uno o múltiples territorios de manera simultánea y comparativa.",
    sintesis: [
      "Los Indicadores de Desarrollo Personal y Social (IDPS) que la Agencia mide junto al Simce capturan aspectos que, si bien están planteados como no estrictamente académicos, resultan fundamentales para comprender de manera integral la experiencia educativa de los estudiantes. Estos indicadores (autoestima académica y motivación, clima de convivencia, participación y formación ciudadana, y hábitos de vida saludable) sirven de barómetro para leer en contexto los resultados de las pruebas académicas del Simce.",
      "Para analizar estos resultados, desarrollamos un motor de comparación interactivo que organiza y visualiza los resultados de todo el país y desde el inicio de su medición, a través del cual es posible navegar por los resultados actuales e históricos de un establecimiento, además de explorar uno o múltiples territorios de manera simultánea y comparativa."
    ],
    estado: "vigente",
    imgs: [
      "assets/proyectos/idps-1.png",
      "assets/proyectos/idps-2.png",
      "assets/proyectos/idps-3.png",
      "assets/proyectos/idps-4.png"
    ]
  },
  {
    id: "categorias",
    orden: 6,
    tipo: "Motor de comparación",
    titulo: "Motor de comparación interactivo de la Categoría de Desempeño de los establecimientos educacionales del país",
    objetivo: "Desarrollamos un motor de comparación interactivo para las Categorías de Desempeño, uno de los componentes clave del Sistema de Aseguramiento de la Calidad de la Educación. Esta herramienta organiza la información en torno a este ordenamiento a escala nacional y permite explorarla de manera desagregada por comuna, SLEP y región.",
    sintesis: [
      "Las Categorías de Desempeño son uno de los componentes clave del Sistema de Aseguramiento de la Calidad de la Educación. Esta ordenación evalúa a cada establecimiento bajo un modelo de rendimiento ajustado al contexto, el cual cruza sus resultados educativos y formativos con el perfil de vulnerabilidad de sus estudiantes para determinar qué tan cerca o lejos están de lo esperado.",
      "Para facilitar el análisis de estos datos, desarrollamos una herramienta interactiva que organiza la información a escala nacional y permite explorarla de manera dinámica por comuna, Servicio Local de Educación Pública (SLEP), región y nivel país, distinguiendo con precisión la educación básica de la media. Su aporte es ofrecer, en una sola herramienta, dos lecturas complementarias: la distribución de los establecimientos por categoría en cada territorio y la evolución de cada establecimiento en el tiempo. Como la Categoría de Desempeño ya incorpora el contexto socioeconómico en su construcción, el motor presenta las clasificaciones tal como las publica la Agencia de Calidad de la Educación, sin segmentaciones adicionales."
    ],
    estado: "vigente",
    imgs: [
      "assets/proyectos/categorias-1.png",
      "assets/proyectos/categorias-2.png",
      "assets/proyectos/categorias-3.png"
    ]
  },
  {
    id: "parvularia",
    orden: 7,
    tipo: "Monitoreo",
    titulo: "Monitoreo de aprendizajes en la educación parvularia",
    objetivo: "Sistema que organiza las evaluaciones realizadas por las educadoras de los jardines infantiles del territorio y los presenta en informes interactivos, segmentados por momento evaluativo y niveles de agrupación que van desde todo el territorio hasta cada párvulo.",
    sintesis: [
      "En conjunto con la coordinación de Educación Parvularia del Área de Mejora Continua y siguiendo los principios de las Bases Curriculares de la Educación Parvularia vigentes, construimos un sistema de monitoreo de aprendizajes para la educación inicial del SLEP Costa Central. Este sistema organiza las evaluaciones realizadas por las educadoras por ámbito, núcleo y objetivo de aprendizaje y los presenta en informes interactivos que permiten segmentar los resultados por momento evaluativo (diagnóstico, primer semestre y segundo semestre) y diversos niveles de agrupación (territorio, jardín infantil, educadora y párvulo).",
      "Su aporte es hacer visible, en un mismo lugar, la cobertura curricular y el logro de los objetivos de aprendizaje a lo largo de los tres momentos de evaluación del año, lo que permite realizar un seguimiento longitudinal y una priorización pedagógica pertinente y oportuna para cada nivel de la educación inicial."
    ],
    estado: "vigente",
    imgs: [
      "assets/proyectos/parvularia-1.png",
      "assets/proyectos/parvularia-2.png",
      "assets/proyectos/parvularia-3.png"
    ]
  },
  {
    id: "inicial",
    orden: 8,
    tipo: "Análisis longitudinal",
    titulo: "Análisis longitudinal de preferencias de matrícula de egresados de jardines infantiles",
    objetivo: "¿Hacia dónde continúan su escolaridad los niños y niñas que egresan de nuestros jardines infantiles? Desarrollamos un sistema de análisis longitudinal que sigue, cohorte a cohorte, dónde eligen matricularse quienes egresan de los jardines infantiles del territorio.",
    sintesis: [
      "Para los párvulos y sus familias, las transiciones entre los niveles iniciales son momentos clave de su trayectoria educativa. Para un sostenedor, esta información es un insumo estratégico para la toma de decisiones en torno a las proyecciones del servicio educativo que ofrece.",
      "A partir de la sistematización y análisis de las preferencias de matrícula de los egresados de jardines infantiles del SLEP Costa Central, identificamos y visualizamos los itinerarios de los párvulos desde los niveles medios hacia los niveles de transición en las escuelas. El resultado es una aplicación interactiva con diagramas de flujo y tablas comparativas que permiten cuantificar el número de niños y niñas que permanecen en nuestras comunidades, cuántos migran a establecimientos de otros sostenedores y cuántos no se logran localizar. Su aporte es ofrecer al territorio una mirada de la continuidad de las trayectorias en un tramo crítico, con información útil para decisiones de oferta y de captación."
    ],
    estado: "vigente",
    imgs: [
      "assets/proyectos/inicial-1.png",
      "assets/proyectos/inicial-2.png",
      "assets/proyectos/inicial-3.png"
    ]
  },
  {
    id: "costapresente",
    orden: 9,
    tipo: "Plataforma · CostaPresente",
    titulo: "CostaPresente",
    objetivo: "Sistema que, de forma similar a la plataforma ministerial ChilePresente, permite realizar un seguimiento preciso de las trayectorias de los estudiantes que alguna vez han estado matriculados en alguno de los establecimientos del SLEP Costa Central.",
    sintesis: [
      "CostaPresente nace para apoyar el seguimiento de las trayectorias escolares de los estudiantes que, en algún momento de los últimos años, han pasado por algún establecimiento del SLEP Costa Central. A partir de registros mensuales de asistencia reconstruye, para cada estudiante, dónde ha estado matriculado y cómo ha evolucionado su escolaridad en términos de asistencia, promoción y retiros."
    ],
    estado: "vigente",
    imgs: [
      "assets/proyectos/costapresente-1.png"
    ]
  },
  {
    id: "ael",
    orden: 10,
    tipo: "Sistema de alertas",
    titulo: "Sistema de alertas de Anótate en la Lista",
    objetivo: "El sistema de alertas de Anótate en la Lista (AEL) identifica los establecimientos con vacantes sin asignar y prepara una comunicación personalizada para cada director o directora. Este mensaje incluye, para cada nivel del establecimiento, los cupos declarados, la matrícula actual y las vacantes sin asignar.",
    sintesis: [
      "El sistema de alertas de Anótate en la Lista (AEL) automatiza una tarea recurrente del trabajo de monitoreo de listas de espera: avisar a los establecimientos del territorio cuando registran vacantes sin asignar en AEL, que canaliza la búsqueda de cupos y matrícula. A partir del reporte quincenal que emite la Dirección de Educación Pública (DEP) a partir de los datos del Mineduc, el sistema identifica los establecimientos con vacantes y lista de espera y prepara, para cada uno, una comunicación personalizada lista para enviar a cada director o directora. Este mensaje incluye, para cada nivel del establecimiento, los cupos declarados, la matrícula actual y las vacantes sin asignar."
    ],
    estado: "vigente",
    imgs: [
      "assets/proyectos/ael-1.png"
    ]
  },
  {
    id: "trayectorias",
    orden: 11,
    tipo: "Minuta · Dirección Ejecutiva",
    titulo: "Análisis de trayectorias educativas interrumpidas",
    objetivo: "Reporte dirigido al Director Ejecutivo cuyo propósito es informar respecto al comportamiento de la desvinculación (o abandono) escolar en el territorio, mediante el uso de modelos de alerta temprana y la priorización de los establecimientos según el nivel de riesgo de desvinculación de sus estudiantes.",
    sintesis: [
      "La desvinculación escolar, entendida como la interrupción de la trayectoria educativa de un estudiante, es uno de los fenómenos más sensibles para un servicio educativo y, habitualmente, se aborda cuando ya ha ocurrido. Para revertir esta lógica, este reporte analiza las trayectorias interrumpidas e irregulares de los estudiantes del SLEP Costa Central con el fin de caracterizar este fenómeno en el territorio y, fundamentalmente, anticipar su ocurrencia.",
      "Este documento, dirigido al Director Ejecutivo, se alimenta de los “Reportes para el seguimiento de estudiantes con trayectorias interrumpidas o irregulares” que el Centro de Estudios del Mineduc (CEM) presenta con regularidad trimestral. A partir de su procesamiento y cruce con los datos de asistencia diaria, además de otras variables sociodemográficas, se generan alertas tempranas orientadas a la acción, permitiendo la identificación de cohortes vulnerables, la priorización de establecimientos educacionales según su nivel de riesgo y la presentación de evidencia clave para el diseño de estrategias de intervención."
    ],
    estado: "desarrollo",
    imgs: []
  },
  {
    id: "rendimiento",
    orden: 12,
    tipo: "Diagnóstico",
    titulo: "Diagnóstico histórico del rendimiento escolar",
    objetivo: "Diagnóstico longitudinal y multidimensional de las bases de rendimiento escolar del Mineduc (2002-2025) con el propósito de caracterizar las trayectorias educativas de los estudiantes de los establecimientos educacionales del SLEP Costa Central y cuantificar las variaciones en las tasas de promoción y reprobación.",
    sintesis: [
      "Diagnóstico longitudinal y multidimensional de las bases de rendimiento escolar del Mineduc (2002-2025) con el propósito de caracterizar las trayectorias educativas de los estudiantes de los establecimientos educacionales del SLEP Costa Central y cuantificar las variaciones en las tasas de promoción y reprobación.",
      "Al vincular estas variables de resultado con la caracterización socioeducativa del estudiante (sexo registral, edad, país de origen, pertenencia a pueblos originarios y condición de alumno integrado, entre otras) y con las particularidades de los establecimientos (emplazamiento rural o urbano, tipos de enseñanza y régimen de jornada, entre otros), buscamos identificar brechas de equidad intra-territoriales, contrastar el desempeño del SLEP frente a otros territorios de la Región de Valparaíso y el nivel nacional y modelar sistemas de alerta temprana basados en la asistencia crónica y el rendimiento académico, para focalizar de forma oportuna y precisa los recursos pedagógicos y de apoyo psicosocial."
    ],
    estado: "desarrollo",
    imgs: []
  }
];

/* Línea de tiempo de hitos del Área.
   future: true → nodo atenuado (hito proyectado / en desarrollo) */
const HITOS = [
  {
    fecha: "01 Jul · 2025",
    titulo: "Traspaso del servicio educativo",
    texto: "El SLEP Costa Central asume la administración de los jardines, escuelas y liceos públicos de las cuatro comunas."
  },
  {
    fecha: "2025 · S2",
    titulo: "Instalación del Área de Monitoreo",
    texto: "Se conforma el Área dentro de la Subdirección de Apoyo Técnico Pedagógico y se definen sus líneas de trabajo."
  },
  {
    fecha: "2025 · S2",
    titulo: "Primeros reportes a la Dirección Ejecutiva",
    texto: "Comienzan las minutas de asistencia y resultados que alimentan la planificación estratégica del Servicio."
  },
  {
    fecha: "2026 · S1",
    titulo: "Modelo de resguardo de la asistencia",
    texto: "Se despliegan los reportes de alerta por inasistencia para directoras y directores de establecimientos."
  },
  {
    fecha: "2026 · S1",
    titulo: "Plataforma CostaPresente",
    texto: "Entra en marcha la plataforma de seguimiento de trayectorias educativas del territorio."
  },
  {
    fecha: "2026 · S2",
    titulo: "Motores de comparación nacional",
    texto: "Herramientas para contrastar resultados y categorías de desempeño con referencias nacionales.",
    future: true
  }
];

/* Equipo — placeholders. Reemplaza nombres y cargos reales.
   iniciales: se muestran en el avatar. */
const EQUIPO = [
  { iniciales: "—", nombre: "Coordinación del Área", rol: "Monitoreo y seguimiento", tag: "Por completar" },
  { iniciales: "—", nombre: "Análisis de datos", rol: "Producción y procesamiento", tag: "Por completar" },
  { iniciales: "—", nombre: "Análisis pedagógico", rol: "Interpretación de resultados", tag: "Por completar" },
  { iniciales: "—", nombre: "Gestión de la información", rol: "Reportería y plataformas", tag: "Por completar" }
];
