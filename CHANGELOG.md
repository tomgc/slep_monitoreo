# Changelog

Cambios al **repositorio**. Los cambios al **sitio publicado** se documentan
en la sección "Changelog" del [README.md](README.md).

## Sin publicar

(sin cambios pendientes)

## v2.1 — 2026-05-27

### Agregado

- Script `20_procesamiento/21_generar_fuentes.R` que genera `datos/fuentes.js` desde el Excel maestro en `10_insumos/fuentes/`.
- Sección "Fuentes utilizadas" en `index.html`: matriz interactiva ámbito × función con buscador y lista de detalle. 67 fuentes, 12 instituciones, 6 funciones presentes.
- Prototipo `variants/fuentes-galaxia.html`: galaxia de nodos agrupados por institución. Cuarta entrada en la galería de variantes.

### Cambios estructurales

- Reorganización del repo en decenas (10/20/30) según norma. `docs/traspasos/` movido a `30_documentacion/traspasos/` con historial preservado.
- `.gitignore`: agregados `.DS_Store`, `_archivo/`, `.claude/`.

### Casos pendientes de normalización

- "CNT-CEM" (2 filas): institución ambigua.
- "Base de datos SIGE - CNT / DEP" (4 filas): dato en campo equivocado.
