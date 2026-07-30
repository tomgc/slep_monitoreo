# Solicitudes al titular — catálogo de fuentes

> Archivo acumulativo generado por el mecanismo de la enmienda E6 del encargo
> `20260730_encargo_verificacion_catalogo_fuentes_v3.md`.
> Se actualiza al cerrar cada tramo de 15 URLs. Las entradas resueltas **no se
> borran**: se marcan como resueltas y quedan como registro.
>
> Una solicitud significa que la página del emisor **no publica** el esquema de
> registros (el libro de códigos, como lo llama Datos Abiertos) ni los nombres
> de columna, y que **no existe copia local alcanzable** en un proyecto hermano.
> La fila del catálogo se emitió igual, con sus `NA`: una solicitud pendiente no
> bloquea el catálogo.
>
> Bajar los archivos es tarea manual del titular. Aquí solo se declara qué falta
> y desde qué URL exacta. Cuando los archivos queden en una ruta, se leen en
> solo lectura, se completan las filas y la entrada se marca resuelta.

**Estado al cierre del tramo 2:** 18 solicitudes acumuladas, todas pendientes
(8 del tramo 1, 10 del tramo 2). Ninguna resuelta todavía.

---

# Tramo 1 — 8 solicitudes
>
> *Actualizado antes del tramo 2:* las URL pasaron de ser la página del conjunto a
> ser el enlace directo al archivo. Los enlaces sí estaban expuestos como `<a href>`
> en las páginas; el primer fetch no los pidió.

---

## F003 — Matrícula educación parvularia

- **id_fuente:** F003
- **base_datos y emisor:** Datos Abiertos · Centro de Estudios del Ministerio de Educación (CEM)
- **URL de descarga:** <https://datosabiertos.mineduc.cl/wp-content/uploads/2025/12/Matricula-Parvularia-2025.rar> (año 2025; los demás años se listan en <https://datosabiertos.mineduc.cl/matricula-educacion-parvularia/>, `.rar` 2011-2025 y `.zip` 2019)
- **Qué falta:** esquema de registros y nombres de columna; la página solo describe el contenido en prosa.
- **Campos bloqueados:** `variables`, `unidad_de_analisis`, `llaves_de_union`, `datos_personales`, `documentacion_tecnica`

## F005 — Alumnos preferentes, prioritarios y beneficiarios SEP

- **id_fuente:** F005
- **base_datos y emisor:** Datos Abiertos · Centro de Estudios del Ministerio de Educación (CEM)
- **URL de descarga:** <https://datosabiertos.mineduc.cl/wp-content/uploads/2026/01/Alumnos-SEP-2025.rar> (año 2025; los demás años en <https://datosabiertos.mineduc.cl/alumnos-preferentes-prioritarios-y-beneficiarios-sep/>, `.rar` 2008-2025)
- **Qué falta:** esquema de registros y nombres de columna.
- **Campos bloqueados:** `variables`, `unidad_de_analisis`, `llaves_de_union`, `datos_personales`, `documentacion_tecnica`

## F006 — Sistema de Admisión Escolar (SAE)

- **id_fuente:** F006
- **base_datos y emisor:** Datos Abiertos · Centro de Estudios del Ministerio de Educación (CEM)
- **URL de descarga:** <https://datosabiertos.mineduc.cl/wp-content/uploads/2026/03/SAE_2025.rar> (año 2025; los demás años en <https://datosabiertos.mineduc.cl/sistema-de-admision-escolar-sae/>, `.rar` y `.zip` 2016-2025)
- **Qué falta:** esquema de registros y nombres de columna.
- **Campos bloqueados:** `variables`, `unidad_de_analisis`, `llaves_de_union`, `datos_personales`, `documentacion_tecnica`

## F007 — Directorio de establecimientos educacionales

- **id_fuente:** F007
- **base_datos y emisor:** Datos Abiertos · Centro de Estudios del Ministerio de Educación (CEM)
- **URL de descarga:** <https://datosabiertos.mineduc.cl/wp-content/uploads/2025/11/Directorio-Oficial-EE-2025.rar> (año 2025) y <https://datosabiertos.mineduc.cl/wp-content/uploads/2021/12/Directorio_oficial_EE_2004.csv> (año 2004, formato `.csv`). Índice completo en <https://datosabiertos.mineduc.cl/directorio-de-establecimientos-educacionales/>
- **Qué falta:** esquema de registros y nombres de columna; conviene un año `.csv` (2004-2012) y uno `.rar` reciente, porque el formato cambia y las columnas pueden no coincidir entre tramos.
- **Campos bloqueados:** `variables`, `llaves_de_union`, `documentacion_tecnica`

## F008 — Subvenciones a establecimientos educacionales

