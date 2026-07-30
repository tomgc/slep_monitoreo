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

**Estado al cierre del tramo 1:** 8 solicitudes, todas pendientes.

---

## F003 — Matrícula educación parvularia

- **id_fuente:** F003
- **base_datos y emisor:** Datos Abiertos · Centro de Estudios del Ministerio de Educación (CEM)
- **URL de descarga:** <https://datosabiertos.mineduc.cl/matricula-educacion-parvularia/> (archivos anuales `.rar` 2011-2025 y `.zip` 2019, listados en esa página)
- **Qué falta:** esquema de registros y nombres de columna; la página solo describe el contenido en prosa.
- **Campos bloqueados:** `variables`, `unidad_de_analisis`, `llaves_de_union`, `datos_personales`, `documentacion_tecnica`

## F005 — Alumnos preferentes, prioritarios y beneficiarios SEP

- **id_fuente:** F005
- **base_datos y emisor:** Datos Abiertos · Centro de Estudios del Ministerio de Educación (CEM)
- **URL de descarga:** <https://datosabiertos.mineduc.cl/alumnos-preferentes-prioritarios-y-beneficiarios-sep/> (archivos anuales `.rar` 2008-2025)
- **Qué falta:** esquema de registros y nombres de columna.
- **Campos bloqueados:** `variables`, `unidad_de_analisis`, `llaves_de_union`, `datos_personales`, `documentacion_tecnica`

## F006 — Sistema de Admisión Escolar (SAE)

- **id_fuente:** F006
- **base_datos y emisor:** Datos Abiertos · Centro de Estudios del Ministerio de Educación (CEM)
- **URL de descarga:** <https://datosabiertos.mineduc.cl/sistema-de-admision-escolar-sae/> (archivos anuales `.rar` y `.zip` 2016-2025)
- **Qué falta:** esquema de registros y nombres de columna.
- **Campos bloqueados:** `variables`, `unidad_de_analisis`, `llaves_de_union`, `datos_personales`, `documentacion_tecnica`

## F007 — Directorio de establecimientos educacionales

- **id_fuente:** F007
- **base_datos y emisor:** Datos Abiertos · Centro de Estudios del Ministerio de Educación (CEM)
- **URL de descarga:** <https://datosabiertos.mineduc.cl/directorio-de-establecimientos-educacionales/> (formato mixto por rango de años: `.rar` en 1992-1997 y 2013-2025, `.csv` en 2004-2012, `.zip` en 1998-2003)
- **Qué falta:** esquema de registros y nombres de columna; conviene un año `.csv` (2004-2012) y uno `.rar` reciente, porque el formato cambia y las columnas pueden no coincidir entre tramos.
- **Campos bloqueados:** `variables`, `llaves_de_union`, `documentacion_tecnica`

## F008 — Subvenciones a establecimientos educacionales

- **id_fuente:** F008
- **base_datos y emisor:** Datos Abiertos · Centro de Estudios del Ministerio de Educación (CEM)
- **URL de descarga:** <https://datosabiertos.mineduc.cl/subvenciones-a-establecimientos-educacionales/> (archivos anuales `.rar` y `.zip` 2005-2025)
- **Qué falta:** esquema de registros, nombres de columna y periodicidad real de publicación (la página no la declara).
- **Campos bloqueados:** `variables`, `llaves_de_union`, `documentacion_tecnica`, `mes_publicacion`

## F009 — Matrícula longitudinal

- **id_fuente:** F009
- **base_datos y emisor:** Datos Abiertos · Centro de Estudios del Ministerio de Educación (CEM)
- **URL de descarga:** <https://datosabiertos.mineduc.cl/matricula-longitudinal/> (libro `.xlsx` único con la serie 2010-2025)
- **Qué falta:** nombres de columna y estructura de hojas del libro; la página nombra las dimensiones de desglose pero no las columnas.
- **Campos bloqueados:** `variables`, `llaves_de_union`, `documentacion_tecnica`

## F010 — Tasas de incidencia de desvinculación

- **id_fuente:** F010
- **base_datos y emisor:** Datos Abiertos · Centro de Estudios del Ministerio de Educación (CEM)
- **URL de descarga:** <https://datosabiertos.mineduc.cl/desvinculacion/> (libro `.xlsx` único, publicado como `OFICIAL Tasa-Incidencia-Desvinculación-2010-2024`)
- **Qué falta:** nombres de columna y definición de la tasa; también conviene confirmar por qué la serie termina en 2024 y no en 2025 como el resto del portal.
- **Campos bloqueados:** `variables`, `llaves_de_union`, `documentacion_tecnica`

## F011 — Practicantes y titulados técnico profesional

- **id_fuente:** F011
- **base_datos y emisor:** Datos Abiertos · Centro de Estudios del Ministerio de Educación (CEM)
- **URL de descarga:** <https://datosabiertos.mineduc.cl/practicantes-y-titulados-tecnico-profesional/> (archivos anuales `.rar` 2013-2021 y 2023-2025, `.zip` 2022)
- **Qué falta:** esquema de registros y nombres de columna.
- **Campos bloqueados:** `variables`, `unidad_de_analisis`, `llaves_de_union`, `datos_personales`, `documentacion_tecnica`
