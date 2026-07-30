# Solicitudes al titular — catálogo de fuentes

> Archivo acumulativo generado por el mecanismo de la enmienda E6 del encargo
> `20260730_encargo_verificacion_catalogo_fuentes_v3.md`.
> Las entradas resueltas **no se borran**: se marcan como resueltas y quedan
> como registro.
>
> Una solicitud significa que la fuente no se pudo completar desde esta sesión.
> La fila del catálogo se emitió igual, con sus `NA`: **una solicitud pendiente
> no bloquea el catálogo**.
>
> Bajar archivos y abrir páginas desde navegador es tarea manual del titular.
> Aquí solo se declara qué falta y desde qué URL exacta. Cuando los archivos
> queden en una ruta, se leen en solo lectura, se completan las filas y la
> entrada se marca resuelta.

**Estado al cierre del tramo 5 (catálogo completo):** 43 fuentes con solicitud
pendiente, de 83 filas del catálogo. Ninguna resuelta todavía.

Agrupadas por **lo que necesitan de ti**, para resolverlas de una vez:

| Bloque | Qué se necesita | Fuentes |
|---|---|---|
| **A** | Descargar el archivo y ponerlo a disposición | 16 |
| **B** | Abrir desde navegador (403 o falla de transporte) | 24 |
| **C** | Acceso con credenciales institucionales | 3 |

**La más pertinente para el Área es F053**, la plataforma de resultados Simce
para SLEP y sostenedores: es la vía institucional propia del servicio y hoy
devuelve 404 en la ruta que registró el reconocimiento.

---

# Bloque A — Descargar el archivo y ponerlo a disposición

Dieciséis fuentes cuya página **sí responde** y **sí publica el enlace de
descarga**, pero que no publican el esquema de registros (el libro de códigos,
como lo llama Datos Abiertos) ni los nombres de columna. El dato está a un clic;
lo que falta es abrirlo para leer su estructura.

## F003 — Matrícula educación parvularia

- **base_datos y emisor:** Datos Abiertos · Centro de Estudios del Ministerio de Educación (CEM)
- **URL de descarga:** <https://datosabiertos.mineduc.cl/wp-content/uploads/2025/12/Matricula-Parvularia-2025.rar> (año 2025; los demás años en <https://datosabiertos.mineduc.cl/matricula-educacion-parvularia/>, `.rar` 2011-2025 y `.zip` 2019)
- **Qué falta:** esquema de registros y nombres de columna; la página solo describe el contenido en prosa.
- **Campos bloqueados:** `variables`, `unidad_de_analisis`, `llaves_de_union`, `datos_personales`, `documentacion_tecnica`

## F005 — Alumnos preferentes, prioritarios y beneficiarios SEP

- **base_datos y emisor:** Datos Abiertos · CEM
- **URL de descarga:** <https://datosabiertos.mineduc.cl/wp-content/uploads/2026/01/Alumnos-SEP-2025.rar> (año 2025; los demás en <https://datosabiertos.mineduc.cl/alumnos-preferentes-prioritarios-y-beneficiarios-sep/>, `.rar` 2008-2025)
- **Qué falta:** esquema de registros y nombres de columna.
- **Campos bloqueados:** `variables`, `unidad_de_analisis`, `llaves_de_union`, `datos_personales`, `documentacion_tecnica`

## F006 — Sistema de Admisión Escolar (SAE)

- **base_datos y emisor:** Datos Abiertos · CEM
- **URL de descarga:** <https://datosabiertos.mineduc.cl/wp-content/uploads/2026/03/SAE_2025.rar> (año 2025; los demás en <https://datosabiertos.mineduc.cl/sistema-de-admision-escolar-sae/>, `.rar` y `.zip` 2016-2025)
- **Qué falta:** esquema de registros y nombres de columna.
- **Campos bloqueados:** `variables`, `unidad_de_analisis`, `llaves_de_union`, `datos_personales`, `documentacion_tecnica`

## F007 — Directorio de establecimientos educacionales

