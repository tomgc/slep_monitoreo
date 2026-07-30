# ==============================================================================
# 31_catalogo_fuentes_filas.R
#
# Proposito : declara las filas del catalogo de fuentes verificadas y las emite
#             como CSV, junto con el log de verificacion por URL visitada.
# Insumos   : ninguno en disco. Las filas son autoria de la verificacion de la
#             fase 1 (observacion directa de cada pagina y, cuando existe, de la
#             copia local en un proyecto hermano). Este script es su fuente.
# Salidas   : 40_salidas/catalogo_fuentes.csv
#             40_salidas/log_verificacion_fuentes.csv
# Contrato  : 50_documentacion/andamios/20260730_encargo_verificacion_catalogo_
#             fuentes_v3.md, seccion 5 mas las enmiendas E1-E6.
# Fecha     : 2026-07-30 (tramo 1)
#
# El esquema vigente son 28 campos. Toda celda sin dato lleva el texto "NA",
# nunca vacia ni con guion. Nada se infiere: lo no observado va como NA y su
# fuente queda registrada como solicitud al titular.
# ==============================================================================

# ---- Auto-instalacion ----
for (p in c("dplyr", "readr", "tibble", "here")) {
  if (!requireNamespace(p, quietly = TRUE)) install.packages(p)
}

library(dplyr)
library(readr)
library(tibble)
library(here)

# ---- Rutas ----
RUTA_CSV <- here("40_salidas", "catalogo_fuentes.csv")
RUTA_LOG <- here("40_salidas", "log_verificacion_fuentes.csv")

# ---- Constantes: vocabularios controlados (encargo seccion 5 + enmienda E1) ----
VOC_AMBITO <- c("1. Comunidades educativas", "2. SLEP", "3. Contexto")

VOC_SUBAMBITO <- c(
  "1.1 Trayectorias estudiantiles", "1.2 Desarrollo social y personal",
  "1.3 Aprendizajes y resultados", "1.4 Instrumentos de gestion educativa",
  "2.1 Gestion institucional del SLEP",
  "2.2 Dimension educativa de instrumentos de gestion",
  "2.3 Indices, analisis y estudios", "3.1 Contexto socioterritorial"
)

VOC_VIA <- c(
  "Portal de datos abiertos", "Descarga directa desde sitio institucional",
  "API", "Consulta web sin descarga", "Entrega via DEP",
  "Sistema con credenciales", "Solicitud formal (Ley 20.285)", "Reporte en PDF"
)

VOC_NIVEL <- c("Abierto", "Abierto con registro", "Institucional mediado",
               "Restringido por solicitud")

# E1: se agrega "rar". No se mapea .rar a zip: son contenedores distintos.
VOC_FORMATO <- c("csv", "xlsx", "zip", "rar", "txt", "json", "api", "pdf",
                 "html", "shapefile", "sin descarga")

VOC_UNIDAD <- c("Estudiante", "Docente o asistente", "Curso", "Establecimiento",
                "Sostenedor", "Comuna", "Region", "Nacional", "Jardin infantil")

VOC_TERRITORIO <- c("Establecimiento", "Comuna", "Region", "Nacional")

VOC_PERIODICIDAD <- c("Anual", "Semestral", "Trimestral", "Bimestral",
                      "Mensual", "Semanal", "Por evento",
                      "Sin periodicidad definida")

VOC_PERSONALES <- c("Sin datos de personas", "Identificador enmascarado (MRUN)",
                    "RUT o identificador directo", "Datos personales sensibles")

VOC_ESTADO <- c("Verificada", "URL viva sin descarga confirmada", "Enlace roto",
                "No encontrada", "Declarada sin verificar")

# ---- Constantes de valores repetidos ----
CEM        <- "Centro de Estudios del Ministerio de Educacion (CEM)"
DA         <- "Datos Abiertos"
PORTAL_DA  <- "https://datosabiertos.mineduc.cl/"
HOY        <- "2026-07-30"

# ==============================================================================
# FILAS DEL CATALOGO
# ==============================================================================

