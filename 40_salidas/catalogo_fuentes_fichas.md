# Catalogo de fuentes de datos del Area de Monitoreo

- **Version:** 1.0
- **Fecha de generacion:** 2026-07-30
- **CSV de origen:** `40_salidas/catalogo_fuentes.csv`
- **Generado por:** `30_procesamiento/33_emitir_fichas_fuentes.R`

> **Archivo generado. No se edita a mano.** Toda correccion se hace sobre el
> script que declara las filas (`31_catalogo_fuentes_filas.R`), se revalida con
> `32_validar_catalogo_fuentes.R` y se vuelve a emitir. Una edicion manual de
> este archivo se pierde en la siguiente corrida.

## Estado de completitud

Que parte de este catalogo esta verificada y que parte es promesa.

| Estado de verificacion | Fuentes | Porcentaje |
|---|---|---|
| Verificada | 49 | 59.0% |
| URL viva sin descarga confirmada | 19 | 22.9% |
| Declarada sin verificar | 12 | 14.5% |
| Enlace roto | 2 | 2.4% |
| No encontrada | 1 | 1.2% |
| **Total** | **83** | **100,0%** |

| Completitud de campos clave | Fuentes | De un total de |
|---|---|---|
| Con enlace de descarga directo | 24 | 83 |
| Con nombres de variable | 7 | 83 |
| Con copia local en un proyecto hermano | 7 | 83 |
| Con documentacion tecnica identificada | 18 | 83 |

| Solicitudes pendientes al titular | Fuentes | Que se necesita |
|---|---|---|
| Bloque A | 12 | Descargar el archivo y ponerlo a disposicion |
| Bloque B | 23 | Abrir desde navegador, por 403 o falla de transporte |
| Bloque C | 3 | Acceso con credenciales institucionales |

El detalle vive en `40_salidas/solicitudes_al_titular.md`.

## Como leer este catalogo

1. La unidad de la ficha es una **fuente de datos**: un conjunto publicado por un emisor, no un portal ni un archivo suelto. Un portal con quince conjuntos produce quince fichas mas, si corresponde, la del portal mismo.
2. `NA` significa **no observado**, nunca cero ni vacio. Una ficha con seis `NA` vale mas que una completa adivinada: lo que no se abrio no se escribe.
3. `estado_verificacion` dice que tan firme es la ficha. **Verificada**: se abrio y se observo. **URL viva sin descarga confirmada**: el host respondio pero el contenido no se pudo recuperar. **Enlace roto** y **No encontrada**: la direccion ya no resuelve. **Declarada sin verificar**: existe segun el reconocimiento, nadie la abrio.
4. Los campos multivalor (`formato`, `variables`, `llaves_de_union`, `fuente_equivalente`) separan sus valores con punto y coma.
5. `copia_local` nombra la **raiz de datos** de un proyecto hermano donde el archivo ya esta descargado, no el repositorio. Cuando aparece, los campos tecnicos se leyeron de esa copia y no de la pagina web.

## Resumen

### Por emisor

| emisor | Fuentes |
|---|---|
| Centro de Estudios del Ministerio de Educacion (CEM) | 28 |
| Agencia de Calidad de la Educacion (ACE) | 6 |
| Instituto Nacional de Estadisticas (INE) | 6 |
| Ministerio de Desarrollo Social y Familia (MDSF) | 6 |
| Superintendencia de Educacion (SIE) | 5 |
| Departamento de Estadisticas e Informacion de Salud (DEIS) | 3 |
| Departamento de Evaluacion, Medicion y Registro Educacional (DEMRE) | 3 |
| Direccion de Educacion Publica (DEP) | 3 |
| Junta Nacional de Auxilio Escolar y Becas (Junaeb) | 3 |
| Centro de Perfeccionamiento, Experimentacion e Investigaciones Pedagogicas (CPEIP) | 2 |
| Junta Nacional de Jardines Infantiles (JUNJI) | 2 |
| Servicio Nacional de Migraciones (SERMIG) | 2 |
| Servicio Nacional para la Prevencion y Rehabilitacion del Consumo de Drogas y Alcohol (SENDA) | 2 |
| Consejo Nacional de Educacion (CNED) | 1 |
| Defensoria de los Derechos de la Ninez | 1 |
| Instituto Nacional de la Juventud (INJUV) | 1 |
| Ministerio del Deporte (Mindep) | 1 |
| Servicio Local de Educacion Publica (SLEP) | 1 |
| Servicio Nacional de Proteccion Especializada a la Ninez y Adolescencia (Mejor Ninez) | 1 |
| Servicio Nacional de la Discapacidad (SENADIS) | 1 |
| Servicio de Registro Civil e Identificacion (SRCeI) | 1 |
| Subsecretaria de Educacion (Mineduc) | 1 |
| Subsecretaria de Educacion Parvularia (Mineduc) | 1 |
| Subsecretaria de Educacion Superior (Mineduc) | 1 |
| Subsecretaria de Prevencion del Delito | 1 |
| **Total** | **83** |

### Por nivel de acceso

| nivel de acceso | Fuentes |
|---|---|
| Abierto | 75 |
| Abierto con registro | 5 |
| Institucional mediado | 2 |
| Restringido por solicitud | 1 |
| **Total** | **83** |

### Por subambito

| subambito | Fuentes |
|---|---|
| 1.1 Trayectorias estudiantiles | 23 |
| 3.1 Contexto socioterritorial | 19 |
| 1.2 Desarrollo social y personal | 13 |
| 1.3 Aprendizajes y resultados | 8 |
| 1.4 Instrumentos de gestion educativa | 8 |
| 2.1 Gestion institucional del SLEP | 8 |
| 2.2 Dimension educativa de instrumentos de gestion | 3 |
| 2.3 Indices, analisis y estudios | 1 |
| **Total** | **83** |

### Por estado de verificacion

| estado de verificacion | Fuentes |
|---|---|
| Verificada | 49 |
| URL viva sin descarga confirmada | 19 |
| Declarada sin verificar | 12 |
| Enlace roto | 2 |
| No encontrada | 1 |
| **Total** | **83** |

## Indice

**1.1 Trayectorias estudiantiles**

- `F001` Portal Datos Abiertos del Centro de Estudios
- `F002` Matricula por estudiante
- `F003` Matricula educacion parvularia
- `F006` Sistema de Admision Escolar (SAE)
- `F009` Matricula longitudinal
- `F010` Tasas de incidencia de desvinculacion
- `F011` Practicantes y titulados tecnico profesional
- `F012` CEM Interactivo
- `F013` Portal API de datos abiertos del Mineduc
- `F014` Organizacion Subsecretaria de Educacion en datos.gob.cl
- `F016` Asistencia declarada mensual por ano
- `F017` Asistencia anual por estudiante
- `F020` Resumen de matricula por establecimiento
- `F063` Organizacion Junta Nacional de Jardines Infantiles en datos.gob.cl
- `F064` Jardines Infantiles JUNJI georreferenciados
- `F065` Sitio institucional de la Subsecretaria de Educacion Parvularia
- `F066` Resumen de matricula en educacion parvularia por establecimiento
- `F074` Portal de bases de datos del proceso de admision
- `F075` Compendios estadisticos del proceso de admision
- `F076` Resultados de admision por unidad educativa
- `F077` Sistema Nacional de Informacion de la Educacion Superior (SIES)
- `F078` INDICES, bases de datos de educacion superior
- `F079` Pruebas de admision a la educacion superior

**1.2 Desarrollo social y personal**

- `F005` Alumnos preferentes, prioritarios y beneficiarios SEP
- `F039` Estudio Nacional de Drogas en Poblacion Escolar 2023
- `F040` Bibliodrogas, listado de estudios del Observatorio Chileno de Drogas
- `F043` Sistema de informacion estadistica de Mejor Ninez
- `F045` Tercer Estudio Nacional de la Discapacidad (III ENDISC 2022)
- `F047` Encuesta Nacional de Juventudes
- `F048` Encuesta Nacional de Habitos de Actividad Fisica y Deporte
- `F049` Observatorio de Derechos de la Ninez
- `F055` Mapa Nutricional
- `F056` Biblioteca de Datos para la Investigacion
- `F057` Informe Mapa Nutricional 2025
- `F059` Denuncias ante la Superintendencia de Educacion
- `F060` Solicitudes de mediacion ante la Superintendencia de Educacion

**1.3 Aprendizajes y resultados**

- `F004` Rendimiento academico por estudiante
- `F018` Notas y egresados de ensenanza media
- `F019` Resumen de rendimiento por establecimiento
- `F050` Resultados Simce e IDPS, seccion institucional
- `F051` Informacion estadistica por establecimiento
- `F052` Visor Simce
- `F053` Plataforma de resultados para SLEP y sostenedores
- `F054` Bases de datos Simce a nivel de estudiante

**1.4 Instrumentos de gestion educativa**

- `F024` Docentes por curso y subsector
- `F067` Sistema de Reconocimiento de la carrera docente
- `F068` Informe Nacional del Portafolio
- `F069` Plataforma de la Evaluacion de Conocimientos Especificos y Pedagogicos
- `F070` Evaluacion docente
- `F071` Evaluacion de Conocimientos Especificos y Pedagogicos (ECEP)
- `F072` Cargos docentes
- `F073` Asistentes de la educacion

**2.1 Gestion institucional del SLEP**

- `F007` Directorio de establecimientos educacionales
- `F008` Subvenciones a establecimientos educacionales
- `F023` Directorio de sostenedores
- `F058` Organizacion Superintendencia de Educacion en datos.gob.cl
- `F061` Procesos administrativos sancionatorios
- `F062` Portal de Datos Abiertos institucional de la Superintendencia
- `F080` Sitio institucional de los Servicios Locales de Educacion Publica
- `F083` Cuenta publica y reportabilidad local de un Servicio Local

**2.2 Dimension educativa de instrumentos de gestion**

- `F021` Planes de Mejoramiento Educativo (PME)
- `F022` Sistema Nacional de Evaluacion del Desempeno (SNED)
- `F081` Convenios de desempeno FAEP

**2.3 Indices, analisis y estudios**

- `F082` Informe Anual del Consejo de Evaluacion del Sistema de Educacion Publica

**3.1 Contexto socioterritorial**

- `F015` Censo de Poblacion y Vivienda 2024, resultados
- `F025` Geodatos abiertos y cartografia censal
- `F026` Microdatos del Censo 2017 a nivel de manzana
- `F027` Estimaciones y proyecciones de poblacion
- `F028` Banco de datos de la Encuesta Nacional de Empleo
- `F029` Organizacion Instituto Nacional de Estadisticas en datos.gob.cl
- `F030` Encuesta de Caracterizacion Socioeconomica Nacional (Casen)
- `F031` Banco Integrado de Datos (BIDAT)
- `F032` Indicadores territoriales del Observatorio Social
- `F033` Consulta interactiva de datos Casen (Redatam)
- `F034` Data Social, catalogo Casen
- `F035` Registro Social de Hogares
- `F036` Portal del Departamento de Estadisticas e Informacion de Salud
- `F037` Organizacion Ministerio de Salud en datos.gob.cl
- `F038` Repositorio DEIS de indicadores basicos de salud
- `F041` Datos abiertos de permisos de residencia y refugio
- `F042` Reportes demograficos de poblacion migrante
- `F044` Estadisticas delictuales por comuna
- `F046` Organizacion Servicio de Registro Civil e Identificacion en datos.gob.cl

## Fichas

### 1.1 Trayectorias estudiantiles

#### F001 <c2><b7> Portal Datos Abiertos del Centro de Estudios

- **ambito_monitoreo:** 1. Comunidades educativas
- **subambito:** 1.1 Trayectorias estudiantiles
- **descripcion:** Portal que agrupa las bases publicas del sistema escolar chileno, organizadas en cinco secciones: estudiantes, docentes y asistentes, establecimientos, sostenedores, e indicadores y encuestas.
- **variables:** NA
- **base_datos:** Datos Abiertos
- **emisor:** Centro de Estudios del Ministerio de Educacion (CEM)
- **via_de_acceso:** Portal de datos abiertos
- **nivel_acceso:** Abierto
- **url_referencia:** https://datosabiertos.mineduc.cl/
- **url_descarga:** NA
- **formato:** html
- **detalle_tecnico:** Fila de contenedor: es el portal, no un conjunto de datos. Sus conjuntos se catalogan como filas propias.
- **unidad_de_analisis:** NA
- **llaves_de_union:** NA
- **desagregacion_territorial:** Nacional
- **cobertura_temporal:** NA
- **periodicidad:** Sin periodicidad definida
- **mes_publicacion:** NA
- **datos_personales:** Sin datos de personas
- **documentacion_tecnica:** NA
- **condiciones_de_uso:** NA
- **usos_en_monitoreo:** Punto de entrada unico a las bases del sistema escolar.
- **estado_verificacion:** Verificada
- **fecha_verificacion:** 2026-07-30
- **observaciones:** La pagina no declara formatos, cobertura temporal, licencia ni documentacion. Contacto publicado: estadisticas@mineduc.cl. Lista mas conjuntos de los que registro el reconocimiento (ver filas F016-F024).
- **copia_local:** NA
- **fuente_equivalente:** NA

#### F002 <c2><b7> Matricula por estudiante

- **ambito_monitoreo:** 1. Comunidades educativas
- **subambito:** 1.1 Trayectorias estudiantiles
- **descripcion:** Matricula por estudiante del sistema escolar en establecimientos reconocidos oficialmente por el Estado, con informacion del estudiante, del establecimiento y del nivel de ensenanza.
- **variables:** AGNO; RBD; DGV_RBD; NOM_RBD; COD_REG_RBD; NOM_REG_RBD_A; COD_PRO_RBD; COD_COM_RBD; NOM_COM_RBD; COD_DEPROV_RBD; NOM_DEPROV_RBD; COD_DEPE; COD_DEPE2; RURAL_RBD; ESTADO_ESTAB; NOMBRE_SLEP; COD_ENSE; COD_ENSE2; COD_ENSE3; COD_GRADO; COD_GRADO2; LET_CUR; COD_JOR; COD_TIP_CUR; COD_DES_CUR; TIPO_AULA; MRUN; GEN_ALU; FEC_NAC_ALU; EDAD_ALU; COD_REG_ALU; COD_COM_ALU; NOM_COM_ALU; COD_SEC; COD_ESPE; COD_RAMA; COD_MEN; ENS
- **base_datos:** Datos Abiertos
- **emisor:** Centro de Estudios del Ministerio de Educacion (CEM)
- **via_de_acceso:** Portal de datos abiertos
- **nivel_acceso:** Abierto
- **url_referencia:** https://datosabiertos.mineduc.cl/matricula-por-estudiante-2/
- **url_descarga:** https://datosabiertos.mineduc.cl/wp-content/uploads/2025/10/Matricula-por-estudiante-2025.rar
- **formato:** rar
- **detalle_tecnico:** La pagina publica 21 archivos .rar, uno por ano, 2004-2025. url_descarga apunta al ano 2025. La serie NO tiene patron derivable: el nombre se mantiene (Matricula-por-estudiante-AAAA.rar) pero la carpeta de subida cambia (2025/10, 2024/11, 2023/10), de modo que cada ano exige leer su enlace en la pagina. La copia local del ano 2025 es .csv de 566 MB, separador punto y coma, cabecera en UTF-8 con marca de orden de bytes (BOM), 38 columnas.
- **unidad_de_analisis:** Estudiante
- **llaves_de_union:** MRUN; RBD; AGNO; COD_COM_RBD
- **desagregacion_territorial:** Establecimiento
- **cobertura_temporal:** 2004-2025 en el portal; 2016-2025 en la copia local, sin anos faltantes
- **periodicidad:** Anual
- **mes_publicacion:** NA
- **datos_personales:** Identificador enmascarado (MRUN)
- **documentacion_tecnica:** NA
- **condiciones_de_uso:** NA
- **usos_en_monitoreo:** Base de matricula del territorio; llave RBD para cruce con asistencia y rendimiento.
- **estado_verificacion:** Verificada
- **fecha_verificacion:** 2026-07-30
- **observaciones:** Columnas, separador, codificacion y anos efectivos leidos de la copia local (solo cabecera), no de la pagina, que no publica esquema de registros. Equivalencia de nombres (enmienda E9): la raiz de datos se llama slep_analisis_matricula y el repositorio hermano correspondiente en ~/Projects se llama slep_minuta_matricula; copia_local registra la raiz de datos, que es donde vive el archivo. Republicada en datos.gob.cl (F014) sin aporte propio: misma cobertura y misma desagregacion.
- **copia_local:** slep_analisis_matricula
- **fuente_equivalente:** NA

#### F003 <c2><b7> Matricula educacion parvularia

- **ambito_monitoreo:** 1. Comunidades educativas
- **subambito:** 1.1 Trayectorias estudiantiles
- **descripcion:** Ninos y ninas en educacion parvularia en establecimientos de JUNJI, Fundacion Integra y otros reconocidos oficialmente.
- **variables:** AGNO; MES; MRUN; GEN_ALU; FEC_NAC_ALU; ID_ESTAB; RBD; ID_ESTAB_J; ID_ESTAB_I; NOM_ESTAB; COD_MAC_ESTAB; COD_REG_ESTAB; NOM_REG_ESTAB; NOM_REG_A_ESTAB; COD_PRO_ESTAB; NOM_PRO_ESTAB; COD_COM_ESTAB; NOM_COM_ESTAB; COD_DEPROV_ESTAB; NOM_DEPROV_ESTAB; LATITUD; LONGITUD; RURAL_ESTAB; ORIGEN; DEPENDENCIA; NIVEL1; NIVEL2; TIPO_ESTAB; NOMBRE_SLEP; COD_ENSE1_M; COD_GRADO_M; LET_CUR_M; COD_TIP_CUR_M; COD_DEPE1_M; COD_ENSE2_M; ESTADO_ESTAB_M; CORR_GRU_J; COD_PROG_J; COD_NIVEL_J; COD_MODAL_J; COD_JOR_J; COD_PROG_I; COD_MODAL_I; COD_NIVEL_I; COD_GRUPO_I; COD_JOR_I; TIPO_SOSTENEDOR; FEC_ING_ESTAB; FORMAL
- **base_datos:** Datos Abiertos
- **emisor:** Centro de Estudios del Ministerio de Educacion (CEM)
- **via_de_acceso:** Portal de datos abiertos
- **nivel_acceso:** Abierto
- **url_referencia:** https://datosabiertos.mineduc.cl/matricula-educacion-parvularia/
- **url_descarga:** https://datosabiertos.mineduc.cl/wp-content/uploads/2025/12/Matricula-Parvularia-2025.rar
- **formato:** rar; zip
- **detalle_tecnico:** Archivos anuales: .rar en 2011-2025 y .zip en 2019. url_descarga apunta al ano 2025, subido en 2025/12. La carpeta de subida varia por ano, de modo que la serie exige leer cada enlace en la pagina. La copia local del ano 2025 es .csv de 151,4 MB, separador punto y coma, cabecera en UTF-8 con marca de orden de bytes (BOM), 49 columnas. Incluye latitud y longitud del establecimiento.
- **unidad_de_analisis:** Estudiante
- **llaves_de_union:** MRUN; RBD; AGNO; COD_COM_ESTAB
- **desagregacion_territorial:** Establecimiento
- **cobertura_temporal:** 2011-2025 en el portal; 2011-2025 en la copia local, serie completa
- **periodicidad:** Anual
- **mes_publicacion:** NA
- **datos_personales:** Identificador enmascarado (MRUN)
- **documentacion_tecnica:** Esquema de registros ER_Educacion_parvularia_Oficial_WEB.pdf, presente en la copia local y no publicado en la pagina
- **condiciones_de_uso:** NA
- **usos_en_monitoreo:** Matricula del nivel parvulario del territorio.
- **estado_verificacion:** Verificada
- **fecha_verificacion:** 2026-07-30
- **observaciones:** Resuelta en la segunda pasada de doble fuente: la pagina no publica esquema de registros, pero la copia local si lo trae como PDF junto al dato. Columnas, separador, codificacion y anos efectivos leidos de la copia local (solo cabecera).
- **copia_local:** slep_estudio_oferta_demanda
- **fuente_equivalente:** NA

#### F006 <c2><b7> Sistema de Admision Escolar (SAE)

- **ambito_monitoreo:** 1. Comunidades educativas
- **subambito:** 1.1 Trayectorias estudiantiles
- **descripcion:** Procesos de admision de estudiantes que asisten a establecimientos subvencionados o que reciben aportes del Estado.
- **variables:** mrun; cod_nivel; es_mujer; prioritario; alto_rendimiento; lat_con_error; lon_con_error; calidad_georef
- **base_datos:** Datos Abiertos
- **emisor:** Centro de Estudios del Ministerio de Educacion (CEM)
- **via_de_acceso:** Portal de datos abiertos
- **nivel_acceso:** Abierto
- **url_referencia:** https://datosabiertos.mineduc.cl/sistema-de-admision-escolar-sae/
- **url_descarga:** https://datosabiertos.mineduc.cl/wp-content/uploads/2026/03/SAE_2025.rar
- **formato:** rar; zip
- **detalle_tecnico:** Archivos comprimidos anuales, .rar y .zip, 2016-2025. url_descarga apunta al ano 2025, subido en 2026/03. Cada ano trae varios archivos por etapa (oferta, postulantes, postulaciones, resultados, relaciones entre postulantes). Las columnas declaradas corresponden al archivo B1 de postulantes de etapa regular del proceso 2025, .csv de 19 MB, separador punto y coma, UTF-8, 8 columnas. La georreferenciacion del postulante viene con error deliberado (lat_con_error, lon_con_error).
- **unidad_de_analisis:** Estudiante
- **llaves_de_union:** mrun; cod_nivel
- **desagregacion_territorial:** Establecimiento
- **cobertura_temporal:** 2016-2025 en el portal; 2016-2025 en la copia local, serie completa
- **periodicidad:** Anual
- **mes_publicacion:** NA
- **datos_personales:** Identificador enmascarado (MRUN)
- **documentacion_tecnica:** Esquema de registros ER_Admision_A1 y variantes por ano, presentes en la copia local
- **condiciones_de_uso:** NA
- **usos_en_monitoreo:** Postulaciones y resultados de admision; insumo de demanda por establecimiento.
- **estado_verificacion:** Verificada
- **fecha_verificacion:** 2026-07-30
- **observaciones:** Resuelta en la segunda pasada de doble fuente. El conjunto no es un archivo unico por ano sino una familia de archivos por etapa; las columnas declaradas son las de uno solo, y los demas archivos tienen esquemas propios que no se transcriben aqui.
- **copia_local:** slep_estudio_oferta_demanda
- **fuente_equivalente:** NA