- **base_datos y emisor:** Datos Abiertos · CEM
- **URL de descarga:** <https://datosabiertos.mineduc.cl/wp-content/uploads/2025/11/Directorio-Oficial-EE-2025.rar> (año 2025) y <https://datosabiertos.mineduc.cl/wp-content/uploads/2021/12/Directorio_oficial_EE_2004.csv> (año 2004, formato `.csv`). Índice completo en <https://datosabiertos.mineduc.cl/directorio-de-establecimientos-educacionales/>
- **Qué falta:** esquema de registros y nombres de columna; conviene un año `.csv` (2004-2012) y uno `.rar` reciente, porque el formato cambia y las columnas pueden no coincidir entre tramos.
- **Campos bloqueados:** `variables`, `llaves_de_union`, `documentacion_tecnica`

## F008 — Subvenciones a establecimientos educacionales

- **base_datos y emisor:** Datos Abiertos · CEM
- **URL de descarga:** <https://datosabiertos.mineduc.cl/wp-content/uploads/2026/06/Subvenciones-a-EE-2025.rar> (año 2025; los demás en <https://datosabiertos.mineduc.cl/subvenciones-a-establecimientos-educacionales/>, `.rar` y `.zip` 2005-2025)
- **Qué falta:** esquema de registros, nombres de columna y periodicidad real de publicación (la página no la declara).
- **Campos bloqueados:** `variables`, `llaves_de_union`, `documentacion_tecnica`, `mes_publicacion`

## F009 — Matrícula longitudinal

- **base_datos y emisor:** Datos Abiertos · CEM
- **URL de descarga:** <https://datosabiertos.mineduc.cl/wp-content/uploads/2025/10/excel-matricula-longuitudinal-2010-2025_no_modificable.xlsx> (libro único, serie 2010-2025; la errata `longuitudinal` es del emisor y es parte de la URL)
- **Qué falta:** nombres de columna y estructura de hojas del libro; la página nombra las dimensiones de desglose pero no las columnas.
- **Campos bloqueados:** `variables`, `llaves_de_union`, `documentacion_tecnica`

## F010 — Tasas de incidencia de desvinculación

- **base_datos y emisor:** Datos Abiertos · CEM
- **URL de descarga:** <https://datosabiertos.mineduc.cl/wp-content/uploads/2025/10/OFICIAL-Tasa-Incidencia-Desvinculacion-2010-2024.xlsx> (libro único, serie 2010-2024)
- **Qué falta:** nombres de columna y definición de la tasa; también conviene confirmar por qué la serie termina en 2024 y no en 2025 como el resto del portal.
- **Campos bloqueados:** `variables`, `llaves_de_union`, `documentacion_tecnica`

## F011 — Practicantes y titulados técnico profesional

- **base_datos y emisor:** Datos Abiertos · CEM
- **URL de descarga:** <https://datosabiertos.mineduc.cl/wp-content/uploads/2026/06/Practicantes-y-Titulados-TP-2025.rar> (año 2025; los demás en <https://datosabiertos.mineduc.cl/practicantes-y-titulados-tecnico-profesional/>, `.rar` 2013-2021 y 2023-2025, `.zip` 2022)
- **Qué falta:** esquema de registros y nombres de columna.
- **Campos bloqueados:** `variables`, `unidad_de_analisis`, `llaves_de_union`, `datos_personales`, `documentacion_tecnica`

## F041 — Datos abiertos de permisos de residencia (SERMIG)

- **base_datos y emisor:** Datos abiertos SERMIG · Servicio Nacional de Migraciones (SERMIG)
- **URL de descarga:** los cuatro libros de metadatos, que son el esquema publicado y **no exigen bajar el dato**:
  - <https://serviciomigraciones.cl/wp-content/uploads/2024/03/Metadatos_RT_Acogidas_2000_1er_semestre_2026.xlsx>
  - <https://serviciomigraciones.cl/wp-content/uploads/estudios/Datos-abiertos/RT/Metadatos_RT_Resueltas_2000_1er_semestre_2026.xlsx>
  - <https://serviciomigraciones.cl/wp-content/uploads/estudios/Datos-abiertos/RD/Metadatos_RD_Acogidas_2000_1er_semestre_2026.xlsx>
  - <https://serviciomigraciones.cl/wp-content/uploads/estudios/Datos-abiertos/RD/Metadatos_RD_Resueltas_2000_1er_semestre_2026.xlsx>
