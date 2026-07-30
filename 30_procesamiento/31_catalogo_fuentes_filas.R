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

# ---- Enmienda E8: campo `fuente_equivalente`, aplicado retroactivamente ------
# Es el id_fuente de la fila que publica el mismo dato por otra via, y es
# bidireccional. En las 24 filas del tramo 1 el valor es "NA" en todas, y el
# motivo es verificable, no una omision: ninguna fila de este tramo republica a
# otra fila de este tramo. Las republicaciones que si existen (los 30 conjuntos
# de datos.gob.cl) no generaron fila por la regla de la enmienda E7, de modo que
# no hay id_fuente al cual apuntar. En cuanto una republicacion genere fila, el
# par se declara explicitamente en ambos extremos.
catalogo <- catalogo |> mutate(fuente_equivalente = "NA")

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
  1L, "H", 15L, "https://censo2024.ine.gob.cl/resultados/", "Responde. Sintesis en PDF, consulta interactiva y Redatam Web hasta manzana. No publica las cifras que el reconocimiento le atribuia.", 1L, HOY
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
