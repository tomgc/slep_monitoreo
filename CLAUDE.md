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
    (snake_case). **Versionados** desde el 2026-08-02, por decisión del
    titular: son el registro metodológico del trabajo del Área, del mismo
    tipo que el backlog que ya era público. El repositorio es público por
    diseño, de modo que se redactan sabiendo que quedan legibles en
    `github.com/tomgc/slep_monitoreo`: sin nombres de establecimientos, RBD,
    RUT, correos ni rutas locales. Al versionarse, este repo vuelve a quedar
    dentro de la regla 1.3.1 de `POLITICA_PROYECTO.md` (traspaso vigente: un
    solo archivo a la vista, el resto en `traspasos/archivo/`) y del bloque 1
    del protocolo §4.7 de `SETTINGS_Y_PROMPTS_OPERACIONALES.md`, que la
    ejecuta.
  - `estructura/` — snapshots del escáner.
- **Pipeline de R para el catálogo de fuentes** (desde la sesión 11), con las
  decenas de la política §1.1:
  - `20_insumos/` — insumos de solo lectura. Contiene
    `resultado_reconocimiento_fuentes.md`, el inventario de URLs candidatas que
    produjo la investigación de reconocimiento del 2026-07-29. Conserva su
    nombre original por la excepción de §1.2.4 (dato heredado de fuente
    externa).
  - `30_procesamiento/` — scripts del flujo, con correlativos por orden de
    ejecución (`31_`, `32_`, `33_`).
  - `40_salidas/` — el catálogo de fuentes en CSV, las fichas en Markdown y el
    log de verificación. Nombre descriptivo sin fecha (política §2).
  - Ninguna de las tres se publica: Pages sirve solo `main` `/docs`.

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

- Sin orquestador `00_run_all.R`. El pipeline del catálogo de fuentes tiene una
  compuerta humana en medio: la verificación de URLs de su fase 1 no es
  automatizable y ocurre entre el parseo y la validación. Un orquestador que no
  puede correr de extremo a extremo declara una automatización que no existe.
  Cada script de `30_procesamiento/` se corre por separado.
- Sin `10_utils/`: la política §1.4 exige duplicación real para migrar una
  función a utils, y todavía no la hay. Deja un hueco en la decena 10 que la
  política §1.2.3 desaconseja; se declara en vez de fabricar una carpeta vacía.
  Cuando dos scripts de `30_procesamiento/` compartan una función, se crea.
- El escáner de estructura (`00_escanear_proyecto.R`) y el validador del atlas
  (`00_validar_atlas.js`) siguen en la raíz con prefijo `00_`: son herramientas
  transversales, no etapas del flujo, y la política §2 admite varios `00_*`.
- El escáner usa dos versiones fijas (actual/anterior) en vez de snapshots sellados
  con timestamp y poda de retención 2 (se aparta de la política 7.3-7.4; simplificación
  para un sitio estático que cambia poco).
- Los traspasos de sesión y `backlog_acumulado.md` **sí se versionan** (desde el
  2026-08-02) y viajan con el repositorio: ya no hay que adjuntarlos a mano al
  abrir cada sesión. Pages sirve solo `main` `/docs`, pero el repositorio
  completo es público y navegable en `github.com`: eso, y no Pages, es lo que
  determina qué queda a la vista. Los logs de encargos ejecutados
  (`50_documentacion/andamios/logs/*.md`) siguen la misma regla; los encargos y
  maquetas de `50_documentacion/andamios/` siguen ignorados por caducos.
