# Changelog

Cambios al **repositorio**. Los cambios al **sitio publicado** se documentan
en la sección "Changelog" del [README.md](README.md).

## Sin publicar

### Agregado

- Sección "Fuentes utilizadas" en `index.html`: matriz interactiva ámbito × función con buscador y lista de detalle. Consume `datos/fuentes.js`. 67 fuentes, 12 instituciones, 6 funciones presentes (la 5 está ausente del catálogo).
- Script `20_procesamiento/21_generar_fuentes.R` que genera `datos/fuentes.js` desde el Excel maestro en `10_insumos/fuentes/`. 67 fuentes mapeadas con modelo de arrays en `funcion_num` y `funcion_label` para soportar fuentes con múltiples funciones (2 casos: DIA y Cuestionarios de contexto SIMCE, ambos en funciones 2 y 3).
- Normalización de instituciones vía diccionario explícito en el script: 10 filas normalizadas (1 CEM-SIGE + 9 variantes Junji). Resultado: 12 instituciones únicas.

### Casos pendientes de normalización

Identificados en el listado de instituciones del Excel, requieren input institucional para resolverse en próxima iteración:

- "CNT-CEM" (2 filas) — ambiguo: puede ser CEM abreviado o CNT (Coordinación Nacional Técnica de SIGE) distinto de CEM.
- "Base de datos SIGE - CNT / DEP" (4 filas) — parece dato en campo equivocado: es una base de datos, no una institución.

### Repositorio

- Reorganizar estructura del repo según norma de decenas: nuevas carpetas `10_insumos/`, `20_procesamiento/`, `30_documentacion/{activa,traspasos,estructura}`.
- Mover `docs/traspasos/traspaso-cierre-v01.md` a `30_documentacion/traspasos/` preservando historial (`git mv`).
- Eliminar carpeta `docs/` (quedó vacía tras la migración).
- Crear `.gitignore` con `.DS_Store` y `_archivo/`.
- Snapshot pre-reorganización guardado localmente en `_archivo/20260526/` (no versionado).

Sitio sin cambios: `index.html`, `variants/`, `scripts/`, `og-image.*` y el workflow de GitHub Pages (`.github/workflows/static.yml`) quedan intactos.