catalogo <- tribble(
  ~id_fuente, ~ambito_monitoreo, ~subambito, ~dato, ~descripcion, ~variables, ~base_datos, ~emisor, ~via_de_acceso, ~nivel_acceso, ~url_referencia, ~url_descarga, ~formato, ~detalle_tecnico, ~unidad_de_analisis, ~llaves_de_union, ~desagregacion_territorial, ~cobertura_temporal, ~periodicidad, ~mes_publicacion, ~datos_personales, ~documentacion_tecnica, ~condiciones_de_uso, ~usos_en_monitoreo, ~estado_verificacion, ~fecha_verificacion, ~observaciones, ~copia_local,

  # --- F001: el portal mismo (fila de contenedor, encargo 2.4) ---
  "F001", "1. Comunidades educativas", "1.1 Trayectorias estudiantiles",
  "Portal Datos Abiertos del Centro de Estudios",
  "Portal que agrupa las bases publicas del sistema escolar chileno, organizadas en cinco secciones: estudiantes, docentes y asistentes, establecimientos, sostenedores, e indicadores y encuestas.",
  "NA", DA, CEM, "Portal de datos abiertos", "Abierto",
  PORTAL_DA, "NA", "html",
  "Fila de contenedor: es el portal, no un conjunto de datos. Sus conjuntos se catalogan como filas propias.",
  "NA", "NA", "Nacional", "NA", "Sin periodicidad definida", "NA",
  "Sin datos de personas", "NA", "NA",
  "Punto de entrada unico a las bases del sistema escolar.",
  "Verificada", HOY,
  "La pagina no declara formatos, cobertura temporal, licencia ni documentacion. Contacto publicado: estadisticas@mineduc.cl. Lista mas conjuntos de los que registro el reconocimiento (ver filas F016-F024).",
  "NA",

  # --- F002: matricula por estudiante (con copia local) ---
  "F002", "1. Comunidades educativas", "1.1 Trayectorias estudiantiles",
  "Matricula por estudiante",
  "Matricula por estudiante del sistema escolar en establecimientos reconocidos oficialmente por el Estado, con informacion del estudiante, del establecimiento y del nivel de ensenanza.",
  "AGNO; RBD; DGV_RBD; NOM_RBD; COD_REG_RBD; NOM_REG_RBD_A; COD_PRO_RBD; COD_COM_RBD; NOM_COM_RBD; COD_DEPROV_RBD; NOM_DEPROV_RBD; COD_DEPE; COD_DEPE2; RURAL_RBD; ESTADO_ESTAB; NOMBRE_SLEP; COD_ENSE; COD_ENSE2; COD_ENSE3; COD_GRADO; COD_GRADO2; LET_CUR; COD_JOR; COD_TIP_CUR; COD_DES_CUR; TIPO_AULA; MRUN; GEN_ALU; FEC_NAC_ALU; EDAD_ALU; COD_REG_ALU; COD_COM_ALU; NOM_COM_ALU; COD_SEC; COD_ESPE; COD_RAMA; COD_MEN; ENS",
  DA, CEM, "Portal de datos abiertos", "Abierto",
  "https://datosabiertos.mineduc.cl/matricula-por-estudiante-2/",
  "https://datosabiertos.mineduc.cl/wp-content/uploads/2025/10/Matricula-por-estudiante-2025.rar",
  "rar",
  "La pagina publica 21 archivos .rar, uno por ano, 2004-2025. url_descarga apunta al ano 2025. La serie NO tiene patron derivable: el nombre se mantiene (Matricula-por-estudiante-AAAA.rar) pero la carpeta de subida cambia (2025/10, 2024/11, 2023/10), de modo que cada ano exige leer su enlace en la pagina. La copia local del ano 2025 es .csv de 566 MB, separador punto y coma, cabecera en UTF-8 con marca de orden de bytes (BOM), 38 columnas.",
  "Estudiante", "MRUN; RBD; AGNO; COD_COM_RBD", "Establecimiento",
  "2004-2025 en el portal; 2016-2025 en la copia local, sin anos faltantes",
  "Anual", "NA", "Identificador enmascarado (MRUN)", "NA", "NA",
  "Base de matricula del territorio; llave RBD para cruce con asistencia y rendimiento.",
  "Verificada", HOY,
  "Columnas, separador, codificacion y anos efectivos leidos de la copia local (solo cabecera), no de la pagina, que no publica esquema de registros. Equivalencia de nombres (enmienda E9): la raiz de datos se llama slep_analisis_matricula y el repositorio hermano correspondiente en ~/Projects se llama slep_minuta_matricula; copia_local registra la raiz de datos, que es donde vive el archivo. Republicada en datos.gob.cl (F014) sin aporte propio: misma cobertura y misma desagregacion.",
  "slep_analisis_matricula",

  # --- F003: matricula parvularia ---
  "F003", "1. Comunidades educativas", "1.1 Trayectorias estudiantiles",
  "Matricula educacion parvularia",
  "Ninos y ninas en educacion parvularia en establecimientos de JUNJI, Fundacion Integra y otros reconocidos oficialmente.",
  "NA", DA, CEM, "Portal de datos abiertos", "Abierto",
  "https://datosabiertos.mineduc.cl/matricula-educacion-parvularia/",
  "https://datosabiertos.mineduc.cl/wp-content/uploads/2025/12/Matricula-Parvularia-2025.rar",
  "rar; zip",
  "Archivos anuales: .rar en 2011-2025 y .zip en 2019. url_descarga apunta al ano 2025, subido en 2025/12. La carpeta de subida varia por ano, de modo que la serie exige leer cada enlace en la pagina.",
  "NA", "NA", "Establecimiento", "2011-2025", "Anual", "NA",
  "NA", "NA", "NA",
  "Matricula del nivel parvulario del territorio.",
  "Verificada", HOY,
  "La pagina no publica esquema de registros ni diccionario. Sin copia local. Solicitud registrada.",
  "NA",

  # --- F004: rendimiento por estudiante (con copia local) ---
  "F004", "1. Comunidades educativas", "1.3 Aprendizajes y resultados",
  "Rendimiento academico por estudiante",
  "Notas y situacion final por estudiante del sistema escolar, con identificacion del establecimiento, el curso y el nivel de ensenanza.",
  "AGNO; RBD; DGV_RBD; NOM_RBD; COD_REG_RBD; NOM_REG_RBD_A; COD_PRO_RBD; COD_COM_RBD; NOM_COM_RBD; COD_DEPROV_RBD; NOM_DEPROV_RBD; COD_DEPE; COD_DEPE2; RURAL_RBD; ESTADO_ESTAB; NOMBRE_SLEP; COD_ENSE; COD_ENSE2; COD_GRADO; LET_CUR; COD_JOR; COD_TIP_CUR; COD_DES_CUR; MRUN; GEN_ALU; FEC_NAC_ALU; EDAD_ALU; COD_REG_ALU; COD_COM_ALU; NOM_COM_ALU; COD_RAMA; COD_SEC; COD_ESPE; PROM_GRAL; ASISTENCIA; SIT_FIN; SIT_FIN_R; COD_MEN",
  DA, CEM, "Portal de datos abiertos", "Abierto",
  "https://datosabiertos.mineduc.cl/rendimiento-por-estudiante-2/",
  "https://datosabiertos.mineduc.cl/wp-content/uploads/2026/03/Rendimiento-por-estudiante-2025.rar",
  "rar",
  "La pagina publica un .rar por ano, 2002-2025. url_descarga apunta al ano 2025. La serie NO tiene patron derivable: el nombre del archivo cambia entre anos (Rendimiento-por-estudiante-2025.rar, Rendimiento_2024.rar, Rendimiento-2023.rar) y la carpeta de subida tambien (2026/03, 2025/04, 2024/09). Cada ano exige leer su enlace en la pagina. La copia local del ano 2025 es .csv de 576 MB, separador punto y coma, cabecera en UTF-8 con marca de orden de bytes (BOM), 38 columnas. Incluye PROM_GRAL, ASISTENCIA y SIT_FIN.",
  "Estudiante", "MRUN; RBD; AGNO; COD_COM_RBD", "Establecimiento",
  "2002-2025 en el portal; 2015-2025 en la copia local, sin anos faltantes",
  "Anual", "NA", "Identificador enmascarado (MRUN)", "NA", "NA",
  "Promedio general, asistencia y situacion final por estudiante; insumo de trayectorias y de aprobacion.",
  "Verificada", HOY,
  "Columnas, separador, codificacion y anos efectivos leidos de la copia local (solo cabecera). El proyecto hermano tambien conserva una version con RUT directo en su carpeta de insumos privados, que no se cataloga aqui.",
  "slep_rendimiento_historico",

  # --- F005: SEP ---
  "F005", "1. Comunidades educativas", "1.2 Desarrollo social y personal",
  "Alumnos preferentes, prioritarios y beneficiarios SEP",
  "Bases de alumnos prioritarios, preferentes y beneficiarios de la Subvencion Escolar Preferencial.",
  "NA", DA, CEM, "Portal de datos abiertos", "Abierto",
  "https://datosabiertos.mineduc.cl/alumnos-preferentes-prioritarios-y-beneficiarios-sep/",
  "https://datosabiertos.mineduc.cl/wp-content/uploads/2026/01/Alumnos-SEP-2025.rar",
  "rar",
  "Un archivo .rar por ano, 2008-2025. url_descarga apunta al ano 2025, subido en 2026/01. La carpeta de subida varia por ano, de modo que la serie exige leer cada enlace en la pagina.",
  "NA", "NA", "Establecimiento", "2008-2025", "Anual", "NA",
  "NA", "NA", "NA",
  "Marcador de vulnerabilidad socioeconomica por estudiante; insumo de focalizacion.",
  "Verificada", HOY,
  "La pagina no publica esquema de registros ni diccionario. Sin copia local. Solicitud registrada.",
  "NA",

  # --- F006: SAE ---
  "F006", "1. Comunidades educativas", "1.1 Trayectorias estudiantiles",
  "Sistema de Admision Escolar (SAE)",
  "Procesos de admision de estudiantes que asisten a establecimientos subvencionados o que reciben aportes del Estado.",
  "NA", DA, CEM, "Portal de datos abiertos", "Abierto",
  "https://datosabiertos.mineduc.cl/sistema-de-admision-escolar-sae/",
  "https://datosabiertos.mineduc.cl/wp-content/uploads/2026/03/SAE_2025.rar",
  "rar; zip",
  "Archivos comprimidos anuales, .rar y .zip, 2016-2025. url_descarga apunta al ano 2025, subido en 2026/03. La carpeta de subida varia por ano, de modo que la serie exige leer cada enlace en la pagina.",
  "NA", "NA", "Establecimiento", "2016-2025", "Anual", "NA",
  "NA", "NA", "NA",
  "Postulaciones y resultados de admision; insumo de demanda por establecimiento.",
  "Verificada", HOY,
  "La pagina no publica esquema de registros ni diccionario. Sin copia local. Solicitud registrada.",
  "NA",

  # --- F007: directorio de establecimientos ---
  "F007", "2. SLEP", "2.1 Gestion institucional del SLEP",
  "Directorio de establecimientos educacionales",
  "Directorios de establecimientos educacionales del pais desde 1992 en adelante.",
  "NA", DA, CEM, "Portal de datos abiertos", "Abierto",
  "https://datosabiertos.mineduc.cl/directorio-de-establecimientos-educacionales/",
  "https://datosabiertos.mineduc.cl/wp-content/uploads/2025/11/Directorio-Oficial-EE-2025.rar",
  "rar; csv; zip",
  "El formato cambia por rango de anos: .rar en 1992-1997 y 2013-2025; .csv en 2004-2012; .zip en 1998-2003. url_descarga apunta al ano 2025. Los anos en .csv viven bajo otra carpeta y otra grafia (ejemplo 2004: /wp-content/uploads/2021/12/Directorio_oficial_EE_2004.csv), de modo que ni el nombre ni la ruta siguen patron: cada ano exige leer su enlace en la pagina.",
  "Establecimiento", "NA", "Establecimiento", "1992-2025", "Anual", "NA",
  "Sin datos de personas", "NA", "NA",
  "Universo de establecimientos con RBD, dependencia y ubicacion; tabla maestra de cruce territorial.",
  "Verificada", HOY,
  "Unica fuente del tramo con formato mixto por rango de anos, declarado en detalle_tecnico segun la enmienda E1. La pagina no publica esquema de registros. Sin copia local directa. Solicitud registrada.",
  "NA",

  # --- F008: subvenciones ---
  "F008", "2. SLEP", "2.1 Gestion institucional del SLEP",
  "Subvenciones a establecimientos educacionales",
  "Bases de subvenciones y asignaciones otorgadas a establecimientos educacionales desde 2005 en adelante.",
  "NA", DA, CEM, "Portal de datos abiertos", "Abierto",
  "https://datosabiertos.mineduc.cl/subvenciones-a-establecimientos-educacionales/",
  "https://datosabiertos.mineduc.cl/wp-content/uploads/2026/06/Subvenciones-a-EE-2025.rar",
  "rar; zip",
  "Un archivo por ano calendario, .rar y .zip, 2005-2025. url_descarga apunta al ano 2025, subido en 2026/06. La carpeta de subida varia por ano, de modo que la serie exige leer cada enlace en la pagina.",
  "Establecimiento", "NA", "Establecimiento", "2005-2025", "Anual", "NA",
  "Sin datos de personas", "NA", "NA",
  "Montos de subvencion por establecimiento; insumo financiero del territorio.",
  "Verificada", HOY,
  "La pagina declara archivos anuales pero no declara periodicidad de publicacion; el valor Anual se toma del formato de los archivos y se anota aqui. No publica esquema de registros. Solicitud registrada.",
  "NA",

  # --- F009: matricula longitudinal ---
  "F009", "1. Comunidades educativas", "1.1 Trayectorias estudiantiles",
  "Matricula longitudinal",
  "Serie de matricula escolar de todos los niveles, desglosada por dependencia, zona, genero, region, provincia, comuna y establecimiento.",
  "NA", DA, CEM, "Portal de datos abiertos", "Abierto",
  "https://datosabiertos.mineduc.cl/matricula-longitudinal/",
  "https://datosabiertos.mineduc.cl/wp-content/uploads/2025/10/excel-matricula-longuitudinal-2010-2025_no_modificable.xlsx",
  "xlsx",
  "Un libro Excel unico con la serie completa; no hay serie de archivos y por tanto no hay patron que declarar. Excluye la educacion parvularia de JUNJI e Integra. El nombre publicado trae una errata del emisor (longuitudinal) que se conserva literal porque es parte de la URL.",
  "Establecimiento", "NA", "Establecimiento", "2010-2025", "Anual", "NA",
  "Sin datos de personas", "NA", "NA",
  "Serie agregada de matricula para tendencias territoriales.",
  "Verificada", HOY,
  "La pagina describe las dimensiones de desglose pero no lista nombres de columna. Sin copia local. Solicitud registrada.",
  "NA",

  # --- F010: desvinculacion ---
  "F010", "1. Comunidades educativas", "1.1 Trayectorias estudiantiles",
  "Tasas de incidencia de desvinculacion",
  "Tasas de incidencia de desvinculacion de ninos, ninas y jovenes de educacion basica y media, por region, provincia, comuna, genero y grado.",
  "NA", DA, CEM, "Portal de datos abiertos", "Abierto",
  "https://datosabiertos.mineduc.cl/desvinculacion/",
  "https://datosabiertos.mineduc.cl/wp-content/uploads/2025/10/OFICIAL-Tasa-Incidencia-Desvinculacion-2010-2024.xlsx",
  "xlsx",
  "Un libro Excel unico con la serie 2010-2024; no hay serie de archivos y por tanto no hay patron que declarar.",
  "Establecimiento", "NA", "Comuna", "2010-2024", "Anual", "NA",
  "Sin datos de personas", "NA", "NA",
  "Indicador de abandono escolar; insumo directo del modelo de desvinculacion del Area.",
  "Verificada", HOY,
  "Cobertura termina en 2024, un ano antes que el resto de las bases del portal. La pagina no lista nombres de columna. Sin copia local. Solicitud registrada.",
  "NA",

  # --- F011: practicantes y titulados TP ---
  "F011", "1. Comunidades educativas", "1.1 Trayectorias estudiantiles",
  "Practicantes y titulados tecnico profesional",
  "Bases de alumnos practicantes y titulados de educacion media tecnico profesional desde 2013 en adelante.",
  "NA", DA, CEM, "Portal de datos abiertos", "Abierto",
  "https://datosabiertos.mineduc.cl/practicantes-y-titulados-tecnico-profesional/",
  "https://datosabiertos.mineduc.cl/wp-content/uploads/2026/06/Practicantes-y-Titulados-TP-2025.rar",
  "rar; zip",
  "Archivos anuales: .rar en 2013-2021 y 2023-2025; .zip en 2022. url_descarga apunta al ano 2025, subido en 2026/06. La carpeta de subida varia por ano, de modo que la serie exige leer cada enlace en la pagina.",
  "NA", "NA", "Establecimiento", "2013-2025", "Anual", "NA",
  "NA", "NA", "NA",
  "Titulacion y practica de la modalidad tecnico profesional; cierre de trayectoria.",
  "Verificada", HOY,
  "La pagina no publica esquema de registros ni diccionario. Sin copia local. Solicitud registrada.",
  "NA",

  # --- F012: CEM Interactivo ---
  "F012", "1. Comunidades educativas", "1.1 Trayectorias estudiantiles",
  "CEM Interactivo",
  "Visualizador de tableros del Centro de Estudios sobre establecimientos, asistencia anual, asistencia mensual, cargos docentes y matricula oficial.",
  "NA", DA, CEM, "Consulta web sin descarga", "Abierto",
  "https://datosabiertos.mineduc.cl/CEM_Interactivo", "NA", "sin descarga",
  "La URL responde 301 y redirige a un tablero embebido de Power BI en app.powerbi.com. No expone archivos.",
  "NA", "NA", "Nacional", "2024-2025", "Sin periodicidad definida", "NA",
  "Sin datos de personas", "NA", "NA",
  "Consulta rapida de matricula y asistencia sin descargar bases.",
  "URL viva sin descarga confirmada", HOY,
  "No se siguio la redireccion: el destino es una aplicacion JavaScript de Power BI que no rinde como HTML plano. La observacion del 301 y del host de destino basta para clasificar la via de acceso.",
  "NA",

  # --- F013: API ---
  "F013", "1. Comunidades educativas", "1.1 Trayectorias estudiantiles",
  "Portal API de datos abiertos del Mineduc",
  "Acceso programatico a bases de datos educativas mediante clave de autenticacion, segun lo declara el reconocimiento.",
  "NA", "Portal API", CEM, "API", "Abierto con registro",
  "http://api.datos.mineduc.cl/", "NA", "api",
  "NA",
  "NA", "NA", "Nacional", "NA", "Sin periodicidad definida", "NA",
  "NA", "NA", "NA",
  "Automatizacion de descargas si el servicio esta operativo.",
  "URL viva sin descarga confirmada", HOY,
  "El host responde pero la validacion TLS falla: el certificado presentado cubre workspace.junar.com y workspace.vor-tex.io, no api.datos.mineduc.cl. El dominio parece delegado a la plataforma Junar. El reconocimiento la registro como http; sobre https no es inspeccionable desde esta sesion. Contenido no verificado.",
  "NA",

  # --- F014: datos.gob.cl Subsecretaria de Educacion ---
  "F014", "1. Comunidades educativas", "1.1 Trayectorias estudiantiles",
  "Organizacion Subsecretaria de Educacion en datos.gob.cl",
  "Organizacion del portal nacional de datos abiertos que republica conjuntos del sistema escolar: matricula parvularia, dotacion docente, asistencia declarada, asistentes de la educacion y otros.",
  "NA", "datos.gob.cl", "Subsecretaria de Educacion (Mineduc)",
  "Portal de datos abiertos", "Abierto",
  "https://datos.gob.cl/organization/subsecretaria_de_educacion", "NA", "csv; xlsx; html",
  "Publica 30 conjuntos de datos. Formatos declarados por el portal: CSV, XLS, XLSX, URL y Power BI.",
  "NA", "NA", "Nacional", "NA", "Sin periodicidad definida", "NA",
  "NA", "NA",
  "Creative Commons: Non-Commercial en 15 conjuntos, Attribution en 14, CCZero en 1",
  "Segunda via de acceso a bases del CEM, con licencia declarada donde el portal propio no la declara.",
  "Verificada", HOY,
  "Unica fuente del tramo que declara licencia explicita. Fecha de ultima actualizacion visible solo en el primer conjunto (2026-07-27). Sus 30 conjuntos NO se catalogan como filas propias, por la regla de la enmienda E7: una republicacion genera fila solo si aporta licencia, formato, cobertura o desagregacion que la fuente primaria no da. De los 30 solo se observaron 12 nombres en la pagina de la organizacion, y ninguno de esos 12 declara a nivel de conjunto un aporte verificable frente a su fuente primaria en el portal del CEM; la unica diferencia observada es agregada (la licencia Creative Commons se declara a nivel de organizacion, no por conjunto). Evaluar los 30 uno a uno exige abrir 30 paginas de conjunto y es una pasada propia, no parte de este tramo.",
  "NA",

  # --- F015: Censo 2024 (lote H, primera URL) ---
  "F015", "3. Contexto", "3.1 Contexto socioterritorial",
  "Censo de Poblacion y Vivienda 2024, resultados",
  "Portal de resultados del Censo 2024 con tableros de consulta de poblacion, viviendas y hogares, y procesamiento en linea de microdatos.",
  "NA", "Censo 2024", "Instituto Nacional de Estadisticas (INE)",
  "Consulta web sin descarga", "Abierto",
  "https://censo2024.ine.gob.cl/resultados/", "NA", "pdf; sin descarga",
  "La pagina ofrece descarga de una sintesis de resultados en PDF y consulta interactiva sin descarga. Los microdatos se procesan en linea con Redatam Web, que genera tabulados y graficos.",
  "Comuna", "NA", "Comuna",
  "2024", "Por evento", "NA",
  "Sin datos de personas", "NA",
  "Declara un enlace a terminos de uso y licencia de datos abiertos, cuyo contenido no se abrio",
  "Base demografica del territorio para denominadores de cobertura escolar.",
  "Verificada", HOY,
  "El visualizador llega a nivel de manzana y entidad censal. La pagina no publica las cifras de poblacion, viviendas ni hogares que el reconocimiento le atribuia: esas cifras no se transcriben al catalogo por no estar observadas en la pagina.",
  "NA",

  # ============================================================================
  # F016-F024: conjuntos listados por el portal y ausentes del reconocimiento.
  # Enmienda E5: se agregan como filas propias. No se abrio su pagina en este
  # tramo, de modo que van como "Declarada sin verificar" con sus campos en NA.
  # ============================================================================

  "F016", "1. Comunidades educativas", "1.1 Trayectorias estudiantiles",
  "Asistencia declarada mensual por ano", "NA", "NA", DA, CEM,
  "Portal de datos abiertos", "Abierto", PORTAL_DA, "NA", "NA", "NA",
  "NA", "NA", "NA", "NA", "NA", "NA", "NA", "NA", "NA",
  "Asistencia mensual, insumo central de la minuta de asistencia del Area.",
  "Declarada sin verificar", "NA",
  "Listada en la seccion Estudiantes del portal y ausente del reconocimiento. Pendiente de verificacion en una pasada posterior.",
  "NA",

  "F017", "1. Comunidades educativas", "1.1 Trayectorias estudiantiles",
  "Asistencia anual por estudiante", "NA", "NA", DA, CEM,
  "Portal de datos abiertos", "Abierto", PORTAL_DA, "NA", "NA", "NA",
  "NA", "NA", "NA", "NA", "NA", "NA", "NA", "NA", "NA",
  "Asistencia individual anual; llave de trayectoria junto a matricula y rendimiento.",
  "Declarada sin verificar", "NA",
  "Listada en la seccion Estudiantes del portal y ausente del reconocimiento. Pendiente de verificacion en una pasada posterior.",
  "NA",

  "F018", "1. Comunidades educativas", "1.3 Aprendizajes y resultados",
  "Notas y egresados de ensenanza media", "NA", "NA", DA, CEM,
  "Portal de datos abiertos", "Abierto", PORTAL_DA, "NA", "NA", "NA",
  "NA", "NA", "NA", "NA", "NA", "NA", "NA", "NA", "NA",
  "Cierre de trayectoria de ensenanza media.",
  "Declarada sin verificar", "NA",
  "Listada en la seccion Estudiantes del portal y ausente del reconocimiento. Pendiente de verificacion en una pasada posterior.",
  "NA",

  "F019", "1. Comunidades educativas", "1.3 Aprendizajes y resultados",
  "Resumen de rendimiento por establecimiento", "NA", "NA", DA, CEM,
  "Portal de datos abiertos", "Abierto", PORTAL_DA, "NA", "NA", "NA",
  "NA", "NA", "NA", "NA", "NA", "NA", "NA", "NA", "NA",
  "Version agregada del rendimiento, util cuando no se requiere el nivel estudiante.",
  "Declarada sin verificar", "NA",
  "Listada en la seccion Establecimientos del portal y ausente del reconocimiento. Pendiente de verificacion en una pasada posterior.",
  "NA",

  "F020", "1. Comunidades educativas", "1.1 Trayectorias estudiantiles",
  "Resumen de matricula por establecimiento", "NA", "NA", DA, CEM,
  "Portal de datos abiertos", "Abierto", PORTAL_DA, "NA", "NA", "NA",
  "NA", "NA", "NA", "NA", "NA", "NA", "NA", "NA", "NA",
  "Version agregada de la matricula por establecimiento.",
  "Declarada sin verificar", "NA",
  "Listada en la seccion Establecimientos del portal y ausente del reconocimiento. Pendiente de verificacion en una pasada posterior.",
  "NA",

  "F021", "2. SLEP", "2.2 Dimension educativa de instrumentos de gestion",
  "Planes de Mejoramiento Educativo (PME)", "NA", "NA", DA, CEM,
  "Portal de datos abiertos", "Abierto", PORTAL_DA, "NA", "NA", "NA",
  "NA", "NA", "NA", "NA", "NA", "NA", "NA", "NA", "NA",
  "Instrumento de gestion educativa por establecimiento; dimension educativa del monitoreo.",
  "Declarada sin verificar", "NA",
  "Listada en la seccion Establecimientos del portal y ausente del reconocimiento. Pendiente de verificacion en una pasada posterior.",
  "NA",

  "F022", "2. SLEP", "2.2 Dimension educativa de instrumentos de gestion",
  "Sistema Nacional de Evaluacion del Desempeno (SNED)", "NA", "NA", DA, CEM,
  "Portal de datos abiertos", "Abierto", PORTAL_DA, "NA", "NA", "NA",
  "NA", "NA", "NA", "NA", "NA", "NA", "NA", "NA", "NA",
  "Desempeno de establecimientos subvencionados; insumo de comparacion territorial.",
  "Declarada sin verificar", "NA",
  "Listada en la seccion Establecimientos del portal y ausente del reconocimiento. Pendiente de verificacion en una pasada posterior.",
  "NA",

  "F023", "2. SLEP", "2.1 Gestion institucional del SLEP",
  "Directorio de sostenedores", "NA", "NA", DA, CEM,
  "Portal de datos abiertos", "Abierto", PORTAL_DA, "NA", "NA", "NA",
  "NA", "NA", "NA", "NA", "NA", "NA", "NA", "NA", "NA",
  "Universo de sostenedores; contraparte institucional del directorio de establecimientos.",
  "Declarada sin verificar", "NA",
  "Listada en la seccion Sostenedores del portal y ausente del reconocimiento. Pendiente de verificacion en una pasada posterior.",
  "NA",

  "F024", "1. Comunidades educativas", "1.4 Instrumentos de gestion educativa",
  "Docentes por curso y subsector", "NA", "NA", DA, CEM,
  "Portal de datos abiertos", "Abierto", PORTAL_DA, "NA", "NA", "NA",
  "NA", "NA", "NA", "NA", "NA", "NA", "NA", "NA", "NA",
  "Asignacion docente por curso; insumo de dotacion y cobertura curricular.",
  "Declarada sin verificar", "NA",
  "Listada en la seccion Docentes y Asistentes del portal y ausente del reconocimiento. Pendiente de verificacion en una pasada posterior.",
  "NA"
)

