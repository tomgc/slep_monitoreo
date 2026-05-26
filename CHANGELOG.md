# Changelog

Cambios al **repositorio**. Los cambios al **sitio publicado** se documentan
en la sección "Changelog" del [README.md](README.md).

## Sin publicar

### Repositorio

- Reorganizar estructura del repo según norma de decenas: nuevas carpetas `10_insumos/`, `20_procesamiento/`, `30_documentacion/{activa,traspasos,estructura}`.
- Mover `docs/traspasos/traspaso-cierre-v01.md` a `30_documentacion/traspasos/` preservando historial (`git mv`).
- Eliminar carpeta `docs/` (quedó vacía tras la migración).
- Crear `.gitignore` con `.DS_Store` y `_archivo/`.
- Snapshot pre-reorganización guardado localmente en `_archivo/20260526/` (no versionado).

Sitio sin cambios: `index.html`, `variants/`, `scripts/`, `og-image.*` y el workflow de GitHub Pages (`.github/workflows/static.yml`) quedan intactos.
