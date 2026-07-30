# brief_research_reconocimiento_fuentes_v2
# Tipo: brief de investigacion de reconocimiento (paso 1 de 2 del mapeo)
# Audiencia/modelo objetivo: Claude con Research avanzada (claude.ai)
# Destino: herramientas_dev/prompts/catalogo_fuentes/brief_research_reconocimiento_fuentes_v2.md
# Paso siguiente: encargo_verificar_y_emitir_catalogo_fuentes_v2.md (Claude Code)
#
# Cambios respecto a v1:
# - Lote H se reordena como contexto sociodemografico, con Censo y Casen nombrados
#   de forma explicita.
# - Lote J nuevo: salud, proteccion social e instituciones publicas afines
#   (incluye el Departamento de Estadisticas e Informacion de Salud del Minsal).
# - Los lotes pasan de nueve a diez; conteos y criterios de aceptacion ajustados.
# - Se especifica el producto: un unico archivo markdown, con estructura fija,
#   pensado como insumo parseable del paso siguiente.

## Rol

Eres un investigador de reconocimiento de fuentes de datos del sistema
educativo chileno. Tu trabajo es levantar el mapa de donde estan los datos, no
construir el catalogo final ni analizar los datos. Buscas puertas, no muebles.

## Objetivo

Un inventario exhaustivo de portales, secciones y URLs candidatas donde
instituciones publicas chilenas publican datos sobre educacion escolar y
parvularia, o datos de contexto que se usan para caracterizar a la poblacion
escolar, con la informacion minima para que un paso posterior de verificacion
pueda abrir cada URL, confirmar el conjunto de datos y llenar un catalogo
estructurado.

Prioridad absoluta: **amplitud de cobertura institucional**. Es mejor un
inventario con 250 URLs candidatas de 35 instituciones que uno con 60 URLs
perfectamente descritas de 5 instituciones.

## Contexto y linea base

Trabajo en el area de monitoreo de un Servicio Local de Educacion Publica
(Chile). Existen dos documentos internos de referencia que ya inventarian
fuentes, con dos sesgos conocidos: se concentran en el Centro de Estudios del
Ministerio de Educacion y en la Agencia de Calidad de la Educacion, y mencionan
solo de paso a Junaeb, la Superintendencia de Educacion, el CPEIP, DEMRE, la
educacion parvularia y las fuentes de contexto territorial, sanitario y de
proteccion social.

El valor de tu trabajo esta justamente en lo que esos documentos no tienen. Por
cada hallazgo debes declarar si es nuevo respecto a esa linea base.

## Alcance

**Incluye:** educacion escolar (parvularia, basica, media, tecnico profesional,
educacion de adultos, educacion especial), la institucionalidad de la Nueva
Educacion Publica, y las fuentes de contexto sociodemografico, sanitario y de
proteccion social que permiten caracterizar a la poblacion escolar y a su
territorio.

**Excluye:** educacion superior salvo en lo que sirve para medir transito desde
la educacion media (acceso, matricula de primer ano, resultados de la prueba de
admision). Excluye tambien fuentes de otros paises, literatura academica y
bases de organismos privados sin mandato publico.

## Instituciones a barrer (los diez lotes)

Cubre los diez. Ninguno puede quedar sin al menos una linea, y si un lote no
publica nada, lo declaras explicitamente.

- **A. Ministerio de Educacion, nivel central.** Centro de Estudios, portal de
  datos abiertos ministerial, Sistema de Informacion General de Estudiantes,
  Sistema de Gestion Documental (reconocimiento oficial, resoluciones de
  estructura de cursos), Division de Educacion General, Sistema de Admision
  Escolar, subvenciones y asignaciones, Coordinacion Nacional de Transporte
  Escolar.
- **B. Agencia de Calidad de la Educacion.** Resultados de las pruebas
  nacionales, estandares de aprendizaje, indicadores de desarrollo personal y
  social, categorias de desempeno, Diagnostico Integral de Aprendizajes,
  estudios internacionales, visitas de evaluacion y orientacion, informes de
  resultados por establecimiento.
- **C. Superintendencia de Educacion.** Datos abiertos, denuncias,
  fiscalizaciones, rendicion de cuentas, registro de sostenedores, circulares
  con formato de reporte.
- **D. Junaeb.** Mapa nutricional, indice de vulnerabilidad escolar y sistema
  de asignacion, becas y beneficios, programas de alimentacion escolar, salud
  escolar, residencias familiares.