- **Qué falta:** los libros de metadatos, que traen los nombres de variable sin necesidad de descargar las bases. **Es la solicitud más barata del bloque**: cuatro archivos livianos que resuelven una fila completa.
- **Campos bloqueados:** `variables`, `llaves_de_union`, `desagregacion_territorial`, `datos_personales`

## F050 — Resultados Simce e IDPS, sección institucional

- **base_datos y emisor:** Simce · Agencia de Calidad de la Educación (ACE)
- **URL de descarga:** <https://www.agenciaeducacion.cl/simce/> (los archivos complementarios `.rar` y los informes técnicos cuelgan de esa sección, alojados en Amazon S3)
- **Qué falta:** los archivos complementarios `.rar` con las bases por establecimiento, y confirmar qué trae el conjunto de datos enlazados RDF/TTL/JSON-LD.
- **Campos bloqueados:** `variables`, `url_descarga`, `llaves_de_union`, `cobertura_temporal` (parcial)

## F066 — Resumen de matrícula parvularia por establecimiento

- **base_datos y emisor:** Datos Abiertos · CEM
- **URL de descarga:** <https://datosabiertos.mineduc.cl/wp-content/uploads/2026/02/Resumen-Educacion-Parvularia-2025.rar> (año 2025; los demás en <https://datosabiertos.mineduc.cl/resumen-de-matricula-en-educacion-parvularia-por-establecimiento-educacional/>, `.rar` 2011-2025)
- **Qué falta:** esquema de registros y nombres de columna.
- **Campos bloqueados:** `variables`, `llaves_de_union`, `documentacion_tecnica`

## F070 — Evaluación docente

- **base_datos y emisor:** Datos Abiertos · CEM
- **URL de descarga:** <https://datosabiertos.mineduc.cl/wp-content/uploads/2026/03/Evaluacion-Docente-2024.rar> (año 2024; los demás en <https://datosabiertos.mineduc.cl/evaluacion-docente/>, `.rar` y `.zip` 2004-2024)
- **Qué falta:** esquema de registros y nombres de columna.
- **Campos bloqueados:** `variables`, `llaves_de_union`, `datos_personales`, `documentacion_tecnica`

## F071 — Evaluación de Conocimientos Específicos y Pedagógicos (ECEP)

- **base_datos y emisor:** Datos Abiertos · CEM
- **URL de descarga:** <https://datosabiertos.mineduc.cl/wp-content/uploads/2026/01/ECEP-2024.rar> (año 2024; los demás en <https://datosabiertos.mineduc.cl/evaluacion-de-conocimientos-especificos-y-pedagogicos-ecep-2/>, `.rar` y `.zip` 2016-2024)
- **Qué falta:** esquema de registros y nombres de columna.
- **Campos bloqueados:** `variables`, `llaves_de_union`, `datos_personales`, `documentacion_tecnica`

## F072 — Cargos docentes

- **base_datos y emisor:** Datos Abiertos · CEM
- **URL de descarga:** <https://datosabiertos.mineduc.cl/wp-content/uploads/2025/08/Directorio-Docentes-2025.rar> (año 2025; los demás en <https://datosabiertos.mineduc.cl/cargos-docentes/>, `.rar` 2003-2025)
- **Qué falta:** esquema de registros y nombres de columna.
- **Campos bloqueados:** `variables`, `llaves_de_union`, `datos_personales`, `documentacion_tecnica`

## F073 — Asistentes de la educación

- **base_datos y emisor:** Datos Abiertos · CEM
- **URL de descarga:** <https://datosabiertos.mineduc.cl/wp-content/uploads/2025/08/Asistentes-de-la-Educacion-2025-.rar> (año 2025; los demás en <https://datosabiertos.mineduc.cl/asistentes-de-la-educacion/>, `.rar` 2007-2025). El guion final antes de la extensión es parte de la URL.
- **Qué falta:** esquema de registros y nombres de columna.
- **Campos bloqueados:** `variables`, `llaves_de_union`, `datos_personales`, `documentacion_tecnica`