# ==============================================================================
# TRAMO 2: 11 URLs restantes del lote H mas las 4 primeras del lote J.
#
# Cuatro sitios respondieron HTTP 403 a la herramienta de consulta. Un 403 NO es
# un enlace roto: el host respondio y lo mas probable es que un navegador humano
# si alcance la pagina. Se clasifican como "URL viva sin descarga confirmada" y
# el 403 queda declarado en observaciones, para que el titular lo revise a mano.
# ==============================================================================

INE  <- "Instituto Nacional de Estadisticas (INE)"
MDSF <- "Ministerio de Desarrollo Social y Familia (MDSF)"
DEIS <- "Departamento de Estadisticas e Informacion de Salud (DEIS)"

catalogo_t2 <- tribble(
  ~id_fuente, ~ambito_monitoreo, ~subambito, ~dato, ~descripcion, ~variables, ~base_datos, ~emisor, ~via_de_acceso, ~nivel_acceso, ~url_referencia, ~url_descarga, ~formato, ~detalle_tecnico, ~unidad_de_analisis, ~llaves_de_union, ~desagregacion_territorial, ~cobertura_temporal, ~periodicidad, ~mes_publicacion, ~datos_personales, ~documentacion_tecnica, ~condiciones_de_uso, ~usos_en_monitoreo, ~estado_verificacion, ~fecha_verificacion, ~observaciones, ~copia_local,

  "F025", "3. Contexto", "3.1 Contexto socioterritorial",
  "Geodatos abiertos y cartografia censal",
  "Cartografia censal y division politico administrativa: limites regionales, provinciales, comunales, distritales y urbanos, manzana y entidad censal, mas capas de estadisticas vitales, permisos de edificacion, genero y migracion internacional.",
  "NA", "Geodatos Abiertos", INE, "Descarga directa desde sitio institucional", "Abierto",
  "https://www.ine.gob.cl/herramientas/portal-de-mapas/geodatos-abiertos", "NA",
  "shapefile; zip",
  "Capas en shapefile comprimido y geodatabase, mas puntos de servicio REST de ArcGIS. La pagina no expone enlaces directos de archivo en su HTML.",
  "Comuna", "NA", "Comuna",
  "Censos 1970-2024; permisos de edificacion 2010-2020; registros administrativos 2011-2020",
  "Sin periodicidad definida", "NA", "Sin datos de personas",
  "Metodologia de georreferenciacion de permisos de edificacion",
  "Declara terminos de uso y licencia de datos abiertos, sin detalle en la pagina",
  "Capas base para georreferenciar establecimientos y construir indicadores territoriales.",
  "Verificada", HOY,
  "Es el portal desde el cual cuelga el conjunto de microdatos por manzana de F026, cuya URL directa esta rota. Unica via viva observada para ese material.",
  "NA",

  "F026", "3. Contexto", "3.1 Contexto socioterritorial",
  "Microdatos del Censo 2017 a nivel de manzana",
  "Microdatos censales agregados a nivel de manzana, publicados como conjunto en el portal ArcGIS Open Data del INE.",
  "NA", "Portal ArcGIS Open Data", INE, "Descarga directa desde sitio institucional", "Abierto",
  "https://geoine-ine-chile.opendata.arcgis.com/datasets/54e0c40680054efaabeb9d53b09e1e7a_0", "NA",
  "NA", "NA", "NA", "NA", "NA", "2017", "Por evento", "NA",
  "Sin datos de personas", "NA", "NA",
  "Caracterizacion socioeconomica del entorno inmediato de cada establecimiento.",
  "Enlace roto", HOY,
  "El servidor devuelve HTTP 404. Se busco la URL vigente y no se encontro: los buscadores siguen indexando este mismo identificador como conjunto vivo, y la variante sin el sufijo de capa (hub.arcgis.com/datasets/54e0c40680054efaabeb9d53b09e1e7a) tambien devuelve 404. El 404 puede significar que el conjunto se retiro o que ArcGIS Hub no sirve contenido a un cliente que no sea navegador; con la evidencia disponible no se puede distinguir, y se registra el estado observado sin decidir la causa. Rutas alternativas anotadas para revision desde navegador: ine-chile.maps.arcgis.com/home/item.html?id=54e0c40680054efaabeb9d53b09e1e7a y el portal de geodatos abiertos (F025), que es la via viva confirmada.",
  "NA",

  "F027", "3. Contexto", "3.1 Contexto socioterritorial",
  "Estimaciones y proyecciones de poblacion",
  "Estimaciones y proyecciones de poblacion del pais, sus regiones y comunas, por area urbana y rural, construidas sobre supuestos de fecundidad, mortalidad y migracion.",
  "NA", "Demografia y vitales", INE, "Descarga directa desde sitio institucional", "Abierto",
  "https://www.ine.gob.cl/estadisticas/sociales/demografia-y-vitales/proyecciones-de-poblacion", "NA",
  "pdf",
  "En la pagina solo se observaron publicaciones en PDF (infografias y sintesis). El reconocimiento le atribuia formato xlsx, que no se observo como enlace en esta verificacion.",
  "Comuna", "NA", "Comuna",
  "1992-2050 base 2017 a nivel pais; 2002-2035 a nivel region y area",
  "Sin periodicidad definida", "NA", "Sin datos de personas",
  "Declara secciones de metodologias y metadatos, sin enlace observable en la pagina",
  "Declara terminos de uso y licencia de datos abiertos",
  "Denominador poblacional para tasas de cobertura y de asistencia por comuna.",
  "Verificada", HOY,
  "Discrepancia con el reconocimiento, que declaraba xlsx: en la pagina solo se observaron PDF. Los archivos de datos, si existen, no estan expuestos como enlace en el HTML. Solicitud registrada.",
  "NA",

  "F028", "3. Contexto", "3.1 Contexto socioterritorial",
  "Banco de datos de la Encuesta Nacional de Empleo",
  "Sistema de consulta que permite cruces dinamicos sobre los microdatos de la Encuesta Nacional de Empleo desde el trimestre enero-marzo de 2010.",
  "NA", "Banco de datos ENE", INE, "Sistema con credenciales", "Abierto con registro",
  "https://bancodatosene.ine.cl/", "NA", "sin descarga",
  "Exige cuenta con correo y contrasena; el registro pide RUT, nombre, correo, tipo de institucion y rol. Ofrece una funcion de exportar datos cuyo formato no se declara. Serie recalibrada con proyecciones del Censo 2017; las calibraciones con Censo 2002 se conservan hasta diciembre de 2019.",
  "Nacional", "NA", "Region",
  "2010 en adelante, por trimestre movil",
  "Trimestral", "NA", "Sin datos de personas",
  "Diccionario de variables, cuestionario y preguntas frecuentes, los tres en PDF",
  "NA",
  "Contexto laboral del territorio; ocupacion y desocupacion como determinantes de trayectoria escolar.",
  "Verificada", HOY,
  "Unica fuente de los dos tramos que publica diccionario de variables. El registro exige RUT del solicitante, dato personal del funcionario que se inscribe, no de terceros.",
  "NA",

  "F029", "3. Contexto", "3.1 Contexto socioterritorial",
  "Organizacion Instituto Nacional de Estadisticas en datos.gob.cl",
  "Organizacion del portal nacional de datos abiertos que agrupa 63 conjuntos del INE: encuestas estructurales de servicios, comercio y transporte, entre otras.",
  "NA", "datos.gob.cl", INE, "Portal de datos abiertos", "Abierto",
  "https://datos.gob.cl/organization/instituto_nacional_de_estadisticas", "NA", "html",
  "Publica 63 conjuntos. El portal declara explicitamente que no hay formatos que coincidan con la busqueda, de modo que los formatos por conjunto no son observables desde la pagina de la organizacion.",
  "NA", "NA", "Nacional", "NA", "Sin periodicidad definida", "NA",
  "Sin datos de personas", "NA",
  "Creative Commons Non-Commercial en los 63 conjuntos",
  "Via alternativa a las encuestas del INE, con licencia declarada.",
  "Verificada", HOY,
  "Ultima actualizacion mas reciente observada: 2021-10-12, casi cinco anos atras, lo que sugiere una organizacion poco mantenida frente al sitio propio del INE. Sus 63 conjuntos no se catalogan como filas propias (enmienda E7): no se observo aporte por conjunto frente a la fuente primaria.",
  "NA",

  "F030", "3. Contexto", "3.1 Contexto socioterritorial",
  "Encuesta de Caracterizacion Socioeconomica Nacional (Casen)",
  "Bases de datos de la encuesta Casen, con series historicas de pobreza, ingresos y caracterizacion socioeconomica de los hogares.",
  "NA", "Observatorio Social", MDSF, "Descarga directa desde sitio institucional", "Abierto",
  "https://observatorio.ministeriodesarrollosocial.gob.cl/encuesta-casen", "NA", "NA",
  "La pagina remite a la seccion Base de Datos de cada ano, sin exponer enlaces directos de archivo ni declarar formatos.",
  "Nacional", "NA", "Region",
  "1990, 1992, 1994, 1996, 1998, 2000, 2003, 2006, 2009, 2011, 2013, 2015, 2017, 2020, 2022, 2024",
  "Bienal", "NA", "NA", "NA",
  "No declara licencia; solo politica de privacidad",
  "Caracterizacion socioeconomica del territorio; pobreza comunal como contexto de la trayectoria escolar.",
  "Verificada", HOY,
  "El reconocimiento declaraba un libro de codigos de 2017 como documentacion asociada; en esta verificacion no se observo enlace a libro de codigos, manual ni cuestionario. La periodicidad Bienal se deduce del patron de la serie declarada en la pagina y no de una declaracion del emisor.",
  "NA",

  "F031", "3. Contexto", "3.1 Contexto socioterritorial",
  "Banco Integrado de Datos (BIDAT)",
  "Repositorio centralizado de datos sociales y de inversion publica: encuestas del Observatorio Social, Registro Social de Hogares, pobreza comunal, canasta basica de alimentos, vulnerabilidad socioterritorial y programas sociales.",
  "NA", "BIDAT", MDSF, "Portal de datos abiertos", "Abierto",
  "https://bidat.gob.cl/", "NA", "csv; xlsx; pdf; shapefile; zip",
  "Ofrece ademas formatos estadisticos propietarios no cubiertos por el vocabulario del esquema: STATA (.dta), R (.rdata) y SPSS (.sav). Los mapas en shapefile requieren conversion a .zip. Sitio servido como HTML, no como aplicacion JavaScript.",
  "Comuna", "NA", "Comuna", "NA", "Sin periodicidad definida", "NA",
  "NA", "Declara glosario y centro de ayuda, sin enlace a documentacion tecnica",
  "Remite a una pagina de terminos de uso, sin licencia declarada en la portada",
  "Punto de acceso real a los datos del Registro Social de Hogares y a la pobreza comunal.",
  "Verificada", HOY,
  "Republicacion que SI genera fila propia bajo la enmienda E7: aporta formatos que la fuente primaria no da (.dta, .rdata, .sav y shapefile) y agrega conjuntos que Casen por si sola no cubre. El acceso al Registro de Informacion Social exige afiliacion institucional; el resto del portal es abierto.",
  "NA",

  "F032", "3. Contexto", "3.1 Contexto socioterritorial",
  "Indicadores territoriales del Observatorio Social",
  "Reportes comunales de caracterizacion social y estimaciones de pobreza comunal, segun lo declara el reconocimiento.",
  "NA", "Observatorio Social", MDSF, "Consulta web sin descarga", "Abierto",
  "http://observatorio.ministeriodesarrollosocial.gob.cl/indicadores/", "NA", "NA", "NA",
  "Comuna", "NA", "Comuna", "NA", "Sin periodicidad definida", "NA",
  "NA", "NA", "NA",
  "Reportes comunales listos para caracterizar el territorio sin procesar microdatos.",
  "URL viva sin descarga confirmada", HOY,
  "El servidor devuelve HTTP 403 a la herramienta de consulta. El host respondio, de modo que no es un enlace roto: lo mas probable es que un navegador humano si alcance la pagina. Contenido no verificado. Solicitud registrada.",
  "NA",

  "F033", "3. Contexto", "3.1 Contexto socioterritorial",
  "Consulta interactiva de datos Casen (Redatam)",
  "Herramienta de consulta interactiva del Observatorio Social que genera tabulados y mapas tematicos de Casen en linea.",
  "NA", "Redatam", MDSF, "Consulta web sin descarga", "Abierto",
  "https://redatam.org/redchl/mds/casen/", "NA", "sin descarga",
  "Aplicacion de servidor Redatam. Solo se obtuvo el encabezado de la pagina; el resto exige interaccion.",
  "Nacional", "NA", "Comuna", "NA", "Sin periodicidad definida", "NA",
  "NA", "NA", "NA",
  "Tabulados de Casen sin descargar ni procesar microdatos.",
  "URL viva sin descarga confirmada", HOY,
  "La pagina responde pero entrega solo su encabezado: los anos cubiertos, la desagregacion y el requisito de registro no son observables sin interactuar con la aplicacion. Solicitud registrada.",
  "NA",

  "F034", "3. Contexto", "3.1 Contexto socioterritorial",
  "Data Social, catalogo Casen",
  "Series historicas de indicadores sociales de Casen, segun lo declara el reconocimiento.",
  "NA", "Data Social", MDSF, "Consulta web sin descarga", "Abierto",
  "https://datasocial.ministeriodesarrollosocial.gob.cl/catalogo/casen", "NA", "NA", "NA",
  "NA", "NA", "NA", "NA", "Sin periodicidad definida", "NA",
  "NA", "NA", "NA",
  "Series de indicadores sociales ya calculadas.",
  "No encontrada", HOY,
  "El dominio datasocial.ministeriodesarrollosocial.gob.cl no resuelve en DNS. No es un 404 dentro de un sitio vivo: el host no existe. El servicio parece haber sido retirado o absorbido por BIDAT (F031), que el propio reconocimiento describe como sucesor operativo del Observatorio Social.",
  "NA",

  "F035", "3. Contexto", "3.1 Contexto socioterritorial",
  "Registro Social de Hogares",
  "Portal del Registro Social de Hogares: entrega la cartola con la calificacion socioeconomica del hogar y gestiona solicitudes de ingreso, actualizacion y rectificacion.",
  "NA", "Registro Social de Hogares", MDSF, "Sistema con credenciales", "Institucional mediado",
  "https://www.registrosocial.gob.cl/", "NA", "sin descarga",
  "Exige autenticacion; la pagina no declara cual es el metodo. Entrega la cartola del hogar, no bases de datos.",
  "NA", "NA", "NA", "NA", "Sin periodicidad definida", "NA",
  "Datos personales sensibles", "Publica documentos, protocolos, material audiovisual e infografias",
  "NA",
  "Tramo de calificacion socioeconomica del hogar, consultable caso a caso.",
  "Verificada", HOY,
  "No publica estadisticas agregadas ni bases descargables: los datos del Registro Social de Hogares en formato de base viven en BIDAT (F031), como ya advertia el reconocimiento. No es equivalente de F031: aqui se consulta un hogar, alla se descarga una base.",
  "NA",

  "F036", "3. Contexto", "3.1 Contexto socioterritorial",
  "Portal del Departamento de Estadisticas e Informacion de Salud",
  "Portal de estadisticas de salud: estadisticas vitales, egresos hospitalarios, urgencias, vacunacion y defunciones, segun lo declara el reconocimiento.",
  "NA", "DEIS", DEIS, "Portal de datos abiertos", "Abierto",
  "https://deis.minsal.cl/", "NA", "NA", "NA",
  "NA", "NA", "Comuna", "NA", "Sin periodicidad definida", "NA",
  "NA", "NA", "NA",
  "Contexto de salud del territorio escolar.",
  "URL viva sin descarga confirmada", HOY,
  "El servidor devuelve HTTP 403 a la herramienta de consulta. El host respondio: no es un enlace roto. El reconocimiento ya advertia que el sitio combina secciones nuevas y antiguas y sugeria una migracion en curso; conviene verificar estabilidad de URLs desde navegador. Solicitud registrada.",
  "NA",

  "F037", "3. Contexto", "3.1 Contexto socioterritorial",
  "Organizacion Ministerio de Salud en datos.gob.cl",
  "Organizacion del portal nacional de datos abiertos con 10 conjuntos del sector salud: urgencias respiratorias por semana epidemiologica, establecimientos de salud, defunciones, hospitalizacion y notificaciones ENO.",
  "NA", "datos.gob.cl", DEIS, "Portal de datos abiertos", "Abierto",
  "https://datos.gob.cl/organization/ministerio_de_salud", "NA",
  "csv; xlsx; pdf; json; zip",
  "Publica 10 conjuntos. Declara ademas formatos estadisticos propietarios fuera del vocabulario del esquema: STATA (.dta), R (.rdata), SPSS (.sav) y Parquet.",
  "Comuna", "NA", "Region", "NA", "Semanal", "NA",
  "Sin datos de personas", "NA",
  "Creative Commons: CCZero en 7 conjuntos, Non-Commercial en 2, Attribution en 1",
  "Contexto sanitario del territorio; defunciones y urgencias como senal de contexto.",
  "Verificada", HOY,
  "Actualizacion mas reciente observada: 2026-07-29, dos dias antes de esta verificacion. Es la via mas viva del DEIS frente a su portal propio (F036), que no fue inspeccionable. La periodicidad Semanal se toma de los conjuntos por semana epidemiologica y no de una declaracion global del portal.",
  "NA",

  "F038", "3. Contexto", "3.1 Contexto socioterritorial",
  "Repositorio DEIS de indicadores basicos de salud",
  "Indicadores basicos de salud por comuna, natalidad y mortalidad, segun lo declara el reconocimiento.",
  "NA", "Repositorio DEIS", DEIS, "Descarga directa desde sitio institucional", "Abierto",
  "https://repositoriodeis.minsal.cl/", "NA", "NA", "NA",
  "Comuna", "NA", "Comuna", "NA", "Sin periodicidad definida", "NA",
  "NA", "NA", "NA",
  "Natalidad y mortalidad comunal como contexto demografico.",
  "URL viva sin descarga confirmada", HOY,
  "El servidor devuelve HTTP 403 a la herramienta de consulta. El host respondio: no es un enlace roto. Solicitud registrada.",
  "NA",

  "F039", "1. Comunidades educativas", "1.2 Desarrollo social y personal",
  "Estudio Nacional de Drogas en Poblacion Escolar 2023",
  "Base de datos del decimoquinto Estudio Nacional de Drogas en Poblacion Escolar, segun lo declara el reconocimiento.",
  "NA", "Observatorio Chileno de Drogas",
  "Servicio Nacional para la Prevencion y Rehabilitacion del Consumo de Drogas y Alcohol (SENDA)",
  "Descarga directa desde sitio institucional", "Abierto con registro",
  "https://www.senda.gob.cl/informacion-y-conocimiento/observatorio-chileno-drogas/base-de-datos/base-de-datos-estudio-nacional-de-poblacion-escolar-2023/",
  "NA", "NA", "NA",
  "Estudiante", "NA", "Comuna", "2023", "Por evento", "NA",
  "NA", "NA", "NA",
  "Consumo de sustancias en poblacion escolar; insumo de convivencia y desarrollo personal.",
  "URL viva sin descarga confirmada", HOY,
  "El servidor devuelve HTTP 403 a la herramienta de consulta. El host respondio: no es un enlace roto. Las prevalencias que el reconocimiento atribuia a esta base no se transcriben al catalogo por no haberse observado. Solicitud registrada.",
  "NA"
)