- **E. Educacion parvularia.** Junta Nacional de Jardines Infantiles,
  Fundacion Integra, Subsecretaria de Educacion Parvularia, Intendencia de
  Educacion Parvularia, sistemas de gestion de la oferta parvularia, buscadores
  publicos de jardines infantiles.
- **F. Docentes y asistentes de la educacion.** Centro de Perfeccionamiento,
  Experimentacion e Investigaciones Pedagogicas, carrera docente y tramos,
  evaluacion docente, evaluacion de conocimientos especificos y pedagogicos,
  dotacion, titulos e idoneidad.
- **G. Transicion a la educacion superior.** Departamento de Evaluacion,
  Medicion y Registro Educacional, Subsecretaria de Educacion Superior, sistema
  de informacion de educacion superior, portales de orientacion vocacional,
  titulacion tecnico profesional.
- **H. Contexto sociodemografico y territorial.** Instituto Nacional de
  Estadisticas: **Censo de Poblacion y Vivienda** (resultados, microdatos,
  cartografia censal, manzanas y entidades), proyecciones de poblacion,
  estadisticas vitales que publica el INE, encuestas de empleo. Ministerio de
  Desarrollo Social y Familia: **Encuesta de Caracterizacion Socioeconomica
  Nacional (Casen)** con sus bases, libros de codigos y series comunales,
  Registro Social de Hogares, Observatorio Social, Banco Integrado de
  Programas Sociales. Division politico administrativa, cartografia comunal y
  portal nacional de datos abiertos.
- **I. Institucionalidad de la Nueva Educacion Publica.** Direccion de
  Educacion Publica (reportes, convenios de gestion educacional, estrategia
  nacional, planes anuales locales), Consejo Nacional de Educacion, y la
  reportabilidad publica que los Servicios Locales estan obligados a publicar.
- **J. Salud, proteccion social e instituciones publicas afines.**
  **Departamento de Estadisticas e Informacion de Salud del Ministerio de Salud
  (DEIS)**: estadisticas vitales (nacimientos, mortalidad), egresos
  hospitalarios, atenciones de urgencia, morbilidad, salud mental, vacunacion,
  y sus series por comuna. Ademas: Servicio Nacional para la Prevencion y
  Rehabilitacion del Consumo de Drogas y Alcohol (estudios en poblacion
  escolar), Servicio Nacional de Proteccion Especializada a la Ninez y
  Adolescencia, Subsecretaria de la Ninez, Defensoria de los Derechos de la
  Ninez, Servicio Nacional de la Discapacidad, Servicio Nacional de
  Migraciones, Servicio de Registro Civil e Identificacion, Subsecretaria de
  Prevencion del Delito, Instituto Nacional de la Juventud, Ministerio del
  Deporte, y cualquier otro organismo publico que publique datos desagregados
  por comuna o por establecimiento educacional que sirvan para caracterizar a
  la poblacion escolar.

## Metodo

1. Por cada institucion, ubica el sitio oficial y **recorre el arbol** de sus
   secciones de datos: "datos abiertos", "estadisticas", "estudios",
   "publicaciones", "transparencia activa", "biblioteca digital", "informes",
   "documentacion tecnica", "microdatos". No te quedes en la portada ni en la
   primera pagina de resultados del buscador.
2. Busca tambien los sistemas de consulta en linea sin descarga (buscadores por
   establecimiento, fichas, mapas, tableros), porque para el area son fuentes
   aunque no entreguen archivo.
3. Cuando encuentres un portal de datos abiertos, registra el portal **y** los
   conjuntos de datos pertinentes que aloja, uno por linea.
4. Registra los diccionarios de variables, libros de codigos y notas
   metodologicas como recurso asociado, no como fila aparte.
5. Cuando dos instituciones publiquen lo mismo, registra ambas y anota la
   relacion.
6. En los lotes H y J, filtra por pertinencia: solo lo que permita caracterizar
   poblacion escolar, sus hogares o su territorio. No inventaries la produccion
   estadistica completa de esas instituciones.

## Producto

**Un unico archivo markdown**, `reconocimiento_fuentes_v1.md`, entregado como
archivo descargable y no solo como texto en el chat. Es el insumo directo del
paso siguiente, que lo parsea de forma programatica: la estructura no es
decorativa.

Estructura obligatoria, en este orden:

1. **Bloque de metadatos** al inicio, como lista:
   `fecha_de_investigacion`, `lotes_cubiertos`, `total_urls_candidatas`,
   `total_marcadas_nuevas`, `instituciones_cubiertas`.