- **id_fuente:** F008
- **base_datos y emisor:** Datos Abiertos · Centro de Estudios del Ministerio de Educación (CEM)
- **URL de descarga:** <https://datosabiertos.mineduc.cl/wp-content/uploads/2026/06/Subvenciones-a-EE-2025.rar> (año 2025; los demás años en <https://datosabiertos.mineduc.cl/subvenciones-a-establecimientos-educacionales/>, `.rar` y `.zip` 2005-2025)
- **Qué falta:** esquema de registros, nombres de columna y periodicidad real de publicación (la página no la declara).
- **Campos bloqueados:** `variables`, `llaves_de_union`, `documentacion_tecnica`, `mes_publicacion`

## F009 — Matrícula longitudinal

- **id_fuente:** F009
- **base_datos y emisor:** Datos Abiertos · Centro de Estudios del Ministerio de Educación (CEM)
- **URL de descarga:** <https://datosabiertos.mineduc.cl/wp-content/uploads/2025/10/excel-matricula-longuitudinal-2010-2025_no_modificable.xlsx> (libro único, serie 2010-2025; la errata `longuitudinal` es del emisor y es parte de la URL)
- **Qué falta:** nombres de columna y estructura de hojas del libro; la página nombra las dimensiones de desglose pero no las columnas.
- **Campos bloqueados:** `variables`, `llaves_de_union`, `documentacion_tecnica`

## F010 — Tasas de incidencia de desvinculación

- **id_fuente:** F010
- **base_datos y emisor:** Datos Abiertos · Centro de Estudios del Ministerio de Educación (CEM)
- **URL de descarga:** <https://datosabiertos.mineduc.cl/wp-content/uploads/2025/10/OFICIAL-Tasa-Incidencia-Desvinculacion-2010-2024.xlsx> (libro único, serie 2010-2024)
- **Qué falta:** nombres de columna y definición de la tasa; también conviene confirmar por qué la serie termina en 2024 y no en 2025 como el resto del portal.
- **Campos bloqueados:** `variables`, `llaves_de_union`, `documentacion_tecnica`

## F011 — Practicantes y titulados técnico profesional

- **id_fuente:** F011
- **base_datos y emisor:** Datos Abiertos · Centro de Estudios del Ministerio de Educación (CEM)
- **URL de descarga:** <https://datosabiertos.mineduc.cl/wp-content/uploads/2026/06/Practicantes-y-Titulados-TP-2025.rar> (año 2025; los demás años en <https://datosabiertos.mineduc.cl/practicantes-y-titulados-tecnico-profesional/>, `.rar` 2013-2021 y 2023-2025, `.zip` 2022)
- **Qué falta:** esquema de registros y nombres de columna.
- **Campos bloqueados:** `variables`, `unidad_de_analisis`, `llaves_de_union`, `datos_personales`, `documentacion_tecnica`

---

# Tramo 2 — 10 solicitudes nuevas

Cuatro de estas entradas tienen una causa distinta a la del tramo 1: **el
servidor devuelve HTTP 403 a la herramienta de consulta**. Un 403 no es un
enlace roto —el host respondió— y lo más probable es que un navegador humano sí
alcance la página. Lo que se pide en esos casos no es el archivo, sino una
mirada desde navegador.

## F025 — Geodatos abiertos y cartografía censal (INE)

- **id_fuente:** F025
- **base_datos y emisor:** Geodatos Abiertos · Instituto Nacional de Estadísticas (INE)
- **URL de descarga:** <https://www.ine.gob.cl/herramientas/portal-de-mapas/geodatos-abiertos> (la página no expone enlaces directos de archivo en su HTML; las capas se descargan desde la interfaz)
- **Qué falta:** nombres de campos de las capas y URL directa de la capa de manzana del Censo 2024.
- **Campos bloqueados:** `variables`, `url_descarga`, `llaves_de_union`

## F026 — Microdatos del Censo 2017 a nivel de manzana (INE)