catalogo <- bind_rows(catalogo, catalogo_t2)

# ==============================================================================
# TRAMO 3: 10 URLs restantes del lote J mas las 5 del lote B.
#
# Tres fallas de transporte distintas aparecen por primera vez en este tramo y
# no se confunden entre si: bucle de redirecciones, certificado TLS no
# verificable, y dominio que no resuelve con espejo vivo.
# ==============================================================================

SERMIG <- "Servicio Nacional de Migraciones (SERMIG)"
ACE    <- "Agencia de Calidad de la Educacion (ACE)"

catalogo_t3 <- tribble(
  ~id_fuente, ~ambito_monitoreo, ~subambito, ~dato, ~descripcion, ~variables, ~base_datos, ~emisor, ~via_de_acceso, ~nivel_acceso, ~url_referencia, ~url_descarga, ~formato, ~detalle_tecnico, ~unidad_de_analisis, ~llaves_de_union, ~desagregacion_territorial, ~cobertura_temporal, ~periodicidad, ~mes_publicacion, ~datos_personales, ~documentacion_tecnica, ~condiciones_de_uso, ~usos_en_monitoreo, ~estado_verificacion, ~fecha_verificacion, ~observaciones, ~copia_local,

  "F040", "1. Comunidades educativas", "1.2 Desarrollo social y personal",
  "Bibliodrogas, listado de estudios del Observatorio Chileno de Drogas",
  "Series de estudios en poblacion escolar y general del Observatorio Chileno de Drogas, segun lo declara el reconocimiento.",
  "NA", "Bibliodrogas",
  "Servicio Nacional para la Prevencion y Rehabilitacion del Consumo de Drogas y Alcohol (SENDA)",
  "Reporte en PDF", "Abierto",
  "https://bibliodrogas.gob.cl/observatorio/", "NA", "NA", "NA",
  "NA", "NA", "Nacional", "NA", "Sin periodicidad definida", "NA",
  "NA", "NA", "NA",
  "Serie historica de consumo en poblacion escolar.",
  "URL viva sin descarga confirmada", HOY,
  "La consulta excede diez redirecciones y no llega a contenido. Es un bucle de redirecciones, no un 404 ni un 403: el host responde pero no resuelve a una pagina final. Contenido no verificado. Solicitud registrada.",
  "NA",

  "F041", "3. Contexto", "3.1 Contexto socioterritorial",
  "Datos abiertos de permisos de residencia y refugio",
  "Bases estructuradas derivadas de registros administrativos de permisos de residencia temporal, residencia definitiva y solicitudes de refugio, desde el ano 2000.",
  "NA", "Datos abiertos SERMIG", SERMIG,
  "Descarga directa desde sitio institucional", "Abierto",
  "https://serviciomigraciones.cl/en/migration-studies/open-data/",
  "https://serviciomigraciones.cl/wp-content/uploads/estudios/Datos-abiertos/RT/RT_Acogidas_2000_1er_semestre_2026.xlsx",
  "xlsx; zip",
  "Publica ocho libros .xlsx en cuatro pares de datos mas metadatos: residencia temporal acogidas y resueltas, residencia definitiva acogidas y resueltas. El refugio va aparte, como .zip con informe y base. url_descarga apunta al par de residencia temporal acogidas.",
  "Nacional", "NA", "Nacional",
  "2000 al primer semestre de 2026",
  "Semestral", "NA", "NA",
  "Un libro de metadatos .xlsx por cada base, publicado junto al dato",
  "No declara licencia",
  "Poblacion migrante como contexto de la matricula del territorio.",
  "Verificada", HOY,
  "Unica fuente de los tres tramos que publica un archivo de metadatos junto a cada base. Esos metadatos son la via para poblar variables sin descargar el dato mismo; se piden como solicitud. Actualizacion mas reciente declarada: 7 de enero de 2026. La pagina no declara desagregacion territorial.",
  "NA",

  "F042", "3. Contexto", "3.1 Contexto socioterritorial",
  "Reportes demograficos de poblacion migrante",
  "Reportes de demografia de la poblacion migrante por continente de origen, region y comuna, construidos sobre el Censo 2024.",
  "NA", "Estudios migratorios", SERMIG, "Reporte en PDF", "Abierto",
  "https://serviciomigraciones.cl/en/migration-studies/demography/", "NA",
  "pdf; zip",
  "Un PDF por cada una de las 16 regiones y por comuna, mas paquetes .zip por continente y una descarga masiva de todas las comunas. Los href completos no aparecen en el HTML: la pagina usa rutas relativas.",
  "Comuna", "NA", "Comuna", "2024", "Por evento", "NA",
  "Sin datos de personas", "NA", "No declara licencia",
  "Caracterizacion de la poblacion migrante por comuna del territorio.",
  "Verificada", HOY,
  "Ultima actualizacion declarada: 1 de julio de 2025. Es la contraparte agregada de F041, que entrega el dato en bruto.",
  "NA",

  "F043", "1. Comunidades educativas", "1.2 Desarrollo social y personal",
  "Sistema de informacion estadistica de Mejor Ninez",
  "Estadisticas de proteccion especializada de ninez y adolescencia, segun lo declara el reconocimiento.",
  "NA", "Sistema de informacion estadistica",
  "Servicio Nacional de Proteccion Especializada a la Ninez y Adolescencia (Mejor Ninez)",
  "Consulta web sin descarga", "Abierto",
  "https://sis.mejorninez.cl/mejor-ninez.html", "NA", "NA", "NA",
  "NA", "NA", "NA", "NA", "Sin periodicidad definida", "NA",
  "NA", "NA", "NA",
  "Contexto de proteccion especializada de los estudiantes del territorio.",
  "URL viva sin descarga confirmada", HOY,
  "La cadena de certificados TLS no se puede verificar: el servidor no entrega el certificado intermedio. No es un 404 ni un 403, y un navegador podria aceptarlo con advertencia. Contenido no verificado. Solicitud registrada.",
  "NA",

  "F044", "3. Contexto", "3.1 Contexto socioterritorial",
  "Estadisticas delictuales por comuna",
  "Casos policiales conocidos por las policias para distintos grupos delictuales, con totales nacionales, por region, provincia y comuna.",
  "NA", "CEAD", "Subsecretaria de Prevencion del Delito",
  "Consulta web sin descarga", "Abierto",
  "https://cead.minsegpublica.gob.cl/estadisticas-delictuales/", "NA", "sin descarga",
  "Sistema interactivo con cortes anual, trimestral y mensual. Cubre el total nacional, 16 regiones, 54 provincias y cientos de comunas. La pagina no declara formatos de exportacion.",
  "Comuna", "NA", "Comuna", "2005-2026",
  "Mensual", "NA", "Sin datos de personas",
  "Notas tecnicas que explican la metodologia, incluido el calculo de poblacion con proyecciones del INE",
  "No declara licencia",
  "Contexto de seguridad del territorio escolar.",
  "Verificada", HOY,
  "El dominio del reconocimiento (cead.spd.gov.cl) NO resuelve en DNS. El propio reconocimiento anticipaba un espejo y pedia verificarlo: el espejo cead.minsegpublica.gob.cl si responde y es el que se cataloga en url_referencia. La sospecha 9 del reconocimiento queda resuelta y la advertencia de que era una aplicacion JavaScript no se confirmo: el sitio rinde como HTML.",
  "NA",

  "F045", "1. Comunidades educativas", "1.2 Desarrollo social y personal",
  "Tercer Estudio Nacional de la Discapacidad (III ENDISC 2022)",
  "Prevalencia de discapacidad en poblacion adulta y en ninos, ninas y adolescentes de 2 a 17 anos, a nivel nacional y en las 16 regiones, sobre la Encuesta Nacional de Discapacidad y Dependencia.",
  "NA", "III ENDISC", "Servicio Nacional de la Discapacidad (SENADIS)",
  "Reporte en PDF", "Abierto",
  "https://www.senadis.gob.cl/pag/693/2004/iii_estudio_nacional_de_la_discapacidad",
  "https://www.senadis.gob.cl/descarga/i/7442/documento", "pdf",
  "url_descarga apunta al libro del estudio. Las secciones de datos remiten a paginas propias que no exponen enlaces directos de archivo.",
  "Nacional", "NA", "Region", "2022", "Por evento", "NA",
  "NA", "NA", "No declara licencia",
  "Prevalencia de discapacidad en poblacion escolar como contexto de necesidades educativas.",
  "Verificada", HOY,
  "El reconocimiento databa el estudio en 2004 por la URL, que conserva ese numero en su ruta; el estudio es de 2022. La base de datos como tal no se observo: solo el libro en PDF. Solicitud registrada.",
  "NA",

  "F046", "3. Contexto", "3.1 Contexto socioterritorial",
  "Organizacion Servicio de Registro Civil e Identificacion en datos.gob.cl",
  "Organizacion del portal nacional de datos abiertos con tres conjuntos: nombres mas comunes de ninos, no donantes y personas juridicas sin fines de lucro.",
  "NA", "datos.gob.cl", "Servicio de Registro Civil e Identificacion (SRCeI)",
  "Portal de datos abiertos", "Abierto",
  "https://datos.gob.cl/organization/servicio_de_registro_civil_e_identificacion",
  "NA", "xlsx",
  "Publica 3 conjuntos, los tres en formato xls.",
  "Nacional", "NA", "Nacional", "NA", "Sin periodicidad definida", "NA",
  "Sin datos de personas", "NA",
  "Creative Commons Non-Commercial en los 3 conjuntos",
  "Aporte marginal al monitoreo: ninguno de los tres conjuntos es de uso educativo directo.",
  "Verificada", HOY,
  "Discrepancia grande con el reconocimiento, que le atribuia nacimientos, defunciones, nombres y personas juridicas por comuna, en formato api. Lo observado son 3 conjuntos en xls, sin nacimientos ni defunciones, y con ultima actualizacion en 2015-10-30, casi once anos atras. La organizacion esta practicamente abandonada.",
  "NA",

  "F047", "1. Comunidades educativas", "1.2 Desarrollo social y personal",
  "Encuesta Nacional de Juventudes",
  "Encuesta trienal sobre educacion, trabajo y participacion de jovenes, segun lo declara el reconocimiento.",
  "NA", "Encuesta Nacional de Juventudes",
  "Instituto Nacional de la Juventud (INJUV)",
  "Descarga directa desde sitio institucional", "Abierto",
  "https://www.injuv.gob.cl/encuestanacionaldejuventud", "NA", "NA", "NA",
  "NA", "NA", "Nacional", "NA", "Sin periodicidad definida", "NA",
  "NA", "NA", "NA",
  "Trayectoria post escolar y participacion juvenil como contexto de egreso.",
  "URL viva sin descarga confirmada", HOY,
  "La cadena de certificados TLS no se puede verificar: el servidor no entrega el certificado intermedio, la misma falla de F043. Contenido no verificado. Solicitud registrada.",
  "NA",

  "F048", "1. Comunidades educativas", "1.2 Desarrollo social y personal",
  "Encuesta Nacional de Habitos de Actividad Fisica y Deporte",
  "Niveles de actividad fisica en poblacion mayor de 5 anos, con un indice multidimensional que clasifica a las personas como activas, parcialmente activas e inactivas segun recomendaciones de la Organizacion Mundial de la Salud.",
  "NA", "ENAFYD", "Ministerio del Deporte (Mindep)", "Reporte en PDF", "Abierto",
  "https://www.mindep.cl/secciones/211",
  "https://page-mindep.s3.amazonaws.com/sigi/files/23033_informe_ejecutivo_nacional_enafyd_1911.pdf",
  "pdf",
  "url_descarga apunta al informe ejecutivo nacional. Se publica ademas una presentacion en PDF. Los archivos viven en un bucket de Amazon S3, no en el dominio institucional.",
  "Nacional", "NA", "Nacional", "2024", "Por evento", "NA",
  "Sin datos de personas", "NA", "No declara licencia",
  "Habitos de actividad fisica de la poblacion escolar como contexto de desarrollo personal.",
  "Verificada", HOY,
  "La pagina no declara el ano de la encuesta en su encabezado, aunque el texto menciona 2024 y lista documentos de 2018, 2019 y 2021. No declara desagregacion territorial, pese a que el reconocimiento la atribuia por region.",
  "NA",

  "F049", "1. Comunidades educativas", "1.2 Desarrollo social y personal",
  "Observatorio de Derechos de la Ninez",
  "Indicadores de derechos de ninos, ninas y adolescentes organizados en cuatro grupos: vida y supervivencia, desarrollo, proteccion y participacion.",
  "NA", "Observatorio de Derechos", "Defensoria de los Derechos de la Ninez",
  "Consulta web sin descarga", "Abierto",
  "https://observatorio.defensorianinez.cl/", "NA", "sin descarga",
  "Buscador de datos por tema, mas documentos descargables: diagnosticos anuales, notas tecnicas, minutas de politica y documentos de trabajo. No declara formatos de dato bruto.",
  "Nacional", "NA", "Nacional", "2018-2025", "Anual", "NA",
  "Sin datos de personas",
  "Diagnosticos anuales, notas tecnicas, minutas de politica y documentos de trabajo",
  "No declara licencia",
  "Marco de derechos para leer los indicadores de trayectoria y convivencia.",
  "Verificada", HOY,
  "Entre los indicadores del grupo de desarrollo hay educacion, recreacion y espacios publicos, directamente pertinentes al monitoreo. Diagnostico anual 2026 disponible.",
  "NA",

  "F050", "1. Comunidades educativas", "1.3 Aprendizajes y resultados",
  "Resultados Simce e IDPS, seccion institucional",
  "Seccion institucional del Simce: resultados nacionales, regionales y comunales, informes tecnicos, documentacion metodologica y acceso a la base de datos estadistica.",
  "NA", "Simce", ACE, "Reporte en PDF", "Abierto",
  "https://www.agenciaeducacion.cl/simce/", "NA", "pdf; rar; html",
  "Publica presentaciones nacionales y por region en PDF, informes tecnicos, archivos complementarios en .rar, un panel Power BI y datos enlazados en RDF, TTL y JSON-LD. Los enlaces de documento apuntan a archivos en Amazon S3.",
  "Establecimiento", "NA", "Comuna", "2010-2025", "Anual", "NA",
  "Sin datos de personas",
  "Informes tecnicos Simce e IDPS 2012-2024; metodologia de construccion de grupos socioeconomicos 2011-2013; calculo de significancia estadistica",
  "No declara restricciones explicitas de licencia; el acceso a datos enmascarados por estudiante exige solicitud formal via Portal de Transparencia u OIRS",
  "Resultados de aprendizaje y desarrollo personal y social por establecimiento del territorio.",
  "Verificada", HOY,
  "Es la fuente mejor documentada de los tres tramos: catorce anos de informes tecnicos y metodologia publicada. Presentaciones por region en diez anos distintos e informes por comuna solo en 2022. Es la puerta de entrada a F051, F052 y F054.",
  "NA",

  "F051", "1. Comunidades educativas", "1.3 Aprendizajes y resultados",
  "Informacion estadistica por establecimiento",
  "Base de datos estadistica de Simce e IDPS por establecimiento, comuna y region, con publicacion de datos enlazados, segun lo declara el reconocimiento.",
  "NA", "Informacion estadistica", ACE, "Portal de datos abiertos", "Abierto",
  "https://informacionestadistica.agenciaeducacion.cl", "NA", "NA",
  "El servidor entrega la plantilla sin renderizar: el cuerpo de la pagina llega con el marcador literal {{titulo}} en vez de contenido. Es una aplicacion de pagina unica que arma su contenido en el navegador.",
  "Establecimiento", "NA", "Establecimiento", "NA", "Sin periodicidad definida", "NA",
  "NA", "NA", "NA",
  "Resultados por establecimiento en formato consultable, sin pasar por los PDF.",
  "URL viva sin descarga confirmada", HOY,
  "El host responde y sirve HTML, pero el HTML no tiene contenido: la interpolacion de plantilla no se ejecuta fuera de un navegador. Es una falla distinta del 403 y del 404. Contenido no verificado. Solicitud registrada.",
  "NA",

  "F052", "1. Comunidades educativas", "1.3 Aprendizajes y resultados",
  "Visor Simce",
  "Tablero interactivo que integra datos historicos de Simce e IDPS y permite analizar resultados nacionales, brechas de genero y brechas por nivel socioeconomico.",
  "NA", "Visor Simce", ACE, "Consulta web sin descarga", "Abierto",
  "https://visorsimce.agenciaeducacion.cl/", "NA", "sin descarga",
  "Permite personalizar por region, ano, genero, grado y asignatura. La pagina de presentacion no declara si el visor permite exportar.",
  "Establecimiento", "NA", "Region", "NA", "Sin periodicidad definida", "NA",
  "Sin datos de personas", "NA", "NA",
  "Lectura rapida de tendencias y brechas sin procesar bases.",
  "Verificada", HOY,
  "El reconocimiento apuntaba a la noticia de lanzamiento; la URL del visor mismo es visorsimce.agenciaeducacion.cl y es la que se cataloga. La cobertura temporal no se declara en la pagina de presentacion.",
  "NA",

  "F053", "1. Comunidades educativas", "1.3 Aprendizajes y resultados",
  "Plataforma de resultados para SLEP y sostenedores",
  "Plataforma con resultados Simce e IDPS por establecimiento, dirigida a servicios locales y sostenedores, segun lo declara el reconocimiento.",
  "NA", "Plataforma de resultados", ACE, "Sistema con credenciales",
  "Institucional mediado",
  "https://resultadossimce.agenciaeducacion.cl/login", "NA", "NA", "NA",
  "Establecimiento", "NA", "Establecimiento", "NA", "Sin periodicidad definida", "NA",
  "NA", "NA", "NA",
  "Via institucional del SLEP a sus propios resultados, con el detalle que el dato publico no trae.",
  "Enlace roto", HOY,
  "El servidor devuelve HTTP 404 en la ruta /login. El host resuelve, de modo que la plataforma probablemente existe con otra ruta de entrada. Es la fuente mas pertinente del lote para el Area, porque es la via institucional propia del SLEP: conviene resolverla. Solicitud registrada.",
  "NA",

  "F054", "1. Comunidades educativas", "1.3 Aprendizajes y resultados",
  "Bases de datos Simce a nivel de estudiante",
  "Puntajes por estudiante y cuestionarios de estudiantes, padres y docentes, con identificador enmascarado, segun lo declara el reconocimiento.",
  "NA", "Simce", ACE, "Solicitud formal (Ley 20.285)", "Restringido por solicitud",
  "https://www.agenciaeducacion.cl/simce/", "NA", "NA", "NA",
  "Estudiante", "NA", "Establecimiento", "NA", "Sin periodicidad definida", "NA",
  "Identificador enmascarado (MRUN)", "NA",
  "Exige solicitud formal via Portal de Transparencia u OIRS",
  "Nivel de dato mas fino disponible de Simce; habilita analisis de trayectoria individual.",
  "Declarada sin verificar", "NA",
  "El reconocimiento la registro como mencionada sin URL directa y no hay pagina propia que abrir. La seccion Simce (F050) confirma la via: el acceso a datos enmascarados por estudiante exige solicitud formal. La sospecha 6 del reconocimiento queda confirmada. datos_personales se declara como identificador enmascarado porque F050 lo describe asi, no por inspeccion de la base.",
  "NA"
)