2. **Diez secciones**, una por lote, con encabezado `## Lote A. <nombre>` y una
   sola tabla markdown por seccion.
3. **Hallazgos destacados:** hasta diez fuentes nuevas que a tu juicio cambian
   el mapa, con una linea de por que.
4. **Vacios y sospechas:** datos que el sistema deberia publicar y no
   encontraste, secciones caidas, portales en migracion, URLs que redirigen a
   otra parte.
5. **Conteo final:** tabla de URLs candidatas por lote, total y marcadas como
   nuevas.

Cada tabla de lote tiene estas diez columnas, en este orden y sin ninguna otra:

| Columna | Contenido |
|---|---|
| `institucion_emisora` | nombre oficial completo y sigla entre parentesis |
| `portal_o_seccion` | nombre de la seccion o del portal donde vive el recurso |
| `url_candidata` | URL exacta, tal como aparece en la barra de direcciones |
| `tipo_de_recurso` | uno de: portal de datos abiertos, repositorio de archivos, buscador o consulta web, API, biblioteca de informes, seccion de transparencia activa, sistema con credenciales |
| `datos_que_parece_contener` | en una linea, que variables o indicadores promete |
| `formato_aparente` | csv, xlsx, zip, json, api, pdf, shapefile, sin descarga, no observable |
| `nivel_acceso_aparente` | abierto, abierto con registro, requiere credenciales institucionales, requiere solicitud formal |
| `documentacion_asociada` | URL del diccionario, manual o libro de codigos, o `no vista` |
| `pagina_de_origen` | URL de la pagina desde la que llegaste a esta |
| `novedad` | uno de: nueva, ya declarada en la linea base, reemplaza a una declarada |

Reglas de forma del markdown, para que el paso siguiente pueda parsearlo:

- Una sola tabla por lote, sin subtablas ni filas de subtitulo dentro de la
  tabla.
- Sin celdas combinadas, sin filas de totales dentro de las tablas de lote, sin
  filas en blanco.
- Ningun caracter `|` dentro de una celda: reemplazalo por `/`.
- Sin saltos de linea dentro de una celda.
- URLs como texto plano, nunca como enlace con etiqueta.
- Ninguna celda vacia: siempre un valor o una marca explicita (`no vista`, `no
  observable`, `mencionada sin URL directa`).

## Restricciones negativas

- No inventes URLs. Cada URL de la tabla tiene que provenir de una pagina que
  efectivamente abriste en esta investigacion. Si una fuente te consta solo por
  mencion de un tercero, va con `url_candidata = mencionada sin URL directa` y
  lo explicas en `pagina_de_origen`.
- No completes `formato_aparente`, `nivel_acceso_aparente` ni
  `datos_que_parece_contener` por analogia con otra fuente. Si no es
  observable, `no observable`.
- No transcribas parrafos de los sitios consultados. Describe con tus palabras.
- No incluyas nombres de establecimientos educacionales, de estudiantes, de
  funcionarios ni de personas identificables.
- No incluyas credenciales, tokens, rutas locales ni nombres de carpetas
  institucionales.
- No uses la sigla "EE": escribe "establecimiento educacional".
- No entregues analisis de los datos, interpretaciones de resultados
  educativos, ni recomendaciones de politica. Esto es un inventario.
- No intentes llenar periodicidad, cobertura temporal, llaves de union ni
  condiciones de uso con rigor: eso lo hace el paso de verificacion posterior.
  Si lo ves de paso, va en `datos_que_parece_contener`.
- No reduzcas el barrido a las instituciones que ya conoces bien. Un lote con
  tres lineas cuando la institucion publica veinte conjuntos de datos es un
  fracaso del encargo.
- No entregues el reporte solo como respuesta en el chat: el producto es el
  archivo.

## Criterios de aceptacion

1. Los diez lotes tienen tabla, o una declaracion explicita de por que el lote
   quedo vacio.
2. El archivo abre el bloque de metadatos con los cinco campos completos.
3. Toda tabla tiene exactamente las diez columnas del esquema, en orden.
4. Ninguna celda esta vacia y ninguna contiene el caracter `|`.
5. Toda `url_candidata` tiene su `pagina_de_origen`.
6. La columna `novedad` esta completa en todas las filas.
7. El conteo final cuadra con el numero de filas de las diez tablas.
8. Los lotes H y J incluyen, como minimo, el Censo de Poblacion y Vivienda, la
   Casen y las estadisticas del Departamento de Estadisticas e Informacion de
   Salud, o una declaracion de por que no fueron encontrados.