## F079 — Pruebas de admisión a la educación superior

- **base_datos y emisor:** Datos Abiertos · CEM
- **URL de descarga:** <https://datosabiertos.mineduc.cl/wp-content/uploads/2026/07/PAES-2026-Inscritos-Puntajes.rar> (proceso 2026; los demás en <https://datosabiertos.mineduc.cl/pruebas-de-admision-a-la-educacion-superior/>, `.rar` y `.zip` 2021-2026)
- **Qué falta:** esquema de registros y nombres de columna. **Es la vía viva al mismo dato que DEMRE publica en F074 y F075**, cuyo dominio no se puede consultar.
- **Campos bloqueados:** `variables`, `llaves_de_union`, `datos_personales`, `documentacion_tecnica`

---

# Bloque B — Abrir desde navegador

Veinticuatro fuentes donde **el host responde** pero el contenido no se puede
recuperar con la herramienta. **Ninguna es un enlace roto definitivo**: lo más
probable es que un navegador humano sí las alcance. Cinco causas distintas:
HTTP 403, HTTP 404 sobre host vivo, cadena TLS no verificable, cabeceras HTTP
malformadas, y plantillas que solo se arman en el navegador.

## F025 — Geodatos abiertos y cartografía censal (INE)

- **base_datos y emisor:** Geodatos Abiertos · Instituto Nacional de Estadísticas (INE)
- **URL:** <https://www.ine.gob.cl/herramientas/portal-de-mapas/geodatos-abiertos> (no expone enlaces directos de archivo en su HTML; las capas se descargan desde la interfaz)
- **Qué falta:** nombres de campos de las capas y URL directa de la capa de manzana del Censo 2024.
- **Campos bloqueados:** `variables`, `url_descarga`, `llaves_de_union`

## F026 — Microdatos del Censo 2017 a nivel de manzana (INE)