catalogo <- bind_rows(catalogo, catalogo_t3)

# ==============================================================================
# TRAMO 4: lotes D, C, E y las tres primeras de F.
#
# Hallazgo sistematico del tramo: en datos.gob.cl las paginas de ORGANIZACION
# rinden como HTML y las fichas de CONJUNTO (/dataset/<slug>) devuelven la
# portada del portal. Las tres fichas del lote C se poblaron con lo que declara
# la pagina de organizacion, que si se leyo, y no con supuestos.
# ==============================================================================

JUNAEB <- "Junta Nacional de Auxilio Escolar y Becas (Junaeb)"
SIE    <- "Superintendencia de Educacion (SIE)"
JUNJI  <- "Junta Nacional de Jardines Infantiles (JUNJI)"
CPEIP  <- "Centro de Perfeccionamiento, Experimentacion e Investigaciones Pedagogicas (CPEIP)"
GOBCL  <- "datos.gob.cl"

catalogo_t4 <- tribble(
  ~id_fuente, ~ambito_monitoreo, ~subambito, ~dato, ~descripcion, ~variables, ~base_datos, ~emisor, ~via_de_acceso, ~nivel_acceso, ~url_referencia, ~url_descarga, ~formato, ~detalle_tecnico, ~unidad_de_analisis, ~llaves_de_union, ~desagregacion_territorial, ~cobertura_temporal, ~periodicidad, ~mes_publicacion, ~datos_personales, ~documentacion_tecnica, ~condiciones_de_uso, ~usos_en_monitoreo, ~estado_verificacion, ~fecha_verificacion, ~observaciones, ~copia_local,

  "F055", "1. Comunidades educativas", "1.2 Desarrollo social y personal",
  "Mapa Nutricional",
  "Distribucion de la situacion nutricional de estudiantes de establecimientos financiados por el Estado, con series por region y comuna e intervalos de confianza.",
  "NA", "Mapa Nutricional", JUNAEB,
  "Descarga directa desde sitio institucional", "Abierto",
  "https://www.junaeb.cl/mapa-nutricional", "NA", "xlsx; pdf",
  "Publica evolucion nacional 2009-2025 en PDF, evolucion por region 2009-2025 en XLSX e intervalos de confianza comunales 2024-2025 en XLSX, mas informes anuales 2017-2025 y presentaciones 2016-2025 en PDF.",
  "Establecimiento", "NA", "Comuna",
  "1997 en adelante para 1 basico; 2003 para 1 medio; 2007 para prekinder y kinder; 2018 para 5 basico; tablas publicadas desde 2011",
  "Anual", "NA", "Sin datos de personas",
  "Diccionario de variables publicado, mas metodologia de la Organizacion Mundial de la Salud y protocolo de medicion antropometrica",
  "No declara licencia",
  "Estado nutricional de los estudiantes del territorio; insumo de desarrollo social y personal.",
  "Verificada", HOY,
  "Segunda fuente de las 60 URLs que publica diccionario de variables, tras el Banco de datos ENE del INE. La cobertura no es uniforme: cada nivel educativo entra a la serie en un ano distinto, lo que hay que tener presente antes de construir series largas.",
  "NA",

  "F056", "1. Comunidades educativas", "1.2 Desarrollo social y personal",
  "Biblioteca de Datos para la Investigacion",
  "Repositorio de bases desidentificadas de Mapa Nutricional y programas de alimentacion escolar, con llave ID_JUNAEB, segun lo declara el reconocimiento.",
  "NA", "Biblioteca de Datos", JUNAEB, "Sistema con credenciales", "Abierto con registro",
  "https://bibliotecadatos.sead.junaeb.cl/", "NA", "NA",
  "El servidor entrega solo el encabezado de la pagina; el cuerpo no llega. No se pudo observar el catalogo, el requisito de registro ni la llave declarada.",
  "Estudiante", "NA", "NA", "NA", "Sin periodicidad definida", "NA",
  "NA", "NA", "NA",
  "Microdatos desidentificados que permitirian vincular nutricion y alimentacion escolar a nivel individual.",
  "URL viva sin descarga confirmada", HOY,
  "El reconocimiento la destacaba como su hallazgo numero 1 y le atribuia la llave ID_JUNAEB; nada de eso se pudo confirmar. Es la fuente de mayor valor potencial no verificada del catalogo. Solicitud registrada.",
  "NA",

  "F057", "1. Comunidades educativas", "1.2 Desarrollo social y personal",
  "Informe Mapa Nutricional 2025",
  "Informe anual de resultados del Mapa Nutricional correspondiente al ano 2025.",
  "NA", "Mapa Nutricional", JUNAEB,
  "Descarga directa desde sitio institucional", "Abierto",
  "https://www.junaeb.cl/mapa-nutricional",
  "https://www.junaeb.cl/wp-content/uploads/2026/03/Mapa-Nutricional-Resultados-2025.pdf",
  "pdf",
  "El archivo existe y pesa 2,2 MB, pero es un PDF de imagen: no tiene texto extraible, de modo que su contenido no se pudo leer ni verificar.",
  "Establecimiento", "NA", "Comuna", "2025", "Anual", "NA",
  "Sin datos de personas", "NA", "No declara licencia",
  "Resultados nutricionales del ano mas reciente.",
  "Verificada", HOY,
  "Verificada en el sentido de que la URL responde y el archivo existe con su tamano integro; su contenido no se transcribe porque el PDF no expone texto. Las cifras de prevalencia que el reconocimiento le atribuia NO se copian al catalogo: no fueron observadas.",
  "NA",

  "F058", "2. SLEP", "2.1 Gestion institucional del SLEP",
  "Organizacion Superintendencia de Educacion en datos.gob.cl",
  "Organizacion del portal nacional de datos abiertos con tres conjuntos de la Superintendencia: denuncias, solicitudes de mediacion y procesos administrativos sancionatorios.",
  "NA", GOBCL, SIE, "Portal de datos abiertos", "Abierto",
  "https://datos.gob.cl/organization/superintendencia-de-educacion", "NA", "csv",
  "Publica 3 conjuntos, los tres en CSV. Las tres fichas se actualizaron el 2024-07-01.",
  "NA", "NA", "Nacional", "NA", "Sin periodicidad definida", "NA",
  "Sin datos de personas", "NA",
  "Creative Commons Attribution (CC-BY) en los 3 conjuntos",
  "Denuncias y mediaciones como senal de convivencia escolar en el territorio.",
  "Verificada", HOY,
  "Es la pagina que sostiene a F059, F060 y F061: sus fichas individuales no rinden, y los formatos, licencias y fechas de esos tres conjuntos se tomaron de aqui, que si se leyo.",
  "NA",

  "F059", "1. Comunidades educativas", "1.2 Desarrollo social y personal",
  "Denuncias ante la Superintendencia de Educacion",
  "Registro de denuncias presentadas ante la Superintendencia de Educacion, por ambito, tema, region y dependencia, segun lo declara el reconocimiento.",
  "NA", GOBCL, SIE, "Portal de datos abiertos", "Abierto",
  "https://datos.gob.cl/dataset/denuncias", "NA", "csv",
  "Formato y licencia tomados de la pagina de organizacion (F058), que si rinde. Ultima actualizacion declarada alli: 2024-07-01.",
  "Establecimiento", "NA", "Region", "NA", "Sin periodicidad definida", "NA",
  "NA", "NA", "Creative Commons Attribution (CC-BY)",
  "Denuncias por establecimiento y tema; senal directa de convivencia escolar.",
  "URL viva sin descarga confirmada", HOY,
  "La ficha del conjunto devuelve la portada del portal en vez de su propia pagina: datos.gob.cl arma las fichas en el navegador. El host responde, de modo que no es enlace roto. La cobertura desde 2014 que declaraba el reconocimiento NO se pudo confirmar y queda como NA. Solicitud registrada.",
  "NA",

  "F060", "1. Comunidades educativas", "1.2 Desarrollo social y personal",
  "Solicitudes de mediacion ante la Superintendencia de Educacion",
  "Registro de solicitudes de mediacion presentadas ante la Superintendencia de Educacion, segun lo declara el reconocimiento.",
  "NA", GOBCL, SIE, "Portal de datos abiertos", "Abierto",
  "https://datos.gob.cl/dataset/solicitudes-de-mediacion", "NA", "csv",
  "Formato y licencia tomados de la pagina de organizacion (F058). Ultima actualizacion declarada alli: 2024-07-01.",
  "Establecimiento", "NA", "Region", "NA", "Sin periodicidad definida", "NA",
  "NA", "NA", "Creative Commons Attribution (CC-BY)",
  "Mediaciones como indicador de conflictos resueltos sin sancion.",
  "URL viva sin descarga confirmada", HOY,
  "Misma falla que F059: la ficha del conjunto devuelve la portada del portal. La cobertura desde 2015 que declaraba el reconocimiento no se pudo confirmar. Solicitud registrada.",
  "NA",

  "F061", "2. SLEP", "2.1 Gestion institucional del SLEP",
  "Procesos administrativos sancionatorios",
  "Registro de procesos administrativos sancionatorios de la ley 20.529, segun lo declara el reconocimiento.",
  "NA", GOBCL, SIE, "Portal de datos abiertos", "Abierto",
  "https://datos.gob.cl/dataset/procesos-administrativos-sancionatorios", "NA", "csv",
  "Formato y licencia tomados de la pagina de organizacion (F058). Ultima actualizacion declarada alli: 2024-07-01.",
  "Establecimiento", "NA", "Region", "NA", "Sin periodicidad definida", "NA",
  "NA", "NA", "Creative Commons Attribution (CC-BY)",
  "Sanciones por establecimiento; riesgo normativo del sostenedor.",
  "URL viva sin descarga confirmada", HOY,
  "Misma falla que F059 y F060: la ficha del conjunto devuelve la portada del portal. Solicitud registrada.",
  "NA",

  "F062", "2. SLEP", "2.1 Gestion institucional del SLEP",
  "Portal de Datos Abiertos institucional de la Superintendencia",
  "Portal propio de datos abiertos de la Superintendencia de Educacion, con registros y estadisticas de denuncias, mediaciones y sanciones, segun lo declara el reconocimiento.",
  "NA", "Portal institucional", SIE, "Portal de datos abiertos", "Abierto",
  "NA", "NA", "NA", "NA",
  "NA", "NA", "NA", "NA", "Sin periodicidad definida", "NA",
  "NA", "NA", "NA",
  "Fuente institucional propia, potencialmente mas completa que los 3 conjuntos de datos.gob.cl.",
  "Declarada sin verificar", "NA",
  "El reconocimiento la registro como mencionada sin URL directa: la Superintendencia comunica un portal propio en supereduc.cl/datosabiertos cuya direccion exacta no se pudo confirmar. Es la sospecha 1 del reconocimiento y sigue abierta. Sin URL que abrir.",
  "NA",

  "F063", "1. Comunidades educativas", "1.1 Trayectorias estudiantiles",
  "Organizacion Junta Nacional de Jardines Infantiles en datos.gob.cl",
  "Organizacion del portal nacional de datos abiertos con dos conjuntos homonimos de jardines infantiles JUNJI.",
  "NA", GOBCL, JUNJI, "Portal de datos abiertos", "Abierto",
  "https://datos.gob.cl/organization/junta_nacional_de_jardines_infantiles", "NA", "html",
  "Publica 2 conjuntos, ambos titulados Jardines Infantiles JUNJI, distinguibles solo por su identificador (27818 y 28271). El portal declara que no hay formatos que coincidan con la busqueda.",
  "Jardin infantil", "NA", "Nacional", "NA", "Sin periodicidad definida", "NA",
  "Sin datos de personas", "NA",
  "Creative Commons Non-Commercial en los 2 conjuntos",
  "Universo de jardines infantiles del territorio.",
  "Verificada", HOY,
  "Dos conjuntos con nombre identico y sin formato declarado, ambos actualizados por ultima vez el 2015-10-30, mismo dia que la organizacion del Registro Civil (F046). El Geoportal (F064) es una via mucho mas util al mismo universo.",
  "NA",

  "F064", "1. Comunidades educativas", "1.1 Trayectorias estudiantiles",
  "Jardines Infantiles JUNJI georreferenciados",
  "Capa de puntos con la ubicacion de las unidades educativas de JUNJI en operacion a abril de 2024, por region y comuna, con direccion y capacidad de atencion.",
  "NA", "Geoportal de Chile", JUNJI,
  "Descarga directa desde sitio institucional", "Abierto",
  "https://geoportal.cl/geoportal/catalog/34965/Jardines%20Infantiles%20JUNJI",
  "https://geoportal.cl/geoportal/catalog/download/1248e5ef-e1ea-3a68-ac3c-199239cc68a7",
  "shapefile",
  "Capa geoespacial de puntos con cobertura nacional. Extension declarada: oeste -76,5484; este -62,1956; sur -56,6513; norte -16,2247. Ofrece ademas servicio WMS.",
  "Jardin infantil", "NA", "Comuna", "2024", "Por evento", "NA",
  "Sin datos de personas",
  "Ficha de metadatos con organizacion responsable, contacto, direccion y servicio WMS",
  "No declara licencia explicita; solo pide citar a la institucion proveedora",
  "Georreferenciacion de la oferta de educacion parvularia del territorio.",
  "Verificada", HOY,
  "Publicada el 19 de junio de 2024 con datos a abril de 2024. Es la fuente georreferenciada mas concreta del catalogo: trae URL de descarga directa y ficha de metadatos, a diferencia de los dos conjuntos homonimos de F063.",
  "NA",

  "F065", "1. Comunidades educativas", "1.1 Trayectorias estudiantiles",
  "Sitio institucional de la Subsecretaria de Educacion Parvularia",
  "Plataforma de recursos y orientaciones para educacion inicial de 0 a 6 anos: marcos curriculares, estandares pedagogicos, material didactico y analisis de matricula.",
  "NA", "Sitio institucional", "Subsecretaria de Educacion Parvularia (Mineduc)",
  "Reporte en PDF", "Abierto",
  "https://parvularia.mineduc.cl/", "NA", "html",
  "No expone descargas con enlace directo ni declara formatos. Remite a un analisis de matricula 2025 y a resultados del estudio TALIS 2024.",
  "NA", "NA", "NA", "NA", "Sin periodicidad definida", "NA",
  "Sin datos de personas", "NA", "No declara licencia",
  "Marco normativo y curricular del nivel parvulario; contexto de los reportes del Area.",
  "Verificada", HOY,
  "El reconocimiento le atribuia informes de caracterizacion, matricula y personal en PDF. Lo observado es un sitio de recursos pedagogicos con estadistica marginal: su aporte al catalogo de fuentes es bajo. La matricula parvularia real vive en F003 y F066.",
  "NA",

  "F066", "1. Comunidades educativas", "1.1 Trayectorias estudiantiles",
  "Resumen de matricula en educacion parvularia por establecimiento",
  "Matricula de educacion parvularia agregada por establecimiento educacional.",
  "NA", DA, CEM, "Portal de datos abiertos", "Abierto",
  "https://datosabiertos.mineduc.cl/resumen-de-matricula-en-educacion-parvularia-por-establecimiento-educacional/",
  "https://datosabiertos.mineduc.cl/wp-content/uploads/2026/02/Resumen-Educacion-Parvularia-2025.rar",
  "rar",
  "Archivos anuales .rar, 2011-2025. url_descarga apunta al ano 2025, subido en 2026/02. La carpeta de subida varia por ano, de modo que la serie exige leer cada enlace en la pagina.",
  "Establecimiento", "NA", "Establecimiento", "2011-2025", "Anual", "NA",
  "Sin datos de personas", "NA", "NA",
  "Version agregada por establecimiento de la matricula parvularia; complementa el dato individual de F003.",
  "Verificada", HOY,
  "La pagina no publica esquema de registros ni descripcion propia. Es la contraparte agregada de F003, que entrega la matricula parvularia por estudiante. Solicitud registrada.",
  "NA",

  "F067", "1. Comunidades educativas", "1.4 Instrumentos de gestion educativa",
  "Sistema de Reconocimiento de la carrera docente",
  "Proceso evaluativo que permite la progresion de docentes en la Carrera Docente, valorando trayectoria, experiencia, competencias y conocimientos.",
  "NA", "Sitio institucional", CPEIP, "Consulta web sin descarga", "Abierto",
  "https://cpeip.cl/evaluacion-de-la-docencia/", "NA", "html",
  "Pagina descriptiva del sistema. No expone informes, bases ni archivos descargables. Describe los instrumentos Portafolio y ECEP y remite a la ley 21.625.",
  "Docente o asistente", "NA", "NA", "NA", "Sin periodicidad definida", "NA",
  "Sin datos de personas", "NA", "No declara licencia",
  "Marco del sistema de evaluacion docente que produce los datos de F068 y F069.",
  "Verificada", HOY,
  "El reconocimiento le atribuia resultados, tramos y documentacion en PDF. Lo observado es una pagina puramente descriptiva, sin cobertura temporal ni descargas. Su valor es de contexto, no de dato.",
  "NA",

  "F068", "1. Comunidades educativas", "1.4 Instrumentos de gestion educativa",
  "Informe Nacional del Portafolio",
  "Resultados estadisticos del instrumento Portafolio del Sistema de Reconocimiento, con graficos, tablas y comparacion historica por agrupacion evaluada, dependencia y region.",
  "NA", "Informe Nacional del Portafolio", CPEIP, "Reporte en PDF", "Abierto",
  "https://cpeip.cl/informe-nacional-del-portafolio-2022/", "NA", "NA",
  "La pagina no aloja el informe: remite a un sitio externo, docentemas.cl, sin descarga directa ni formato declarado.",
  "Docente o asistente", "NA", "Region", "2022", "Anual", "NA",
  "Sin datos de personas", "NA", "No declara licencia",
  "Resultados del Portafolio por region y dependencia; contexto de la dotacion docente del territorio.",
  "Verificada", HOY,
  "El informe vive en docentemas.cl, dominio que el reconocimiento no inventario y que queda fuera del alcance de este catalogo. Se anota la dependencia externa sin seguirla.",
  "NA",

  "F069", "1. Comunidades educativas", "1.4 Instrumentos de gestion educativa",
  "Plataforma de la Evaluacion de Conocimientos Especificos y Pedagogicos",
  "Sitio del proceso ECEP: validacion de datos, convocatoria, temarios y calendario de la evaluacion.",
  "NA", "ECEP", ACE, "Consulta web sin descarga", "Abierto",
  "https://www.evaluacionconocimientos.cl/", "NA", "pdf; html",
  "Publica los temarios de las pruebas 2026 y un documento de equivalencia entre Portafolio y ECEP en PDF. Remite a Carrera Docente, DocenteMas y Portal Docente para tramites y resultados.",
  "Docente o asistente", "NA", "NA", "2026", "Anual", "NA",
  "Sin datos de personas",
  "Documento de coherencia entre Portafolio y ECEP, y temarios de las pruebas",
  "No declara licencia",
  "Calendario e instrumentos de la evaluacion docente; contexto de la dotacion del territorio.",
  "Verificada", HOY,
  "El reconocimiento la clasificaba como sistema con credenciales institucionales; lo observado es una pagina informativa publica, sin formulario de ingreso visible. Se corrige la via de acceso y el nivel de acceso respecto de lo que declaraba el reconocimiento. Calendario referencial: agosto y septiembre de 2026.",
  "NA"
)

