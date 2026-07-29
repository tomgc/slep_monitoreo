# CLAUDE.md — slep_monitoreo

## Qué es

Sitio institucional estático del **Área de Monitoreo** del SLEP Costa Central.
Publicado en GitHub Pages desde **`main` `/docs`**:
<https://tomgc.github.io/slep_monitoreo/>.

## Stack

- HTML + CSS + JavaScript vanilla. Sin frameworks, sin paso de build.
- Tipografías: **gobCL** y **Museo Sans** (en `fonts/`, cargadas por `colors_and_type.css`).
- Contenido editable en `data.js` (`PROYECTOS`, `HITOS`).
- Capturas de los proyectos en `assets/proyectos/`.

## Reglas duras

- **El sitio vive en `docs/`.** `index.html`, `app.js`, `styles.css`,
  `colors_and_type.css`, `data.js`, `.nojekyll`, `assets/` y `fonts/` viven ahí y no
  se mueven ni a la raíz ni a otra subcarpeta: GitHub Pages los sirve desde
  `main` `/docs` y moverlos rompe el deploy. La raíz dejó de ser el docroot para
  que Pages no publique `50_documentacion/`, `CLAUDE.md` ni los `.R` (PR #4).
- **Idioma: español neutro latinoamericano, SIN voseo.** Nada de "seleccioná", "usá",
  "reemplazá", "querés". Usar "tú" o formas impersonales. Aplica a código, comentarios,
  contenido del sitio y mensajes de commit.
- **`data.js`:** el campo `imgs` de cada proyecto es un arreglo de rutas; la primera es
  la portada del banner; si el arreglo está vacío, se muestra el marcador "próximamente".
- **`git push` SIEMPRE requiere aprobación explícita del usuario.**

## Estructura

Aplicación **pragmática** de `POLITICA_PROYECTO.md` (en `50_documentacion/activa/`):

- El sitio vive en `docs/`, carpeta sin prefijo de decena: GitHub Pages solo
  admite la raíz del repositorio o `/docs` como origen, y la raíz se descartó
  para no publicar el resto del repositorio (PR #4).
- `50_documentacion/` agrupa la documentación:
  - `activa/` — política y documentos vigentes.
  - `traspasos/` — traspasos de cierre de sesión y `backlog_acumulado.md`
    (snake_case). **Gitignored**: no se versionan (GitHub Pages publica todo
    el repo y no deben ser públicos).
  - `estructura/` — snapshots del escáner.
- **Sin pipeline de R:** la feature "Fuentes" y su procesamiento se retiraron en v1.0.

## Escáner de estructura

`00_escanear_proyecto.R` regenera el inventario del repositorio. Genera dos
versiones fijas en `50_documentacion/estructura/`: `estructura_actual.*`
(corrida más reciente) y `estructura_anterior.*` (corrida previa). Cada corrida
pisa, sin acumular snapshots con timestamp. Conviene correrlo al abrir o cerrar
sesión, o después de reorganizar:

```bash
Rscript 00_escanear_proyecto.R
```

## Excepciones declaradas

- Sin orquestador `00_run_all.R`: no hay pipeline de R que orquestar.
- Sin `10_utils/` ni decenas de procesamiento: no hay código R de proceso.
- El **único** script de R es el escáner de estructura (`00_escanear_proyecto.R`),
  que es herramienta de estructura, no procesamiento de datos.
- El escáner usa dos versiones fijas (actual/anterior) en vez de snapshots sellados
  con timestamp y poda de retención 2 (se aparta de la política 7.3-7.4; simplificación
  para un sitio estático que cambia poco).
- Los traspasos de sesión y `backlog_acumulado.md` NO se versionan: viven en
  `50_documentacion/traspasos/` pero están **gitignored** porque GitHub Pages
  publica todo el repo y no deben ser públicos. Se adjuntan a mano al abrir
  cada sesión.