#### F009 <c2><b7> Matricula longitudinal

- **ambito_monitoreo:** 1. Comunidades educativas
- **subambito:** 1.1 Trayectorias estudiantiles
- **descripcion:** Serie de matricula escolar de todos los niveles, desglosada por dependencia, zona, genero, region, provincia, comuna y establecimiento.
- **variables:** NA
- **base_datos:** Datos Abiertos
- **emisor:** Centro de Estudios del Ministerio de Educacion (CEM)
- **via_de_acceso:** Portal de datos abiertos
- **nivel_acceso:** Abierto
- **url_referencia:** https://datosabiertos.mineduc.cl/matricula-longitudinal/
- **url_descarga:** https://datosabiertos.mineduc.cl/wp-content/uploads/2025/10/excel-matricula-longuitudinal-2010-2025_no_modificable.xlsx
- **formato:** xlsx
- **detalle_tecnico:** Un libro Excel unico con la serie completa; no hay serie de archivos y por tanto no hay patron que declarar. Excluye la educacion parvularia de JUNJI e Integra. El nombre publicado trae una errata del emisor (longuitudinal) que se conserva literal porque es parte de la URL.
- **unidad_de_analisis:** Establecimiento
- **llaves_de_union:** NA
- **desagregacion_territorial:** Establecimiento
- **cobertura_temporal:** 2010-2025
- **periodicidad:** Anual
- **mes_publicacion:** NA
- **datos_personales:** Sin datos de personas
- **documentacion_tecnica:** NA
- **condiciones_de_uso:** NA
- **usos_en_monitoreo:** Serie agregada de matricula para tendencias territoriales.
- **estado_verificacion:** Verificada
- **fecha_verificacion:** 2026-07-30
- **observaciones:** La pagina describe las dimensiones de desglose pero no lista nombres de columna. Sin copia local. Solicitud registrada.
- **copia_local:** NA
- **fuente_equivalente:** NA

#### F010 <c2><b7> Tasas de incidencia de desvinculacion

- **ambito_monitoreo:** 1. Comunidades educativas
- **subambito:** 1.1 Trayectorias estudiantiles
- **descripcion:** Tasas de incidencia de desvinculacion de ninos, ninas y jovenes de educacion basica y media, por region, provincia, comuna, genero y grado.
- **variables:** NA
- **base_datos:** Datos Abiertos
- **emisor:** Centro de Estudios del Ministerio de Educacion (CEM)
- **via_de_acceso:** Portal de datos abiertos
- **nivel_acceso:** Abierto
- **url_referencia:** https://datosabiertos.mineduc.cl/desvinculacion/
- **url_descarga:** https://datosabiertos.mineduc.cl/wp-content/uploads/2025/10/OFICIAL-Tasa-Incidencia-Desvinculacion-2010-2024.xlsx
- **formato:** xlsx
- **detalle_tecnico:** Un libro Excel unico con la serie 2010-2024; no hay serie de archivos y por tanto no hay patron que declarar.
- **unidad_de_analisis:** Establecimiento
- **llaves_de_union:** NA
- **desagregacion_territorial:** Comuna
- **cobertura_temporal:** 2010-2024
- **periodicidad:** Anual
- **mes_publicacion:** NA
- **datos_personales:** Sin datos de personas
- **documentacion_tecnica:** NA
- **condiciones_de_uso:** NA
- **usos_en_monitoreo:** Indicador de abandono escolar; insumo directo del modelo de desvinculacion del Area.
- **estado_verificacion:** Verificada
- **fecha_verificacion:** 2026-07-30
- **observaciones:** Cobertura termina en 2024, un ano antes que el resto de las bases del portal. La pagina no lista nombres de columna. Sin copia local. Solicitud registrada.
- **copia_local:** NA
- **fuente_equivalente:** NA

#### F011 <c2><b7> Practicantes y titulados tecnico profesional

- **ambito_monitoreo:** 1. Comunidades educativas
- **subambito:** 1.1 Trayectorias estudiantiles
- **descripcion:** Bases de alumnos practicantes y titulados de educacion media tecnico profesional desde 2013 en adelante.
- **variables:** NA
- **base_datos:** Datos Abiertos
- **emisor:** Centro de Estudios del Ministerio de Educacion (CEM)
- **via_de_acceso:** Portal de datos abiertos
- **nivel_acceso:** Abierto
- **url_referencia:** https://datosabiertos.mineduc.cl/practicantes-y-titulados-tecnico-profesional/
- **url_descarga:** https://datosabiertos.mineduc.cl/wp-content/uploads/2026/06/Practicantes-y-Titulados-TP-2025.rar
- **formato:** rar; zip
- **detalle_tecnico:** Archivos anuales: .rar en 2013-2021 y 2023-2025; .zip en 2022. url_descarga apunta al ano 2025, subido en 2026/06. La carpeta de subida varia por ano, de modo que la serie exige leer cada enlace en la pagina.
- **unidad_de_analisis:** NA
- **llaves_de_union:** NA
- **desagregacion_territorial:** Establecimiento
- **cobertura_temporal:** 2013-2025
- **periodicidad:** Anual
- **mes_publicacion:** NA
- **datos_personales:** NA
- **documentacion_tecnica:** NA
- **condiciones_de_uso:** NA
- **usos_en_monitoreo:** Titulacion y practica de la modalidad tecnico profesional; cierre de trayectoria.
- **estado_verificacion:** Verificada
- **fecha_verificacion:** 2026-07-30
- **observaciones:** La pagina no publica esquema de registros ni diccionario. Sin copia local. Solicitud registrada.
- **copia_local:** NA
- **fuente_equivalente:** NA

#### F012 <c2><b7> CEM Interactivo

- **ambito_monitoreo:** 1. Comunidades educativas
- **subambito:** 1.1 Trayectorias estudiantiles
- **descripcion:** Visualizador de tableros del Centro de Estudios sobre establecimientos, asistencia anual, asistencia mensual, cargos docentes y matricula oficial.
- **variables:** NA
- **base_datos:** Datos Abiertos
- **emisor:** Centro de Estudios del Ministerio de Educacion (CEM)
- **via_de_acceso:** Consulta web sin descarga
- **nivel_acceso:** Abierto
- **url_referencia:** https://datosabiertos.mineduc.cl/CEM_Interactivo
- **url_descarga:** NA
- **formato:** sin descarga
- **detalle_tecnico:** La URL responde 301 y redirige a un tablero embebido de Power BI en app.powerbi.com. No expone archivos.
- **unidad_de_analisis:** NA
- **llaves_de_union:** NA
- **desagregacion_territorial:** Nacional
- **cobertura_temporal:** 2024-2025
- **periodicidad:** Sin periodicidad definida
- **mes_publicacion:** NA
- **datos_personales:** Sin datos de personas
- **documentacion_tecnica:** NA
- **condiciones_de_uso:** NA
- **usos_en_monitoreo:** Consulta rapida de matricula y asistencia sin descargar bases.
- **estado_verificacion:** URL viva sin descarga confirmada
- **fecha_verificacion:** 2026-07-30
- **observaciones:** No se siguio la redireccion: el destino es una aplicacion JavaScript de Power BI que no rinde como HTML plano. La observacion del 301 y del host de destino basta para clasificar la via de acceso.
- **copia_local:** NA
- **fuente_equivalente:** NA

#### F013 <c2><b7> Portal API de datos abiertos del Mineduc

- **ambito_monitoreo:** 1. Comunidades educativas
- **subambito:** 1.1 Trayectorias estudiantiles
- **descripcion:** Acceso programatico a bases de datos educativas mediante clave de autenticacion, segun lo declara el reconocimiento.
- **variables:** NA
- **base_datos:** Portal API
- **emisor:** Centro de Estudios del Ministerio de Educacion (CEM)
- **via_de_acceso:** API
- **nivel_acceso:** Abierto con registro
- **url_referencia:** http://api.datos.mineduc.cl/
- **url_descarga:** NA
- **formato:** api
- **detalle_tecnico:** NA
- **unidad_de_analisis:** NA
- **llaves_de_union:** NA
- **desagregacion_territorial:** Nacional
- **cobertura_temporal:** NA
- **periodicidad:** Sin periodicidad definida
- **mes_publicacion:** NA
- **datos_personales:** NA
- **documentacion_tecnica:** NA
- **condiciones_de_uso:** NA
- **usos_en_monitoreo:** Automatizacion de descargas si el servicio esta operativo.
- **estado_verificacion:** URL viva sin descarga confirmada
- **fecha_verificacion:** 2026-07-30
- **observaciones:** El host responde pero la validacion TLS falla: el certificado presentado cubre workspace.junar.com y workspace.vor-tex.io, no api.datos.mineduc.cl. El dominio parece delegado a la plataforma Junar. El reconocimiento la registro como http; sobre https no es inspeccionable desde esta sesion. Contenido no verificado.
- **copia_local:** NA
- **fuente_equivalente:** NA

#### F014 <c2><b7> Organizacion Subsecretaria de Educacion en datos.gob.cl

- **ambito_monitoreo:** 1. Comunidades educativas
- **subambito:** 1.1 Trayectorias estudiantiles
- **descripcion:** Organizacion del portal nacional de datos abiertos que republica conjuntos del sistema escolar: matricula parvularia, dotacion docente, asistencia declarada, asistentes de la educacion y otros.
- **variables:** NA
- **base_datos:** datos.gob.cl
- **emisor:** Subsecretaria de Educacion (Mineduc)
- **via_de_acceso:** Portal de datos abiertos
- **nivel_acceso:** Abierto
- **url_referencia:** https://datos.gob.cl/organization/subsecretaria_de_educacion
- **url_descarga:** NA
- **formato:** csv; xlsx; html
- **detalle_tecnico:** Publica 30 conjuntos de datos. Formatos declarados por el portal: CSV, XLS, XLSX, URL y Power BI.
- **unidad_de_analisis:** NA
- **llaves_de_union:** NA
- **desagregacion_territorial:** Nacional
- **cobertura_temporal:** NA
- **periodicidad:** Sin periodicidad definida
- **mes_publicacion:** NA
- **datos_personales:** NA
- **documentacion_tecnica:** NA
- **condiciones_de_uso:** Creative Commons: Non-Commercial en 15 conjuntos, Attribution en 14, CCZero en 1
- **usos_en_monitoreo:** Segunda via de acceso a bases del CEM, con licencia declarada donde el portal propio no la declara.
- **estado_verificacion:** Verificada
- **fecha_verificacion:** 2026-07-30
- **observaciones:** Unica fuente del tramo que declara licencia explicita. Fecha de ultima actualizacion visible solo en el primer conjunto (2026-07-27). Sus 30 conjuntos NO se catalogan como filas propias, por la regla de la enmienda E7: una republicacion genera fila solo si aporta licencia, formato, cobertura o desagregacion que la fuente primaria no da. De los 30 solo se observaron 12 nombres en la pagina de la organizacion, y ninguno de esos 12 declara a nivel de conjunto un aporte verificable frente a su fuente primaria en el portal del CEM; la unica diferencia observada es agregada (la licencia Creative Commons se declara a nivel de organizacion, no por conjunto). Evaluar los 30 uno a uno exige abrir 30 paginas de conjunto y es una pasada propia, no parte de este tramo.
- **copia_local:** NA
- **fuente_equivalente:** NA

#### F016 <c2><b7> Asistencia declarada mensual por ano

- **ambito_monitoreo:** 1. Comunidades educativas
- **subambito:** 1.1 Trayectorias estudiantiles
- **descripcion:** NA
- **variables:** NA
- **base_datos:** Datos Abiertos
- **emisor:** Centro de Estudios del Ministerio de Educacion (CEM)
- **via_de_acceso:** Portal de datos abiertos
- **nivel_acceso:** Abierto
- **url_referencia:** https://datosabiertos.mineduc.cl/
- **url_descarga:** NA
- **formato:** NA
- **detalle_tecnico:** NA
- **unidad_de_analisis:** NA
- **llaves_de_union:** NA
- **desagregacion_territorial:** NA
- **cobertura_temporal:** NA
- **periodicidad:** NA
- **mes_publicacion:** NA
- **datos_personales:** NA
- **documentacion_tecnica:** NA
- **condiciones_de_uso:** NA
- **usos_en_monitoreo:** Asistencia mensual, insumo central de la minuta de asistencia del Area.
- **estado_verificacion:** Declarada sin verificar
- **fecha_verificacion:** NA
- **observaciones:** Listada en la seccion Estudiantes del portal y ausente del reconocimiento. Pendiente de verificacion en una pasada posterior.
- **copia_local:** NA
- **fuente_equivalente:** NA

#### F017 <c2><b7> Asistencia anual por estudiante

- **ambito_monitoreo:** 1. Comunidades educativas
- **subambito:** 1.1 Trayectorias estudiantiles
- **descripcion:** NA
- **variables:** NA
- **base_datos:** Datos Abiertos
- **emisor:** Centro de Estudios del Ministerio de Educacion (CEM)
- **via_de_acceso:** Portal de datos abiertos
- **nivel_acceso:** Abierto
- **url_referencia:** https://datosabiertos.mineduc.cl/
- **url_descarga:** NA
- **formato:** NA
- **detalle_tecnico:** NA
- **unidad_de_analisis:** NA
- **llaves_de_union:** NA
- **desagregacion_territorial:** NA
- **cobertura_temporal:** NA
- **periodicidad:** NA
- **mes_publicacion:** NA
- **datos_personales:** NA
- **documentacion_tecnica:** NA
- **condiciones_de_uso:** NA
- **usos_en_monitoreo:** Asistencia individual anual; llave de trayectoria junto a matricula y rendimiento.
- **estado_verificacion:** Declarada sin verificar
- **fecha_verificacion:** NA
- **observaciones:** Listada en la seccion Estudiantes del portal y ausente del reconocimiento. Pendiente de verificacion en una pasada posterior.
- **copia_local:** NA
- **fuente_equivalente:** NA

#### F020 <c2><b7> Resumen de matricula por establecimiento

- **ambito_monitoreo:** 1. Comunidades educativas
- **subambito:** 1.1 Trayectorias estudiantiles
- **descripcion:** NA
- **variables:** NA
- **base_datos:** Datos Abiertos
- **emisor:** Centro de Estudios del Ministerio de Educacion (CEM)
- **via_de_acceso:** Portal de datos abiertos
- **nivel_acceso:** Abierto
- **url_referencia:** https://datosabiertos.mineduc.cl/
- **url_descarga:** NA
- **formato:** NA
- **detalle_tecnico:** NA
- **unidad_de_analisis:** NA
- **llaves_de_union:** NA
- **desagregacion_territorial:** NA
- **cobertura_temporal:** NA
- **periodicidad:** NA
- **mes_publicacion:** NA
- **datos_personales:** NA
- **documentacion_tecnica:** NA
- **condiciones_de_uso:** NA
- **usos_en_monitoreo:** Version agregada de la matricula por establecimiento.
- **estado_verificacion:** Declarada sin verificar
- **fecha_verificacion:** NA
- **observaciones:** Listada en la seccion Establecimientos del portal y ausente del reconocimiento. Pendiente de verificacion en una pasada posterior.
- **copia_local:** NA
- **fuente_equivalente:** NA

#### F063 <c2><b7> Organizacion Junta Nacional de Jardines Infantiles en datos.gob.cl

- **ambito_monitoreo:** 1. Comunidades educativas
- **subambito:** 1.1 Trayectorias estudiantiles
- **descripcion:** Organizacion del portal nacional de datos abiertos con dos conjuntos homonimos de jardines infantiles JUNJI.
- **variables:** NA
- **base_datos:** datos.gob.cl
- **emisor:** Junta Nacional de Jardines Infantiles (JUNJI)
- **via_de_acceso:** Portal de datos abiertos
- **nivel_acceso:** Abierto
- **url_referencia:** https://datos.gob.cl/organization/junta_nacional_de_jardines_infantiles
- **url_descarga:** NA
- **formato:** html
- **detalle_tecnico:** Publica 2 conjuntos, ambos titulados Jardines Infantiles JUNJI, distinguibles solo por su identificador (27818 y 28271). El portal declara que no hay formatos que coincidan con la busqueda.
- **unidad_de_analisis:** Jardin infantil
- **llaves_de_union:** NA
- **desagregacion_territorial:** Nacional
- **cobertura_temporal:** NA
- **periodicidad:** Sin periodicidad definida
- **mes_publicacion:** NA
- **datos_personales:** Sin datos de personas
- **documentacion_tecnica:** NA
- **condiciones_de_uso:** Creative Commons Non-Commercial en los 2 conjuntos
- **usos_en_monitoreo:** Universo de jardines infantiles del territorio.
- **estado_verificacion:** Verificada
- **fecha_verificacion:** 2026-07-30
- **observaciones:** Dos conjuntos con nombre identico y sin formato declarado, ambos actualizados por ultima vez el 2015-10-30, mismo dia que la organizacion del Registro Civil (F046). El Geoportal (F064) es una via mucho mas util al mismo universo.
- **copia_local:** NA
- **fuente_equivalente:** NA

#### F064 <c2><b7> Jardines Infantiles JUNJI georreferenciados

- **ambito_monitoreo:** 1. Comunidades educativas
- **subambito:** 1.1 Trayectorias estudiantiles
- **descripcion:** Capa de puntos con la ubicacion de las unidades educativas de JUNJI en operacion a abril de 2024, por region y comuna, con direccion y capacidad de atencion.
- **variables:** NA
- **base_datos:** Geoportal de Chile
- **emisor:** Junta Nacional de Jardines Infantiles (JUNJI)
- **via_de_acceso:** Descarga directa desde sitio institucional
- **nivel_acceso:** Abierto
- **url_referencia:** https://geoportal.cl/geoportal/catalog/34965/Jardines%20Infantiles%20JUNJI
- **url_descarga:** https://geoportal.cl/geoportal/catalog/download/1248e5ef-e1ea-3a68-ac3c-199239cc68a7
- **formato:** shapefile
- **detalle_tecnico:** Capa geoespacial de puntos con cobertura nacional. Extension declarada: oeste -76,5484; este -62,1956; sur -56,6513; norte -16,2247. Ofrece ademas servicio WMS.
- **unidad_de_analisis:** Jardin infantil
- **llaves_de_union:** NA
- **desagregacion_territorial:** Comuna
- **cobertura_temporal:** 2024
- **periodicidad:** Por evento
- **mes_publicacion:** NA
- **datos_personales:** Sin datos de personas
- **documentacion_tecnica:** Ficha de metadatos con organizacion responsable, contacto, direccion y servicio WMS
- **condiciones_de_uso:** No declara licencia explicita; solo pide citar a la institucion proveedora
- **usos_en_monitoreo:** Georreferenciacion de la oferta de educacion parvularia del territorio.
- **estado_verificacion:** Verificada
- **fecha_verificacion:** 2026-07-30
- **observaciones:** Publicada el 19 de junio de 2024 con datos a abril de 2024. Es la fuente georreferenciada mas concreta del catalogo: trae URL de descarga directa y ficha de metadatos, a diferencia de los dos conjuntos homonimos de F063.
- **copia_local:** NA
- **fuente_equivalente:** NA

#### F065 <c2><b7> Sitio institucional de la Subsecretaria de Educacion Parvularia

- **ambito_monitoreo:** 1. Comunidades educativas
- **subambito:** 1.1 Trayectorias estudiantiles
- **descripcion:** Plataforma de recursos y orientaciones para educacion inicial de 0 a 6 anos: marcos curriculares, estandares pedagogicos, material didactico y analisis de matricula.
- **variables:** NA
- **base_datos:** Sitio institucional
- **emisor:** Subsecretaria de Educacion Parvularia (Mineduc)
- **via_de_acceso:** Reporte en PDF
- **nivel_acceso:** Abierto
- **url_referencia:** https://parvularia.mineduc.cl/
- **url_descarga:** NA
- **formato:** html
- **detalle_tecnico:** No expone descargas con enlace directo ni declara formatos. Remite a un analisis de matricula 2025 y a resultados del estudio TALIS 2024.
- **unidad_de_analisis:** NA
- **llaves_de_union:** NA
- **desagregacion_territorial:** NA
- **cobertura_temporal:** NA
- **periodicidad:** Sin periodicidad definida
- **mes_publicacion:** NA
- **datos_personales:** Sin datos de personas
- **documentacion_tecnica:** NA
- **condiciones_de_uso:** No declara licencia
- **usos_en_monitoreo:** Marco normativo y curricular del nivel parvulario; contexto de los reportes del Area.
- **estado_verificacion:** Verificada
- **fecha_verificacion:** 2026-07-30
- **observaciones:** El reconocimiento le atribuia informes de caracterizacion, matricula y personal en PDF. Lo observado es un sitio de recursos pedagogicos con estadistica marginal: su aporte al catalogo de fuentes es bajo. La matricula parvularia real vive en F003 y F066.
- **copia_local:** NA
- **fuente_equivalente:** NA

#### F066 <c2><b7> Resumen de matricula en educacion parvularia por establecimiento

- **ambito_monitoreo:** 1. Comunidades educativas
- **subambito:** 1.1 Trayectorias estudiantiles
- **descripcion:** Matricula de educacion parvularia agregada por establecimiento educacional.
- **variables:** NA
- **base_datos:** Datos Abiertos
- **emisor:** Centro de Estudios del Ministerio de Educacion (CEM)
- **via_de_acceso:** Portal de datos abiertos
- **nivel_acceso:** Abierto
- **url_referencia:** https://datosabiertos.mineduc.cl/resumen-de-matricula-en-educacion-parvularia-por-establecimiento-educacional/
- **url_descarga:** https://datosabiertos.mineduc.cl/wp-content/uploads/2026/02/Resumen-Educacion-Parvularia-2025.rar
- **formato:** rar
- **detalle_tecnico:** Archivos anuales .rar, 2011-2025. url_descarga apunta al ano 2025, subido en 2026/02. La carpeta de subida varia por ano, de modo que la serie exige leer cada enlace en la pagina.
- **unidad_de_analisis:** Establecimiento
- **llaves_de_union:** NA
- **desagregacion_territorial:** Establecimiento
- **cobertura_temporal:** 2011-2025
- **periodicidad:** Anual
- **mes_publicacion:** NA
- **datos_personales:** Sin datos de personas
- **documentacion_tecnica:** NA
- **condiciones_de_uso:** NA
- **usos_en_monitoreo:** Version agregada por establecimiento de la matricula parvularia; complementa el dato individual de F003.
- **estado_verificacion:** Verificada
- **fecha_verificacion:** 2026-07-30
- **observaciones:** La pagina no publica esquema de registros ni descripcion propia. Es la contraparte agregada de F003, que entrega la matricula parvularia por estudiante. Solicitud registrada.
- **copia_local:** NA
- **fuente_equivalente:** NA