- **id_fuente:** F026
- **base_datos y emisor:** Portal ArcGIS Open Data · Instituto Nacional de Estadísticas (INE)
- **URL de descarga:** <https://geoine-ine-chile.opendata.arcgis.com/datasets/54e0c40680054efaabeb9d53b09e1e7a_0> — **devuelve HTTP 404**
- **Qué falta:** confirmar desde navegador si el conjunto sigue publicado. Se buscó la URL vigente y no se encontró una que responda: los buscadores siguen indexando este mismo identificador como conjunto vivo, y la variante sin sufijo de capa (<https://hub.arcgis.com/datasets/54e0c40680054efaabeb9d53b09e1e7a>) también devuelve 404. Rutas alternativas a probar: <https://ine-chile.maps.arcgis.com/home/item.html?id=54e0c40680054efaabeb9d53b09e1e7a> y el portal de geodatos abiertos (F025).
- **Campos bloqueados:** todos salvo `dato`, `emisor` y `cobertura_temporal`

## F027 — Estimaciones y proyecciones de población (INE)

- **id_fuente:** F027
- **base_datos y emisor:** Demografía y vitales · Instituto Nacional de Estadísticas (INE)
- **URL de descarga:** <https://www.ine.gob.cl/estadisticas/sociales/demografia-y-vitales/proyecciones-de-poblacion> (solo se observaron PDF; el reconocimiento le atribuía `xlsx`)
- **Qué falta:** confirmar si existen los archivos `xlsx` de proyecciones por comuna y su URL; hoy solo se ven infografías y síntesis en PDF.
- **Campos bloqueados:** `variables`, `url_descarga`, `formato` (parcial)

## F030 — Encuesta Casen (Observatorio Social)

- **id_fuente:** F030
- **base_datos y emisor:** Observatorio Social · Ministerio de Desarrollo Social y Familia (MDSF)
- **URL de descarga:** <https://observatorio.ministeriodesarrollosocial.gob.cl/encuesta-casen> (remite a la sección Base de Datos de cada año, sin enlaces directos)
- **Qué falta:** libro de códigos y URL de la base del año 2024; la página no expone ni documentación ni enlaces de archivo.
- **Campos bloqueados:** `variables`, `url_descarga`, `formato`, `llaves_de_union`, `documentacion_tecnica`, `datos_personales`

## F031 — Banco Integrado de Datos (BIDAT)

- **id_fuente:** F031
- **base_datos y emisor:** BIDAT · Ministerio de Desarrollo Social y Familia (MDSF)
- **URL de descarga:** <https://bidat.gob.cl/> (portada; los conjuntos cuelgan de sus fichas)
- **Qué falta:** esquema de las bases de pobreza comunal y Registro Social de Hogares, y sus URL de ficha.
- **Campos bloqueados:** `variables`, `url_descarga`, `llaves_de_union`, `cobertura_temporal`, `datos_personales`

## F032 — Indicadores territoriales del Observatorio Social

- **id_fuente:** F032
- **base_datos y emisor:** Observatorio Social · Ministerio de Desarrollo Social y Familia (MDSF)
- **URL de descarga:** <http://observatorio.ministeriodesarrollosocial.gob.cl/indicadores/> — **devuelve HTTP 403 a la herramienta**
- **Qué falta:** una revisión desde navegador que confirme qué reportes comunales ofrece y si permiten descarga.
- **Campos bloqueados:** `variables`, `url_descarga`, `formato`, `cobertura_temporal`, `documentacion_tecnica`, `condiciones_de_uso`

## F033 — Consulta interactiva de Casen (Redatam)

- **id_fuente:** F033
- **base_datos y emisor:** Redatam · Ministerio de Desarrollo Social y Familia (MDSF)
- **URL de descarga:** <https://redatam.org/redchl/mds/casen/> (aplicación de servidor; solo entregó su encabezado)
- **Qué falta:** años de Casen cubiertos, desagregación disponible y si exige registro. Requiere interactuar con la aplicación.
- **Campos bloqueados:** `cobertura_temporal`, `desagregacion_territorial`, `nivel_acceso` (por confirmar)

## F036 — Portal del DEIS

- **id_fuente:** F036
- **base_datos y emisor:** DEIS · Departamento de Estadísticas e Información de Salud (DEIS)
- **URL de descarga:** <https://deis.minsal.cl/> — **devuelve HTTP 403 a la herramienta**
- **Qué falta:** revisión desde navegador del catálogo de conjuntos y sus formatos; el reconocimiento advertía una migración en curso y conviene confirmar qué URL son estables.
- **Campos bloqueados:** `variables`, `url_descarga`, `formato`, `cobertura_temporal`, `periodicidad`, `documentacion_tecnica`

## F038 — Repositorio DEIS de indicadores básicos de salud

- **id_fuente:** F038
- **base_datos y emisor:** Repositorio DEIS · Departamento de Estadísticas e Información de Salud (DEIS)
- **URL de descarga:** <https://repositoriodeis.minsal.cl/> — **devuelve HTTP 403 a la herramienta**
- **Qué falta:** revisión desde navegador de las series disponibles y sus formatos.
- **Campos bloqueados:** `variables`, `url_descarga`, `formato`, `cobertura_temporal`, `periodicidad`

## F039 — Estudio Nacional de Drogas en Población Escolar 2023 (SENDA)

- **id_fuente:** F039
- **base_datos y emisor:** Observatorio Chileno de Drogas · Servicio Nacional para la Prevención y Rehabilitación del Consumo de Drogas y Alcohol (SENDA)
- **URL de descarga:** <https://www.senda.gob.cl/informacion-y-conocimiento/observatorio-chileno-drogas/base-de-datos/base-de-datos-estudio-nacional-de-poblacion-escolar-2023/> — **devuelve HTTP 403 a la herramienta**
- **Qué falta:** revisión desde navegador; el reconocimiento declaraba que la base exige registro, lo que no se pudo confirmar.
- **Campos bloqueados:** `variables`, `url_descarga`, `formato`, `nivel_acceso` (por confirmar), `documentacion_tecnica`
