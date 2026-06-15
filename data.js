/* ===========================================================
   Área de Monitoreo — Datos del sitio
   Edite estos arreglos para agregar/quitar contenido.
   El portafolio se construye solo a partir de PROYECTOS.
   =========================================================== */

/* Estado: "vigente" | "desarrollo"
   thumb: tono del placeholder de captura → plum | ocean | olive | coral | sand
   imgs: arreglo de rutas a capturas del proyecto (ej. ['assets/proyectos/x-1.jpg']).
         La primera es la portada del banner; el lightbox las muestra todas en un pasador.
         Si el arreglo está vacío, se muestra el marcador 'próximamente'. */
const PROYECTOS = [
  {
    tipo: "Monitoreo",
    titulo: "Monitoreo de aprendizajes en la educación parvularia",
    objetivo: "Sistematiza evidencia sobre los aprendizajes de niñas y niños del nivel parvulario para apoyar las decisiones pedagógicas de los jardines infantiles del territorio.",
    estado: "desarrollo",
    thumb: "plum",
    imgs: []
  },
  {
    tipo: "Seguimiento",
    titulo: "Seguimiento de trayectorias en la educación inicial",
    objetivo: "Acompaña la trayectoria de las y los párvulos a lo largo del ciclo inicial, anticipando alertas tempranas de asistencia y continuidad educativa.",
    estado: "vigente",
    thumb: "ocean",
    imgs: []
  },
  {
    tipo: "Plataforma · CostaPresente",
    titulo: "Seguimiento de trayectorias en establecimientos del SLEP",
    objetivo: "Plataforma territorial que integra los indicadores de trayectoria educativa de las y los estudiantes de los 97 establecimientos del Servicio Local.",
    estado: "vigente",
    thumb: "plum",
    imgs: []
  },
  {
    tipo: "Minuta · Dirección Ejecutiva",
    titulo: "Minuta de asistencia mensual",
    objetivo: "Reporte mensual de asistencia consolidado para la Dirección Ejecutiva, con foco en las variaciones por comuna, nivel y establecimiento.",
    estado: "vigente",
    thumb: "olive",
    imgs: []
  },
  {
    tipo: "Minuta · Dirección Ejecutiva",
    titulo: "Minutas de resultados Simce",
    objetivo: "Síntesis interpretada de los resultados Simce del territorio para apoyar la planificación estratégica de la Dirección Ejecutiva.",
    estado: "vigente",
    thumb: "ocean",
    imgs: []
  },
  {
    tipo: "Minuta · Dirección Ejecutiva",
    titulo: "Minuta sobre la desvinculación de estudiantes",
    objetivo: "Analiza la desvinculación y el abandono escolar para orientar acciones de retención y revinculación educativa en las comunidades.",
    estado: "vigente",
    thumb: "coral",
    imgs: []
  },
  {
    tipo: "Reporte · Directores/as",
    titulo: "Reportes del modelo de resguardo de la asistencia",
    objetivo: "Reportes dirigidos a directoras y directores que identifican estudiantes en riesgo por inasistencia, según el modelo de resguardo de la asistencia.",
    estado: "vigente",
    thumb: "plum",
    imgs: []
  },
  {
    tipo: "Motor de comparación",
    titulo: "Comparación de resultados nacionales en los Estándares de Aprendizaje",
    objetivo: "Herramienta que contrasta los Estándares de Aprendizaje del territorio con referencias nacionales para situar los resultados en contexto.",
    estado: "desarrollo",
    thumb: "sand",
    imgs: []
  },
  {
    tipo: "Motor de comparación",
    titulo: "Comparación de categorías de desempeño a nivel nacional",
    objetivo: "Compara las Categorías de Desempeño de los establecimientos del Servicio Local con el panorama nacional para identificar brechas y fortalezas.",
    estado: "desarrollo",
    thumb: "ocean",
    imgs: []
  },
  {
    tipo: "Reporte AEL",
    titulo: "Reporte de Análisis del Entorno y los Logros (AEL)",
    objetivo: "Consolida indicadores de aprendizaje, asistencia y aprobación por establecimiento para nutrir los ciclos de mejora de cada comunidad educativa.",
    estado: "vigente",
    thumb: "olive",
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