#### F074 <c2><b7> Portal de bases de datos del proceso de admision

- **ambito_monitoreo:** 1. Comunidades educativas
- **subambito:** 1.1 Trayectorias estudiantiles
- **descripcion:** Bases de datos individuales del proceso de admision a la educacion superior, segun lo declara el reconocimiento.
- **variables:** ID; ANYO_PROCESO; COD_CARRERA; COD_UNIVERSIDAD; bloques EXPERIENCIAPREVIA1 a EXPERIENCIAPREVIA5_9; PRIMERA_GENERACION_1; PRIMERA_GENERACION_2; bloques CCEA3_ a CCEA12_
- **base_datos:** Portal Bases de Datos
- **emisor:** Departamento de Evaluacion, Medicion y Registro Educacional (DEMRE)
- **via_de_acceso:** Descarga directa desde sitio institucional
- **nivel_acceso:** Abierto
- **url_referencia:** https://demre.cl/portales/portal-bases-datos
- **url_descarga:** NA
- **formato:** csv
- **detalle_tecnico:** La copia local del proceso 2024 es .csv de 23,7 MB, separador punto y coma, UTF-8, 56 columnas. Las columnas declaradas corresponden al archivo de cuestionario de caracterizacion; el conjunto se reparte en varios archivos por etapa (inscripcion, rendicion y resultados, postulacion y seleccion, cuestionarios), cada uno con su propio esquema. Los bloques repetidos se abrevian por rango.
- **unidad_de_analisis:** Estudiante
- **llaves_de_union:** ID; ANYO_PROCESO
- **desagregacion_territorial:** Establecimiento
- **cobertura_temporal:** 2023-2026 en la copia local; el rango del portal no se pudo observar
- **periodicidad:** Anual
- **mes_publicacion:** NA
- **datos_personales:** Identificador enmascarado (MRUN)
- **documentacion_tecnica:** Guia de uso de datos abiertos del DEMRE, guia_uso_datos_abiertos_demre.pdf, presente en la copia local
- **condiciones_de_uso:** NA
- **usos_en_monitoreo:** Resultados individuales de admision de los egresados del territorio.
- **estado_verificacion:** URL viva sin descarga confirmada
- **fecha_verificacion:** 2026-07-30
- **observaciones:** El servidor entrega cabeceras HTTP malformadas (falta el retorno de carro esperado tras un valor de cabecera) y la respuesta no se puede parsear. Es una falla de protocolo del servidor, no un 403 ni un 404, y afecta a todo el dominio demre.cl: F075 falla igual. El estado se mantiene porque describe la verificacion de la URL, que no se pudo hacer; el CONTENIDO si quedo verificado por copia local en la segunda pasada de doble fuente, que ademas aporto la guia de uso del emisor.
- **copia_local:** slep_paes
- **fuente_equivalente:** NA

#### F075 <c2><b7> Compendios estadisticos del proceso de admision

- **ambito_monitoreo:** 1. Comunidades educativas
- **subambito:** 1.1 Trayectorias estudiantiles
- **descripcion:** Estadisticas por proceso de admision desagregadas por subgrupos, segun lo declara el reconocimiento.
- **variables:** NA
- **base_datos:** Compendios Estadisticos
- **emisor:** Departamento de Evaluacion, Medicion y Registro Educacional (DEMRE)
- **via_de_acceso:** Reporte en PDF
- **nivel_acceso:** Abierto
- **url_referencia:** https://demre.cl/estadisticas/compendios-estadisticos
- **url_descarga:** NA
- **formato:** NA
- **detalle_tecnico:** NA
- **unidad_de_analisis:** Nacional
- **llaves_de_union:** NA
- **desagregacion_territorial:** Region
- **cobertura_temporal:** NA
- **periodicidad:** Anual
- **mes_publicacion:** NA
- **datos_personales:** Sin datos de personas
- **documentacion_tecnica:** NA
- **condiciones_de_uso:** NA
- **usos_en_monitoreo:** Estadisticas agregadas de admision, sin procesar bases individuales.
- **estado_verificacion:** URL viva sin descarga confirmada
- **fecha_verificacion:** 2026-07-30
- **observaciones:** Misma falla de protocolo que F074: cabeceras HTTP malformadas en todo el dominio demre.cl. El reconocimiento le atribuia formato xlsx, que no se pudo confirmar. Solicitud registrada.
- **copia_local:** NA
- **fuente_equivalente:** NA

#### F076 <c2><b7> Resultados de admision por unidad educativa

- **ambito_monitoreo:** 1. Comunidades educativas
- **subambito:** 1.1 Trayectorias estudiantiles
- **descripcion:** Resultados de la prueba de admision comparados por establecimiento, comuna y region, segun lo declara el reconocimiento.
- **variables:** NA
- **base_datos:** Consulta de resultados
- **emisor:** Departamento de Evaluacion, Medicion y Registro Educacional (DEMRE)
- **via_de_acceso:** Consulta web sin descarga
- **nivel_acceso:** Abierto
- **url_referencia:** NA
- **url_descarga:** NA
- **formato:** NA
- **detalle_tecnico:** NA
- **unidad_de_analisis:** Establecimiento
- **llaves_de_union:** NA
- **desagregacion_territorial:** Establecimiento
- **cobertura_temporal:** NA
- **periodicidad:** Sin periodicidad definida
- **mes_publicacion:** NA
- **datos_personales:** Sin datos de personas
- **documentacion_tecnica:** NA
- **condiciones_de_uso:** NA
- **usos_en_monitoreo:** Comparacion de resultados de admision entre establecimientos del territorio.
- **estado_verificacion:** Declarada sin verificar
- **fecha_verificacion:** NA
- **observaciones:** El reconocimiento la registro como mencionada sin URL directa, apuntando solo a una noticia de enero de 2025. Sin URL que abrir. Es la tercera y ultima de las tres filas sin URL del reconocimiento.
- **copia_local:** NA
- **fuente_equivalente:** NA

#### F077 <c2><b7> Sistema Nacional de Informacion de la Educacion Superior (SIES)

- **ambito_monitoreo:** 1. Comunidades educativas
- **subambito:** 1.1 Trayectorias estudiantiles
- **descripcion:** Sistema de informacion de educacion superior con matricula, titulacion, retencion, empleabilidad, ingresos, personal academico e infraestructura.
- **variables:** NA
- **base_datos:** SIES
- **emisor:** Subsecretaria de Educacion Superior (Mineduc)
- **via_de_acceso:** Sistema con credenciales
- **nivel_acceso:** Abierto con registro
- **url_referencia:** https://www.mifuturo.cl/sies/
- **url_descarga:** NA
- **formato:** xlsx; html
- **detalle_tecnico:** Ofrece buscadores de bases, informes anuales, perfiles regionales y tableros Power BI. La descarga de busquedas exige cuenta de usuario. Los href completos no aparecen en el HTML.
- **unidad_de_analisis:** Nacional
- **llaves_de_union:** NA
- **desagregacion_territorial:** Region
- **cobertura_temporal:** hasta 2025; compendio historico sin rango declarado
- **periodicidad:** Anual
- **mes_publicacion:** NA
- **datos_personales:** NA
- **documentacion_tecnica:** NA
- **condiciones_de_uso:** Exige registro para descargar; declara terminos y condiciones
- **usos_en_monitoreo:** Continuidad de estudios de los egresados del territorio en educacion superior.
- **estado_verificacion:** Verificada
- **fecha_verificacion:** 2026-07-30
- **observaciones:** El reconocimiento la clasificaba como abierta; la descarga en realidad exige registro, de modo que el nivel de acceso se corrige a Abierto con registro. Informes recientes: matricula 2025, titulacion 2024 y duracion real y en exceso 2025.
- **copia_local:** NA
- **fuente_equivalente:** NA

#### F078 <c2><b7> INDICES, bases de datos de educacion superior

- **ambito_monitoreo:** 1. Comunidades educativas
- **subambito:** 1.1 Trayectorias estudiantiles
- **descripcion:** Bases de matricula, vacantes, aranceles y oferta academica de pregrado y posgrado, segun lo declara el reconocimiento.
- **variables:** NA
- **base_datos:** INDICES
- **emisor:** Consejo Nacional de Educacion (CNED)
- **via_de_acceso:** Descarga directa desde sitio institucional
- **nivel_acceso:** Abierto
- **url_referencia:** https://www.cned.cl/bases-de-datos
- **url_descarga:** NA
- **formato:** NA
- **detalle_tecnico:** NA
- **unidad_de_analisis:** Nacional
- **llaves_de_union:** NA
- **desagregacion_territorial:** Region
- **cobertura_temporal:** NA
- **periodicidad:** Anual
- **mes_publicacion:** NA
- **datos_personales:** Sin datos de personas
- **documentacion_tecnica:** El reconocimiento declara documentacion en cned.cl/estadistica/indices-bd-institucional, no verificada
- **condiciones_de_uso:** NA
- **usos_en_monitoreo:** Segunda fuente de matricula de educacion superior, util para triangular con el SIES.
- **estado_verificacion:** URL viva sin descarga confirmada
- **fecha_verificacion:** 2026-07-30
- **observaciones:** El servidor devuelve HTTP 403 a la herramienta de consulta. El host respondio: no es un enlace roto. Es la unica fuente del lote G con documentacion tecnica declarada por el reconocimiento. Solicitud registrada.
- **copia_local:** NA
- **fuente_equivalente:** NA

#### F079 <c2><b7> Pruebas de admision a la educacion superior

- **ambito_monitoreo:** 1. Comunidades educativas
- **subambito:** 1.1 Trayectorias estudiantiles
- **descripcion:** Bases de puntajes de candidatos, informacion de postulantes, cupos supernumerarios, cupos PACE y matriculacion.
- **variables:** NA
- **base_datos:** Datos Abiertos
- **emisor:** Centro de Estudios del Ministerio de Educacion (CEM)
- **via_de_acceso:** Portal de datos abiertos
- **nivel_acceso:** Abierto
- **url_referencia:** https://datosabiertos.mineduc.cl/pruebas-de-admision-a-la-educacion-superior/
- **url_descarga:** https://datosabiertos.mineduc.cl/wp-content/uploads/2026/07/PAES-2026-Inscritos-Puntajes.rar
- **formato:** rar; zip
- **detalle_tecnico:** Archivos anuales .rar y .zip, procesos 2021-2026. url_descarga apunta al proceso 2026, subido en 2026/07: es el archivo mas reciente de todo el catalogo.
- **unidad_de_analisis:** Estudiante
- **llaves_de_union:** NA
- **desagregacion_territorial:** Establecimiento
- **cobertura_temporal:** 2021-2026
- **periodicidad:** Anual
- **mes_publicacion:** NA
- **datos_personales:** NA
- **documentacion_tecnica:** NA
- **condiciones_de_uso:** NA
- **usos_en_monitoreo:** Puntajes y postulacion de los egresados del territorio; via publica alternativa a DEMRE.
- **estado_verificacion:** Verificada
- **fecha_verificacion:** 2026-07-30
- **observaciones:** Es la via viva al mismo dato que DEMRE publica en F074, cuyo dominio no se puede consultar. No publica esquema de registros. Solicitud registrada.
- **copia_local:** NA
- **fuente_equivalente:** NA

### 1.2 Desarrollo social y personal

#### F005 <c2><b7> Alumnos preferentes, prioritarios y beneficiarios SEP

- **ambito_monitoreo:** 1. Comunidades educativas
- **subambito:** 1.2 Desarrollo social y personal
- **descripcion:** Bases de alumnos prioritarios, preferentes y beneficiarios de la Subvencion Escolar Preferencial.
- **variables:** NA
- **base_datos:** Datos Abiertos
- **emisor:** Centro de Estudios del Ministerio de Educacion (CEM)
- **via_de_acceso:** Portal de datos abiertos
- **nivel_acceso:** Abierto
- **url_referencia:** https://datosabiertos.mineduc.cl/alumnos-preferentes-prioritarios-y-beneficiarios-sep/
- **url_descarga:** https://datosabiertos.mineduc.cl/wp-content/uploads/2026/01/Alumnos-SEP-2025.rar
- **formato:** rar
- **detalle_tecnico:** Un archivo .rar por ano, 2008-2025. url_descarga apunta al ano 2025, subido en 2026/01. La carpeta de subida varia por ano, de modo que la serie exige leer cada enlace en la pagina.
- **unidad_de_analisis:** NA
- **llaves_de_union:** NA
- **desagregacion_territorial:** Establecimiento
- **cobertura_temporal:** 2008-2025
- **periodicidad:** Anual
- **mes_publicacion:** NA
- **datos_personales:** NA
- **documentacion_tecnica:** NA
- **condiciones_de_uso:** NA
- **usos_en_monitoreo:** Marcador de vulnerabilidad socioeconomica por estudiante; insumo de focalizacion.
- **estado_verificacion:** Verificada
- **fecha_verificacion:** 2026-07-30
- **observaciones:** La pagina no publica esquema de registros ni diccionario. Sin copia local. Solicitud registrada.
- **copia_local:** NA
- **fuente_equivalente:** NA

#### F039 <c2><b7> Estudio Nacional de Drogas en Poblacion Escolar 2023

- **ambito_monitoreo:** 1. Comunidades educativas
- **subambito:** 1.2 Desarrollo social y personal
- **descripcion:** Base de datos del decimoquinto Estudio Nacional de Drogas en Poblacion Escolar, segun lo declara el reconocimiento.
- **variables:** NA
- **base_datos:** Observatorio Chileno de Drogas
- **emisor:** Servicio Nacional para la Prevencion y Rehabilitacion del Consumo de Drogas y Alcohol (SENDA)
- **via_de_acceso:** Descarga directa desde sitio institucional
- **nivel_acceso:** Abierto con registro
- **url_referencia:** https://www.senda.gob.cl/informacion-y-conocimiento/observatorio-chileno-drogas/base-de-datos/base-de-datos-estudio-nacional-de-poblacion-escolar-2023/
- **url_descarga:** NA
- **formato:** NA
- **detalle_tecnico:** NA
- **unidad_de_analisis:** Estudiante
- **llaves_de_union:** NA
- **desagregacion_territorial:** Comuna
- **cobertura_temporal:** 2023
- **periodicidad:** Por evento
- **mes_publicacion:** NA
- **datos_personales:** NA
- **documentacion_tecnica:** NA
- **condiciones_de_uso:** NA
- **usos_en_monitoreo:** Consumo de sustancias en poblacion escolar; insumo de convivencia y desarrollo personal.
- **estado_verificacion:** URL viva sin descarga confirmada
- **fecha_verificacion:** 2026-07-30
- **observaciones:** El servidor devuelve HTTP 403 a la herramienta de consulta. El host respondio: no es un enlace roto. Las prevalencias que el reconocimiento atribuia a esta base no se transcriben al catalogo por no haberse observado. Solicitud registrada.
- **copia_local:** NA
- **fuente_equivalente:** NA

#### F040 <c2><b7> Bibliodrogas, listado de estudios del Observatorio Chileno de Drogas

- **ambito_monitoreo:** 1. Comunidades educativas
- **subambito:** 1.2 Desarrollo social y personal
- **descripcion:** Series de estudios en poblacion escolar y general del Observatorio Chileno de Drogas, segun lo declara el reconocimiento.
- **variables:** NA
- **base_datos:** Bibliodrogas
- **emisor:** Servicio Nacional para la Prevencion y Rehabilitacion del Consumo de Drogas y Alcohol (SENDA)
- **via_de_acceso:** Reporte en PDF
- **nivel_acceso:** Abierto
- **url_referencia:** https://bibliodrogas.gob.cl/observatorio/
- **url_descarga:** NA
- **formato:** NA
- **detalle_tecnico:** NA
- **unidad_de_analisis:** NA
- **llaves_de_union:** NA
- **desagregacion_territorial:** Nacional
- **cobertura_temporal:** NA
- **periodicidad:** Sin periodicidad definida
- **mes_publicacion:** NA
- **datos_personales:** NA
- **documentacion_tecnica:** NA
- **condiciones_de_uso:** NA
- **usos_en_monitoreo:** Serie historica de consumo en poblacion escolar.
- **estado_verificacion:** URL viva sin descarga confirmada
- **fecha_verificacion:** 2026-07-30
- **observaciones:** La consulta excede diez redirecciones y no llega a contenido. Es un bucle de redirecciones, no un 404 ni un 403: el host responde pero no resuelve a una pagina final. Contenido no verificado. Solicitud registrada.
- **copia_local:** NA
- **fuente_equivalente:** NA

#### F043 <c2><b7> Sistema de informacion estadistica de Mejor Ninez

- **ambito_monitoreo:** 1. Comunidades educativas
- **subambito:** 1.2 Desarrollo social y personal
- **descripcion:** Estadisticas de proteccion especializada de ninez y adolescencia, segun lo declara el reconocimiento.
- **variables:** NA
- **base_datos:** Sistema de informacion estadistica
- **emisor:** Servicio Nacional de Proteccion Especializada a la Ninez y Adolescencia (Mejor Ninez)
- **via_de_acceso:** Consulta web sin descarga
- **nivel_acceso:** Abierto
- **url_referencia:** https://sis.mejorninez.cl/mejor-ninez.html
- **url_descarga:** NA
- **formato:** NA
- **detalle_tecnico:** NA
- **unidad_de_analisis:** NA
- **llaves_de_union:** NA
- **desagregacion_territorial:** NA
- **cobertura_temporal:** NA
- **periodicidad:** Sin periodicidad definida
- **mes_publicacion:** NA
- **datos_personales:** NA
- **documentacion_tecnica:** NA
- **condiciones_de_uso:** NA
- **usos_en_monitoreo:** Contexto de proteccion especializada de los estudiantes del territorio.
- **estado_verificacion:** URL viva sin descarga confirmada
- **fecha_verificacion:** 2026-07-30
- **observaciones:** La cadena de certificados TLS no se puede verificar: el servidor no entrega el certificado intermedio. No es un 404 ni un 403, y un navegador podria aceptarlo con advertencia. Contenido no verificado. Solicitud registrada.
- **copia_local:** NA
- **fuente_equivalente:** NA

#### F045 <c2><b7> Tercer Estudio Nacional de la Discapacidad (III ENDISC 2022)

- **ambito_monitoreo:** 1. Comunidades educativas
- **subambito:** 1.2 Desarrollo social y personal
- **descripcion:** Prevalencia de discapacidad en poblacion adulta y en ninos, ninas y adolescentes de 2 a 17 anos, a nivel nacional y en las 16 regiones, sobre la Encuesta Nacional de Discapacidad y Dependencia.
- **variables:** NA
- **base_datos:** III ENDISC
- **emisor:** Servicio Nacional de la Discapacidad (SENADIS)
- **via_de_acceso:** Reporte en PDF
- **nivel_acceso:** Abierto
- **url_referencia:** https://www.senadis.gob.cl/pag/693/2004/iii_estudio_nacional_de_la_discapacidad
- **url_descarga:** https://www.senadis.gob.cl/descarga/i/7442/documento
- **formato:** pdf
- **detalle_tecnico:** url_descarga apunta al libro del estudio. Las secciones de datos remiten a paginas propias que no exponen enlaces directos de archivo.
- **unidad_de_analisis:** Nacional
- **llaves_de_union:** NA
- **desagregacion_territorial:** Region
- **cobertura_temporal:** 2022
- **periodicidad:** Por evento
- **mes_publicacion:** NA
- **datos_personales:** NA
- **documentacion_tecnica:** NA
- **condiciones_de_uso:** No declara licencia
- **usos_en_monitoreo:** Prevalencia de discapacidad en poblacion escolar como contexto de necesidades educativas.
- **estado_verificacion:** Verificada
- **fecha_verificacion:** 2026-07-30
- **observaciones:** El reconocimiento databa el estudio en 2004 por la URL, que conserva ese numero en su ruta; el estudio es de 2022. La base de datos como tal no se observo: solo el libro en PDF. Solicitud registrada.
- **copia_local:** NA
- **fuente_equivalente:** NA

#### F047 <c2><b7> Encuesta Nacional de Juventudes

- **ambito_monitoreo:** 1. Comunidades educativas
- **subambito:** 1.2 Desarrollo social y personal
- **descripcion:** Encuesta trienal sobre educacion, trabajo y participacion de jovenes, segun lo declara el reconocimiento.
- **variables:** NA
- **base_datos:** Encuesta Nacional de Juventudes
- **emisor:** Instituto Nacional de la Juventud (INJUV)
- **via_de_acceso:** Descarga directa desde sitio institucional
- **nivel_acceso:** Abierto
- **url_referencia:** https://www.injuv.gob.cl/encuestanacionaldejuventud
- **url_descarga:** NA
- **formato:** NA
- **detalle_tecnico:** NA
- **unidad_de_analisis:** NA
- **llaves_de_union:** NA
- **desagregacion_territorial:** Nacional
- **cobertura_temporal:** NA
- **periodicidad:** Sin periodicidad definida
- **mes_publicacion:** NA
- **datos_personales:** NA
- **documentacion_tecnica:** NA
- **condiciones_de_uso:** NA
- **usos_en_monitoreo:** Trayectoria post escolar y participacion juvenil como contexto de egreso.
- **estado_verificacion:** URL viva sin descarga confirmada
- **fecha_verificacion:** 2026-07-30
- **observaciones:** La cadena de certificados TLS no se puede verificar: el servidor no entrega el certificado intermedio, la misma falla de F043. Contenido no verificado. Solicitud registrada.
- **copia_local:** NA
- **fuente_equivalente:** NA