catalogo <- bind_rows(catalogo, catalogo_t4)

# ==============================================================================
# TRAMO 5: resto del lote F, todo el lote G y todo el lote I.
#
# El lote I no estaba en la instruccion del tramo, que hablaba del "resto de F y
# todo G". Se incluye igual porque el criterio de aceptacion 2 del encargo exige
# que toda URL candidata del reconocimiento tenga destino, y dejar fuera el lote
# I habria cerrado el catalogo con cuatro URLs sin procesar.
#
# Hallazgo del tramo: el dominio de la Direccion de Educacion Publica migro de
# educacionpublica.gob.cl a dep.gob.cl, con redireccion 301. Afecta a las tres
# primeras filas del lote I.
# ==============================================================================

DEMRE <- "Departamento de Evaluacion, Medicion y Registro Educacional (DEMRE)"
DEP   <- "Direccion de Educacion Publica (DEP)"

catalogo_t5 <- tribble(
  ~id_fuente, ~ambito_monitoreo, ~subambito, ~dato, ~descripcion, ~variables, ~base_datos, ~emisor, ~via_de_acceso, ~nivel_acceso, ~url_referencia, ~url_descarga, ~formato, ~detalle_tecnico, ~unidad_de_analisis, ~llaves_de_union, ~desagregacion_territorial, ~cobertura_temporal, ~periodicidad, ~mes_publicacion, ~datos_personales, ~documentacion_tecnica, ~condiciones_de_uso, ~usos_en_monitoreo, ~estado_verificacion, ~fecha_verificacion, ~observaciones, ~copia_local,

  "F070", "1. Comunidades educativas", "1.4 Instrumentos de gestion educativa",
  "Evaluacion docente",
  "Bases de datos de la evaluacion docente desde el ano 2004 en adelante.",
  "NA", DA, CEM, "Portal de datos abiertos", "Abierto",
  "https://datosabiertos.mineduc.cl/evaluacion-docente/",
  "https://datosabiertos.mineduc.cl/wp-content/uploads/2026/03/Evaluacion-Docente-2024.rar",
  "rar; zip",
  "Archivos anuales .rar y .zip, 2004-2024. url_descarga apunta al ano 2024, subido en 2026/03.",
  "Docente o asistente", "NA", "Establecimiento", "2004-2024", "Anual", "NA",
  "NA", "NA", "NA",
  "Resultados de evaluacion docente por establecimiento; insumo de dotacion.",
  "Verificada", HOY,
  "La serie termina en 2024, un ano antes que las bases de estudiantes del mismo portal. No publica esquema de registros. Solicitud registrada.",
  "NA",

  "F071", "1. Comunidades educativas", "1.4 Instrumentos de gestion educativa",
  "Evaluacion de Conocimientos Especificos y Pedagogicos (ECEP)",
  "Bases de datos de la ECEP desde el ano 2016 en adelante.",
  "NA", DA, CEM, "Portal de datos abiertos", "Abierto",
  "https://datosabiertos.mineduc.cl/evaluacion-de-conocimientos-especificos-y-pedagogicos-ecep-2/",
  "https://datosabiertos.mineduc.cl/wp-content/uploads/2026/01/ECEP-2024.rar",
  "rar; zip",
  "Archivos anuales .rar y .zip, 2016-2024. url_descarga apunta al ano 2024, subido en 2026/01.",
  "Docente o asistente", "NA", "Establecimiento", "2016-2024", "Anual", "NA",
  "NA", "NA", "NA",
  "Resultados de la ECEP; contraparte de dato de la plataforma informativa F069.",
  "Verificada", HOY,
  "Es el dato que respalda a F069, que solo publica temarios y calendario. No publica esquema de registros. Solicitud registrada.",
  "NA",

  "F072", "1. Comunidades educativas", "1.4 Instrumentos de gestion educativa",
  "Cargos docentes",
  "Directorios anuales de docentes del sistema educativo, con dotacion, cargos y funciones.",
  "NA", DA, CEM, "Portal de datos abiertos", "Abierto",
  "https://datosabiertos.mineduc.cl/cargos-docentes/",
  "https://datosabiertos.mineduc.cl/wp-content/uploads/2025/08/Directorio-Docentes-2025.rar",
  "rar",
  "Archivos anuales .rar, 2003-2025. url_descarga apunta al ano 2025, subido en 2025/08.",
  "Docente o asistente", "NA", "Establecimiento", "2003-2025", "Anual", "NA",
  "NA", "NA", "NA",
  "Dotacion docente por establecimiento del territorio.",
  "Verificada", HOY,
  "La pagina se titula Cargos docentes pero el archivo se publica como Directorio-Docentes. No publica esquema de registros. Solicitud registrada.",
  "NA",

  "F073", "1. Comunidades educativas", "1.4 Instrumentos de gestion educativa",
  "Asistentes de la educacion",
  "Bases de datos de asistentes de la educacion desde el ano 2007 en adelante.",
  "NA", DA, CEM, "Portal de datos abiertos", "Abierto",
  "https://datosabiertos.mineduc.cl/asistentes-de-la-educacion/",
  "https://datosabiertos.mineduc.cl/wp-content/uploads/2025/08/Asistentes-de-la-Educacion-2025-.rar",
  "rar",
  "Archivos anuales .rar, 2007-2025. url_descarga apunta al ano 2025, subido en 2025/08. El nombre del archivo trae un guion final antes de la extension, que es parte de la URL.",
  "Docente o asistente", "NA", "Establecimiento", "2007-2025", "Anual", "NA",
  "NA", "NA", "NA",
  "Dotacion de asistentes de la educacion por establecimiento.",
  "Verificada", HOY,
  "No publica esquema de registros. Solicitud registrada.",
  "NA",

  "F074", "1. Comunidades educativas", "1.1 Trayectorias estudiantiles",
  "Portal de bases de datos del proceso de admision",
  "Bases de datos individuales del proceso de admision a la educacion superior, segun lo declara el reconocimiento.",
  "NA", "Portal Bases de Datos", DEMRE,
  "Descarga directa desde sitio institucional", "Abierto",
  "https://demre.cl/portales/portal-bases-datos", "NA", "NA", "NA",
  "Estudiante", "NA", "Establecimiento", "NA", "Sin periodicidad definida", "NA",
  "NA", "NA", "NA",
  "Resultados individuales de admision de los egresados del territorio.",
  "URL viva sin descarga confirmada", HOY,
  "El servidor entrega cabeceras HTTP malformadas (falta el retorno de carro esperado tras un valor de cabecera) y la respuesta no se puede parsear. Es una falla de protocolo del servidor, no un 403 ni un 404, y afecta a todo el dominio demre.cl: F075 falla igual. Un navegador tolerante probablemente si abra la pagina. Solicitud registrada.",
  "NA",

  "F075", "1. Comunidades educativas", "1.1 Trayectorias estudiantiles",
  "Compendios estadisticos del proceso de admision",
  "Estadisticas por proceso de admision desagregadas por subgrupos, segun lo declara el reconocimiento.",
  "NA", "Compendios Estadisticos", DEMRE, "Reporte en PDF", "Abierto",
  "https://demre.cl/estadisticas/compendios-estadisticos", "NA", "NA", "NA",
  "Nacional", "NA", "Region", "NA", "Anual", "NA",
  "Sin datos de personas", "NA", "NA",
  "Estadisticas agregadas de admision, sin procesar bases individuales.",
  "URL viva sin descarga confirmada", HOY,
  "Misma falla de protocolo que F074: cabeceras HTTP malformadas en todo el dominio demre.cl. El reconocimiento le atribuia formato xlsx, que no se pudo confirmar. Solicitud registrada.",
  "NA",

  "F076", "1. Comunidades educativas", "1.1 Trayectorias estudiantiles",
  "Resultados de admision por unidad educativa",
  "Resultados de la prueba de admision comparados por establecimiento, comuna y region, segun lo declara el reconocimiento.",
  "NA", "Consulta de resultados", DEMRE, "Consulta web sin descarga", "Abierto",
  "NA", "NA", "NA", "NA",
  "Establecimiento", "NA", "Establecimiento", "NA", "Sin periodicidad definida", "NA",
  "Sin datos de personas", "NA", "NA",
  "Comparacion de resultados de admision entre establecimientos del territorio.",
  "Declarada sin verificar", "NA",
  "El reconocimiento la registro como mencionada sin URL directa, apuntando solo a una noticia de enero de 2025. Sin URL que abrir. Es la tercera y ultima de las tres filas sin URL del reconocimiento.",
  "NA",

  "F077", "1. Comunidades educativas", "1.1 Trayectorias estudiantiles",
  "Sistema Nacional de Informacion de la Educacion Superior (SIES)",
  "Sistema de informacion de educacion superior con matricula, titulacion, retencion, empleabilidad, ingresos, personal academico e infraestructura.",
  "NA", "SIES", "Subsecretaria de Educacion Superior (Mineduc)",
  "Sistema con credenciales", "Abierto con registro",
  "https://www.mifuturo.cl/sies/", "NA", "xlsx; html",
  "Ofrece buscadores de bases, informes anuales, perfiles regionales y tableros Power BI. La descarga de busquedas exige cuenta de usuario. Los href completos no aparecen en el HTML.",
  "Nacional", "NA", "Region", "hasta 2025; compendio historico sin rango declarado",
  "Anual", "NA", "NA", "NA",
  "Exige registro para descargar; declara terminos y condiciones",
  "Continuidad de estudios de los egresados del territorio en educacion superior.",
  "Verificada", HOY,
  "El reconocimiento la clasificaba como abierta; la descarga en realidad exige registro, de modo que el nivel de acceso se corrige a Abierto con registro. Informes recientes: matricula 2025, titulacion 2024 y duracion real y en exceso 2025.",
  "NA",

  "F078", "1. Comunidades educativas", "1.1 Trayectorias estudiantiles",
  "INDICES, bases de datos de educacion superior",
  "Bases de matricula, vacantes, aranceles y oferta academica de pregrado y posgrado, segun lo declara el reconocimiento.",
  "NA", "INDICES", "Consejo Nacional de Educacion (CNED)",
  "Descarga directa desde sitio institucional", "Abierto",
  "https://www.cned.cl/bases-de-datos", "NA", "NA", "NA",
  "Nacional", "NA", "Region", "NA", "Anual", "NA",
  "Sin datos de personas",
  "El reconocimiento declara documentacion en cned.cl/estadistica/indices-bd-institucional, no verificada",
  "NA",
  "Segunda fuente de matricula de educacion superior, util para triangular con el SIES.",
  "URL viva sin descarga confirmada", HOY,
  "El servidor devuelve HTTP 403 a la herramienta de consulta. El host respondio: no es un enlace roto. Es la unica fuente del lote G con documentacion tecnica declarada por el reconocimiento. Solicitud registrada.",
  "NA",

  "F079", "1. Comunidades educativas", "1.1 Trayectorias estudiantiles",
  "Pruebas de admision a la educacion superior",
  "Bases de puntajes de candidatos, informacion de postulantes, cupos supernumerarios, cupos PACE y matriculacion.",
  "NA", DA, CEM, "Portal de datos abiertos", "Abierto",
  "https://datosabiertos.mineduc.cl/pruebas-de-admision-a-la-educacion-superior/",
  "https://datosabiertos.mineduc.cl/wp-content/uploads/2026/07/PAES-2026-Inscritos-Puntajes.rar",
  "rar; zip",
  "Archivos anuales .rar y .zip, procesos 2021-2026. url_descarga apunta al proceso 2026, subido en 2026/07: es el archivo mas reciente de todo el catalogo.",
  "Estudiante", "NA", "Establecimiento", "2021-2026", "Anual", "NA",
  "NA", "NA", "NA",
  "Puntajes y postulacion de los egresados del territorio; via publica alternativa a DEMRE.",
  "Verificada", HOY,
  "Es la via viva al mismo dato que DEMRE publica en F074, cuyo dominio no se puede consultar. No publica esquema de registros. Solicitud registrada.",
  "NA",

  "F080", "2. SLEP", "2.1 Gestion institucional del SLEP",
  "Sitio institucional de los Servicios Locales de Educacion Publica",
  "Informacion institucional sobre los Servicios Locales de Educacion Publica: estructura, funciones, financiamiento, gobernanza y su relacion con municipios y el Ministerio de Educacion.",
  "NA", "Sitio institucional", DEP, "Reporte en PDF", "Abierto",
  "https://dep.gob.cl/servicios-locales-de-educacion-publica/",
  "https://educacionpublica.gob.cl/wp-content/uploads/2022/06/ENEP-Pagina_.pdf",
  "pdf; html",
  "url_descarga apunta a la Primera Estrategia Nacional de Educacion Publica 2020-2028. Publica ademas orientaciones para la gestion de programas educativos, tambien en PDF.",
  "Sostenedor", "NA", "Nacional", "2020-2028 para la estrategia nacional",
  "Sin periodicidad definida", "NA", "Sin datos de personas", "NA", "NA",
  "Marco normativo e institucional de la Nueva Educacion Publica en que opera el SLEP.",
  "Verificada", HOY,
  "El dominio del reconocimiento (educacionpublica.gob.cl) redirige con 301 a dep.gob.cl: la Direccion de Educacion Publica migro de dominio. Se cataloga el destino. La migracion es parcial: los archivos PDF siguen sirviendose desde el dominio antiguo. El sitio declara 15 SLEP activos y no publica datos desagregados por servicio.",
  "NA",

  "F081", "2. SLEP", "2.2 Dimension educativa de instrumentos de gestion",
  "Convenios de desempeno FAEP",
  "Resoluciones exentas que aprueban los convenios de desempeno del Fondo de Apoyo a la Educacion Publica entre la Direccion de Educacion Publica y cada Servicio Local.",
  "NA", "Repositorio de resoluciones", DEP,
  "Descarga directa desde sitio institucional", "Abierto",
  "https://dep.gob.cl/servicios-locales-de-educacion-publica/",
  "https://dep.gob.cl/wp-content/uploads/2025/08/REX-N%C2%B0177-APRUEBA-CONVENIO-DE-DESEMPENO-SLEP-ATACAMA-FAEP-2025.pdf",
  "pdf",
  "El ejemplo inventariado por el reconocimiento corresponde al SLEP Atacama, ano 2025. El archivo existe y pesa 4,3 MB, pero su texto no es extraible. No hay un indice de resoluciones: cada convenio se publica como archivo suelto.",
  "Sostenedor", "NA", "Nacional", "2025", "Anual", "NA",
  "Sin datos de personas", "NA", "NA",
  "Metas comprometidas por cada Servicio Local; contraparte de la reportabilidad del Area.",
  "Verificada", HOY,
  "Verificada en el sentido de que la URL responde y el archivo existe integro; su contenido no se pudo leer. La URL del reconocimiento redirige con 301 al mismo dominio nuevo dep.gob.cl. El convenio del SLEP Costa Central no esta inventariado: habria que ubicarlo por separado.",
  "NA",

  "F082", "2. SLEP", "2.3 Indices, analisis y estudios",
  "Informe Anual del Consejo de Evaluacion del Sistema de Educacion Publica",
  "Informe anual que evalua la implementacion del sistema de educacion publica y entrega recomendaciones para su consolidacion.",
  "NA", "Consejo de Evaluacion", DEP, "Reporte en PDF", "Abierto",
  "https://dep.gob.cl/dep/informe-2025-del-consejo-de-evaluacion-releva-avances-en-la-implementacion-de-los-slep-y-entrega-recomendaciones-para-su-consolidacion/",
  "https://educacionpublica.gob.cl/wp-content/uploads/2026/03/Informe-Anual-2025-Consejo-Evaluador-del-Sistema-de-Educacion-Publica.pdf",
  "pdf",
  "Informe 2025 publicado el 4 de marzo de 2026. La pagina declara ocho informes anteriores, de 2018 a 2024. El PDF se sirve desde el dominio antiguo educacionpublica.gob.cl.",
  "Sostenedor", "NA", "Nacional", "2018-2025", "Anual", "NA",
  "Sin datos de personas", "NA", "NA",
  "Evaluacion externa de la implementacion del sistema; contexto de la gestion del SLEP.",
  "Verificada", HOY,
  "Serie anual completa de ocho informes previos mas el de 2025. La pagina declara 36 SLEP en regimen y 58 creados; esas cifras no se transcriben al catalogo por ser contenido del informe y no metadato de la fuente.",
  "NA",

  "F083", "2. SLEP", "2.1 Gestion institucional del SLEP",
  "Cuenta publica y reportabilidad local de un Servicio Local",
  "Plan Anual Local, Convenio de Gestion Educacional, metas y resultados publicados por un Servicio Local en su transparencia activa, segun lo declara el reconocimiento.",
  "NA", "Sitio institucional del Servicio Local",
  "Servicio Local de Educacion Publica (SLEP)",
  "Consulta web sin descarga", "Abierto",
  "https://slepsantiagocentro.gob.cl/", "NA", "NA", "NA",
  "Sostenedor", "NA", "Comuna", "NA", "Anual", "NA",
  "Sin datos de personas", "NA", "NA",
  "Modelo de reportabilidad local; referencia de que publica otro Servicio Local.",
  "URL viva sin descarga confirmada", HOY,
  "El servidor devuelve HTTP 403 a la herramienta de consulta. El host respondio: no es un enlace roto. El reconocimiento inventario el sitio del SLEP Santiago Centro como ejemplo de reportabilidad local; no es el sitio del SLEP Costa Central. Solicitud registrada.",
  "NA"
)

