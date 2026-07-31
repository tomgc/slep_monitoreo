/* Catálogo del Atlas Celeste de los Datos Educativos.
   Contrato: 50_documentacion/activa/50_contrato_atlas_datos.md
   Validar con: node 00_validar_atlas.js docs/atlas_datos.js

   Alcance nacional: la institución "internacional" (UNESCO · OECD) se
   retiró junto con todas las rutas que la referenciaban. */

const ATLAS_INSTITUCIONES = [
  {
    "id": "mineduc",
    "nombre": "MINEDUC",
    "desc": "Ministerio de Educación. Rectoría del sistema y mayor productor de datos educativos del país.",
    "color": "#2A8FD9",
    "x": 44,
    "y": 42,
    "bases": [
      {
        "id": "datos-abiertos",
        "nombre": "Datos Abiertos",
        "desde": 2004,
        "url": "https://datosabiertos.mineduc.cl",
        "desc": "Portal de bases públicas del Centro de Estudios del Mineduc.",
        "datos": [
          {
            "id": "matricula",
            "nombre": "Matrícula",
            "desde": 2004,
            "acceso": "Acceso público",
            "desc": "Matrícula oficial por estudiante y establecimiento, año a año.",
            "variables": [
              "RBD",
              "Curso",
              "Género",
              "Edad",
              "Dependencia",
              "Comuna"
            ],
            "relaciones": [
              "demre.paes.inscritos",
              "dep.monitoreo.matricula-run",
              "ine.censo.poblacion-escolar",
              "ine.proyecciones.proyeccion",
              "junaeb.beneficios.tne",
              "junaeb.sinae.ive",
              "mineduc.datos-abiertos.asistencia",
              "mineduc.datos-abiertos.docentes",
              "mineduc.datos-abiertos.matricula-parvularia",
              "mineduc.datos-abiertos.rendimiento",
              "mineduc.sae.postulaciones",
              "mineduc.sige.registro-nominal"
            ]
          },
          {
            "id": "asistencia",
            "nombre": "Asistencia",
            "desde": 2011,
            "acceso": "Acceso público",
            "desc": "Asistencia mensual declarada por cada establecimiento.",
            "variables": [
              "RBD",
              "Mes",
              "Días asistidos",
              "% asistencia"
            ],
            "relaciones": [
              "dep.monitoreo.cge",
              "junaeb.sinae.ive",
              "mdsf.casen.casen-educacion",
              "mineduc.comunidad-escolar.trayectoria",
              "mineduc.datos-abiertos.desvinculacion",
              "mineduc.datos-abiertos.matricula"
            ]
          },
          {
            "id": "rendimiento",
            "nombre": "Rendimiento académico",
            "desde": 2002,
            "acceso": "Acceso público",
            "desc": "Promedio de notas y situación final: aprobación, repitencia y retiro.",
            "variables": [
              "Promedio general",
              "Aprobación",
              "Repitencia",
              "Retiro"
            ],
            "relaciones": [
              "agencia.simce.puntajes",
              "demre.paes.puntajes",
              "mineduc.datos-abiertos.matricula",
              "mineduc.sige.actas",
              "mineduc.sige.registro-nominal"
            ]
          },
          {
            "id": "docentes",
            "nombre": "Docentes",
            "desde": 2003,
            "acceso": "Acceso público",
            "desc": "Dotación docente, funciones y horas de contrato.",
            "variables": [
              "Horas de contrato",
              "Función",
              "Título",
              "Establecimiento"
            ],
            "relaciones": [
              "mineduc.datos-abiertos.matricula",
              "mineduc.gestion.asistentes",
              "mineduc.gestion.ecep"
            ]
          },
          {
            "id": "establecimientos",
            "nombre": "Directorio de establecimientos",
            "desde": 1992,
            "acceso": "Acceso público",
            "desc": "Registro oficial de establecimientos y su dependencia.",
            "variables": [
              "RBD",
              "Dependencia",
              "Ruralidad",
              "Matrícula total"
            ],
            "relaciones": [
              "ine.censo.poblacion-escolar",
              "mineduc.gestion.pme",
              "mineduc.sae.postulaciones",
              "supereduc.denuncias.denuncias",
              "supereduc.rendicion.recursos"
            ]
          },
          {
            "id": "matricula-parvularia",
            "nombre": "Matrícula parvularia",
            "desde": 2015,
            "acceso": "Acceso público",
            "desc": "Matrícula de educación parvularia por establecimiento.",
            "variables": [
              "Nivel",
              "Establecimiento",
              "Comuna"
            ],
            "relaciones": [
              "junji.gesparvu.asistencia-parvularia",
              "mineduc.datos-abiertos.matricula"
            ]
          },
          {
            "id": "sep",
            "nombre": "Preferentes y prioritarios (SEP)",
            "desde": 2008,
            "acceso": "Acceso público",
            "desc": "Estudiantes preferentes, prioritarios y beneficiarios de la Subvención Escolar Preferencial.",
            "variables": [
              "Prioritario",
              "Preferente",
              "Beneficiario SEP"
            ],
            "relaciones": [
              "junaeb.sinae.ive",
              "mineduc.gestion.subvenciones"
            ]
          },
          {
            "id": "desvinculacion",
            "nombre": "Desvinculación",
            "desde": 2022,
            "acceso": "Acceso público",
            "desc": "Tasa de incidencia de la desvinculación escolar.",
            "variables": [
              "Tasa de incidencia",
              "RBD",
              "Grado"
            ],
            "relaciones": [
              "dep.monitoreo.cge",
              "mineduc.comunidad-escolar.trayectoria",
              "mineduc.datos-abiertos.asistencia"
            ]
          },
          {
            "id": "titulacion-tp",
            "nombre": "Titulación TP",
            "desde": 2010,
            "acceso": "Acceso público",
            "desc": "Practicantes y titulados de educación media técnico-profesional.",
            "variables": [
              "Especialidad",
              "Practicantes",
              "Titulados"
            ],
            "relaciones": [
              "dep.monitoreo.enep",
              "mineduc.sies.matricula-superior"
            ]
          }
        ]
      },
      {
        "id": "sige",
        "nombre": "SIGE",
        "desde": 2006,
        "url": "https://sige.mineduc.cl",
        "desc": "Sistema de Información General de Estudiantes: el registro nominal del sistema escolar.",
        "datos": [
          {
            "id": "registro-nominal",
            "nombre": "Registro nominal",
            "desde": 2006,
            "acceso": "Acceso restringido",
            "desc": "Trayectoria de cada estudiante identificada por RUN.",
            "variables": [
              "RUN",
              "Establecimiento",
              "Curso",
              "Estado"
            ],
            "relaciones": [
              "dep.monitoreo.matricula-run",
              "mineduc.datos-abiertos.matricula",
              "mineduc.datos-abiertos.rendimiento"
            ]
          },
          {
            "id": "actas",
            "nombre": "Actas de calificaciones",
            "desde": 2007,
            "acceso": "Acceso restringido",
            "desc": "Notas finales y promoción por curso.",
            "variables": [
              "Notas finales",
              "Promoción"
            ],
            "relaciones": [
              "mineduc.datos-abiertos.rendimiento"
            ]
          }
        ]
      },
      {
        "id": "sies",
        "nombre": "SIES",
        "desde": 2005,
        "url": "https://www.mifuturo.cl",
        "desc": "Servicio de Información de Educación Superior.",
        "datos": [
          {
            "id": "matricula-superior",
            "nombre": "Matrícula superior",
            "desde": 2005,
            "acceso": "Acceso público",
            "desc": "Matrícula de pregrado y posgrado en todas las instituciones.",
            "variables": [
              "Institución",
              "Carrera",
              "Género",
              "Región"
            ],
            "relaciones": [
              "demre.admision.seleccion",
              "demre.paes.puntajes",
              "mineduc.datos-abiertos.titulacion-tp",
              "mineduc.sies.titulacion"
            ]
          },
          {
            "id": "titulacion",
            "nombre": "Titulación",
            "desde": 2007,
            "acceso": "Acceso público",
            "desc": "Titulados por carrera e institución.",
            "variables": [
              "Título",
              "Duración real",
              "Institución"
            ],
            "relaciones": [
              "mineduc.sies.empleabilidad",
              "mineduc.sies.matricula-superior"
            ]
          },
          {
            "id": "empleabilidad",
            "nombre": "Empleabilidad e ingresos",
            "desde": 2012,
            "acceso": "Acceso público",
            "desc": "Inserción laboral e ingresos de titulados.",
            "variables": [
              "Empleabilidad 1er año",
              "Ingreso promedio"
            ],
            "relaciones": [
              "mineduc.sies.titulacion"
            ]
          }
        ]
      },
      {
        "id": "comunidad-escolar",
        "nombre": "Comunidad Escolar",
        "desde": 2020,
        "url": "https://www.comunidadescolar.cl",
        "desc": "Plataforma de reportes para las comunidades educativas.",
        "datos": [
          {
            "id": "trayectoria",
            "nombre": "Reporte de trayectoria",
            "desde": 2023,
            "acceso": "Acceso restringido",
            "desc": "Seguimiento trimestral de estudiantes con trayectoria interrumpida.",
            "variables": [
              "Estudiante",
              "Estado",
              "Trimestre"
            ],
            "relaciones": [
              "mineduc.datos-abiertos.asistencia",
              "mineduc.datos-abiertos.desvinculacion"
            ]
          }
        ]
      },
      {
        "id": "sae",
        "nombre": "SAE",
        "desde": 2016,
        "url": "https://www.sistemadeadmisionescolar.cl",
        "desc": "Sistema de Admisión Escolar: postulación centralizada.",
        "datos": [
          {
            "id": "postulaciones",
            "nombre": "Oferta y demanda SAE",
            "desde": 2016,
            "acceso": "Acceso público",
            "desc": "Vacantes, postulaciones y asignaciones por establecimiento.",
            "variables": [
              "Vacantes",
              "Postulaciones",
              "Asignados"
            ],
            "relaciones": [
              "mineduc.datos-abiertos.establecimientos",
              "mineduc.datos-abiertos.matricula"
            ]
          }
        ]
      },
      {
        "id": "gestion",
        "nombre": "Gestión y dotaciones",
        "desde": 2008,
        "url": "https://datosabiertos.mineduc.cl",
        "desc": "Bases de gestión educativa y dotación del sistema (CEM).",
        "datos": [
          {
            "id": "pme",
            "nombre": "PME",
            "desde": 2015,
            "acceso": "Acceso público",
            "desc": "Planes de Mejoramiento Educativo: planificación e implementación anual.",
            "variables": [
              "Acciones",
              "Cumplimiento",
              "RBD"
            ],
            "relaciones": [
              "dep.monitoreo.enep",
              "mineduc.datos-abiertos.establecimientos"
            ]
          },
          {
            "id": "did",
            "nombre": "DID",
            "desde": 2022,
            "acceso": "Acceso restringido",
            "desc": "Diagnóstico integral de desempeño de jardines infantiles (JISC).",
            "variables": [
              "Dimensión",
              "Resultado",
              "Jardín"
            ],
            "relaciones": [
              "junji.gesparvu.b2"
            ]
          },
          {
            "id": "subvenciones",
            "nombre": "Subvenciones",
            "desde": 2008,
            "acceso": "Acceso público",
            "desc": "Subvenciones pagadas a cada establecimiento.",
            "variables": [
              "Monto",
              "Tipo de subvención",
              "RBD"
            ],
            "relaciones": [
              "mineduc.datos-abiertos.sep",
              "supereduc.rendicion.recursos"
            ]
          },
          {
            "id": "sned",
            "nombre": "SNED",
            "desde": 1996,
            "acceso": "Acceso público",
            "desc": "Sistema Nacional de Evaluación de Desempeño de los establecimientos.",
            "variables": [
              "Puntaje SNED",
              "Tramo",
              "RBD"
            ],
            "relaciones": [
              "agencia.simce.puntajes"
            ]
          },
          {
            "id": "ecep",
            "nombre": "ECEP",
            "desde": 2017,
            "acceso": "Acceso público",
            "desc": "Evaluación de conocimientos específicos y pedagógicos docentes.",
            "variables": [
              "Puntaje",
              "Nivel",
              "Disciplina"
            ],
            "relaciones": [
              "mineduc.datos-abiertos.docentes"
            ]
          },
          {
            "id": "asistentes",
            "nombre": "Asistentes de la educación",
            "desde": 2012,
            "acceso": "Acceso público",
            "desc": "Dotación de asistentes de la educación (AAEE).",
            "variables": [
              "Cargo",
              "Horas",
              "Establecimiento"
            ],
            "relaciones": [
              "junji.dotaciones.aaee-jisc",
              "mineduc.datos-abiertos.docentes"
            ]
          }
        ]
      }
    ]
  },
  {
    "id": "agencia",
    "nombre": "Agencia de Calidad",
    "desc": "Agencia de Calidad de la Educación. Evalúa aprendizajes y desarrollo integral.",
    "color": "#E88663",
    "x": 70,
    "y": 24,
    "bases": [
      {
        "id": "simce",
        "nombre": "SIMCE",
        "desde": 1988,
        "url": "https://www.agenciaeducacion.cl",
        "desc": "Sistema de Medición de la Calidad de la Educación.",
        "datos": [
          {
            "id": "puntajes",
            "nombre": "Puntajes SIMCE",
            "desde": 1988,
            "acceso": "Acceso público",
            "desc": "Resultados por establecimiento y grupo socioeconómico.",
            "variables": [
              "Lectura",
              "Matemática",
              "GSE",
              "RBD"
            ],
            "relaciones": [
              "agencia.dia.cobertura-dia",
              "agencia.idps.indicadores",
              "agencia.internacionales.pisa",
              "agencia.ordenacion.categoria",
              "agencia.simce.estandares",
              "demre.paes.puntajes",
              "junaeb.sinae.ive",
              "mineduc.datos-abiertos.rendimiento",
              "mineduc.gestion.sned"
            ]
          },
          {
            "id": "estandares",
            "nombre": "Estándares de aprendizaje",
            "desde": 2013,
            "acceso": "Acceso público",
            "desc": "Distribución de estudiantes por nivel de aprendizaje.",
            "variables": [
              "Nivel adecuado",
              "Nivel elemental",
              "Nivel insuficiente"
            ],
            "relaciones": [
              "agencia.simce.puntajes"
            ]
          }
        ]
      },
      {
        "id": "idps",
        "nombre": "IDPS",
        "desde": 2014,
        "url": "https://www.agenciaeducacion.cl",
        "desc": "Indicadores de Desarrollo Personal y Social.",
        "datos": [
          {
            "id": "indicadores",
            "nombre": "Indicadores IDPS",
            "desde": 2014,
            "acceso": "Acceso público",
            "desc": "Bienestar y convivencia reportados junto al SIMCE.",
            "variables": [
              "Autoestima académica",
              "Clima de convivencia",
              "Participación",
              "Vida saludable"
            ],
            "relaciones": [
              "agencia.dia.resultados-dia",
              "agencia.simce.puntajes",
              "dep.monitoreo.enep",
              "junaeb.nutricion.mapa"
            ]
          }
        ]
      },
      {
        "id": "ordenacion",
        "nombre": "Categoría de Desempeño",
        "desde": 2016,
        "url": "https://www.agenciaeducacion.cl",
        "desc": "Ordenación oficial de establecimientos según desempeño.",
        "datos": [
          {
            "id": "categoria",
            "nombre": "Categoría de Desempeño",
            "desde": 2016,
            "acceso": "Acceso público",
            "desc": "Clasificación anual: alto, medio, medio-bajo, insuficiente.",
            "variables": [
              "Categoría",
              "Trayectoria",
              "RBD"
            ],
            "relaciones": [
              "agencia.simce.puntajes",
              "junaeb.sinae.ive"
            ]
          }
        ]
      },
      {
        "id": "internacionales",
        "nombre": "Estudios internacionales",
        "desde": 2000,
        "url": "https://www.agenciaeducacion.cl",
        "desc": "Participación de Chile en mediciones comparadas.",
        "datos": [
          {
            "id": "pisa",
            "nombre": "PISA",
            "desde": 2000,
            "acceso": "Acceso público",
            "desc": "Evaluación OECD a estudiantes de 15 años.",
            "variables": [
              "Lectura",
              "Matemática",
              "Ciencias"
            ],
            "relaciones": [
              "agencia.simce.puntajes"
            ]
          },
          {
            "id": "erce",
            "nombre": "ERCE",
            "desde": 2006,
            "acceso": "Acceso público",
            "desc": "Estudio regional comparativo de la UNESCO.",
            "variables": [
              "Lectura",
              "Matemática",
              "Escritura"
            ],
            "relaciones": []
          }
        ]
      },
      {
        "id": "dia",
        "nombre": "DIA",
        "desde": 2020,
        "url": "https://www.agenciaeducacion.cl",
        "desc": "Diagnóstico Integral de Aprendizajes.",
        "datos": [
          {
            "id": "cobertura-dia",
            "nombre": "Cobertura DIA",
            "desde": 2020,
            "acceso": "Acceso restringido",
            "desc": "Cobertura de aplicación por ventana (vía DEP).",
            "variables": [
              "Aplicación",
              "Cobertura",
              "Área"
            ],
            "relaciones": [
              "agencia.simce.puntajes",
              "dep.monitoreo.cge"
            ]
          },
          {
            "id": "resultados-dia",
            "nombre": "Resultados DIA",
            "desde": 2020,
            "acceso": "Acceso restringido",
            "desc": "Resultados académicos y socioemocionales del diagnóstico.",
            "variables": [
              "Área académica",
              "Socioemocional",
              "Curso"
            ],
            "relaciones": [
              "agencia.idps.indicadores"
            ]
          }
        ]
      }
    ]
  },
  {
    "id": "junaeb",
    "nombre": "JUNAEB",
    "desc": "Junta Nacional de Auxilio Escolar y Becas. Bienestar y equidad estudiantil.",
    "color": "#9BC93E",
    "x": 58,
    "y": 64,
    "bases": [
      {
        "id": "sinae",
        "nombre": "IVE · SINAE",
        "desde": 2007,
        "url": "https://www.junaeb.cl",
        "desc": "Sistema Nacional de Asignación con Equidad.",
        "datos": [
          {
            "id": "ive",
            "nombre": "Índice de Vulnerabilidad Escolar",
            "desde": 2007,
            "acceso": "Acceso público",
            "desc": "Medida de vulnerabilidad por establecimiento y nivel.",
            "variables": [
              "IVE-SINAE",
              "Prioridades",
              "RBD"
            ],
            "relaciones": [
              "agencia.ordenacion.categoria",
              "agencia.simce.puntajes",
              "junaeb.beneficios.pae",
              "mdsf.casen.casen-educacion",
              "mdsf.rsh.calificacion",
              "mineduc.datos-abiertos.asistencia",
              "mineduc.datos-abiertos.matricula",
              "mineduc.datos-abiertos.sep"
            ]
          }
        ]
      },
      {
        "id": "nutricion",
        "nombre": "Mapa Nutricional",
        "desde": 2009,
        "url": "https://www.junaeb.cl",
        "desc": "Estado nutricional de estudiantes de cursos clave.",
        "datos": [
          {
            "id": "mapa",
            "nombre": "Estado nutricional",
            "desde": 2009,
            "acceso": "Acceso público",
            "desc": "Peso, talla y clasificación nutricional por curso.",
            "variables": [
              "Peso",
              "Talla",
              "IMC",
              "Curso"
            ],
            "relaciones": [
              "agencia.idps.indicadores"
            ]
          }
        ]
      },
      {
        "id": "beneficios",
        "nombre": "Beneficios estudiantiles",
        "desde": 1964,
        "url": "https://www.junaeb.cl",
        "desc": "Programas de apoyo a la permanencia escolar.",
        "datos": [
          {
            "id": "pae",
            "nombre": "Alimentación escolar (PAE)",
            "desde": 1964,
            "acceso": "Acceso público",
            "desc": "Cobertura del Programa de Alimentación Escolar.",
            "variables": [
              "Raciones",
              "Cobertura",
              "Comuna"
            ],
            "relaciones": [
              "junaeb.sinae.ive"
            ]
          },
          {
            "id": "tne",
            "nombre": "TNE",
            "desde": 1991,
            "acceso": "Acceso público",
            "desc": "Tarjeta Nacional Estudiantil: transporte escolar.",
            "variables": [
              "Tarjetas emitidas",
              "Nivel"
            ],
            "relaciones": [
              "mineduc.datos-abiertos.matricula"
            ]
          }
        ]
      }
    ]
  },
  {
    "id": "demre",
    "nombre": "DEMRE",
    "desc": "Departamento de Evaluación, Medición y Registro Educacional (U. de Chile). La puerta a la educación superior.",
    "color": "#FFC92E",
    "x": 75,
    "y": 48,
    "bases": [
      {
        "id": "paes",
        "nombre": "PAES",
        "desde": 2022,
        "url": "https://demre.cl",
        "desc": "Prueba de Acceso a la Educación Superior — heredera de la PAA (1967) y la PSU (2003).",
        "datos": [
          {
            "id": "puntajes",
            "nombre": "Puntajes PAES",
            "desde": 2022,
            "acceso": "Acceso público",
            "desc": "Resultados por prueba y establecimiento de origen.",
            "variables": [
              "Comp. lectora",
              "Matemática 1 y 2",
              "Historia",
              "Ciencias"
            ],
            "relaciones": [
              "agencia.simce.puntajes",
              "mineduc.datos-abiertos.rendimiento",
              "mineduc.sies.matricula-superior"
            ]
          },
          {
            "id": "inscritos",
            "nombre": "Inscritos y rendición",
            "desde": 2022,
            "acceso": "Acceso público",
            "desc": "Quiénes se inscriben y quiénes rinden la prueba.",
            "variables": [
              "Inscritos",
              "Rinden",
              "Dependencia"
            ],
            "relaciones": [
              "mineduc.datos-abiertos.matricula"
            ]
          }
        ]
      },
      {
        "id": "admision",
        "nombre": "Proceso de admisión",
        "desde": 2004,
        "url": "https://acceso.mineduc.cl",
        "desc": "Postulación centralizada a las universidades.",
        "datos": [
          {
            "id": "seleccion",
            "nombre": "Postulación y selección",
            "desde": 2004,
            "acceso": "Acceso público",
            "desc": "Postulaciones, selección y matrícula por carrera.",
            "variables": [
              "Postulaciones",
              "Seleccionados",
              "Carrera"
            ],
            "relaciones": [
              "mineduc.sies.matricula-superior"
            ]
          }
        ]
      }
    ]
  },
  {
    "id": "supereduc",
    "nombre": "Superintendencia",
    "desc": "Superintendencia de Educación. Fiscaliza recursos y resguarda derechos educacionales.",
    "color": "#EE2D49",
    "x": 35,
    "y": 60,
    "bases": [
      {
        "id": "denuncias",
        "nombre": "Denuncias",
        "desde": 2012,
        "url": "https://www.supereduc.cl",
        "desc": "Denuncias ciudadanas sobre la vida escolar.",
        "datos": [
          {
            "id": "denuncias",
            "nombre": "Denuncias ciudadanas",
            "desde": 2012,
            "acceso": "Acceso público",
            "desc": "Materia, región y estado de cada denuncia.",
            "variables": [
              "Materia",
              "Región",
              "Estado"
            ],
            "relaciones": [
              "mineduc.datos-abiertos.establecimientos"
            ]
          }
        ]
      },
      {
        "id": "rendicion",
        "nombre": "Rendición de cuentas",
        "desde": 2013,
        "url": "https://www.supereduc.cl",
        "desc": "Uso de recursos públicos por sostenedores.",
        "datos": [
          {
            "id": "recursos",
            "nombre": "Uso de subvenciones",
            "desde": 2013,
            "acceso": "Acceso público",
            "desc": "Ingresos y gastos declarados por sostenedor.",
            "variables": [
              "Subvención",
              "Gasto declarado",
              "Sostenedor"
            ],
            "relaciones": [
              "mineduc.datos-abiertos.establecimientos",
              "mineduc.gestion.subvenciones"
            ]
          }
        ]
      }
    ]
  },
  {
    "id": "ine",
    "nombre": "INE",
    "desc": "Instituto Nacional de Estadísticas. El contexto demográfico del sistema.",
    "color": "#BCA493",
    "x": 76,
    "y": 72,
    "bases": [
      {
        "id": "censo",
        "nombre": "Censo de Población",
        "desde": 1992,
        "url": "https://www.ine.gob.cl",
        "desc": "El retrato completo de la población de Chile.",
        "datos": [
          {
            "id": "poblacion-escolar",
            "nombre": "Población en edad escolar",
            "desde": 1992,
            "acceso": "Acceso público",
            "desc": "Personas en edad escolar por comuna y escolaridad.",
            "variables": [
              "Edad",
              "Comuna",
              "Escolaridad"
            ],
            "relaciones": [
              "ine.proyecciones.proyeccion",
              "mineduc.datos-abiertos.establecimientos",
              "mineduc.datos-abiertos.matricula"
            ]
          }
        ]
      },
      {
        "id": "proyecciones",
        "nombre": "Proyecciones de población",
        "desde": 2002,
        "url": "https://www.ine.gob.cl",
        "desc": "Cuántos estudiantes habrá mañana.",
        "datos": [
          {
            "id": "proyeccion",
            "nombre": "Población proyectada",
            "desde": 2002,
            "acceso": "Acceso público",
            "desc": "Población futura por edad, año y comuna.",
            "variables": [
              "Edad",
              "Año",
              "Comuna"
            ],
            "relaciones": [
              "ine.censo.poblacion-escolar",
              "mineduc.datos-abiertos.matricula"
            ]
          }
        ]
      }
    ]
  },
  {
    "id": "mdsf",
    "nombre": "Desarrollo Social",
    "desc": "Ministerio de Desarrollo Social y Familia. La dimensión socioeconómica de los hogares.",
    "color": "#F8A0AE",
    "x": 52,
    "y": 16,
    "bases": [
      {
        "id": "casen",
        "nombre": "Encuesta CASEN",
        "desde": 1990,
        "url": "https://observatorio.ministeriodesarrollosocial.gob.cl",
        "desc": "Caracterización socioeconómica nacional de hogares.",
        "datos": [
          {
            "id": "casen-educacion",
            "nombre": "Módulo educación",
            "desde": 1990,
            "acceso": "Acceso público",
            "desc": "Escolaridad y asistencia según ingreso del hogar.",
            "variables": [
              "Escolaridad",
              "Asistencia",
              "Quintil de ingreso"
            ],
            "relaciones": [
              "junaeb.sinae.ive",
              "mineduc.datos-abiertos.asistencia"
            ]
          }
        ]
      },
      {
        "id": "rsh",
        "nombre": "Registro Social de Hogares",
        "desde": 2016,
        "url": "https://registrosocial.gob.cl",
        "desc": "La base socioeconómica nominal del Estado.",
        "datos": [
          {
            "id": "calificacion",
            "nombre": "Calificación socioeconómica",
            "desde": 2016,
            "acceso": "Acceso restringido",
            "desc": "Tramo socioeconómico de cada hogar.",
            "variables": [
              "Tramo",
              "Hogar",
              "Comuna"
            ],
            "relaciones": [
              "junaeb.sinae.ive"
            ]
          }
        ]
      }
    ]
  },
  {
    "id": "dep",
    "nombre": "DEP",
    "desc": "Dirección de Educación Pública. Coordina los SLEP y canaliza bases oficiales para su monitoreo.",
    "color": "#0062A0",
    "x": 60,
    "y": 40,
    "bases": [
      {
        "id": "monitoreo",
        "nombre": "Monitoreo, Estudios y Datos",
        "desde": 2018,
        "url": "https://educacionpublica.gob.cl",
        "desc": "Subdepartamento que redistribuye bases oficiales hacia los SLEP («vía DEP»).",
        "datos": [
          {
            "id": "matricula-run",
            "nombre": "Matrícula oficial (RUN)",
            "desde": 2018,
            "acceso": "Acceso restringido",
            "desc": "Versión privada identificada por RUN, distribuida a los SLEP.",
            "variables": [
              "RUN",
              "RBD",
              "Curso"
            ],
            "relaciones": [
              "mineduc.datos-abiertos.matricula",
              "mineduc.sige.registro-nominal"
            ]
          },
          {
            "id": "cge",
            "nombre": "Indicadores CGE",
            "desde": 2018,
            "acceso": "Acceso restringido",
            "desc": "Indicadores de los Convenios de Gestión Educacional de los SLEP.",
            "variables": [
              "% matrícula pública",
              "Asistencia promedio",
              "Desvinculación"
            ],
            "relaciones": [
              "agencia.dia.cobertura-dia",
              "mineduc.datos-abiertos.asistencia",
              "mineduc.datos-abiertos.desvinculacion"
            ]
          },
          {
            "id": "enep",
            "nombre": "Indicadores ENEP",
            "desde": 2020,
            "acceso": "Acceso público",
            "desc": "Seguimiento de la Estrategia Nacional de Educación Pública.",
            "variables": [
              "IDPS",
              "Titulación TP",
              "Acceso a educación superior"
            ],
            "relaciones": [
              "agencia.idps.indicadores",
              "mineduc.datos-abiertos.titulacion-tp",
              "mineduc.gestion.pme"
            ]
          }
        ]
      }
    ]
  },
  {
    "id": "junji",
    "nombre": "JUNJI",
    "desc": "Junta Nacional de Jardines Infantiles. Los datos de la educación parvularia pública.",
    "color": "#75924E",
    "x": 62,
    "y": 84,
    "bases": [
      {
        "id": "gesparvu",
        "nombre": "GESPARVU",
        "desde": 2010,
        "url": "https://www.junji.gob.cl",
        "desc": "Sistema de gestión de párvulos.",
        "datos": [
          {
            "id": "asistencia-parvularia",
            "nombre": "Asistencia mensual parvularia",
            "desde": 2010,
            "acceso": "Acceso restringido",
            "desc": "Asistencia mensual de jardines infantiles (vía DEP).",
            "variables": [
              "Jardín",
              "Mes",
              "Asistencia"
            ],
            "relaciones": [
              "mineduc.datos-abiertos.matricula-parvularia"
            ]
          },
          {
            "id": "b2",
            "nombre": "Caracterización JISC (B2)",
            "desde": 2015,
            "acceso": "Acceso restringido",
            "desc": "Caracterización de jardines infantiles vía transferencia.",
            "variables": [
              "Jardín",
              "Comuna",
              "Capacidad"
            ],
            "relaciones": [
              "mineduc.gestion.did"
            ]
          }
        ]
      },
      {
        "id": "dotaciones",
        "nombre": "Dotaciones JISC",
        "desde": 2015,
        "url": "https://www.junji.gob.cl",
        "desc": "Personal de jardines infantiles.",
        "datos": [
          {
            "id": "educadoras",
            "nombre": "Educadoras JISC",
            "desde": 2015,
            "acceso": "Acceso restringido",
            "desc": "Dotación de educadoras de párvulos.",
            "variables": [
              "Cargo",
              "Horas",
              "Jardín"
            ],
            "relaciones": [
              "junji.dotaciones.aaee-jisc"
            ]
          },
          {
            "id": "aaee-jisc",
            "nombre": "Asistentes (AAEE) JISC",
            "desde": 2015,
            "acceso": "Acceso restringido",
            "desc": "Dotación de asistentes de la educación en jardines.",
            "variables": [
              "Cargo",
              "Horas",
              "Jardín"
            ],
            "relaciones": [
              "junji.dotaciones.educadoras",
              "mineduc.gestion.asistentes"
            ]
          }
        ]
      }
    ]
  }
];