#### F048 <c2><b7> Encuesta Nacional de Habitos de Actividad Fisica y Deporte

- **ambito_monitoreo:** 1. Comunidades educativas
- **subambito:** 1.2 Desarrollo social y personal
- **descripcion:** Niveles de actividad fisica en poblacion mayor de 5 anos, con un indice multidimensional que clasifica a las personas como activas, parcialmente activas e inactivas segun recomendaciones de la Organizacion Mundial de la Salud.
- **variables:** NA
- **base_datos:** ENAFYD
- **emisor:** Ministerio del Deporte (Mindep)
- **via_de_acceso:** Reporte en PDF
- **nivel_acceso:** Abierto
- **url_referencia:** https://www.mindep.cl/secciones/211
- **url_descarga:** https://page-mindep.s3.amazonaws.com/sigi/files/23033_informe_ejecutivo_nacional_enafyd_1911.pdf
- **formato:** pdf
- **detalle_tecnico:** url_descarga apunta al informe ejecutivo nacional. Se publica ademas una presentacion en PDF. Los archivos viven en un bucket de Amazon S3, no en el dominio institucional.
- **unidad_de_analisis:** Nacional
- **llaves_de_union:** NA
- **desagregacion_territorial:** Nacional
- **cobertura_temporal:** 2024
- **periodicidad:** Por evento
- **mes_publicacion:** NA
- **datos_personales:** Sin datos de personas
- **documentacion_tecnica:** NA
- **condiciones_de_uso:** No declara licencia
- **usos_en_monitoreo:** Habitos de actividad fisica de la poblacion escolar como contexto de desarrollo personal.
- **estado_verificacion:** Verificada
- **fecha_verificacion:** 2026-07-30
- **observaciones:** La pagina no declara el ano de la encuesta en su encabezado, aunque el texto menciona 2024 y lista documentos de 2018, 2019 y 2021. No declara desagregacion territorial, pese a que el reconocimiento la atribuia por region.
- **copia_local:** NA
- **fuente_equivalente:** NA

#### F049 <c2><b7> Observatorio de Derechos de la Ninez

- **ambito_monitoreo:** 1. Comunidades educativas
- **subambito:** 1.2 Desarrollo social y personal
- **descripcion:** Indicadores de derechos de ninos, ninas y adolescentes organizados en cuatro grupos: vida y supervivencia, desarrollo, proteccion y participacion.
- **variables:** NA
- **base_datos:** Observatorio de Derechos
- **emisor:** Defensoria de los Derechos de la Ninez
- **via_de_acceso:** Consulta web sin descarga
- **nivel_acceso:** Abierto
- **url_referencia:** https://observatorio.defensorianinez.cl/
- **url_descarga:** NA
- **formato:** sin descarga
- **detalle_tecnico:** Buscador de datos por tema, mas documentos descargables: diagnosticos anuales, notas tecnicas, minutas de politica y documentos de trabajo. No declara formatos de dato bruto.
- **unidad_de_analisis:** Nacional
- **llaves_de_union:** NA
- **desagregacion_territorial:** Nacional
- **cobertura_temporal:** 2018-2025
- **periodicidad:** Anual
- **mes_publicacion:** NA
- **datos_personales:** Sin datos de personas
- **documentacion_tecnica:** Diagnosticos anuales, notas tecnicas, minutas de politica y documentos de trabajo
- **condiciones_de_uso:** No declara licencia
- **usos_en_monitoreo:** Marco de derechos para leer los indicadores de trayectoria y convivencia.
- **estado_verificacion:** Verificada
- **fecha_verificacion:** 2026-07-30
- **observaciones:** Entre los indicadores del grupo de desarrollo hay educacion, recreacion y espacios publicos, directamente pertinentes al monitoreo. Diagnostico anual 2026 disponible.
- **copia_local:** NA
- **fuente_equivalente:** NA

#### F055 <c2><b7> Mapa Nutricional

- **ambito_monitoreo:** 1. Comunidades educativas
- **subambito:** 1.2 Desarrollo social y personal
- **descripcion:** Distribucion de la situacion nutricional de estudiantes de establecimientos financiados por el Estado, con series por region y comuna e intervalos de confianza.
- **variables:** NA
- **base_datos:** Mapa Nutricional
- **emisor:** Junta Nacional de Auxilio Escolar y Becas (Junaeb)
- **via_de_acceso:** Descarga directa desde sitio institucional
- **nivel_acceso:** Abierto
- **url_referencia:** https://www.junaeb.cl/mapa-nutricional
- **url_descarga:** NA
- **formato:** xlsx; pdf
- **detalle_tecnico:** Publica evolucion nacional 2009-2025 en PDF, evolucion por region 2009-2025 en XLSX e intervalos de confianza comunales 2024-2025 en XLSX, mas informes anuales 2017-2025 y presentaciones 2016-2025 en PDF.
- **unidad_de_analisis:** Establecimiento
- **llaves_de_union:** NA
- **desagregacion_territorial:** Comuna
- **cobertura_temporal:** 1997 en adelante para 1 basico; 2003 para 1 medio; 2007 para prekinder y kinder; 2018 para 5 basico; tablas publicadas desde 2011
- **periodicidad:** Anual
- **mes_publicacion:** NA
- **datos_personales:** Sin datos de personas
- **documentacion_tecnica:** Diccionario de variables publicado, mas metodologia de la Organizacion Mundial de la Salud y protocolo de medicion antropometrica
- **condiciones_de_uso:** No declara licencia
- **usos_en_monitoreo:** Estado nutricional de los estudiantes del territorio; insumo de desarrollo social y personal.
- **estado_verificacion:** Verificada
- **fecha_verificacion:** 2026-07-30
- **observaciones:** Segunda fuente de las 60 URLs que publica diccionario de variables, tras el Banco de datos ENE del INE. La cobertura no es uniforme: cada nivel educativo entra a la serie en un ano distinto, lo que hay que tener presente antes de construir series largas.
- **copia_local:** NA
- **fuente_equivalente:** NA

#### F056 <c2><b7> Biblioteca de Datos para la Investigacion

- **ambito_monitoreo:** 1. Comunidades educativas
- **subambito:** 1.2 Desarrollo social y personal
- **descripcion:** Repositorio de bases desidentificadas de Mapa Nutricional y programas de alimentacion escolar, con llave ID_JUNAEB, segun lo declara el reconocimiento.
- **variables:** NA
- **base_datos:** Biblioteca de Datos
- **emisor:** Junta Nacional de Auxilio Escolar y Becas (Junaeb)
- **via_de_acceso:** Sistema con credenciales
- **nivel_acceso:** Abierto con registro
- **url_referencia:** https://bibliotecadatos.sead.junaeb.cl/
- **url_descarga:** NA
- **formato:** NA
- **detalle_tecnico:** El servidor entrega solo el encabezado de la pagina; el cuerpo no llega. No se pudo observar el catalogo, el requisito de registro ni la llave declarada.
- **unidad_de_analisis:** Estudiante
- **llaves_de_union:** NA
- **desagregacion_territorial:** NA
- **cobertura_temporal:** NA
- **periodicidad:** Sin periodicidad definida
- **mes_publicacion:** NA
- **datos_personales:** NA
- **documentacion_tecnica:** NA
- **condiciones_de_uso:** NA
- **usos_en_monitoreo:** Microdatos desidentificados que permitirian vincular nutricion y alimentacion escolar a nivel individual.
- **estado_verificacion:** URL viva sin descarga confirmada
- **fecha_verificacion:** 2026-07-30
- **observaciones:** El reconocimiento la destacaba como su hallazgo numero 1 y le atribuia la llave ID_JUNAEB; nada de eso se pudo confirmar. Es la fuente de mayor valor potencial no verificada del catalogo. Solicitud registrada.
- **copia_local:** NA
- **fuente_equivalente:** NA

#### F057 <c2><b7> Informe Mapa Nutricional 2025

- **ambito_monitoreo:** 1. Comunidades educativas
- **subambito:** 1.2 Desarrollo social y personal
- **descripcion:** Informe anual de resultados del Mapa Nutricional correspondiente al ano 2025.
- **variables:** NA
- **base_datos:** Mapa Nutricional
- **emisor:** Junta Nacional de Auxilio Escolar y Becas (Junaeb)
- **via_de_acceso:** Descarga directa desde sitio institucional
- **nivel_acceso:** Abierto
- **url_referencia:** https://www.junaeb.cl/mapa-nutricional
- **url_descarga:** https://www.junaeb.cl/wp-content/uploads/2026/03/Mapa-Nutricional-Resultados-2025.pdf
- **formato:** pdf
- **detalle_tecnico:** El archivo existe y pesa 2,2 MB, pero es un PDF de imagen: no tiene texto extraible, de modo que su contenido no se pudo leer ni verificar.
- **unidad_de_analisis:** Establecimiento
- **llaves_de_union:** NA
- **desagregacion_territorial:** Comuna
- **cobertura_temporal:** 2025
- **periodicidad:** Anual
- **mes_publicacion:** NA
- **datos_personales:** Sin datos de personas
- **documentacion_tecnica:** NA
- **condiciones_de_uso:** No declara licencia
- **usos_en_monitoreo:** Resultados nutricionales del ano mas reciente.
- **estado_verificacion:** Verificada
- **fecha_verificacion:** 2026-07-30
- **observaciones:** Verificada en el sentido de que la URL responde y el archivo existe con su tamano integro; su contenido no se transcribe porque el PDF no expone texto. Las cifras de prevalencia que el reconocimiento le atribuia NO se copian al catalogo: no fueron observadas.
- **copia_local:** NA
- **fuente_equivalente:** NA

#### F059 <c2><b7> Denuncias ante la Superintendencia de Educacion

- **ambito_monitoreo:** 1. Comunidades educativas
- **subambito:** 1.2 Desarrollo social y personal
- **descripcion:** Registro de denuncias presentadas ante la Superintendencia de Educacion, por ambito, tema, region y dependencia, segun lo declara el reconocimiento.
- **variables:** NA
- **base_datos:** datos.gob.cl
- **emisor:** Superintendencia de Educacion (SIE)
- **via_de_acceso:** Portal de datos abiertos
- **nivel_acceso:** Abierto
- **url_referencia:** https://datos.gob.cl/dataset/denuncias
- **url_descarga:** NA
- **formato:** csv
- **detalle_tecnico:** Formato y licencia tomados de la pagina de organizacion (F058), que si rinde. Ultima actualizacion declarada alli: 2024-07-01.
- **unidad_de_analisis:** Establecimiento
- **llaves_de_union:** NA
- **desagregacion_territorial:** Region
- **cobertura_temporal:** NA
- **periodicidad:** Sin periodicidad definida
- **mes_publicacion:** NA
- **datos_personales:** NA
- **documentacion_tecnica:** NA
- **condiciones_de_uso:** Creative Commons Attribution (CC-BY)
- **usos_en_monitoreo:** Denuncias por establecimiento y tema; senal directa de convivencia escolar.
- **estado_verificacion:** URL viva sin descarga confirmada
- **fecha_verificacion:** 2026-07-30
- **observaciones:** La ficha del conjunto devuelve la portada del portal en vez de su propia pagina: datos.gob.cl arma las fichas en el navegador. El host responde, de modo que no es enlace roto. La cobertura desde 2014 que declaraba el reconocimiento NO se pudo confirmar y queda como NA. Solicitud registrada.
- **copia_local:** NA
- **fuente_equivalente:** NA

#### F060 <c2><b7> Solicitudes de mediacion ante la Superintendencia de Educacion

- **ambito_monitoreo:** 1. Comunidades educativas
- **subambito:** 1.2 Desarrollo social y personal
- **descripcion:** Registro de solicitudes de mediacion presentadas ante la Superintendencia de Educacion, segun lo declara el reconocimiento.
- **variables:** NA
- **base_datos:** datos.gob.cl
- **emisor:** Superintendencia de Educacion (SIE)
- **via_de_acceso:** Portal de datos abiertos
- **nivel_acceso:** Abierto
- **url_referencia:** https://datos.gob.cl/dataset/solicitudes-de-mediacion
- **url_descarga:** NA
- **formato:** csv
- **detalle_tecnico:** Formato y licencia tomados de la pagina de organizacion (F058). Ultima actualizacion declarada alli: 2024-07-01.
- **unidad_de_analisis:** Establecimiento
- **llaves_de_union:** NA
- **desagregacion_territorial:** Region
- **cobertura_temporal:** NA
- **periodicidad:** Sin periodicidad definida
- **mes_publicacion:** NA
- **datos_personales:** NA
- **documentacion_tecnica:** NA
- **condiciones_de_uso:** Creative Commons Attribution (CC-BY)
- **usos_en_monitoreo:** Mediaciones como indicador de conflictos resueltos sin sancion.
- **estado_verificacion:** URL viva sin descarga confirmada
- **fecha_verificacion:** 2026-07-30
- **observaciones:** Misma falla que F059: la ficha del conjunto devuelve la portada del portal. La cobertura desde 2015 que declaraba el reconocimiento no se pudo confirmar. Solicitud registrada.
- **copia_local:** NA
- **fuente_equivalente:** NA

### 1.3 Aprendizajes y resultados

#### F004 <c2><b7> Rendimiento academico por estudiante

- **ambito_monitoreo:** 1. Comunidades educativas
- **subambito:** 1.3 Aprendizajes y resultados
- **descripcion:** Notas y situacion final por estudiante del sistema escolar, con identificacion del establecimiento, el curso y el nivel de ensenanza.
- **variables:** AGNO; RBD; DGV_RBD; NOM_RBD; COD_REG_RBD; NOM_REG_RBD_A; COD_PRO_RBD; COD_COM_RBD; NOM_COM_RBD; COD_DEPROV_RBD; NOM_DEPROV_RBD; COD_DEPE; COD_DEPE2; RURAL_RBD; ESTADO_ESTAB; NOMBRE_SLEP; COD_ENSE; COD_ENSE2; COD_GRADO; LET_CUR; COD_JOR; COD_TIP_CUR; COD_DES_CUR; MRUN; GEN_ALU; FEC_NAC_ALU; EDAD_ALU; COD_REG_ALU; COD_COM_ALU; NOM_COM_ALU; COD_RAMA; COD_SEC; COD_ESPE; PROM_GRAL; ASISTENCIA; SIT_FIN; SIT_FIN_R; COD_MEN
- **base_datos:** Datos Abiertos
- **emisor:** Centro de Estudios del Ministerio de Educacion (CEM)
- **via_de_acceso:** Portal de datos abiertos
- **nivel_acceso:** Abierto
- **url_referencia:** https://datosabiertos.mineduc.cl/rendimiento-por-estudiante-2/
- **url_descarga:** https://datosabiertos.mineduc.cl/wp-content/uploads/2026/03/Rendimiento-por-estudiante-2025.rar
- **formato:** rar
- **detalle_tecnico:** La pagina publica un .rar por ano, 2002-2025. url_descarga apunta al ano 2025. La serie NO tiene patron derivable: el nombre del archivo cambia entre anos (Rendimiento-por-estudiante-2025.rar, Rendimiento_2024.rar, Rendimiento-2023.rar) y la carpeta de subida tambien (2026/03, 2025/04, 2024/09). Cada ano exige leer su enlace en la pagina. La copia local del ano 2025 es .csv de 576 MB, separador punto y coma, cabecera en UTF-8 con marca de orden de bytes (BOM), 38 columnas. Incluye PROM_GRAL, ASISTENCIA y SIT_FIN.
- **unidad_de_analisis:** Estudiante
- **llaves_de_union:** MRUN; RBD; AGNO; COD_COM_RBD
- **desagregacion_territorial:** Establecimiento
- **cobertura_temporal:** 2002-2025 en el portal; 2015-2025 en la copia local, sin anos faltantes
- **periodicidad:** Anual
- **mes_publicacion:** NA
- **datos_personales:** Identificador enmascarado (MRUN)
- **documentacion_tecnica:** NA
- **condiciones_de_uso:** NA
- **usos_en_monitoreo:** Promedio general, asistencia y situacion final por estudiante; insumo de trayectorias y de aprobacion.
- **estado_verificacion:** Verificada
- **fecha_verificacion:** 2026-07-30
- **observaciones:** Columnas, separador, codificacion y anos efectivos leidos de la copia local (solo cabecera). El proyecto hermano tambien conserva una version con RUT directo en su carpeta de insumos privados, que no se cataloga aqui.
- **copia_local:** slep_rendimiento_historico
- **fuente_equivalente:** NA

#### F018 <c2><b7> Notas y egresados de ensenanza media

- **ambito_monitoreo:** 1. Comunidades educativas
- **subambito:** 1.3 Aprendizajes y resultados
- **descripcion:** NA
- **variables:** NA
- **base_datos:** Datos Abiertos
- **emisor:** Centro de Estudios del Ministerio de Educacion (CEM)
- **via_de_acceso:** Portal de datos abiertos
- **nivel_acceso:** Abierto
- **url_referencia:** https://datosabiertos.mineduc.cl/
- **url_descarga:** NA
- **formato:** NA
- **detalle_tecnico:** NA
- **unidad_de_analisis:** NA
- **llaves_de_union:** NA
- **desagregacion_territorial:** NA
- **cobertura_temporal:** NA
- **periodicidad:** NA
- **mes_publicacion:** NA
- **datos_personales:** NA
- **documentacion_tecnica:** NA
- **condiciones_de_uso:** NA
- **usos_en_monitoreo:** Cierre de trayectoria de ensenanza media.
- **estado_verificacion:** Declarada sin verificar
- **fecha_verificacion:** NA
- **observaciones:** Listada en la seccion Estudiantes del portal y ausente del reconocimiento. Pendiente de verificacion en una pasada posterior.
- **copia_local:** NA
- **fuente_equivalente:** NA

#### F019 <c2><b7> Resumen de rendimiento por establecimiento

- **ambito_monitoreo:** 1. Comunidades educativas
- **subambito:** 1.3 Aprendizajes y resultados
- **descripcion:** NA
- **variables:** NA
- **base_datos:** Datos Abiertos
- **emisor:** Centro de Estudios del Ministerio de Educacion (CEM)
- **via_de_acceso:** Portal de datos abiertos
- **nivel_acceso:** Abierto
- **url_referencia:** https://datosabiertos.mineduc.cl/
- **url_descarga:** NA
- **formato:** NA
- **detalle_tecnico:** NA
- **unidad_de_analisis:** NA
- **llaves_de_union:** NA
- **desagregacion_territorial:** NA
- **cobertura_temporal:** NA
- **periodicidad:** NA
- **mes_publicacion:** NA
- **datos_personales:** NA
- **documentacion_tecnica:** NA
- **condiciones_de_uso:** NA
- **usos_en_monitoreo:** Version agregada del rendimiento, util cuando no se requiere el nivel estudiante.
- **estado_verificacion:** Declarada sin verificar
- **fecha_verificacion:** NA
- **observaciones:** Listada en la seccion Establecimientos del portal y ausente del reconocimiento. Pendiente de verificacion en una pasada posterior.
- **copia_local:** NA
- **fuente_equivalente:** NA

#### F050 <c2><b7> Resultados Simce e IDPS, seccion institucional

- **ambito_monitoreo:** 1. Comunidades educativas
- **subambito:** 1.3 Aprendizajes y resultados
- **descripcion:** Seccion institucional del Simce: resultados nacionales, regionales y comunales, informes tecnicos, documentacion metodologica y acceso a la base de datos estadistica.
- **variables:** NA
- **base_datos:** Simce
- **emisor:** Agencia de Calidad de la Educacion (ACE)
- **via_de_acceso:** Reporte en PDF
- **nivel_acceso:** Abierto
- **url_referencia:** https://www.agenciaeducacion.cl/simce/
- **url_descarga:** NA
- **formato:** pdf; rar; html
- **detalle_tecnico:** Publica presentaciones nacionales y por region en PDF, informes tecnicos, archivos complementarios en .rar, un panel Power BI y datos enlazados en RDF, TTL y JSON-LD. Los enlaces de documento apuntan a archivos en Amazon S3.
- **unidad_de_analisis:** Establecimiento
- **llaves_de_union:** NA
- **desagregacion_territorial:** Comuna
- **cobertura_temporal:** 2010-2025
- **periodicidad:** Anual
- **mes_publicacion:** NA
- **datos_personales:** Sin datos de personas
- **documentacion_tecnica:** Informes tecnicos Simce e IDPS 2012-2024; metodologia de construccion de grupos socioeconomicos 2011-2013; calculo de significancia estadistica
- **condiciones_de_uso:** No declara restricciones explicitas de licencia; el acceso a datos enmascarados por estudiante exige solicitud formal via Portal de Transparencia u OIRS
- **usos_en_monitoreo:** Resultados de aprendizaje y desarrollo personal y social por establecimiento del territorio.
- **estado_verificacion:** Verificada
- **fecha_verificacion:** 2026-07-30
- **observaciones:** Es la fuente mejor documentada de los tres tramos: catorce anos de informes tecnicos y metodologia publicada. Presentaciones por region en diez anos distintos e informes por comuna solo en 2022. Es la puerta de entrada a F051, F052 y F054.
- **copia_local:** NA
- **fuente_equivalente:** NA

#### F051 <c2><b7> Informacion estadistica por establecimiento

- **ambito_monitoreo:** 1. Comunidades educativas
- **subambito:** 1.3 Aprendizajes y resultados
- **descripcion:** Base de datos estadistica de Simce e IDPS por establecimiento, comuna y region, con publicacion de datos enlazados, segun lo declara el reconocimiento.
- **variables:** NA
- **base_datos:** Informacion estadistica
- **emisor:** Agencia de Calidad de la Educacion (ACE)
- **via_de_acceso:** Portal de datos abiertos
- **nivel_acceso:** Abierto
- **url_referencia:** https://informacionestadistica.agenciaeducacion.cl
- **url_descarga:** NA
- **formato:** NA
- **detalle_tecnico:** El servidor entrega la plantilla sin renderizar: el cuerpo de la pagina llega con el marcador literal {{titulo}} en vez de contenido. Es una aplicacion de pagina unica que arma su contenido en el navegador.
- **unidad_de_analisis:** Establecimiento
- **llaves_de_union:** NA
- **desagregacion_territorial:** Establecimiento
- **cobertura_temporal:** NA
- **periodicidad:** Sin periodicidad definida
- **mes_publicacion:** NA
- **datos_personales:** NA
- **documentacion_tecnica:** NA
- **condiciones_de_uso:** NA
- **usos_en_monitoreo:** Resultados por establecimiento en formato consultable, sin pasar por los PDF.
- **estado_verificacion:** URL viva sin descarga confirmada
- **fecha_verificacion:** 2026-07-30
- **observaciones:** El host responde y sirve HTML, pero el HTML no tiene contenido: la interpolacion de plantilla no se ejecuta fuera de un navegador. Es una falla distinta del 403 y del 404. Contenido no verificado. Solicitud registrada.
- **copia_local:** NA
- **fuente_equivalente:** NA