catalogo <- bind_rows(catalogo, catalogo_t5)

# ---- Enmienda E8: campo `fuente_equivalente`, aplicado retroactivamente ------
# Es el id_fuente de la fila que publica el mismo dato por otra via, y es
# bidireccional. En las 24 filas del tramo 1 el valor es "NA" en todas, y el
# motivo es verificable, no una omision: ninguna fila de este tramo republica a
# otra fila de este tramo. Las republicaciones que si existen (los 30 conjuntos
# de datos.gob.cl) no generaron fila por la regla de la enmienda E7, de modo que
# no hay id_fuente al cual apuntar. En cuanto una republicacion genere fila, el
# par se declara explicitamente en ambos extremos.
catalogo <- catalogo |> mutate(fuente_equivalente = "NA")

# Cuando una fuente tiene mas de una equivalente, van separadas por "; ", igual
# que el resto de los campos multivalor del esquema. Las cuatro filas de Casen
# publican el mismo dato por cuatro vias distintas y se apuntan entre si.
EQUIVALENCIAS <- c(
  F030 = "F031; F033; F034",   # Casen en el Observatorio Social
  F031 = "F030; F033; F034",   # Casen dentro de BIDAT
  F033 = "F030; F031; F034",   # Casen tabulada en Redatam
  F034 = "F030; F031; F033"    # Casen en Data Social (host caido)
)
catalogo$fuente_equivalente[match(names(EQUIVALENCIAS), catalogo$id_fuente)] <-
  unname(EQUIVALENCIAS)

# Comprobacion de reciprocidad: si A declara a B, B debe declarar a A.
for (id in names(EQUIVALENCIAS)) {
  destinos <- trimws(strsplit(EQUIVALENCIAS[[id]], ";")[[1]])
  for (d in destinos) {
    vuelta <- trimws(strsplit(catalogo$fuente_equivalente[catalogo$id_fuente == d], ";")[[1]])
    if (!id %in% vuelta) stop("equivalencia no reciproca: ", id, " -> ", d)
  }
}

# ==============================================================================
# LOG DE VERIFICACION: una linea por URL visitada (encargo fase 1, punto 5)
# ==============================================================================