const ATLAS_AMBITOS = [
  {
    "id": "trayectorias",
    "nombre": "Trayectorias educativas",
    "pregunta": "¿Cómo evoluciona la historia educativa de un estudiante?",
    "datos": [
      "mineduc.datos-abiertos.matricula",
      "mineduc.datos-abiertos.asistencia",
      "mineduc.datos-abiertos.rendimiento",
      "agencia.simce.puntajes",
      "demre.paes.puntajes",
      "mineduc.sies.matricula-superior"
    ]
  },
  {
    "id": "asistencia",
    "nombre": "Asistencia y permanencia",
    "pregunta": "¿Por qué disminuye la asistencia escolar?",
    "datos": [
      "mineduc.datos-abiertos.asistencia",
      "mineduc.datos-abiertos.matricula",
      "junaeb.sinae.ive",
      "mdsf.casen.casen-educacion",
      "ine.censo.poblacion-escolar"
    ]
  },
  {
    "id": "equidad",
    "nombre": "Equidad territorial",
    "pregunta": "¿Dónde necesita más apoyo el sistema?",
    "datos": [
      "junaeb.sinae.ive",
      "ine.censo.poblacion-escolar",
      "junaeb.nutricion.mapa",
      "agencia.ordenacion.categoria",
      "mdsf.rsh.calificacion"
    ]
  },
  {
    "id": "bienestar",
    "nombre": "Aprendizaje y bienestar",
    "pregunta": "¿Qué aprenden y cómo se sienten las y los estudiantes?",
    "datos": [
      "agencia.simce.puntajes",
      "agencia.idps.indicadores",
      "junaeb.nutricion.mapa",
      "agencia.internacionales.pisa"
    ]
  },
  {
    "id": "parvularia",
    "nombre": "Educación parvularia",
    "pregunta": "¿Cómo se cuida la primera infancia en el sistema público?",
    "datos": [
      "mineduc.datos-abiertos.matricula-parvularia",
      "junji.gesparvu.asistencia-parvularia",
      "junji.gesparvu.b2",
      "junji.dotaciones.educadoras",
      "junaeb.nutricion.mapa"
    ]
  },
  {
    "id": "mejora",
    "nombre": "Gestión y mejora",
    "pregunta": "¿Cómo mejoran los establecimientos y sus equipos?",
    "datos": [
      "mineduc.gestion.pme",
      "agencia.dia.resultados-dia",
      "mineduc.gestion.sned",
      "dep.monitoreo.cge",
      "mineduc.gestion.subvenciones"
    ]
  }
];

const ATLAS_FRASES = {
  "universo": "El problema no es la falta de datos: tenemos millones de estrellas, pero pocos mapas para comprenderlas.",
  "institucion": "Cada institución es un sistema solar: sus bases de datos lo orbitan como planetas.",
  "base": "Cada base de datos es un planeta: al acercarnos vemos los datos que lo componen.",
  "dato": "El conocimiento aparece cuando conectamos los puntos.",
  "ambito": "Las preguntas educativas dibujan constelaciones entre datos distantes."
};