#### F052 <c2><b7> Visor Simce

- **ambito_monitoreo:** 1. Comunidades educativas
- **subambito:** 1.3 Aprendizajes y resultados
- **descripcion:** Tablero interactivo que integra datos historicos de Simce e IDPS y permite analizar resultados nacionales, brechas de genero y brechas por nivel socioeconomico.
- **variables:** NA
- **base_datos:** Visor Simce
- **emisor:** Agencia de Calidad de la Educacion (ACE)
- **via_de_acceso:** Consulta web sin descarga
- **nivel_acceso:** Abierto
- **url_referencia:** https://visorsimce.agenciaeducacion.cl/
- **url_descarga:** NA
- **formato:** sin descarga
- **detalle_tecnico:** Permite personalizar por region, ano, genero, grado y asignatura. La pagina de presentacion no declara si el visor permite exportar.
- **unidad_de_analisis:** Establecimiento
- **llaves_de_union:** NA
- **desagregacion_territorial:** Region
- **cobertura_temporal:** NA
- **periodicidad:** Sin periodicidad definida
- **mes_publicacion:** NA
- **datos_personales:** Sin datos de personas
- **documentacion_tecnica:** NA
- **condiciones_de_uso:** NA
- **usos_en_monitoreo:** Lectura rapida de tendencias y brechas sin procesar bases.
- **estado_verificacion:** Verificada
- **fecha_verificacion:** 2026-07-30
- **observaciones:** El reconocimiento apuntaba a la noticia de lanzamiento; la URL del visor mismo es visorsimce.agenciaeducacion.cl y es la que se cataloga. La cobertura temporal no se declara en la pagina de presentacion.
- **copia_local:** NA
- **fuente_equivalente:** NA

#### F053 <c2><b7> Plataforma de resultados para SLEP y sostenedores

- **ambito_monitoreo:** 1. Comunidades educativas
- **subambito:** 1.3 Aprendizajes y resultados
- **descripcion:** Plataforma con resultados Simce e IDPS por establecimiento, dirigida a servicios locales y sostenedores, segun lo declara el reconocimiento.
- **variables:** NA
- **base_datos:** Plataforma de resultados
- **emisor:** Agencia de Calidad de la Educacion (ACE)
- **via_de_acceso:** Sistema con credenciales
- **nivel_acceso:** Institucional mediado
- **url_referencia:** https://resultadossimce.agenciaeducacion.cl/login
- **url_descarga:** NA
- **formato:** NA
- **detalle_tecnico:** NA
- **unidad_de_analisis:** Establecimiento
- **llaves_de_union:** NA
- **desagregacion_territorial:** Establecimiento
- **cobertura_temporal:** NA
- **periodicidad:** Sin periodicidad definida
- **mes_publicacion:** NA
- **datos_personales:** NA
- **documentacion_tecnica:** NA
- **condiciones_de_uso:** NA
- **usos_en_monitoreo:** Via institucional del SLEP a sus propios resultados, con el detalle que el dato publico no trae.
- **estado_verificacion:** Enlace roto
- **fecha_verificacion:** 2026-07-30
- **observaciones:** El servidor devuelve HTTP 404 en la ruta /login. El host resuelve, de modo que la plataforma probablemente existe con otra ruta de entrada. Es la fuente mas pertinente del lote para el Area, porque es la via institucional propia del SLEP: conviene resolverla. Solicitud registrada.
- **copia_local:** NA
- **fuente_equivalente:** NA

#### F054 <c2><b7> Bases de datos Simce a nivel de estudiante

- **ambito_monitoreo:** 1. Comunidades educativas
- **subambito:** 1.3 Aprendizajes y resultados
- **descripcion:** Puntajes por estudiante y cuestionarios de estudiantes, padres y docentes, con identificador enmascarado, segun lo declara el reconocimiento.
- **variables:** NA
- **base_datos:** Simce
- **emisor:** Agencia de Calidad de la Educacion (ACE)
- **via_de_acceso:** Solicitud formal (Ley 20.285)
- **nivel_acceso:** Restringido por solicitud
- **url_referencia:** https://www.agenciaeducacion.cl/simce/
- **url_descarga:** NA
- **formato:** NA
- **detalle_tecnico:** NA
- **unidad_de_analisis:** Estudiante
- **llaves_de_union:** NA
- **desagregacion_territorial:** Establecimiento
- **cobertura_temporal:** NA
- **periodicidad:** Sin periodicidad definida
- **mes_publicacion:** NA
- **datos_personales:** Identificador enmascarado (MRUN)
- **documentacion_tecnica:** NA
- **condiciones_de_uso:** Exige solicitud formal via Portal de Transparencia u OIRS
- **usos_en_monitoreo:** Nivel de dato mas fino disponible de Simce; habilita analisis de trayectoria individual.
- **estado_verificacion:** Declarada sin verificar
- **fecha_verificacion:** NA
- **observaciones:** El reconocimiento la registro como mencionada sin URL directa y no hay pagina propia que abrir. La seccion Simce (F050) confirma la via: el acceso a datos enmascarados por estudiante exige solicitud formal. La sospecha 6 del reconocimiento queda confirmada. datos_personales se declara como identificador enmascarado porque F050 lo describe asi, no por inspeccion de la base.
- **copia_local:** NA
- **fuente_equivalente:** NA

### 1.4 Instrumentos de gestion educativa

#### F024 <c2><b7> Docentes por curso y subsector

- **ambito_monitoreo:** 1. Comunidades educativas
- **subambito:** 1.4 Instrumentos de gestion educativa
- **descripcion:** NA
- **variables:** NA
- **base_datos:** Datos Abiertos
- **emisor:** Centro de Estudios del Ministerio de Educacion (CEM)
- **via_de_acceso:** Portal de datos abiertos
- **nivel_acceso:** Abierto
- **url_referencia:** https://datosabiertos.mineduc.cl/
- **url_descarga:** NA
- **formato:** NA
- **detalle_tecnico:** NA
- **unidad_de_analisis:** NA
- **llaves_de_union:** NA
- **desagregacion_territorial:** NA
- **cobertura_temporal:** NA
- **periodicidad:** NA
- **mes_publicacion:** NA
- **datos_personales:** NA
- **documentacion_tecnica:** NA
- **condiciones_de_uso:** NA
- **usos_en_monitoreo:** Asignacion docente por curso; insumo de dotacion y cobertura curricular.
- **estado_verificacion:** Declarada sin verificar
- **fecha_verificacion:** NA
- **observaciones:** Listada en la seccion Docentes y Asistentes del portal y ausente del reconocimiento. Pendiente de verificacion en una pasada posterior.
- **copia_local:** NA
- **fuente_equivalente:** NA

#### F067 <c2><b7> Sistema de Reconocimiento de la carrera docente

- **ambito_monitoreo:** 1. Comunidades educativas
- **subambito:** 1.4 Instrumentos de gestion educativa
- **descripcion:** Proceso evaluativo que permite la progresion de docentes en la Carrera Docente, valorando trayectoria, experiencia, competencias y conocimientos.
- **variables:** NA
- **base_datos:** Sitio institucional
- **emisor:** Centro de Perfeccionamiento, Experimentacion e Investigaciones Pedagogicas (CPEIP)
- **via_de_acceso:** Consulta web sin descarga
- **nivel_acceso:** Abierto
- **url_referencia:** https://cpeip.cl/evaluacion-de-la-docencia/
- **url_descarga:** NA
- **formato:** html
- **detalle_tecnico:** Pagina descriptiva del sistema. No expone informes, bases ni archivos descargables. Describe los instrumentos Portafolio y ECEP y remite a la ley 21.625.
- **unidad_de_analisis:** Docente o asistente
- **llaves_de_union:** NA
- **desagregacion_territorial:** NA
- **cobertura_temporal:** NA
- **periodicidad:** Sin periodicidad definida
- **mes_publicacion:** NA
- **datos_personales:** Sin datos de personas
- **documentacion_tecnica:** NA
- **condiciones_de_uso:** No declara licencia
- **usos_en_monitoreo:** Marco del sistema de evaluacion docente que produce los datos de F068 y F069.
- **estado_verificacion:** Verificada
- **fecha_verificacion:** 2026-07-30
- **observaciones:** El reconocimiento le atribuia resultados, tramos y documentacion en PDF. Lo observado es una pagina puramente descriptiva, sin cobertura temporal ni descargas. Su valor es de contexto, no de dato.
- **copia_local:** NA
- **fuente_equivalente:** NA

#### F068 <c2><b7> Informe Nacional del Portafolio

- **ambito_monitoreo:** 1. Comunidades educativas
- **subambito:** 1.4 Instrumentos de gestion educativa
- **descripcion:** Resultados estadisticos del instrumento Portafolio del Sistema de Reconocimiento, con graficos, tablas y comparacion historica por agrupacion evaluada, dependencia y region.
- **variables:** NA
- **base_datos:** Informe Nacional del Portafolio
- **emisor:** Centro de Perfeccionamiento, Experimentacion e Investigaciones Pedagogicas (CPEIP)
- **via_de_acceso:** Reporte en PDF
- **nivel_acceso:** Abierto
- **url_referencia:** https://cpeip.cl/informe-nacional-del-portafolio-2022/
- **url_descarga:** NA
- **formato:** NA
- **detalle_tecnico:** La pagina no aloja el informe: remite a un sitio externo, docentemas.cl, sin descarga directa ni formato declarado.
- **unidad_de_analisis:** Docente o asistente
- **llaves_de_union:** NA
- **desagregacion_territorial:** Region
- **cobertura_temporal:** 2022
- **periodicidad:** Anual
- **mes_publicacion:** NA
- **datos_personales:** Sin datos de personas
- **documentacion_tecnica:** NA
- **condiciones_de_uso:** No declara licencia
- **usos_en_monitoreo:** Resultados del Portafolio por region y dependencia; contexto de la dotacion docente del territorio.
- **estado_verificacion:** Verificada
- **fecha_verificacion:** 2026-07-30
- **observaciones:** El informe vive en docentemas.cl, dominio que el reconocimiento no inventario y que queda fuera del alcance de este catalogo. Se anota la dependencia externa sin seguirla.
- **copia_local:** NA
- **fuente_equivalente:** NA

#### F069 <c2><b7> Plataforma de la Evaluacion de Conocimientos Especificos y Pedagogicos

- **ambito_monitoreo:** 1. Comunidades educativas
- **subambito:** 1.4 Instrumentos de gestion educativa
- **descripcion:** Sitio del proceso ECEP: validacion de datos, convocatoria, temarios y calendario de la evaluacion.
- **variables:** NA
- **base_datos:** ECEP
- **emisor:** Agencia de Calidad de la Educacion (ACE)
- **via_de_acceso:** Consulta web sin descarga
- **nivel_acceso:** Abierto
- **url_referencia:** https://www.evaluacionconocimientos.cl/
- **url_descarga:** NA
- **formato:** pdf; html
- **detalle_tecnico:** Publica los temarios de las pruebas 2026 y un documento de equivalencia entre Portafolio y ECEP en PDF. Remite a Carrera Docente, DocenteMas y Portal Docente para tramites y resultados.
- **unidad_de_analisis:** Docente o asistente
- **llaves_de_union:** NA
- **desagregacion_territorial:** NA
- **cobertura_temporal:** 2026
- **periodicidad:** Anual
- **mes_publicacion:** NA
- **datos_personales:** Sin datos de personas
- **documentacion_tecnica:** Documento de coherencia entre Portafolio y ECEP, y temarios de las pruebas
- **condiciones_de_uso:** No declara licencia
- **usos_en_monitoreo:** Calendario e instrumentos de la evaluacion docente; contexto de la dotacion del territorio.
- **estado_verificacion:** Verificada
- **fecha_verificacion:** 2026-07-30
- **observaciones:** El reconocimiento la clasificaba como sistema con credenciales institucionales; lo observado es una pagina informativa publica, sin formulario de ingreso visible. Se corrige la via de acceso y el nivel de acceso respecto de lo que declaraba el reconocimiento. Calendario referencial: agosto y septiembre de 2026.
- **copia_local:** NA
- **fuente_equivalente:** NA

#### F070 <c2><b7> Evaluacion docente

- **ambito_monitoreo:** 1. Comunidades educativas
- **subambito:** 1.4 Instrumentos de gestion educativa
- **descripcion:** Bases de datos de la evaluacion docente desde el ano 2004 en adelante.
- **variables:** AGNO_EVAL; RBD; DGV_RBD; NOM_RBD; COD_REG_RBD; NOM_REG_RBD_A; COD_PRO_RBD; COD_COM_RBD; NOM_COM_RBD; COD_DEPROV_RBD; NOM_DEPROV_RBD; COD_DEPE; COD_DEPE2; RURAL_RBD; ESTADO_ESTAB; MRUN; DOC_GENERO; DOC_FEC_NAC; NIVEL; PF_PJE; PF_ESC; PF_CAT_CARRERA
- **base_datos:** Datos Abiertos
- **emisor:** Centro de Estudios del Ministerio de Educacion (CEM)
- **via_de_acceso:** Portal de datos abiertos
- **nivel_acceso:** Abierto
- **url_referencia:** https://datosabiertos.mineduc.cl/evaluacion-docente/
- **url_descarga:** https://datosabiertos.mineduc.cl/wp-content/uploads/2026/03/Evaluacion-Docente-2024.rar
- **formato:** rar; zip
- **detalle_tecnico:** Archivos anuales .rar y .zip, 2004-2024. url_descarga apunta al ano 2024, subido en 2026/03. La copia local del ano 2024 es .csv de 2,9 MB, separador punto y coma, UTF-8, 22 columnas. Incluye puntaje del Portafolio (PF_PJE), su escala (PF_ESC) y el tramo de carrera resultante (PF_CAT_CARRERA).
- **unidad_de_analisis:** Docente o asistente
- **llaves_de_union:** MRUN; RBD; AGNO_EVAL
- **desagregacion_territorial:** Establecimiento
- **cobertura_temporal:** 2004-2024 en el portal; 2004-2024 en la copia local, serie completa
- **periodicidad:** Anual
- **mes_publicacion:** NA
- **datos_personales:** Identificador enmascarado (MRUN)
- **documentacion_tecnica:** Esquema de registros ER_Evaluacion_Docente_PUBL_CLAVE.pdf, presente en la copia local
- **condiciones_de_uso:** NA
- **usos_en_monitoreo:** Resultados de evaluacion docente por establecimiento; insumo de dotacion.
- **estado_verificacion:** Verificada
- **fecha_verificacion:** 2026-07-30
- **observaciones:** La serie termina en 2024, un ano antes que las bases de estudiantes del mismo portal. Resuelta en la segunda pasada de doble fuente: la copia local trae la serie completa y su esquema de registros.
- **copia_local:** slep_estudio_oferta_demanda
- **fuente_equivalente:** NA

#### F071 <c2><b7> Evaluacion de Conocimientos Especificos y Pedagogicos (ECEP)

- **ambito_monitoreo:** 1. Comunidades educativas
- **subambito:** 1.4 Instrumentos de gestion educativa
- **descripcion:** Bases de datos de la ECEP desde el ano 2016 en adelante.
- **variables:** NA
- **base_datos:** Datos Abiertos
- **emisor:** Centro de Estudios del Ministerio de Educacion (CEM)
- **via_de_acceso:** Portal de datos abiertos
- **nivel_acceso:** Abierto
- **url_referencia:** https://datosabiertos.mineduc.cl/evaluacion-de-conocimientos-especificos-y-pedagogicos-ecep-2/
- **url_descarga:** https://datosabiertos.mineduc.cl/wp-content/uploads/2026/01/ECEP-2024.rar
- **formato:** rar; zip
- **detalle_tecnico:** Archivos anuales .rar y .zip, 2016-2024. url_descarga apunta al ano 2024, subido en 2026/01.
- **unidad_de_analisis:** Docente o asistente
- **llaves_de_union:** NA
- **desagregacion_territorial:** Establecimiento
- **cobertura_temporal:** 2016-2024
- **periodicidad:** Anual
- **mes_publicacion:** NA
- **datos_personales:** NA
- **documentacion_tecnica:** NA
- **condiciones_de_uso:** NA
- **usos_en_monitoreo:** Resultados de la ECEP; contraparte de dato de la plataforma informativa F069.
- **estado_verificacion:** Verificada
- **fecha_verificacion:** 2026-07-30
- **observaciones:** Es el dato que respalda a F069, que solo publica temarios y calendario. No publica esquema de registros. Solicitud registrada.
- **copia_local:** NA
- **fuente_equivalente:** NA

#### F072 <c2><b7> Cargos docentes

- **ambito_monitoreo:** 1. Comunidades educativas
- **subambito:** 1.4 Instrumentos de gestion educativa
- **descripcion:** Directorios anuales de docentes del sistema educativo, con dotacion, cargos y funciones.
- **variables:** NA
- **base_datos:** Datos Abiertos
- **emisor:** Centro de Estudios del Ministerio de Educacion (CEM)
- **via_de_acceso:** Portal de datos abiertos
- **nivel_acceso:** Abierto
- **url_referencia:** https://datosabiertos.mineduc.cl/cargos-docentes/
- **url_descarga:** https://datosabiertos.mineduc.cl/wp-content/uploads/2025/08/Directorio-Docentes-2025.rar
- **formato:** rar
- **detalle_tecnico:** Archivos anuales .rar, 2003-2025. url_descarga apunta al ano 2025, subido en 2025/08.
- **unidad_de_analisis:** Docente o asistente
- **llaves_de_union:** NA
- **desagregacion_territorial:** Establecimiento
- **cobertura_temporal:** 2003-2025
- **periodicidad:** Anual
- **mes_publicacion:** NA
- **datos_personales:** NA
- **documentacion_tecnica:** NA
- **condiciones_de_uso:** NA
- **usos_en_monitoreo:** Dotacion docente por establecimiento del territorio.
- **estado_verificacion:** Verificada
- **fecha_verificacion:** 2026-07-30
- **observaciones:** La pagina se titula Cargos docentes pero el archivo se publica como Directorio-Docentes. No publica esquema de registros. Solicitud registrada.
- **copia_local:** NA
- **fuente_equivalente:** NA

#### F073 <c2><b7> Asistentes de la educacion

- **ambito_monitoreo:** 1. Comunidades educativas
- **subambito:** 1.4 Instrumentos de gestion educativa
- **descripcion:** Bases de datos de asistentes de la educacion desde el ano 2007 en adelante.
- **variables:** NA
- **base_datos:** Datos Abiertos
- **emisor:** Centro de Estudios del Ministerio de Educacion (CEM)
- **via_de_acceso:** Portal de datos abiertos
- **nivel_acceso:** Abierto
- **url_referencia:** https://datosabiertos.mineduc.cl/asistentes-de-la-educacion/
- **url_descarga:** https://datosabiertos.mineduc.cl/wp-content/uploads/2025/08/Asistentes-de-la-Educacion-2025-.rar
- **formato:** rar
- **detalle_tecnico:** Archivos anuales .rar, 2007-2025. url_descarga apunta al ano 2025, subido en 2025/08. El nombre del archivo trae un guion final antes de la extension, que es parte de la URL.
- **unidad_de_analisis:** Docente o asistente
- **llaves_de_union:** NA
- **desagregacion_territorial:** Establecimiento
- **cobertura_temporal:** 2007-2025
- **periodicidad:** Anual
- **mes_publicacion:** NA
- **datos_personales:** NA
- **documentacion_tecnica:** NA
- **condiciones_de_uso:** NA
- **usos_en_monitoreo:** Dotacion de asistentes de la educacion por establecimiento.
- **estado_verificacion:** Verificada
- **fecha_verificacion:** 2026-07-30
- **observaciones:** No publica esquema de registros. Solicitud registrada.
- **copia_local:** NA
- **fuente_equivalente:** NA

### 2.1 Gestion institucional del SLEP

#### F007 <c2><b7> Directorio de establecimientos educacionales

- **ambito_monitoreo:** 2. SLEP
- **subambito:** 2.1 Gestion institucional del SLEP
- **descripcion:** Directorios de establecimientos educacionales del pais desde 1992 en adelante.
- **variables:** AGNO; RBD; DGV_RBD; NOM_RBD; MRUN; RUT_SOSTENEDOR; P_JURIDICA; COD_REG_RBD; NOM_REG_RBD_A; COD_PRO_RBD; COD_COM_RBD; NOM_COM_RBD; COD_DEPROV_RBD; NOM_DEPROV_RBD; COD_DEPE; COD_DEPE2; RURAL_RBD; LATITUD; LONGITUD; CONVENIO_PIE; PACE; ENS_01 a ENS_11; MAT_ENS_1 a MAT_ENS_8; MAT_TOTAL; MATRICULA; ESTADO_ESTAB; ORI_RELIGIOSA; ORI_OTRO_GLOSA; PAGO_MATRICULA; PAGO_MENSUAL; ESPE_01 a ESPE_11
- **base_datos:** Datos Abiertos
- **emisor:** Centro de Estudios del Ministerio de Educacion (CEM)
- **via_de_acceso:** Portal de datos abiertos
- **nivel_acceso:** Abierto
- **url_referencia:** https://datosabiertos.mineduc.cl/directorio-de-establecimientos-educacionales/
- **url_descarga:** https://datosabiertos.mineduc.cl/wp-content/uploads/2025/11/Directorio-Oficial-EE-2025.rar
- **formato:** rar; csv; zip
- **detalle_tecnico:** El formato cambia por rango de anos: .rar en 1992-1997 y 2013-2025; .csv en 2004-2012; .zip en 1998-2003. url_descarga apunta al ano 2025. Los anos en .csv viven bajo otra carpeta y otra grafia (ejemplo 2004: /wp-content/uploads/2021/12/Directorio_oficial_EE_2004.csv), de modo que ni el nombre ni la ruta siguen patron: cada ano exige leer su enlace en la pagina. La copia local del ano 2025 es .csv de 3,6 MB, separador punto y coma, cabecera en UTF-8 con marca de orden de bytes (BOM), 58 columnas. Los bloques ENS_, MAT_ENS_ y ESPE_ se abrevian arriba por rango.
- **unidad_de_analisis:** Establecimiento
- **llaves_de_union:** RBD; AGNO; COD_COM_RBD
- **desagregacion_territorial:** Establecimiento
- **cobertura_temporal:** 1992-2025
- **periodicidad:** Anual
- **mes_publicacion:** NA
- **datos_personales:** RUT o identificador directo
- **documentacion_tecnica:** Glosas del directorio oficial, glosas_directorio_oficial_ee.pdf, presentes en la copia local
- **condiciones_de_uso:** NA
- **usos_en_monitoreo:** Universo de establecimientos con RBD, dependencia y ubicacion; tabla maestra de cruce territorial.
- **estado_verificacion:** Verificada
- **fecha_verificacion:** 2026-07-30
- **observaciones:** Unica fuente con formato mixto por rango de anos, declarado en detalle_tecnico segun la enmienda E1. Resuelta en la segunda pasada de doble fuente. ATENCION DE GOBERNANZA: trae RUT_SOSTENEDOR sin enmascarar, ademas de MRUN; es la unica fuente del catalogo con identificador directo de persona, y su tratamiento cae bajo la politica de gobernanza de datos del proyecto.
- **copia_local:** slep_seguimiento_educacion_inicial
- **fuente_equivalente:** NA