log_verificacion <- tribble(
  ~tramo, ~lote, ~orden, ~url, ~resultado, ~filas_generadas, ~timestamp,
  1L, "A",  1L, PORTAL_DA, "Responde. Portal vivo, lista cinco secciones de conjuntos. No declara formatos, licencia ni documentacion.", 1L, HOY,
  1L, "A",  2L, "https://datosabiertos.mineduc.cl/matricula-por-estudiante-2/", "Responde. 21 archivos .rar, 2004-2025. Completada con copia local de slep_analisis_matricula.", 1L, HOY,
  1L, "A",  3L, "https://datosabiertos.mineduc.cl/matricula-educacion-parvularia/", "Responde. .rar 2011-2025 y .zip 2019. Sin esquema de registros.", 1L, HOY,
  1L, "A",  4L, "https://datosabiertos.mineduc.cl/rendimiento-por-estudiante-2/", "Responde. .rar 2002-2025. Completada con copia local de slep_rendimiento_historico.", 1L, HOY,
  1L, "A",  5L, "https://datosabiertos.mineduc.cl/alumnos-preferentes-prioritarios-y-beneficiarios-sep/", "Responde. .rar 2008-2025. Sin esquema de registros.", 1L, HOY,
  1L, "A",  6L, "https://datosabiertos.mineduc.cl/sistema-de-admision-escolar-sae/", "Responde. .rar y .zip 2016-2025. Sin esquema de registros.", 1L, HOY,
  1L, "A",  7L, "https://datosabiertos.mineduc.cl/directorio-de-establecimientos-educacionales/", "Responde. Formato mixto por rango de anos: .rar, .csv y .zip, 1992-2025.", 1L, HOY,
  1L, "A",  8L, "https://datosabiertos.mineduc.cl/subvenciones-a-establecimientos-educacionales/", "Responde. .rar y .zip 2005-2025. No declara periodicidad de publicacion.", 1L, HOY,
  1L, "A",  9L, "https://datosabiertos.mineduc.cl/matricula-longitudinal/", "Responde. .xlsx 2010-2025. Excluye parvularia de JUNJI e Integra.", 1L, HOY,
  1L, "A", 10L, "https://datosabiertos.mineduc.cl/desvinculacion/", "Responde. .xlsx unico, 2010-2024. Cobertura un ano mas corta que el resto del portal.", 1L, HOY,
  1L, "A", 11L, "https://datosabiertos.mineduc.cl/practicantes-y-titulados-tecnico-profesional/", "Responde. .rar 2013-2021 y 2023-2025, .zip 2022.", 1L, HOY,
  1L, "A", 12L, "https://datosabiertos.mineduc.cl/CEM_Interactivo", "Responde 301. Redirige a app.powerbi.com. Redireccion no seguida: destino es aplicacion JavaScript.", 1L, HOY,
  1L, "A", 13L, "http://api.datos.mineduc.cl/", "Host responde pero falla la validacion TLS: certificado de workspace.junar.com y workspace.vor-tex.io. Contenido no inspeccionable.", 1L, HOY,
  1L, "A", 14L, "https://datos.gob.cl/organization/subsecretaria_de_educacion", "Responde. 30 conjuntos. Unica fuente del tramo con licencia declarada (Creative Commons).", 1L, HOY,
  1L, "H", 15L, "https://censo2024.ine.gob.cl/resultados/", "Responde. Sintesis en PDF, consulta interactiva y Redatam Web hasta manzana. No publica las cifras que el reconocimiento le atribuia.", 1L, HOY,

  2L, "H", 16L, "https://www.ine.gob.cl/herramientas/portal-de-mapas/geodatos-abiertos", "Responde. Capas censales y de division politico administrativa en shapefile y geodatabase. Sin enlaces directos de archivo en el HTML.", 1L, HOY,
  2L, "H", 17L, "https://geoine-ine-chile.opendata.arcgis.com/datasets/54e0c40680054efaabeb9d53b09e1e7a_0", "HTTP 404. El identificador del conjunto ya no resuelve. Enlace roto.", 1L, HOY,
  2L, "H", 18L, "https://www.ine.gob.cl/estadisticas/sociales/demografia-y-vitales/proyecciones-de-poblacion", "Responde. Solo PDF observados, no xlsx como declaraba el reconocimiento. Proyecciones 1992-2050.", 1L, HOY,
  2L, "H", 19L, "https://bancodatosene.ine.cl/", "Responde. Exige registro con correo y contrasena. Unica fuente de los dos tramos con diccionario de variables publicado.", 1L, HOY,
  2L, "H", 20L, "https://datos.gob.cl/organization/instituto_nacional_de_estadisticas", "Responde. 63 conjuntos, licencia CC Non-Commercial. Ultima actualizacion observada: 2021-10-12.", 1L, HOY,
  2L, "H", 21L, "https://observatorio.ministeriodesarrollosocial.gob.cl/encuesta-casen", "Responde. Serie 1990-2024. Sin enlaces directos ni documentacion tecnica observable.", 1L, HOY,
  2L, "H", 22L, "https://bidat.gob.cl/", "Responde. Nueve colecciones. Aporta formatos que la fuente primaria no da: .dta, .rdata, .sav y shapefile.", 1L, HOY,
  2L, "H", 23L, "http://observatorio.ministeriodesarrollosocial.gob.cl/indicadores/", "HTTP 403 a la herramienta. Host vivo, contenido no inspeccionable desde esta sesion.", 1L, HOY,
  2L, "H", 24L, "https://redatam.org/redchl/mds/casen/", "Responde solo con su encabezado. Aplicacion Redatam que exige interaccion.", 1L, HOY,
  2L, "H", 25L, "https://datasocial.ministeriodesarrollosocial.gob.cl/catalogo/casen", "El dominio no resuelve en DNS. El host no existe.", 1L, HOY,
  2L, "H", 26L, "https://www.registrosocial.gob.cl/", "Responde. Consulta de cartola con autenticacion; no publica bases descargables.", 1L, HOY,
  2L, "J", 27L, "https://deis.minsal.cl/", "HTTP 403 a la herramienta. Host vivo, contenido no inspeccionable desde esta sesion.", 1L, HOY,
  2L, "J", 28L, "https://datos.gob.cl/organization/ministerio_de_salud", "Responde. 10 conjuntos, licencias CC. Actualizacion mas reciente: 2026-07-29.", 1L, HOY,
  2L, "J", 29L, "https://repositoriodeis.minsal.cl/", "HTTP 403 a la herramienta. Host vivo, contenido no inspeccionable desde esta sesion.", 1L, HOY,
  2L, "J", 30L, "https://www.senda.gob.cl/informacion-y-conocimiento/observatorio-chileno-drogas/base-de-datos/base-de-datos-estudio-nacional-de-poblacion-escolar-2023/", "HTTP 403 a la herramienta. Host vivo, contenido no inspeccionable desde esta sesion.", 1L, HOY,

  3L, "J", 31L, "https://bibliodrogas.gob.cl/observatorio/", "Bucle de redirecciones: excede diez saltos sin llegar a contenido.", 1L, HOY,
  3L, "J", 32L, "https://serviciomigraciones.cl/en/migration-studies/open-data/", "Responde. Ocho libros xlsx en cuatro pares dato mas metadatos, y un zip de refugio. Unica fuente con metadatos publicados junto al dato.", 1L, HOY,
  3L, "J", 33L, "https://serviciomigraciones.cl/en/migration-studies/demography/", "Responde. PDF por region y comuna mas zip por continente, sobre Censo 2024. Sin href absolutos en el HTML.", 1L, HOY,
  3L, "J", 34L, "https://sis.mejorninez.cl/mejor-ninez.html", "Cadena de certificados TLS no verificable: falta el intermedio. Contenido no inspeccionable.", 1L, HOY,
  3L, "J", 35L, "https://cead.spd.gov.cl/estadisticas-delictuales/", "El dominio no resuelve en DNS. Se verifico el espejo cead.minsegpublica.gob.cl, que si responde y es el que se cataloga.", 1L, HOY,
  3L, "J", 36L, "https://www.senadis.gob.cl/pag/693/2004/iii_estudio_nacional_de_la_discapacidad", "Responde. III ENDISC 2022, libro en PDF. La base de datos como tal no se observo.", 1L, HOY,
  3L, "J", 37L, "https://datos.gob.cl/organization/servicio_de_registro_civil_e_identificacion", "Responde. Solo 3 conjuntos en xls, ultima actualizacion 2015-10-30. Discrepa fuerte del reconocimiento.", 1L, HOY,
  3L, "J", 38L, "https://www.injuv.gob.cl/encuestanacionaldejuventud", "Cadena de certificados TLS no verificable: falta el intermedio, igual que en Mejor Ninez.", 1L, HOY,
  3L, "J", 39L, "https://www.mindep.cl/secciones/211", "Responde. Informe ejecutivo y presentacion en PDF, alojados en Amazon S3.", 1L, HOY,
  3L, "J", 40L, "https://observatorio.defensorianinez.cl/", "Responde. Indicadores de derechos en cuatro grupos, 2018-2025, con diagnosticos anuales.", 1L, HOY,
  3L, "B", 41L, "https://www.agenciaeducacion.cl/simce/", "Responde. La fuente mejor documentada de los tres tramos: informes tecnicos 2012-2024 y metodologia publicada.", 1L, HOY,
  3L, "B", 42L, "https://informacionestadistica.agenciaeducacion.cl", "Responde con la plantilla sin renderizar: el cuerpo llega con el marcador literal {{titulo}}. Aplicacion de pagina unica.", 1L, HOY,
  3L, "B", 43L, "https://www.agenciaeducacion.cl/visor-simce-una-nueva-mirada-a-los-datos-de-la-educacion-chilena/", "Responde. Es la noticia de lanzamiento; entrega la URL real del visor, visorsimce.agenciaeducacion.cl.", 1L, HOY,
  3L, "B", 44L, "https://resultadossimce.agenciaeducacion.cl/login", "HTTP 404 en la ruta /login. El host resuelve: la plataforma probablemente tiene otra ruta de entrada.", 1L, HOY,
  3L, "B", 45L, "mencionada sin URL directa (bases Simce a nivel de estudiante)", "Sin URL que abrir. Va al catalogo como Declarada sin verificar. F050 confirma que la via es solicitud formal.", 1L, HOY,

  4L, "D", 46L, "https://www.junaeb.cl/mapa-nutricional", "Responde. Series 2009-2025 en XLSX y PDF, intervalos comunales, y diccionario de variables publicado.", 1L, HOY,
  4L, "D", 47L, "https://bibliotecadatos.sead.junaeb.cl/", "Entrega solo el encabezado; el cuerpo no llega. No se pudo confirmar catalogo, registro ni la llave ID_JUNAEB.", 1L, HOY,
  4L, "D", 48L, "https://www.junaeb.cl/wp-content/uploads/2026/03/Mapa-Nutricional-Resultados-2025.pdf", "Responde. El archivo existe, 2,2 MB, pero es un PDF de imagen sin texto extraible.", 1L, HOY,
  4L, "C", 49L, "https://datos.gob.cl/organization/superintendencia-de-educacion", "Responde. 3 conjuntos en CSV, licencia CC-BY, los tres actualizados el 2024-07-01.", 1L, HOY,
  4L, "C", 50L, "https://datos.gob.cl/dataset/denuncias", "La ficha del conjunto devuelve la portada del portal. Poblada con lo que declara la pagina de organizacion.", 1L, HOY,
  4L, "C", 51L, "https://datos.gob.cl/dataset/solicitudes-de-mediacion", "Misma falla: la ficha devuelve la portada del portal.", 1L, HOY,
  4L, "C", 52L, "https://datos.gob.cl/dataset/procesos-administrativos-sancionatorios", "Misma falla: la ficha devuelve la portada del portal. Tercera consecutiva del mismo patron.", 1L, HOY,
  4L, "C", 53L, "mencionada sin URL directa (portal propio de la Superintendencia)", "Sin URL que abrir. La sospecha 1 del reconocimiento sigue abierta.", 1L, HOY,
  4L, "E", 54L, "https://datos.gob.cl/organization/junta_nacional_de_jardines_infantiles", "Responde. 2 conjuntos homonimos sin formato declarado, ultima actualizacion 2015-10-30.", 1L, HOY,
  4L, "E", 55L, "https://geoportal.cl/geoportal/catalog/34965/Jardines%20Infantiles%20JUNJI", "Responde. Capa de puntos con URL de descarga directa, ficha de metadatos y servicio WMS.", 1L, HOY,
  4L, "E", 56L, "https://parvularia.mineduc.cl/", "Responde. Sitio de recursos pedagogicos; estadistica marginal y sin descargas con enlace directo.", 1L, HOY,
  4L, "E", 57L, "https://datosabiertos.mineduc.cl/resumen-de-matricula-en-educacion-parvularia-por-establecimiento-educacional/", "Responde. .rar anuales 2011-2025, con enlace directo del ano 2025.", 1L, HOY,
  4L, "F", 58L, "https://cpeip.cl/evaluacion-de-la-docencia/", "Responde. Pagina descriptiva del Sistema de Reconocimiento, sin informes ni descargas.", 1L, HOY,
  4L, "F", 59L, "https://cpeip.cl/informe-nacional-del-portafolio-2022/", "Responde. El informe no vive aqui: remite a docentemas.cl, dominio fuera del inventario.", 1L, HOY,
  4L, "F", 60L, "https://www.evaluacionconocimientos.cl/", "Responde. Pagina informativa publica con temarios 2026; no es un sistema con credenciales como declaraba el reconocimiento.", 1L, HOY,

  5L, "F", 61L, "https://datosabiertos.mineduc.cl/evaluacion-docente/", "Responde. .rar y .zip 2004-2024, con enlace directo del ano 2024.", 1L, HOY,
  5L, "F", 62L, "https://datosabiertos.mineduc.cl/evaluacion-de-conocimientos-especificos-y-pedagogicos-ecep-2/", "Responde. .rar y .zip 2016-2024, con enlace directo del ano 2024.", 1L, HOY,
  5L, "F", 63L, "https://datosabiertos.mineduc.cl/cargos-docentes/", "Responde. .rar 2003-2025. La pagina se titula Cargos docentes y el archivo se publica como Directorio-Docentes.", 1L, HOY,
  5L, "F", 64L, "https://datosabiertos.mineduc.cl/asistentes-de-la-educacion/", "Responde. .rar 2007-2025, con enlace directo del ano 2025.", 1L, HOY,
  5L, "G", 65L, "https://demre.cl/portales/portal-bases-datos", "Cabeceras HTTP malformadas: la respuesta no se puede parsear. Falla de protocolo de todo el dominio demre.cl.", 1L, HOY,
  5L, "G", 66L, "https://demre.cl/estadisticas/compendios-estadisticos", "Misma falla de protocolo del dominio demre.cl.", 1L, HOY,
  5L, "G", 67L, "mencionada sin URL directa (resultados de admision por unidad educativa)", "Sin URL que abrir. Tercera y ultima de las tres filas sin URL del reconocimiento.", 1L, HOY,
  5L, "G", 68L, "https://www.mifuturo.cl/sies/", "Responde. Buscadores, informes y tableros. La descarga exige registro, contra lo que declaraba el reconocimiento.", 1L, HOY,
  5L, "G", 69L, "https://www.cned.cl/bases-de-datos", "HTTP 403 a la herramienta. Host vivo, contenido no inspeccionable desde esta sesion.", 1L, HOY,
  5L, "G", 70L, "https://datosabiertos.mineduc.cl/pruebas-de-admision-a-la-educacion-superior/", "Responde. .rar y .zip para los procesos 2021-2026. Archivo mas reciente de todo el catalogo.", 1L, HOY,
  5L, "I", 71L, "https://educacionpublica.gob.cl/servicios-locales-de-educacion-publica/", "Redirige 301 a dep.gob.cl: la Direccion de Educacion Publica migro de dominio. El destino responde.", 1L, HOY,
  5L, "I", 72L, "https://educacionpublica.gob.cl/wp-content/uploads/2025/08/REX-N%C2%B0177-APRUEBA-CONVENIO-DE-DESEMPENO-SLEP-ATACAMA-FAEP-2025.pdf", "Redirige 301 a dep.gob.cl. El archivo existe, 4,3 MB, pero su texto no es extraible.", 1L, HOY,
  5L, "I", 73L, "https://educacionpublica.gob.cl/dep/informe-2025-del-consejo-de-evaluacion-releva-avances-en-la-implementacion-de-los-slep-y-entrega-recomendaciones-para-su-consolidacion/", "Responde en dep.gob.cl. Informe 2025 mas ocho informes previos, 2018-2024.", 1L, HOY,
  5L, "I", 74L, "https://slepsantiagocentro.gob.cl/", "HTTP 403 a la herramienta. Host vivo, contenido no inspeccionable desde esta sesion.", 1L, HOY
)

# ==============================================================================
# VERIFICACION ANTES DE ESCRIBIR (generar, verificar, consumar)
# ==============================================================================

CAMPOS <- c(
  "id_fuente", "ambito_monitoreo", "subambito", "dato", "descripcion",
  "variables", "base_datos", "emisor", "via_de_acceso", "nivel_acceso",
  "url_referencia", "url_descarga", "formato", "detalle_tecnico",
  "unidad_de_analisis", "llaves_de_union", "desagregacion_territorial",
  "cobertura_temporal", "periodicidad", "mes_publicacion", "datos_personales",
  "documentacion_tecnica", "condiciones_de_uso", "usos_en_monitoreo",
  "estado_verificacion", "fecha_verificacion", "observaciones", "copia_local",
  "fuente_equivalente"
)

catalogo <- catalogo |> select(all_of(CAMPOS))

stopifnot(
  "el esquema debe tener 29 campos"           = length(CAMPOS) == 29,
  "los nombres deben coincidir y estar en orden" = identical(names(catalogo), CAMPOS),
  "ninguna celda puede quedar vacia"          = !any(is.na(catalogo) | catalogo == ""),
  "id_fuente sin duplicados"                  = !any(duplicated(catalogo$id_fuente)),
  "id_fuente con patron F###"                 = all(grepl("^F[0-9]{3}$", catalogo$id_fuente)),
  "id_fuente correlativo sin saltos"          = identical(
    catalogo$id_fuente,
    sprintf("F%03d", seq_len(nrow(catalogo)))
  )
)

cat("Filas del catalogo :", nrow(catalogo), "\n")
cat("Campos del esquema :", ncol(catalogo), "\n")
cat("URLs en el log     :", nrow(log_verificacion), "\n")

# ---- Escritura ----
write_csv(catalogo, RUTA_CSV, na = "NA")
write_csv(log_verificacion, RUTA_LOG, na = "NA")

cat("Escrito:", RUTA_CSV, "\n")
cat("Escrito:", RUTA_LOG, "\n")