- **base_datos y emisor:** Portal ArcGIS Open Data · INE
- **URL:** <https://geoine-ine-chile.opendata.arcgis.com/datasets/54e0c40680054efaabeb9d53b09e1e7a_0> — **HTTP 404**
- **Qué falta:** confirmar desde navegador si el conjunto sigue publicado. Se buscó la URL vigente y no se encontró una que responda: los buscadores siguen indexando este mismo identificador como conjunto vivo, y la variante sin sufijo de capa (<https://hub.arcgis.com/datasets/54e0c40680054efaabeb9d53b09e1e7a>) también devuelve 404. Rutas alternativas a probar: <https://ine-chile.maps.arcgis.com/home/item.html?id=54e0c40680054efaabeb9d53b09e1e7a> y el portal de geodatos abiertos (F025).
- **Campos bloqueados:** todos salvo `dato`, `emisor` y `cobertura_temporal`

## F027 — Estimaciones y proyecciones de población (INE)

- **base_datos y emisor:** Demografía y vitales · INE
- **URL:** <https://www.ine.gob.cl/estadisticas/sociales/demografia-y-vitales/proyecciones-de-poblacion> (solo se observaron PDF; el reconocimiento le atribuía `xlsx`)
- **Qué falta:** confirmar si existen los archivos `xlsx` de proyecciones por comuna y su URL; hoy solo se ven infografías y síntesis en PDF.
- **Campos bloqueados:** `variables`, `url_descarga`, `formato` (parcial)

## F030 — Encuesta Casen (Observatorio Social)

- **base_datos y emisor:** Observatorio Social · Ministerio de Desarrollo Social y Familia (MDSF)
- **URL:** <https://observatorio.ministeriodesarrollosocial.gob.cl/encuesta-casen> (remite a la sección Base de Datos de cada año, sin enlaces directos)
- **Qué falta:** libro de códigos y URL de la base del año 2024; la página no expone ni documentación ni enlaces de archivo.
- **Campos bloqueados:** `variables`, `url_descarga`, `formato`, `llaves_de_union`, `documentacion_tecnica`, `datos_personales`

## F031 — Banco Integrado de Datos (BIDAT)

- **base_datos y emisor:** BIDAT · MDSF
- **URL:** <https://bidat.gob.cl/> (portada; los conjuntos cuelgan de sus fichas)
- **Qué falta:** esquema de las bases de pobreza comunal y Registro Social de Hogares, y sus URL de ficha.
- **Campos bloqueados:** `variables`, `url_descarga`, `llaves_de_union`, `cobertura_temporal`, `datos_personales`

## F032 — Indicadores territoriales del Observatorio Social

- **base_datos y emisor:** Observatorio Social · MDSF
- **URL:** <http://observatorio.ministeriodesarrollosocial.gob.cl/indicadores/> — **HTTP 403**
- **Qué falta:** confirmar qué reportes comunales ofrece y si permiten descarga.
- **Campos bloqueados:** `variables`, `url_descarga`, `formato`, `cobertura_temporal`, `documentacion_tecnica`, `condiciones_de_uso`

## F033 — Consulta interactiva de Casen (Redatam)

- **base_datos y emisor:** Redatam · MDSF
- **URL:** <https://redatam.org/redchl/mds/casen/> (aplicación de servidor; solo entregó su encabezado)
- **Qué falta:** años de Casen cubiertos, desagregación disponible y si exige registro. Requiere interactuar con la aplicación.
- **Campos bloqueados:** `cobertura_temporal`, `desagregacion_territorial`, `nivel_acceso` (por confirmar)

## F036 — Portal del DEIS

- **base_datos y emisor:** DEIS · Departamento de Estadísticas e Información de Salud (DEIS)
- **URL:** <https://deis.minsal.cl/> — **HTTP 403**
- **Qué falta:** catálogo de conjuntos y sus formatos; el reconocimiento advertía una migración en curso y conviene confirmar qué URL son estables.
- **Campos bloqueados:** `variables`, `url_descarga`, `formato`, `cobertura_temporal`, `periodicidad`, `documentacion_tecnica`

## F038 — Repositorio DEIS de indicadores básicos de salud

- **base_datos y emisor:** Repositorio DEIS · DEIS
- **URL:** <https://repositoriodeis.minsal.cl/> — **HTTP 403**
- **Qué falta:** series disponibles y sus formatos.
- **Campos bloqueados:** `variables`, `url_descarga`, `formato`, `cobertura_temporal`, `periodicidad`

## F039 — Estudio Nacional de Drogas en Población Escolar 2023 (SENDA)

- **base_datos y emisor:** Observatorio Chileno de Drogas · SENDA
- **URL:** <https://www.senda.gob.cl/informacion-y-conocimiento/observatorio-chileno-drogas/base-de-datos/base-de-datos-estudio-nacional-de-poblacion-escolar-2023/> — **HTTP 403**
- **Qué falta:** el reconocimiento declaraba que la base exige registro, lo que no se pudo confirmar.
- **Campos bloqueados:** `variables`, `url_descarga`, `formato`, `nivel_acceso` (por confirmar), `documentacion_tecnica`

## F040 — Bibliodrogas, listado de estudios (SENDA)

- **base_datos y emisor:** Bibliodrogas · SENDA
- **URL:** <https://bibliodrogas.gob.cl/observatorio/> — **bucle de redirecciones, excede 10 saltos**
- **Qué falta:** la serie de estudios en población escolar y sus enlaces de descarga.
- **Campos bloqueados:** `variables`, `url_descarga`, `formato`, `cobertura_temporal`, `documentacion_tecnica`

## F043 — Sistema de información estadística (Mejor Niñez)

- **base_datos y emisor:** Sistema de información estadística · Mejor Niñez
- **URL:** <https://sis.mejorninez.cl/mejor-ninez.html> — **cadena de certificados TLS no verificable**
- **Qué falta:** qué estadísticas ofrece y si permiten descarga. El navegador probablemente lo abra con advertencia de certificado.
- **Campos bloqueados:** `variables`, `url_descarga`, `formato`, `cobertura_temporal`, `desagregacion_territorial`

## F045 — III Estudio Nacional de la Discapacidad (SENADIS)

- **base_datos y emisor:** III ENDISC · Servicio Nacional de la Discapacidad (SENADIS)
- **URL:** <https://www.senadis.gob.cl/pag/693/2004/iii_estudio_nacional_de_la_discapacidad> (el libro sí se descarga: <https://www.senadis.gob.cl/descarga/i/7442/documento>)
- **Qué falta:** la base de datos del estudio, que no se observó en la página; solo aparece el libro. Confirmar si ENDIDE 2022 publica microdatos y dónde.
- **Campos bloqueados:** `variables`, `formato` (parcial), `llaves_de_union`, `datos_personales`

## F047 — Encuesta Nacional de Juventudes (INJUV)

- **base_datos y emisor:** Encuesta Nacional de Juventudes · Instituto Nacional de la Juventud (INJUV)
- **URL:** <https://www.injuv.gob.cl/encuestanacionaldejuventud> — **cadena de certificados TLS no verificable**
- **Qué falta:** versiones disponibles de la encuesta y sus bases.
- **Campos bloqueados:** `variables`, `url_descarga`, `formato`, `cobertura_temporal`, `periodicidad`

## F051 — Información estadística por establecimiento (Agencia de Calidad)

- **base_datos y emisor:** Información estadística · Agencia de Calidad de la Educación (ACE)
- **URL:** <https://informacionestadistica.agenciaeducacion.cl> — **entrega la plantilla sin renderizar (`{{titulo}}` literal)**
- **Qué falta:** catálogo de conjuntos, sus formatos y si publica datos enlazados como declaraba el reconocimiento.
- **Campos bloqueados:** `variables`, `url_descarga`, `formato`, `cobertura_temporal`, `periodicidad`

## F056 — Biblioteca de Datos para la Investigación (JUNAEB)

- **base_datos y emisor:** Biblioteca de Datos · Junta Nacional de Auxilio Escolar y Becas (Junaeb)
- **URL:** <https://bibliotecadatos.sead.junaeb.cl/> — **entrega solo el encabezado; el cuerpo no llega**
- **Qué falta:** catálogo, requisito de registro y la llave `ID_JUNAEB`. **Es la fuente de mayor valor potencial no verificada del catálogo**: el reconocimiento la destacó como su hallazgo n° 1 porque permitiría vincular Mapa Nutricional y alimentación escolar a nivel individual.
- **Campos bloqueados:** `variables`, `url_descarga`, `formato`, `llaves_de_union`, `cobertura_temporal`, `nivel_acceso` (por confirmar)

## F059, F060, F061 — Los tres conjuntos de la Superintendencia de Educación

- **base_datos y emisor:** datos.gob.cl · Superintendencia de Educación (SIE)
- **URL:** las tres fichas **devuelven la portada del portal** en vez de su propia página:
  - <https://datos.gob.cl/dataset/denuncias>
  - <https://datos.gob.cl/dataset/solicitudes-de-mediacion>
  - <https://datos.gob.cl/dataset/procesos-administrativos-sancionatorios>
- **Qué falta:** el enlace CSV de cada conjunto y su cobertura temporal (el reconocimiento declaraba denuncias desde 2014 y mediaciones desde 2015; no se pudo confirmar).
- **Campos bloqueados:** `variables`, `url_descarga`, `cobertura_temporal`, `periodicidad`, `llaves_de_union`

## F074, F075 — Portal de bases de datos y compendios estadísticos (DEMRE)

- **base_datos y emisor:** Portal Bases de Datos y Compendios Estadísticos · Departamento de Evaluación, Medición y Registro Educacional (DEMRE)
- **URL:** **todo el dominio `demre.cl` entrega cabeceras HTTP malformadas** y la respuesta no se puede parsear:
  - <https://demre.cl/portales/portal-bases-datos>
  - <https://demre.cl/estadisticas/compendios-estadisticos>
- **Qué falta:** las bases individuales del proceso de admisión y los compendios; el reconocimiento atribuía `xlsx` a los compendios, sin confirmar. Nota: el mismo dato se publica por vía alterna en F079, que sí responde.
- **Campos bloqueados:** `variables`, `url_descarga`, `formato`, `cobertura_temporal`, `documentacion_tecnica`

## F076 — Resultados de admisión por unidad educativa (DEMRE)

- **base_datos y emisor:** Consulta de resultados · DEMRE
- **URL:** no hay. El reconocimiento la registró como mencionada sin URL directa, apuntando solo a una noticia de enero de 2025.
- **Qué falta:** ubicar la URL del buscador de resultados por establecimiento, si sigue publicado.
- **Campos bloqueados:** todos salvo `dato`, `emisor` y `usos_en_monitoreo`

## F078 — INDICES, bases de datos de educación superior (CNED)

- **base_datos y emisor:** INDICES · Consejo Nacional de Educación (CNED)
- **URL:** <https://www.cned.cl/bases-de-datos> — **HTTP 403**
- **Qué falta:** las bases de matrícula, vacantes, aranceles y oferta académica, y la documentación que el reconocimiento sitúa en <https://www.cned.cl/estadistica/indices-bd-institucional>.
- **Campos bloqueados:** `variables`, `url_descarga`, `formato`, `cobertura_temporal`

## F083 — Cuenta pública y reportabilidad local de un Servicio Local

- **base_datos y emisor:** Sitio institucional · Servicio Local de Educación Pública (SLEP)
- **URL:** <https://slepsantiagocentro.gob.cl/> — **HTTP 403**
- **Qué falta:** qué instrumentos publica (Plan Anual Local, Convenio de Gestión Educacional) y en qué formato. Es el sitio del SLEP Santiago Centro, inventariado como ejemplo de reportabilidad local: **no es el sitio del SLEP Costa Central**.
- **Campos bloqueados:** `variables`, `url_descarga`, `formato`, `cobertura_temporal`

---

# Bloque C — Acceso con credenciales institucionales

Tres fuentes que no se resuelven ni descargando ni abriendo el navegador: exigen
una cuenta, una afiliación o un trámite formal del Área.

## F053 — Plataforma de resultados para SLEP y sostenedores (Agencia de Calidad)

- **base_datos y emisor:** Plataforma de resultados · ACE
- **URL:** <https://resultadossimce.agenciaeducacion.cl/login> — **HTTP 404 en esa ruta**; el host sí resuelve
- **Qué falta:** la ruta de entrada vigente y el ingreso con las credenciales institucionales del SLEP. **Es la solicitud más pertinente de las 43**: es la vía institucional propia del servicio a sus resultados por establecimiento, con el detalle que el dato público no trae.
- **Campos bloqueados:** `variables`, `url_referencia` (por corregir), `formato`, `cobertura_temporal`, `documentacion_tecnica`

## F054 — Bases Simce a nivel de estudiante (Agencia de Calidad)

- **base_datos y emisor:** Simce · ACE
- **URL:** no hay descarga. La vía es **solicitud formal por Portal de Transparencia u OIRS**, confirmada en la sección Simce (F050).
- **Qué falta:** decidir si el Área cursa la solicitud formal; sin eso la fila no puede pasar de `Declarada sin verificar`.
- **Campos bloqueados:** `variables`, `url_descarga`, `formato`, `cobertura_temporal`, `periodicidad`, `documentacion_tecnica`, `fecha_verificacion`

## F077 — Sistema Nacional de Información de la Educación Superior (SIES)

- **base_datos y emisor:** SIES · Subsecretaría de Educación Superior (Mineduc)
- **URL:** <https://www.mifuturo.cl/sies/> — responde, pero **la descarga de búsquedas exige cuenta de usuario**
- **Qué falta:** una cuenta para descargar las bases de matrícula, titulación, personal académico y oferta de programas. El reconocimiento la clasificaba como abierta; en realidad no lo es.
- **Campos bloqueados:** `variables`, `url_descarga`, `llaves_de_union`, `cobertura_temporal` (parcial)