#### F008 <c2><b7> Subvenciones a establecimientos educacionales

- **ambito_monitoreo:** 2. SLEP
- **subambito:** 2.1 Gestion institucional del SLEP
- **descripcion:** Bases de subvenciones y asignaciones otorgadas a establecimientos educacionales desde 2005 en adelante.
- **variables:** NA
- **base_datos:** Datos Abiertos
- **emisor:** Centro de Estudios del Ministerio de Educacion (CEM)
- **via_de_acceso:** Portal de datos abiertos
- **nivel_acceso:** Abierto
- **url_referencia:** https://datosabiertos.mineduc.cl/subvenciones-a-establecimientos-educacionales/
- **url_descarga:** https://datosabiertos.mineduc.cl/wp-content/uploads/2026/06/Subvenciones-a-EE-2025.rar
- **formato:** rar; zip
- **detalle_tecnico:** Un archivo por ano calendario, .rar y .zip, 2005-2025. url_descarga apunta al ano 2025, subido en 2026/06. La carpeta de subida varia por ano, de modo que la serie exige leer cada enlace en la pagina.
- **unidad_de_analisis:** Establecimiento
- **llaves_de_union:** NA
- **desagregacion_territorial:** Establecimiento
- **cobertura_temporal:** 2005-2025
- **periodicidad:** Anual
- **mes_publicacion:** NA
- **datos_personales:** Sin datos de personas
- **documentacion_tecnica:** NA
- **condiciones_de_uso:** NA
- **usos_en_monitoreo:** Montos de subvencion por establecimiento; insumo financiero del territorio.
- **estado_verificacion:** Verificada
- **fecha_verificacion:** 2026-07-30
- **observaciones:** La pagina declara archivos anuales pero no declara periodicidad de publicacion; el valor Anual se toma del formato de los archivos y se anota aqui. No publica esquema de registros. Solicitud registrada.
- **copia_local:** NA
- **fuente_equivalente:** NA

#### F023 <c2><b7> Directorio de sostenedores

- **ambito_monitoreo:** 2. SLEP
- **subambito:** 2.1 Gestion institucional del SLEP
- **descripcion:** NA
- **variables:** NA
- **base_datos:** Datos Abiertos
- **emisor:** Centro de Estudios del Ministerio de Educacion (CEM)
- **via_de_acceso:** Portal de datos abiertos
- **nivel_acceso:** Abierto
- **url_referencia:** https://datosabiertos.mineduc.cl/
- **url_descarga:** NA
- **formato:** NA
- **detalle_tecnico:** NA
- **unidad_de_analisis:** NA
- **llaves_de_union:** NA
- **desagregacion_territorial:** NA
- **cobertura_temporal:** NA
- **periodicidad:** NA
- **mes_publicacion:** NA
- **datos_personales:** NA
- **documentacion_tecnica:** NA
- **condiciones_de_uso:** NA
- **usos_en_monitoreo:** Universo de sostenedores; contraparte institucional del directorio de establecimientos.
- **estado_verificacion:** Declarada sin verificar
- **fecha_verificacion:** NA
- **observaciones:** Listada en la seccion Sostenedores del portal y ausente del reconocimiento. Pendiente de verificacion en una pasada posterior.
- **copia_local:** NA
- **fuente_equivalente:** NA

#### F058 <c2><b7> Organizacion Superintendencia de Educacion en datos.gob.cl

- **ambito_monitoreo:** 2. SLEP
- **subambito:** 2.1 Gestion institucional del SLEP
- **descripcion:** Organizacion del portal nacional de datos abiertos con tres conjuntos de la Superintendencia: denuncias, solicitudes de mediacion y procesos administrativos sancionatorios.
- **variables:** NA
- **base_datos:** datos.gob.cl
- **emisor:** Superintendencia de Educacion (SIE)
- **via_de_acceso:** Portal de datos abiertos
- **nivel_acceso:** Abierto
- **url_referencia:** https://datos.gob.cl/organization/superintendencia-de-educacion
- **url_descarga:** NA
- **formato:** csv
- **detalle_tecnico:** Publica 3 conjuntos, los tres en CSV. Las tres fichas se actualizaron el 2024-07-01.
- **unidad_de_analisis:** NA
- **llaves_de_union:** NA
- **desagregacion_territorial:** Nacional
- **cobertura_temporal:** NA
- **periodicidad:** Sin periodicidad definida
- **mes_publicacion:** NA
- **datos_personales:** Sin datos de personas
- **documentacion_tecnica:** NA
- **condiciones_de_uso:** Creative Commons Attribution (CC-BY) en los 3 conjuntos
- **usos_en_monitoreo:** Denuncias y mediaciones como senal de convivencia escolar en el territorio.
- **estado_verificacion:** Verificada
- **fecha_verificacion:** 2026-07-30
- **observaciones:** Es la pagina que sostiene a F059, F060 y F061: sus fichas individuales no rinden, y los formatos, licencias y fechas de esos tres conjuntos se tomaron de aqui, que si se leyo.
- **copia_local:** NA
- **fuente_equivalente:** NA

#### F061 <c2><b7> Procesos administrativos sancionatorios

- **ambito_monitoreo:** 2. SLEP
- **subambito:** 2.1 Gestion institucional del SLEP
- **descripcion:** Registro de procesos administrativos sancionatorios de la ley 20.529, segun lo declara el reconocimiento.
- **variables:** NA
- **base_datos:** datos.gob.cl
- **emisor:** Superintendencia de Educacion (SIE)
- **via_de_acceso:** Portal de datos abiertos
- **nivel_acceso:** Abierto
- **url_referencia:** https://datos.gob.cl/dataset/procesos-administrativos-sancionatorios
- **url_descarga:** NA
- **formato:** csv
- **detalle_tecnico:** Formato y licencia tomados de la pagina de organizacion (F058). Ultima actualizacion declarada alli: 2024-07-01.
- **unidad_de_analisis:** Establecimiento
- **llaves_de_union:** NA
- **desagregacion_territorial:** Region
- **cobertura_temporal:** NA
- **periodicidad:** Sin periodicidad definida
- **mes_publicacion:** NA
- **datos_personales:** NA
- **documentacion_tecnica:** NA
- **condiciones_de_uso:** Creative Commons Attribution (CC-BY)
- **usos_en_monitoreo:** Sanciones por establecimiento; riesgo normativo del sostenedor.
- **estado_verificacion:** URL viva sin descarga confirmada
- **fecha_verificacion:** 2026-07-30
- **observaciones:** Misma falla que F059 y F060: la ficha del conjunto devuelve la portada del portal. Solicitud registrada.
- **copia_local:** NA
- **fuente_equivalente:** NA

#### F062 <c2><b7> Portal de Datos Abiertos institucional de la Superintendencia

- **ambito_monitoreo:** 2. SLEP
- **subambito:** 2.1 Gestion institucional del SLEP
- **descripcion:** Portal propio de datos abiertos de la Superintendencia de Educacion, con registros y estadisticas de denuncias, mediaciones y sanciones, segun lo declara el reconocimiento.
- **variables:** NA
- **base_datos:** Portal institucional
- **emisor:** Superintendencia de Educacion (SIE)
- **via_de_acceso:** Portal de datos abiertos
- **nivel_acceso:** Abierto
- **url_referencia:** NA
- **url_descarga:** NA
- **formato:** NA
- **detalle_tecnico:** NA
- **unidad_de_analisis:** NA
- **llaves_de_union:** NA
- **desagregacion_territorial:** NA
- **cobertura_temporal:** NA
- **periodicidad:** Sin periodicidad definida
- **mes_publicacion:** NA
- **datos_personales:** NA
- **documentacion_tecnica:** NA
- **condiciones_de_uso:** NA
- **usos_en_monitoreo:** Fuente institucional propia, potencialmente mas completa que los 3 conjuntos de datos.gob.cl.
- **estado_verificacion:** Declarada sin verificar
- **fecha_verificacion:** NA
- **observaciones:** El reconocimiento la registro como mencionada sin URL directa: la Superintendencia comunica un portal propio en supereduc.cl/datosabiertos cuya direccion exacta no se pudo confirmar. Es la sospecha 1 del reconocimiento y sigue abierta. Sin URL que abrir.
- **copia_local:** NA
- **fuente_equivalente:** NA

#### F080 <c2><b7> Sitio institucional de los Servicios Locales de Educacion Publica

- **ambito_monitoreo:** 2. SLEP
- **subambito:** 2.1 Gestion institucional del SLEP
- **descripcion:** Informacion institucional sobre los Servicios Locales de Educacion Publica: estructura, funciones, financiamiento, gobernanza y su relacion con municipios y el Ministerio de Educacion.
- **variables:** NA
- **base_datos:** Sitio institucional
- **emisor:** Direccion de Educacion Publica (DEP)
- **via_de_acceso:** Reporte en PDF
- **nivel_acceso:** Abierto
- **url_referencia:** https://dep.gob.cl/servicios-locales-de-educacion-publica/
- **url_descarga:** https://educacionpublica.gob.cl/wp-content/uploads/2022/06/ENEP-Pagina_.pdf
- **formato:** pdf; html
- **detalle_tecnico:** url_descarga apunta a la Primera Estrategia Nacional de Educacion Publica 2020-2028. Publica ademas orientaciones para la gestion de programas educativos, tambien en PDF.
- **unidad_de_analisis:** Sostenedor
- **llaves_de_union:** NA
- **desagregacion_territorial:** Nacional
- **cobertura_temporal:** 2020-2028 para la estrategia nacional
- **periodicidad:** Sin periodicidad definida
- **mes_publicacion:** NA
- **datos_personales:** Sin datos de personas
- **documentacion_tecnica:** NA
- **condiciones_de_uso:** NA
- **usos_en_monitoreo:** Marco normativo e institucional de la Nueva Educacion Publica en que opera el SLEP.
- **estado_verificacion:** Verificada
- **fecha_verificacion:** 2026-07-30
- **observaciones:** El dominio del reconocimiento (educacionpublica.gob.cl) redirige con 301 a dep.gob.cl: la Direccion de Educacion Publica migro de dominio. Se cataloga el destino. La migracion es parcial: los archivos PDF siguen sirviendose desde el dominio antiguo. El sitio declara 15 SLEP activos y no publica datos desagregados por servicio.
- **copia_local:** NA
- **fuente_equivalente:** NA

#### F083 <c2><b7> Cuenta publica y reportabilidad local de un Servicio Local

- **ambito_monitoreo:** 2. SLEP
- **subambito:** 2.1 Gestion institucional del SLEP
- **descripcion:** Plan Anual Local, Convenio de Gestion Educacional, metas y resultados publicados por un Servicio Local en su transparencia activa, segun lo declara el reconocimiento.
- **variables:** NA
- **base_datos:** Sitio institucional del Servicio Local
- **emisor:** Servicio Local de Educacion Publica (SLEP)
- **via_de_acceso:** Consulta web sin descarga
- **nivel_acceso:** Abierto
- **url_referencia:** https://slepsantiagocentro.gob.cl/
- **url_descarga:** NA
- **formato:** NA
- **detalle_tecnico:** NA
- **unidad_de_analisis:** Sostenedor
- **llaves_de_union:** NA
- **desagregacion_territorial:** Comuna
- **cobertura_temporal:** NA
- **periodicidad:** Anual
- **mes_publicacion:** NA
- **datos_personales:** Sin datos de personas
- **documentacion_tecnica:** NA
- **condiciones_de_uso:** NA
- **usos_en_monitoreo:** Modelo de reportabilidad local; referencia de que publica otro Servicio Local.
- **estado_verificacion:** URL viva sin descarga confirmada
- **fecha_verificacion:** 2026-07-30
- **observaciones:** El servidor devuelve HTTP 403 a la herramienta de consulta. El host respondio: no es un enlace roto. El reconocimiento inventario el sitio del SLEP Santiago Centro como ejemplo de reportabilidad local; no es el sitio del SLEP Costa Central. Solicitud registrada.
- **copia_local:** NA
- **fuente_equivalente:** NA

### 2.2 Dimension educativa de instrumentos de gestion

#### F021 <c2><b7> Planes de Mejoramiento Educativo (PME)

- **ambito_monitoreo:** 2. SLEP
- **subambito:** 2.2 Dimension educativa de instrumentos de gestion
- **descripcion:** NA
- **variables:** NA
- **base_datos:** Datos Abiertos
- **emisor:** Centro de Estudios del Ministerio de Educacion (CEM)
- **via_de_acceso:** Portal de datos abiertos
- **nivel_acceso:** Abierto
- **url_referencia:** https://datosabiertos.mineduc.cl/
- **url_descarga:** NA
- **formato:** NA
- **detalle_tecnico:** NA
- **unidad_de_analisis:** NA
- **llaves_de_union:** NA
- **desagregacion_territorial:** NA
- **cobertura_temporal:** NA
- **periodicidad:** NA
- **mes_publicacion:** NA
- **datos_personales:** NA
- **documentacion_tecnica:** NA
- **condiciones_de_uso:** NA
- **usos_en_monitoreo:** Instrumento de gestion educativa por establecimiento; dimension educativa del monitoreo.
- **estado_verificacion:** Declarada sin verificar
- **fecha_verificacion:** NA
- **observaciones:** Listada en la seccion Establecimientos del portal y ausente del reconocimiento. Pendiente de verificacion en una pasada posterior.
- **copia_local:** NA
- **fuente_equivalente:** NA

#### F022 <c2><b7> Sistema Nacional de Evaluacion del Desempeno (SNED)

- **ambito_monitoreo:** 2. SLEP
- **subambito:** 2.2 Dimension educativa de instrumentos de gestion
- **descripcion:** NA
- **variables:** NA
- **base_datos:** Datos Abiertos
- **emisor:** Centro de Estudios del Ministerio de Educacion (CEM)
- **via_de_acceso:** Portal de datos abiertos
- **nivel_acceso:** Abierto
- **url_referencia:** https://datosabiertos.mineduc.cl/
- **url_descarga:** NA
- **formato:** NA
- **detalle_tecnico:** NA
- **unidad_de_analisis:** NA
- **llaves_de_union:** NA
- **desagregacion_territorial:** NA
- **cobertura_temporal:** NA
- **periodicidad:** NA
- **mes_publicacion:** NA
- **datos_personales:** NA
- **documentacion_tecnica:** NA
- **condiciones_de_uso:** NA
- **usos_en_monitoreo:** Desempeno de establecimientos subvencionados; insumo de comparacion territorial.
- **estado_verificacion:** Declarada sin verificar
- **fecha_verificacion:** NA
- **observaciones:** Listada en la seccion Establecimientos del portal y ausente del reconocimiento. Pendiente de verificacion en una pasada posterior.
- **copia_local:** NA
- **fuente_equivalente:** NA

#### F081 <c2><b7> Convenios de desempeno FAEP

- **ambito_monitoreo:** 2. SLEP
- **subambito:** 2.2 Dimension educativa de instrumentos de gestion
- **descripcion:** Resoluciones exentas que aprueban los convenios de desempeno del Fondo de Apoyo a la Educacion Publica entre la Direccion de Educacion Publica y cada Servicio Local.
- **variables:** NA
- **base_datos:** Repositorio de resoluciones
- **emisor:** Direccion de Educacion Publica (DEP)
- **via_de_acceso:** Descarga directa desde sitio institucional
- **nivel_acceso:** Abierto
- **url_referencia:** https://dep.gob.cl/servicios-locales-de-educacion-publica/
- **url_descarga:** https://dep.gob.cl/wp-content/uploads/2025/08/REX-N%C2%B0177-APRUEBA-CONVENIO-DE-DESEMPENO-SLEP-ATACAMA-FAEP-2025.pdf
- **formato:** pdf
- **detalle_tecnico:** El ejemplo inventariado por el reconocimiento corresponde al SLEP Atacama, ano 2025. El archivo existe y pesa 4,3 MB, pero su texto no es extraible. No hay un indice de resoluciones: cada convenio se publica como archivo suelto.
- **unidad_de_analisis:** Sostenedor
- **llaves_de_union:** NA
- **desagregacion_territorial:** Nacional
- **cobertura_temporal:** 2025
- **periodicidad:** Anual
- **mes_publicacion:** NA
- **datos_personales:** Sin datos de personas
- **documentacion_tecnica:** NA
- **condiciones_de_uso:** NA
- **usos_en_monitoreo:** Metas comprometidas por cada Servicio Local; contraparte de la reportabilidad del Area.
- **estado_verificacion:** Verificada
- **fecha_verificacion:** 2026-07-30
- **observaciones:** Verificada en el sentido de que la URL responde y el archivo existe integro; su contenido no se pudo leer. La URL del reconocimiento redirige con 301 al mismo dominio nuevo dep.gob.cl. El convenio del SLEP Costa Central no esta inventariado: habria que ubicarlo por separado.
- **copia_local:** NA
- **fuente_equivalente:** NA

### 2.3 Indices, analisis y estudios

#### F082 <c2><b7> Informe Anual del Consejo de Evaluacion del Sistema de Educacion Publica

- **ambito_monitoreo:** 2. SLEP
- **subambito:** 2.3 Indices, analisis y estudios
- **descripcion:** Informe anual que evalua la implementacion del sistema de educacion publica y entrega recomendaciones para su consolidacion.
- **variables:** NA
- **base_datos:** Consejo de Evaluacion
- **emisor:** Direccion de Educacion Publica (DEP)
- **via_de_acceso:** Reporte en PDF
- **nivel_acceso:** Abierto
- **url_referencia:** https://dep.gob.cl/dep/informe-2025-del-consejo-de-evaluacion-releva-avances-en-la-implementacion-de-los-slep-y-entrega-recomendaciones-para-su-consolidacion/
- **url_descarga:** https://educacionpublica.gob.cl/wp-content/uploads/2026/03/Informe-Anual-2025-Consejo-Evaluador-del-Sistema-de-Educacion-Publica.pdf
- **formato:** pdf
- **detalle_tecnico:** Informe 2025 publicado el 4 de marzo de 2026. La pagina declara ocho informes anteriores, de 2018 a 2024. El PDF se sirve desde el dominio antiguo educacionpublica.gob.cl.
- **unidad_de_analisis:** Sostenedor
- **llaves_de_union:** NA
- **desagregacion_territorial:** Nacional
- **cobertura_temporal:** 2018-2025
- **periodicidad:** Anual
- **mes_publicacion:** NA
- **datos_personales:** Sin datos de personas
- **documentacion_tecnica:** NA
- **condiciones_de_uso:** NA
- **usos_en_monitoreo:** Evaluacion externa de la implementacion del sistema; contexto de la gestion del SLEP.
- **estado_verificacion:** Verificada
- **fecha_verificacion:** 2026-07-30
- **observaciones:** Serie anual completa de ocho informes previos mas el de 2025. La pagina declara 36 SLEP en regimen y 58 creados; esas cifras no se transcriben al catalogo por ser contenido del informe y no metadato de la fuente.
- **copia_local:** NA
- **fuente_equivalente:** NA

### 3.1 Contexto socioterritorial

#### F015 <c2><b7> Censo de Poblacion y Vivienda 2024, resultados

- **ambito_monitoreo:** 3. Contexto
- **subambito:** 3.1 Contexto socioterritorial
- **descripcion:** Portal de resultados del Censo 2024 con tableros de consulta de poblacion, viviendas y hogares, y procesamiento en linea de microdatos.
- **variables:** NA
- **base_datos:** Censo 2024
- **emisor:** Instituto Nacional de Estadisticas (INE)
- **via_de_acceso:** Consulta web sin descarga
- **nivel_acceso:** Abierto
- **url_referencia:** https://censo2024.ine.gob.cl/resultados/
- **url_descarga:** NA
- **formato:** pdf; sin descarga
- **detalle_tecnico:** La pagina ofrece descarga de una sintesis de resultados en PDF y consulta interactiva sin descarga. Los microdatos se procesan en linea con Redatam Web, que genera tabulados y graficos.
- **unidad_de_analisis:** Comuna
- **llaves_de_union:** NA
- **desagregacion_territorial:** Comuna
- **cobertura_temporal:** 2024
- **periodicidad:** Por evento
- **mes_publicacion:** NA
- **datos_personales:** Sin datos de personas
- **documentacion_tecnica:** NA
- **condiciones_de_uso:** Declara un enlace a terminos de uso y licencia de datos abiertos, cuyo contenido no se abrio
- **usos_en_monitoreo:** Base demografica del territorio para denominadores de cobertura escolar.
- **estado_verificacion:** Verificada
- **fecha_verificacion:** 2026-07-30
- **observaciones:** El visualizador llega a nivel de manzana y entidad censal. La pagina no publica las cifras de poblacion, viviendas ni hogares que el reconocimiento le atribuia: esas cifras no se transcriben al catalogo por no estar observadas en la pagina.
- **copia_local:** NA
- **fuente_equivalente:** NA

#### F025 <c2><b7> Geodatos abiertos y cartografia censal

- **ambito_monitoreo:** 3. Contexto
- **subambito:** 3.1 Contexto socioterritorial
- **descripcion:** Cartografia censal y division politico administrativa: limites regionales, provinciales, comunales, distritales y urbanos, manzana y entidad censal, mas capas de estadisticas vitales, permisos de edificacion, genero y migracion internacional.
- **variables:** NA
- **base_datos:** Geodatos Abiertos
- **emisor:** Instituto Nacional de Estadisticas (INE)
- **via_de_acceso:** Descarga directa desde sitio institucional
- **nivel_acceso:** Abierto
- **url_referencia:** https://www.ine.gob.cl/herramientas/portal-de-mapas/geodatos-abiertos
- **url_descarga:** NA
- **formato:** shapefile; zip
- **detalle_tecnico:** Capas en shapefile comprimido y geodatabase, mas puntos de servicio REST de ArcGIS. La pagina no expone enlaces directos de archivo en su HTML.
- **unidad_de_analisis:** Comuna
- **llaves_de_union:** NA
- **desagregacion_territorial:** Comuna
- **cobertura_temporal:** Censos 1970-2024; permisos de edificacion 2010-2020; registros administrativos 2011-2020
- **periodicidad:** Sin periodicidad definida
- **mes_publicacion:** NA
- **datos_personales:** Sin datos de personas
- **documentacion_tecnica:** Metodologia de georreferenciacion de permisos de edificacion
- **condiciones_de_uso:** Declara terminos de uso y licencia de datos abiertos, sin detalle en la pagina
- **usos_en_monitoreo:** Capas base para georreferenciar establecimientos y construir indicadores territoriales.
- **estado_verificacion:** Verificada
- **fecha_verificacion:** 2026-07-30
- **observaciones:** Es el portal desde el cual cuelga el conjunto de microdatos por manzana de F026, cuya URL directa esta rota. Unica via viva observada para ese material.
- **copia_local:** NA
- **fuente_equivalente:** NA

#### F026 <c2><b7> Microdatos del Censo 2017 a nivel de manzana

- **ambito_monitoreo:** 3. Contexto
- **subambito:** 3.1 Contexto socioterritorial
- **descripcion:** Microdatos censales agregados a nivel de manzana, publicados como conjunto en el portal ArcGIS Open Data del INE.
- **variables:** NA
- **base_datos:** Portal ArcGIS Open Data
- **emisor:** Instituto Nacional de Estadisticas (INE)
- **via_de_acceso:** Descarga directa desde sitio institucional
- **nivel_acceso:** Abierto
- **url_referencia:** https://geoine-ine-chile.opendata.arcgis.com/datasets/54e0c40680054efaabeb9d53b09e1e7a_0
- **url_descarga:** NA
- **formato:** NA
- **detalle_tecnico:** NA
- **unidad_de_analisis:** NA
- **llaves_de_union:** NA
- **desagregacion_territorial:** NA
- **cobertura_temporal:** 2017
- **periodicidad:** Por evento
- **mes_publicacion:** NA
- **datos_personales:** Sin datos de personas
- **documentacion_tecnica:** NA
- **condiciones_de_uso:** NA
- **usos_en_monitoreo:** Caracterizacion socioeconomica del entorno inmediato de cada establecimiento.
- **estado_verificacion:** Enlace roto
- **fecha_verificacion:** 2026-07-30
- **observaciones:** El servidor devuelve HTTP 404. Se busco la URL vigente y no se encontro: los buscadores siguen indexando este mismo identificador como conjunto vivo, y la variante sin el sufijo de capa (hub.arcgis.com/datasets/54e0c40680054efaabeb9d53b09e1e7a) tambien devuelve 404. El 404 puede significar que el conjunto se retiro o que ArcGIS Hub no sirve contenido a un cliente que no sea navegador; con la evidencia disponible no se puede distinguir, y se registra el estado observado sin decidir la causa. Rutas alternativas anotadas para revision desde navegador: ine-chile.maps.arcgis.com/home/item.html?id=54e0c40680054efaabeb9d53b09e1e7a y el portal de geodatos abiertos (F025), que es la via viva confirmada.
- **copia_local:** NA
- **fuente_equivalente:** NA

#### F027 <c2><b7> Estimaciones y proyecciones de poblacion

- **ambito_monitoreo:** 3. Contexto
- **subambito:** 3.1 Contexto socioterritorial
- **descripcion:** Estimaciones y proyecciones de poblacion del pais, sus regiones y comunas, por area urbana y rural, construidas sobre supuestos de fecundidad, mortalidad y migracion.
- **variables:** NA
- **base_datos:** Demografia y vitales
- **emisor:** Instituto Nacional de Estadisticas (INE)
- **via_de_acceso:** Descarga directa desde sitio institucional
- **nivel_acceso:** Abierto
- **url_referencia:** https://www.ine.gob.cl/estadisticas/sociales/demografia-y-vitales/proyecciones-de-poblacion
- **url_descarga:** NA
- **formato:** pdf
- **detalle_tecnico:** En la pagina solo se observaron publicaciones en PDF (infografias y sintesis). El reconocimiento le atribuia formato xlsx, que no se observo como enlace en esta verificacion.
- **unidad_de_analisis:** Comuna
- **llaves_de_union:** NA
- **desagregacion_territorial:** Comuna
- **cobertura_temporal:** 1992-2050 base 2017 a nivel pais; 2002-2035 a nivel region y area
- **periodicidad:** Sin periodicidad definida
- **mes_publicacion:** NA
- **datos_personales:** Sin datos de personas
- **documentacion_tecnica:** Declara secciones de metodologias y metadatos, sin enlace observable en la pagina
- **condiciones_de_uso:** Declara terminos de uso y licencia de datos abiertos
- **usos_en_monitoreo:** Denominador poblacional para tasas de cobertura y de asistencia por comuna.
- **estado_verificacion:** Verificada
- **fecha_verificacion:** 2026-07-30
- **observaciones:** Discrepancia con el reconocimiento, que declaraba xlsx: en la pagina solo se observaron PDF. Los archivos de datos, si existen, no estan expuestos como enlace en el HTML. Solicitud registrada.
- **copia_local:** NA
- **fuente_equivalente:** NA

#### F028 <c2><b7> Banco de datos de la Encuesta Nacional de Empleo

- **ambito_monitoreo:** 3. Contexto
- **subambito:** 3.1 Contexto socioterritorial
- **descripcion:** Sistema de consulta que permite cruces dinamicos sobre los microdatos de la Encuesta Nacional de Empleo desde el trimestre enero-marzo de 2010.
- **variables:** NA
- **base_datos:** Banco de datos ENE
- **emisor:** Instituto Nacional de Estadisticas (INE)
- **via_de_acceso:** Sistema con credenciales
- **nivel_acceso:** Abierto con registro
- **url_referencia:** https://bancodatosene.ine.cl/
- **url_descarga:** NA
- **formato:** sin descarga
- **detalle_tecnico:** Exige cuenta con correo y contrasena; el registro pide RUT, nombre, correo, tipo de institucion y rol. Ofrece una funcion de exportar datos cuyo formato no se declara. Serie recalibrada con proyecciones del Censo 2017; las calibraciones con Censo 2002 se conservan hasta diciembre de 2019.
- **unidad_de_analisis:** Nacional
- **llaves_de_union:** NA
- **desagregacion_territorial:** Region
- **cobertura_temporal:** 2010 en adelante, por trimestre movil
- **periodicidad:** Trimestral
- **mes_publicacion:** NA
- **datos_personales:** Sin datos de personas
- **documentacion_tecnica:** Diccionario de variables, cuestionario y preguntas frecuentes, los tres en PDF
- **condiciones_de_uso:** NA
- **usos_en_monitoreo:** Contexto laboral del territorio; ocupacion y desocupacion como determinantes de trayectoria escolar.
- **estado_verificacion:** Verificada
- **fecha_verificacion:** 2026-07-30
- **observaciones:** Unica fuente de los dos tramos que publica diccionario de variables. El registro exige RUT del solicitante, dato personal del funcionario que se inscribe, no de terceros.
- **copia_local:** NA
- **fuente_equivalente:** NA

#### F029 <c2><b7> Organizacion Instituto Nacional de Estadisticas en datos.gob.cl

- **ambito_monitoreo:** 3. Contexto
- **subambito:** 3.1 Contexto socioterritorial
- **descripcion:** Organizacion del portal nacional de datos abiertos que agrupa 63 conjuntos del INE: encuestas estructurales de servicios, comercio y transporte, entre otras.
- **variables:** NA
- **base_datos:** datos.gob.cl
- **emisor:** Instituto Nacional de Estadisticas (INE)
- **via_de_acceso:** Portal de datos abiertos
- **nivel_acceso:** Abierto
- **url_referencia:** https://datos.gob.cl/organization/instituto_nacional_de_estadisticas
- **url_descarga:** NA
- **formato:** html
- **detalle_tecnico:** Publica 63 conjuntos. El portal declara explicitamente que no hay formatos que coincidan con la busqueda, de modo que los formatos por conjunto no son observables desde la pagina de la organizacion.
- **unidad_de_analisis:** NA
- **llaves_de_union:** NA
- **desagregacion_territorial:** Nacional
- **cobertura_temporal:** NA
- **periodicidad:** Sin periodicidad definida
- **mes_publicacion:** NA
- **datos_personales:** Sin datos de personas
- **documentacion_tecnica:** NA
- **condiciones_de_uso:** Creative Commons Non-Commercial en los 63 conjuntos
- **usos_en_monitoreo:** Via alternativa a las encuestas del INE, con licencia declarada.
- **estado_verificacion:** Verificada
- **fecha_verificacion:** 2026-07-30
- **observaciones:** Ultima actualizacion mas reciente observada: 2021-10-12, casi cinco anos atras, lo que sugiere una organizacion poco mantenida frente al sitio propio del INE. Sus 63 conjuntos no se catalogan como filas propias (enmienda E7): no se observo aporte por conjunto frente a la fuente primaria.
- **copia_local:** NA
- **fuente_equivalente:** NA

#### F030 <c2><b7> Encuesta de Caracterizacion Socioeconomica Nacional (Casen)

- **ambito_monitoreo:** 3. Contexto
- **subambito:** 3.1 Contexto socioterritorial
- **descripcion:** Bases de datos de la encuesta Casen, con series historicas de pobreza, ingresos y caracterizacion socioeconomica de los hogares.
- **variables:** NA
- **base_datos:** Observatorio Social
- **emisor:** Ministerio de Desarrollo Social y Familia (MDSF)
- **via_de_acceso:** Descarga directa desde sitio institucional
- **nivel_acceso:** Abierto
- **url_referencia:** https://observatorio.ministeriodesarrollosocial.gob.cl/encuesta-casen
- **url_descarga:** NA
- **formato:** NA
- **detalle_tecnico:** La pagina remite a la seccion Base de Datos de cada ano, sin exponer enlaces directos de archivo ni declarar formatos.
- **unidad_de_analisis:** Nacional
- **llaves_de_union:** NA
- **desagregacion_territorial:** Region
- **cobertura_temporal:** 1990, 1992, 1994, 1996, 1998, 2000, 2003, 2006, 2009, 2011, 2013, 2015, 2017, 2020, 2022, 2024
- **periodicidad:** Sin periodicidad definida
- **mes_publicacion:** NA
- **datos_personales:** NA
- **documentacion_tecnica:** NA
- **condiciones_de_uso:** No declara licencia; solo politica de privacidad
- **usos_en_monitoreo:** Caracterizacion socioeconomica del territorio; pobreza comunal como contexto de la trayectoria escolar.
- **estado_verificacion:** Verificada
- **fecha_verificacion:** 2026-07-30
- **observaciones:** El reconocimiento declaraba un libro de codigos de 2017 como documentacion asociada; en esta verificacion no se observo enlace a libro de codigos, manual ni cuestionario. PENDIENTE DE VOCABULARIO: la serie declarada en la pagina es bienal desde 1990 con irregularidades (saltos de tres anos entre 2000 y 2009), pero el vocabulario controlado de periodicidad no admite el valor Bienal. Se usa Sin periodicidad definida, que es el valor legal mas cercano, y se deja el patron real declarado aqui. Agregar Bienal al vocabulario es decision del titular, no del asistente.
- **copia_local:** NA
- **fuente_equivalente:** F031; F033; F034

#### F031 <c2><b7> Banco Integrado de Datos (BIDAT)

- **ambito_monitoreo:** 3. Contexto
- **subambito:** 3.1 Contexto socioterritorial
- **descripcion:** Repositorio centralizado de datos sociales y de inversion publica: encuestas del Observatorio Social, Registro Social de Hogares, pobreza comunal, canasta basica de alimentos, vulnerabilidad socioterritorial y programas sociales.
- **variables:** NA
- **base_datos:** BIDAT
- **emisor:** Ministerio de Desarrollo Social y Familia (MDSF)
- **via_de_acceso:** Portal de datos abiertos
- **nivel_acceso:** Abierto
- **url_referencia:** https://bidat.gob.cl/
- **url_descarga:** NA
- **formato:** csv; xlsx; pdf; shapefile; zip
- **detalle_tecnico:** Ofrece ademas formatos estadisticos propietarios no cubiertos por el vocabulario del esquema: STATA (.dta), R (.rdata) y SPSS (.sav). Los mapas en shapefile requieren conversion a .zip. Sitio servido como HTML, no como aplicacion JavaScript.
- **unidad_de_analisis:** Comuna
- **llaves_de_union:** NA
- **desagregacion_territorial:** Comuna
- **cobertura_temporal:** NA
- **periodicidad:** Sin periodicidad definida
- **mes_publicacion:** NA
- **datos_personales:** NA
- **documentacion_tecnica:** Declara glosario y centro de ayuda, sin enlace a documentacion tecnica
- **condiciones_de_uso:** Remite a una pagina de terminos de uso, sin licencia declarada en la portada
- **usos_en_monitoreo:** Punto de acceso real a los datos del Registro Social de Hogares y a la pobreza comunal.
- **estado_verificacion:** Verificada
- **fecha_verificacion:** 2026-07-30
- **observaciones:** Republicacion que SI genera fila propia bajo la enmienda E7: aporta formatos que la fuente primaria no da (.dta, .rdata, .sav y shapefile) y agrega conjuntos que Casen por si sola no cubre. El acceso al Registro de Informacion Social exige afiliacion institucional; el resto del portal es abierto.
- **copia_local:** NA
- **fuente_equivalente:** F030; F033; F034

#### F032 <c2><b7> Indicadores territoriales del Observatorio Social

- **ambito_monitoreo:** 3. Contexto
- **subambito:** 3.1 Contexto socioterritorial
- **descripcion:** Reportes comunales de caracterizacion social y estimaciones de pobreza comunal, segun lo declara el reconocimiento.
- **variables:** NA
- **base_datos:** Observatorio Social
- **emisor:** Ministerio de Desarrollo Social y Familia (MDSF)
- **via_de_acceso:** Consulta web sin descarga
- **nivel_acceso:** Abierto
- **url_referencia:** http://observatorio.ministeriodesarrollosocial.gob.cl/indicadores/
- **url_descarga:** NA
- **formato:** NA
- **detalle_tecnico:** NA
- **unidad_de_analisis:** Comuna
- **llaves_de_union:** NA
- **desagregacion_territorial:** Comuna
- **cobertura_temporal:** NA
- **periodicidad:** Sin periodicidad definida
- **mes_publicacion:** NA
- **datos_personales:** NA
- **documentacion_tecnica:** NA
- **condiciones_de_uso:** NA
- **usos_en_monitoreo:** Reportes comunales listos para caracterizar el territorio sin procesar microdatos.
- **estado_verificacion:** URL viva sin descarga confirmada
- **fecha_verificacion:** 2026-07-30
- **observaciones:** El servidor devuelve HTTP 403 a la herramienta de consulta. El host respondio, de modo que no es un enlace roto: lo mas probable es que un navegador humano si alcance la pagina. Contenido no verificado. Solicitud registrada.
- **copia_local:** NA
- **fuente_equivalente:** NA

#### F033 <c2><b7> Consulta interactiva de datos Casen (Redatam)

- **ambito_monitoreo:** 3. Contexto
- **subambito:** 3.1 Contexto socioterritorial
- **descripcion:** Herramienta de consulta interactiva del Observatorio Social que genera tabulados y mapas tematicos de Casen en linea.
- **variables:** NA
- **base_datos:** Redatam
- **emisor:** Ministerio de Desarrollo Social y Familia (MDSF)
- **via_de_acceso:** Consulta web sin descarga
- **nivel_acceso:** Abierto
- **url_referencia:** https://redatam.org/redchl/mds/casen/
- **url_descarga:** NA
- **formato:** sin descarga
- **detalle_tecnico:** Aplicacion de servidor Redatam. Solo se obtuvo el encabezado de la pagina; el resto exige interaccion.
- **unidad_de_analisis:** Nacional
- **llaves_de_union:** NA
- **desagregacion_territorial:** Comuna
- **cobertura_temporal:** NA
- **periodicidad:** Sin periodicidad definida
- **mes_publicacion:** NA
- **datos_personales:** NA
- **documentacion_tecnica:** NA
- **condiciones_de_uso:** NA
- **usos_en_monitoreo:** Tabulados de Casen sin descargar ni procesar microdatos.
- **estado_verificacion:** URL viva sin descarga confirmada
- **fecha_verificacion:** 2026-07-30
- **observaciones:** La pagina responde pero entrega solo su encabezado: los anos cubiertos, la desagregacion y el requisito de registro no son observables sin interactuar con la aplicacion. Solicitud registrada.
- **copia_local:** NA
- **fuente_equivalente:** F030; F031; F034

#### F034 <c2><b7> Data Social, catalogo Casen

- **ambito_monitoreo:** 3. Contexto
- **subambito:** 3.1 Contexto socioterritorial
- **descripcion:** Series historicas de indicadores sociales de Casen, segun lo declara el reconocimiento.
- **variables:** NA
- **base_datos:** Data Social
- **emisor:** Ministerio de Desarrollo Social y Familia (MDSF)
- **via_de_acceso:** Consulta web sin descarga
- **nivel_acceso:** Abierto
- **url_referencia:** https://datasocial.ministeriodesarrollosocial.gob.cl/catalogo/casen
- **url_descarga:** NA
- **formato:** NA
- **detalle_tecnico:** NA
- **unidad_de_analisis:** NA
- **llaves_de_union:** NA
- **desagregacion_territorial:** NA
- **cobertura_temporal:** NA
- **periodicidad:** Sin periodicidad definida
- **mes_publicacion:** NA
- **datos_personales:** NA
- **documentacion_tecnica:** NA
- **condiciones_de_uso:** NA
- **usos_en_monitoreo:** Series de indicadores sociales ya calculadas.
- **estado_verificacion:** No encontrada
- **fecha_verificacion:** 2026-07-30
- **observaciones:** El dominio datasocial.ministeriodesarrollosocial.gob.cl no resuelve en DNS. No es un 404 dentro de un sitio vivo: el host no existe. El servicio parece haber sido retirado o absorbido por BIDAT (F031), que el propio reconocimiento describe como sucesor operativo del Observatorio Social.
- **copia_local:** NA
- **fuente_equivalente:** F030; F031; F033

#### F035 <c2><b7> Registro Social de Hogares

- **ambito_monitoreo:** 3. Contexto
- **subambito:** 3.1 Contexto socioterritorial
- **descripcion:** Portal del Registro Social de Hogares: entrega la cartola con la calificacion socioeconomica del hogar y gestiona solicitudes de ingreso, actualizacion y rectificacion.
- **variables:** NA
- **base_datos:** Registro Social de Hogares
- **emisor:** Ministerio de Desarrollo Social y Familia (MDSF)
- **via_de_acceso:** Sistema con credenciales
- **nivel_acceso:** Institucional mediado
- **url_referencia:** https://www.registrosocial.gob.cl/
- **url_descarga:** NA
- **formato:** sin descarga
- **detalle_tecnico:** Exige autenticacion; la pagina no declara cual es el metodo. Entrega la cartola del hogar, no bases de datos.
- **unidad_de_analisis:** NA
- **llaves_de_union:** NA
- **desagregacion_territorial:** NA
- **cobertura_temporal:** NA
- **periodicidad:** Sin periodicidad definida
- **mes_publicacion:** NA
- **datos_personales:** Datos personales sensibles
- **documentacion_tecnica:** Publica documentos, protocolos, material audiovisual e infografias
- **condiciones_de_uso:** NA
- **usos_en_monitoreo:** Tramo de calificacion socioeconomica del hogar, consultable caso a caso.
- **estado_verificacion:** Verificada
- **fecha_verificacion:** 2026-07-30
- **observaciones:** No publica estadisticas agregadas ni bases descargables: los datos del Registro Social de Hogares en formato de base viven en BIDAT (F031), como ya advertia el reconocimiento. No es equivalente de F031: aqui se consulta un hogar, alla se descarga una base.
- **copia_local:** NA
- **fuente_equivalente:** NA

#### F036 <c2><b7> Portal del Departamento de Estadisticas e Informacion de Salud

- **ambito_monitoreo:** 3. Contexto
- **subambito:** 3.1 Contexto socioterritorial
- **descripcion:** Portal de estadisticas de salud: estadisticas vitales, egresos hospitalarios, urgencias, vacunacion y defunciones, segun lo declara el reconocimiento.
- **variables:** NA
- **base_datos:** DEIS
- **emisor:** Departamento de Estadisticas e Informacion de Salud (DEIS)
- **via_de_acceso:** Portal de datos abiertos
- **nivel_acceso:** Abierto
- **url_referencia:** https://deis.minsal.cl/
- **url_descarga:** NA
- **formato:** NA
- **detalle_tecnico:** NA
- **unidad_de_analisis:** NA
- **llaves_de_union:** NA
- **desagregacion_territorial:** Comuna
- **cobertura_temporal:** NA
- **periodicidad:** Sin periodicidad definida
- **mes_publicacion:** NA
- **datos_personales:** NA
- **documentacion_tecnica:** NA
- **condiciones_de_uso:** NA
- **usos_en_monitoreo:** Contexto de salud del territorio escolar.
- **estado_verificacion:** URL viva sin descarga confirmada
- **fecha_verificacion:** 2026-07-30
- **observaciones:** El servidor devuelve HTTP 403 a la herramienta de consulta. El host respondio: no es un enlace roto. El reconocimiento ya advertia que el sitio combina secciones nuevas y antiguas y sugeria una migracion en curso; conviene verificar estabilidad de URLs desde navegador. Solicitud registrada.
- **copia_local:** NA
- **fuente_equivalente:** NA

#### F037 <c2><b7> Organizacion Ministerio de Salud en datos.gob.cl

- **ambito_monitoreo:** 3. Contexto
- **subambito:** 3.1 Contexto socioterritorial
- **descripcion:** Organizacion del portal nacional de datos abiertos con 10 conjuntos del sector salud: urgencias respiratorias por semana epidemiologica, establecimientos de salud, defunciones, hospitalizacion y notificaciones ENO.
- **variables:** NA
- **base_datos:** datos.gob.cl
- **emisor:** Departamento de Estadisticas e Informacion de Salud (DEIS)
- **via_de_acceso:** Portal de datos abiertos
- **nivel_acceso:** Abierto
- **url_referencia:** https://datos.gob.cl/organization/ministerio_de_salud
- **url_descarga:** NA
- **formato:** csv; xlsx; pdf; json; zip
- **detalle_tecnico:** Publica 10 conjuntos. Declara ademas formatos estadisticos propietarios fuera del vocabulario del esquema: STATA (.dta), R (.rdata), SPSS (.sav) y Parquet.
- **unidad_de_analisis:** Comuna
- **llaves_de_union:** NA
- **desagregacion_territorial:** Region
- **cobertura_temporal:** NA
- **periodicidad:** Semanal
- **mes_publicacion:** NA
- **datos_personales:** Sin datos de personas
- **documentacion_tecnica:** NA
- **condiciones_de_uso:** Creative Commons: CCZero en 7 conjuntos, Non-Commercial en 2, Attribution en 1
- **usos_en_monitoreo:** Contexto sanitario del territorio; defunciones y urgencias como senal de contexto.
- **estado_verificacion:** Verificada
- **fecha_verificacion:** 2026-07-30
- **observaciones:** Actualizacion mas reciente observada: 2026-07-29, dos dias antes de esta verificacion. Es la via mas viva del DEIS frente a su portal propio (F036), que no fue inspeccionable. La periodicidad Semanal se toma de los conjuntos por semana epidemiologica y no de una declaracion global del portal.
- **copia_local:** NA
- **fuente_equivalente:** NA

#### F038 <c2><b7> Repositorio DEIS de indicadores basicos de salud

- **ambito_monitoreo:** 3. Contexto
- **subambito:** 3.1 Contexto socioterritorial
- **descripcion:** Indicadores basicos de salud por comuna, natalidad y mortalidad, segun lo declara el reconocimiento.
- **variables:** NA
- **base_datos:** Repositorio DEIS
- **emisor:** Departamento de Estadisticas e Informacion de Salud (DEIS)
- **via_de_acceso:** Descarga directa desde sitio institucional
- **nivel_acceso:** Abierto
- **url_referencia:** https://repositoriodeis.minsal.cl/
- **url_descarga:** NA
- **formato:** NA
- **detalle_tecnico:** NA
- **unidad_de_analisis:** Comuna
- **llaves_de_union:** NA
- **desagregacion_territorial:** Comuna
- **cobertura_temporal:** NA
- **periodicidad:** Sin periodicidad definida
- **mes_publicacion:** NA
- **datos_personales:** NA
- **documentacion_tecnica:** NA
- **condiciones_de_uso:** NA
- **usos_en_monitoreo:** Natalidad y mortalidad comunal como contexto demografico.
- **estado_verificacion:** URL viva sin descarga confirmada
- **fecha_verificacion:** 2026-07-30
- **observaciones:** El servidor devuelve HTTP 403 a la herramienta de consulta. El host respondio: no es un enlace roto. Solicitud registrada.
- **copia_local:** NA
- **fuente_equivalente:** NA

#### F041 <c2><b7> Datos abiertos de permisos de residencia y refugio

- **ambito_monitoreo:** 3. Contexto
- **subambito:** 3.1 Contexto socioterritorial
- **descripcion:** Bases estructuradas derivadas de registros administrativos de permisos de residencia temporal, residencia definitiva y solicitudes de refugio, desde el ano 2000.
- **variables:** NA
- **base_datos:** Datos abiertos SERMIG
- **emisor:** Servicio Nacional de Migraciones (SERMIG)
- **via_de_acceso:** Descarga directa desde sitio institucional
- **nivel_acceso:** Abierto
- **url_referencia:** https://serviciomigraciones.cl/en/migration-studies/open-data/
- **url_descarga:** https://serviciomigraciones.cl/wp-content/uploads/estudios/Datos-abiertos/RT/RT_Acogidas_2000_1er_semestre_2026.xlsx
- **formato:** xlsx; zip
- **detalle_tecnico:** Publica ocho libros .xlsx en cuatro pares de datos mas metadatos: residencia temporal acogidas y resueltas, residencia definitiva acogidas y resueltas. El refugio va aparte, como .zip con informe y base. url_descarga apunta al par de residencia temporal acogidas.
- **unidad_de_analisis:** Nacional
- **llaves_de_union:** NA
- **desagregacion_territorial:** Nacional
- **cobertura_temporal:** 2000 al primer semestre de 2026
- **periodicidad:** Semestral
- **mes_publicacion:** NA
- **datos_personales:** NA
- **documentacion_tecnica:** Un libro de metadatos .xlsx por cada base, publicado junto al dato
- **condiciones_de_uso:** No declara licencia
- **usos_en_monitoreo:** Poblacion migrante como contexto de la matricula del territorio.
- **estado_verificacion:** Verificada
- **fecha_verificacion:** 2026-07-30
- **observaciones:** Unica fuente de los tres tramos que publica un archivo de metadatos junto a cada base. Esos metadatos son la via para poblar variables sin descargar el dato mismo; se piden como solicitud. Actualizacion mas reciente declarada: 7 de enero de 2026. La pagina no declara desagregacion territorial.
- **copia_local:** NA
- **fuente_equivalente:** NA

#### F042 <c2><b7> Reportes demograficos de poblacion migrante

- **ambito_monitoreo:** 3. Contexto
- **subambito:** 3.1 Contexto socioterritorial
- **descripcion:** Reportes de demografia de la poblacion migrante por continente de origen, region y comuna, construidos sobre el Censo 2024.
- **variables:** NA
- **base_datos:** Estudios migratorios
- **emisor:** Servicio Nacional de Migraciones (SERMIG)
- **via_de_acceso:** Reporte en PDF
- **nivel_acceso:** Abierto
- **url_referencia:** https://serviciomigraciones.cl/en/migration-studies/demography/
- **url_descarga:** NA
- **formato:** pdf; zip
- **detalle_tecnico:** Un PDF por cada una de las 16 regiones y por comuna, mas paquetes .zip por continente y una descarga masiva de todas las comunas. Los href completos no aparecen en el HTML: la pagina usa rutas relativas.
- **unidad_de_analisis:** Comuna
- **llaves_de_union:** NA
- **desagregacion_territorial:** Comuna
- **cobertura_temporal:** 2024
- **periodicidad:** Por evento
- **mes_publicacion:** NA
- **datos_personales:** Sin datos de personas
- **documentacion_tecnica:** NA
- **condiciones_de_uso:** No declara licencia
- **usos_en_monitoreo:** Caracterizacion de la poblacion migrante por comuna del territorio.
- **estado_verificacion:** Verificada
- **fecha_verificacion:** 2026-07-30
- **observaciones:** Ultima actualizacion declarada: 1 de julio de 2025. Es la contraparte agregada de F041, que entrega el dato en bruto.
- **copia_local:** NA
- **fuente_equivalente:** NA

#### F044 <c2><b7> Estadisticas delictuales por comuna

- **ambito_monitoreo:** 3. Contexto
- **subambito:** 3.1 Contexto socioterritorial
- **descripcion:** Casos policiales conocidos por las policias para distintos grupos delictuales, con totales nacionales, por region, provincia y comuna.
- **variables:** NA
- **base_datos:** CEAD
- **emisor:** Subsecretaria de Prevencion del Delito
- **via_de_acceso:** Consulta web sin descarga
- **nivel_acceso:** Abierto
- **url_referencia:** https://cead.minsegpublica.gob.cl/estadisticas-delictuales/
- **url_descarga:** NA
- **formato:** sin descarga
- **detalle_tecnico:** Sistema interactivo con cortes anual, trimestral y mensual. Cubre el total nacional, 16 regiones, 54 provincias y cientos de comunas. La pagina no declara formatos de exportacion.
- **unidad_de_analisis:** Comuna
- **llaves_de_union:** NA
- **desagregacion_territorial:** Comuna
- **cobertura_temporal:** 2005-2026
- **periodicidad:** Mensual
- **mes_publicacion:** NA
- **datos_personales:** Sin datos de personas
- **documentacion_tecnica:** Notas tecnicas que explican la metodologia, incluido el calculo de poblacion con proyecciones del INE
- **condiciones_de_uso:** No declara licencia
- **usos_en_monitoreo:** Contexto de seguridad del territorio escolar.
- **estado_verificacion:** Verificada
- **fecha_verificacion:** 2026-07-30
- **observaciones:** El dominio del reconocimiento (cead.spd.gov.cl) NO resuelve en DNS. El propio reconocimiento anticipaba un espejo y pedia verificarlo: el espejo cead.minsegpublica.gob.cl si responde y es el que se cataloga en url_referencia. La sospecha 9 del reconocimiento queda resuelta y la advertencia de que era una aplicacion JavaScript no se confirmo: el sitio rinde como HTML.
- **copia_local:** NA
- **fuente_equivalente:** NA

#### F046 <c2><b7> Organizacion Servicio de Registro Civil e Identificacion en datos.gob.cl

- **ambito_monitoreo:** 3. Contexto
- **subambito:** 3.1 Contexto socioterritorial
- **descripcion:** Organizacion del portal nacional de datos abiertos con tres conjuntos: nombres mas comunes de ninos, no donantes y personas juridicas sin fines de lucro.
- **variables:** NA
- **base_datos:** datos.gob.cl
- **emisor:** Servicio de Registro Civil e Identificacion (SRCeI)
- **via_de_acceso:** Portal de datos abiertos
- **nivel_acceso:** Abierto
- **url_referencia:** https://datos.gob.cl/organization/servicio_de_registro_civil_e_identificacion
- **url_descarga:** NA
- **formato:** xlsx
- **detalle_tecnico:** Publica 3 conjuntos, los tres en formato xls.
- **unidad_de_analisis:** Nacional
- **llaves_de_union:** NA
- **desagregacion_territorial:** Nacional
- **cobertura_temporal:** NA
- **periodicidad:** Sin periodicidad definida
- **mes_publicacion:** NA
- **datos_personales:** Sin datos de personas
- **documentacion_tecnica:** NA
- **condiciones_de_uso:** Creative Commons Non-Commercial en los 3 conjuntos
- **usos_en_monitoreo:** Aporte marginal al monitoreo: ninguno de los tres conjuntos es de uso educativo directo.
- **estado_verificacion:** Verificada
- **fecha_verificacion:** 2026-07-30
- **observaciones:** Discrepancia grande con el reconocimiento, que le atribuia nacimientos, defunciones, nombres y personas juridicas por comuna, en formato api. Lo observado son 3 conjuntos en xls, sin nacimientos ni defunciones, y con ultima actualizacion en 2015-10-30, casi once anos atras. La organizacion esta practicamente abandonada.
- **copia_local:** NA
- **fuente_equivalente:** NA

## Vacios conocidos

Las fuentes cuyo `estado_verificacion` no es `Verificada`, con su observacion.

| Fuente | Estado | Observacion |
|---|---|---|
| F012 CEM Interactivo | URL viva sin descarga confirmada | No se siguio la redireccion: el destino es una aplicacion JavaScript de Power BI que no rinde como HTML plano. La observacion del 301 y del host de destino basta para clasificar la via de acceso. |
| F013 Portal API de datos abiertos del Mineduc | URL viva sin descarga confirmada | El host responde pero la validacion TLS falla: el certificado presentado cubre workspace.junar.com y workspace.vor-tex.io, no api.datos.mineduc.cl. El dominio parece delegado a la plataforma Junar. El reconocimiento la registro como http; sobre https no es inspeccionable desde esta sesion. Contenido no verificado. |
| F016 Asistencia declarada mensual por ano | Declarada sin verificar | Listada en la seccion Estudiantes del portal y ausente del reconocimiento. Pendiente de verificacion en una pasada posterior. |
| F017 Asistencia anual por estudiante | Declarada sin verificar | Listada en la seccion Estudiantes del portal y ausente del reconocimiento. Pendiente de verificacion en una pasada posterior. |
| F018 Notas y egresados de ensenanza media | Declarada sin verificar | Listada en la seccion Estudiantes del portal y ausente del reconocimiento. Pendiente de verificacion en una pasada posterior. |
| F019 Resumen de rendimiento por establecimiento | Declarada sin verificar | Listada en la seccion Establecimientos del portal y ausente del reconocimiento. Pendiente de verificacion en una pasada posterior. |
| F020 Resumen de matricula por establecimiento | Declarada sin verificar | Listada en la seccion Establecimientos del portal y ausente del reconocimiento. Pendiente de verificacion en una pasada posterior. |
| F021 Planes de Mejoramiento Educativo (PME) | Declarada sin verificar | Listada en la seccion Establecimientos del portal y ausente del reconocimiento. Pendiente de verificacion en una pasada posterior. |
| F022 Sistema Nacional de Evaluacion del Desempeno (SNED) | Declarada sin verificar | Listada en la seccion Establecimientos del portal y ausente del reconocimiento. Pendiente de verificacion en una pasada posterior. |
| F023 Directorio de sostenedores | Declarada sin verificar | Listada en la seccion Sostenedores del portal y ausente del reconocimiento. Pendiente de verificacion en una pasada posterior. |
| F024 Docentes por curso y subsector | Declarada sin verificar | Listada en la seccion Docentes y Asistentes del portal y ausente del reconocimiento. Pendiente de verificacion en una pasada posterior. |
| F026 Microdatos del Censo 2017 a nivel de manzana | Enlace roto | El servidor devuelve HTTP 404. Se busco la URL vigente y no se encontro: los buscadores siguen indexando este mismo identificador como conjunto vivo, y la variante sin el sufijo de capa (hub.arcgis.com/datasets/54e0c40680054efaabeb9d53b09e1e7a) tambien devuelve 404. El 404 puede significar que el conjunto se retiro o que ArcGIS Hub no sirve contenido a un cliente que no sea navegador; con la evidencia disponible no se puede distinguir, y se registra el estado observado sin decidir la causa. Rutas alternativas anotadas para revision desde navegador: ine-chile.maps.arcgis.com/home/item.html?id=54e0c40680054efaabeb9d53b09e1e7a y el portal de geodatos abiertos (F025), que es la via viva confirmada. |
| F032 Indicadores territoriales del Observatorio Social | URL viva sin descarga confirmada | El servidor devuelve HTTP 403 a la herramienta de consulta. El host respondio, de modo que no es un enlace roto: lo mas probable es que un navegador humano si alcance la pagina. Contenido no verificado. Solicitud registrada. |
| F033 Consulta interactiva de datos Casen (Redatam) | URL viva sin descarga confirmada | La pagina responde pero entrega solo su encabezado: los anos cubiertos, la desagregacion y el requisito de registro no son observables sin interactuar con la aplicacion. Solicitud registrada. |
| F034 Data Social, catalogo Casen | No encontrada | El dominio datasocial.ministeriodesarrollosocial.gob.cl no resuelve en DNS. No es un 404 dentro de un sitio vivo: el host no existe. El servicio parece haber sido retirado o absorbido por BIDAT (F031), que el propio reconocimiento describe como sucesor operativo del Observatorio Social. |
| F036 Portal del Departamento de Estadisticas e Informacion de Salud | URL viva sin descarga confirmada | El servidor devuelve HTTP 403 a la herramienta de consulta. El host respondio: no es un enlace roto. El reconocimiento ya advertia que el sitio combina secciones nuevas y antiguas y sugeria una migracion en curso; conviene verificar estabilidad de URLs desde navegador. Solicitud registrada. |
| F038 Repositorio DEIS de indicadores basicos de salud | URL viva sin descarga confirmada | El servidor devuelve HTTP 403 a la herramienta de consulta. El host respondio: no es un enlace roto. Solicitud registrada. |
| F039 Estudio Nacional de Drogas en Poblacion Escolar 2023 | URL viva sin descarga confirmada | El servidor devuelve HTTP 403 a la herramienta de consulta. El host respondio: no es un enlace roto. Las prevalencias que el reconocimiento atribuia a esta base no se transcriben al catalogo por no haberse observado. Solicitud registrada. |
| F040 Bibliodrogas, listado de estudios del Observatorio Chileno de Drogas | URL viva sin descarga confirmada | La consulta excede diez redirecciones y no llega a contenido. Es un bucle de redirecciones, no un 404 ni un 403: el host responde pero no resuelve a una pagina final. Contenido no verificado. Solicitud registrada. |
| F043 Sistema de informacion estadistica de Mejor Ninez | URL viva sin descarga confirmada | La cadena de certificados TLS no se puede verificar: el servidor no entrega el certificado intermedio. No es un 404 ni un 403, y un navegador podria aceptarlo con advertencia. Contenido no verificado. Solicitud registrada. |
| F047 Encuesta Nacional de Juventudes | URL viva sin descarga confirmada | La cadena de certificados TLS no se puede verificar: el servidor no entrega el certificado intermedio, la misma falla de F043. Contenido no verificado. Solicitud registrada. |
| F051 Informacion estadistica por establecimiento | URL viva sin descarga confirmada | El host responde y sirve HTML, pero el HTML no tiene contenido: la interpolacion de plantilla no se ejecuta fuera de un navegador. Es una falla distinta del 403 y del 404. Contenido no verificado. Solicitud registrada. |
| F053 Plataforma de resultados para SLEP y sostenedores | Enlace roto | El servidor devuelve HTTP 404 en la ruta /login. El host resuelve, de modo que la plataforma probablemente existe con otra ruta de entrada. Es la fuente mas pertinente del lote para el Area, porque es la via institucional propia del SLEP: conviene resolverla. Solicitud registrada. |
| F054 Bases de datos Simce a nivel de estudiante | Declarada sin verificar | El reconocimiento la registro como mencionada sin URL directa y no hay pagina propia que abrir. La seccion Simce (F050) confirma la via: el acceso a datos enmascarados por estudiante exige solicitud formal. La sospecha 6 del reconocimiento queda confirmada. datos_personales se declara como identificador enmascarado porque F050 lo describe asi, no por inspeccion de la base. |
| F056 Biblioteca de Datos para la Investigacion | URL viva sin descarga confirmada | El reconocimiento la destacaba como su hallazgo numero 1 y le atribuia la llave ID_JUNAEB; nada de eso se pudo confirmar. Es la fuente de mayor valor potencial no verificada del catalogo. Solicitud registrada. |
| F059 Denuncias ante la Superintendencia de Educacion | URL viva sin descarga confirmada | La ficha del conjunto devuelve la portada del portal en vez de su propia pagina: datos.gob.cl arma las fichas en el navegador. El host responde, de modo que no es enlace roto. La cobertura desde 2014 que declaraba el reconocimiento NO se pudo confirmar y queda como NA. Solicitud registrada. |
| F060 Solicitudes de mediacion ante la Superintendencia de Educacion | URL viva sin descarga confirmada | Misma falla que F059: la ficha del conjunto devuelve la portada del portal. La cobertura desde 2015 que declaraba el reconocimiento no se pudo confirmar. Solicitud registrada. |
| F061 Procesos administrativos sancionatorios | URL viva sin descarga confirmada | Misma falla que F059 y F060: la ficha del conjunto devuelve la portada del portal. Solicitud registrada. |
| F062 Portal de Datos Abiertos institucional de la Superintendencia | Declarada sin verificar | El reconocimiento la registro como mencionada sin URL directa: la Superintendencia comunica un portal propio en supereduc.cl/datosabiertos cuya direccion exacta no se pudo confirmar. Es la sospecha 1 del reconocimiento y sigue abierta. Sin URL que abrir. |
| F074 Portal de bases de datos del proceso de admision | URL viva sin descarga confirmada | El servidor entrega cabeceras HTTP malformadas (falta el retorno de carro esperado tras un valor de cabecera) y la respuesta no se puede parsear. Es una falla de protocolo del servidor, no un 403 ni un 404, y afecta a todo el dominio demre.cl: F075 falla igual. El estado se mantiene porque describe la verificacion de la URL, que no se pudo hacer; el CONTENIDO si quedo verificado por copia local en la segunda pasada de doble fuente, que ademas aporto la guia de uso del emisor. |
| F075 Compendios estadisticos del proceso de admision | URL viva sin descarga confirmada | Misma falla de protocolo que F074: cabeceras HTTP malformadas en todo el dominio demre.cl. El reconocimiento le atribuia formato xlsx, que no se pudo confirmar. Solicitud registrada. |
| F076 Resultados de admision por unidad educativa | Declarada sin verificar | El reconocimiento la registro como mencionada sin URL directa, apuntando solo a una noticia de enero de 2025. Sin URL que abrir. Es la tercera y ultima de las tres filas sin URL del reconocimiento. |
| F078 INDICES, bases de datos de educacion superior | URL viva sin descarga confirmada | El servidor devuelve HTTP 403 a la herramienta de consulta. El host respondio: no es un enlace roto. Es la unica fuente del lote G con documentacion tecnica declarada por el reconocimiento. Solicitud registrada. |
| F083 Cuenta publica y reportabilidad local de un Servicio Local | URL viva sin descarga confirmada | El servidor devuelve HTTP 403 a la herramienta de consulta. El host respondio: no es un enlace roto. El reconocimiento inventario el sitio del SLEP Santiago Centro como ejemplo de reportabilidad local; no es el sitio del SLEP Costa Central. Solicitud registrada. |

**34 de 83 fuentes** no estan verificadas.

