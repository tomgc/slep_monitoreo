# Área de Monitoreo — SLEP Costa Central

Sitio institucional de presentación del Área de Monitoreo de Procesos y Resultados Educativos. Publicado en **<https://tomgc.github.io/slep_monitoreo/>** vía GitHub Pages desde la rama `main`.

## Stack

Página única, estática, sin dependencias externas. Todo el CSS y JS vive inline en `index.html`. Compatible con cualquier navegador moderno. Layout en bento grid (6 columnas) con sidebar fija a la izquierda y paleta oficial SLEP Costa Central.

```
.
├── index.html              # Sitio principal (bento, v2.1)
├── datos/
│   └── fuentes.js          # window.FUENTES — generado por R (no editar a mano)
├── og-image.svg            # Fuente del preview social (1200x630)
├── og-image.png            # Renderizado para Open Graph / Twitter
├── scripts/
│   └── regenerate-og-image.sh
├── variants/               # Direcciones visuales alternativas
│   ├── index.html          # Galería de variantes
│   ├── classic.html        # v1.4 navy/azul (sitio anterior)
│   ├── editorial.html      # Long-form serifa
│   ├── institucional.html  # Documento institucional
│   └── fuentes-galaxia.html # Prototipo: galaxia de fuentes por institución
└── README.md
```

## Cómo editar el contenido

Todos los datos están como `const` al inicio del bloque `<script>` en `index.html`, agrupados por tipo. Para actualizar contenido, editar el array correspondiente:

| Dato | Variable | Campos |
|---|---|---|
| Equipo | `equipo` | `nombre`, `cargo`, `mail`, `color`, `iniciales` |
| Glosario | `glosario` | `sigla`, `def` |
| Hitos de la trayectoria | `hitos` | `fecha`, `titulo`, `desc` |
| Productos / entregables | `productos` | `tag`, `color`, `barColor`, `titulo`, `desc`, `bars[]` |
| Indicadores (KPIs) | hardcoded en HTML | tarjetas `.card.kpi.{blue,green,coral}` con `data-fill` |
| Ámbitos de actuación | hardcoded en HTML | tarjetas `.ambito-card.{purple,blue,green}` |

Las variantes en `variants/` replican estos datos en cada archivo. Si actualizás contenido del sitio principal, hay que propagar los cambios manualmente.

## Estructura del repositorio

Además de los archivos del sitio (listados arriba), el repo está organizado en "decenas" temáticas para separar insumos, procesamiento y documentación:

```
.
├── 10_insumos/          # Datos crudos, fuentes externas
│   └── fuentes/
├── 20_procesamiento/    # Scripts de transformación, notebooks, pipelines
├── 30_documentacion/    # Documentación del proyecto y de procesos
│   ├── activa/          # Documentación viva (specs, notas en curso)
│   ├── traspasos/       # Traspasos de cierre y entregas formales
│   └── estructura/      # Decisiones de arquitectura / convenciones
└── _archivo/            # Snapshots locales (no versionados)
```

Convenciones:

- Las carpetas se numeran de a 10 (`10_`, `20_`, `30_`) para permitir intercalar nuevas decenas sin renombrar las existentes.
- Solo se crean decenas cuando hay contenido real para alojar (sin saltos).
- Las subcarpetas vacías mantienen un archivo `.gitkeep` para que git las preserve.
- `_archivo/` queda fuera del repo (`.gitignore`) y aloja snapshots locales pre-refactor.

### Pipeline de datos (Fuentes)

La sección "Fuentes utilizadas" del sitio consume `datos/fuentes.js`, que se genera de manera reproducible desde el Excel maestro:

```
10_insumos/fuentes/fuentes_informacion_2026.xlsx
        │
        ▼ (Rscript con readxl + dplyr + janitor + jsonlite)
20_procesamiento/21_generar_fuentes.R
        │
        ▼ (escribe window.FUENTES como .js)
datos/fuentes.js
        │
        ▼ (<script src> en index.html y variants/fuentes-galaxia.html)
sitio publicado
```

Para actualizar los datos del catálogo:

1. Editar `10_insumos/fuentes/fuentes_informacion_2026.xlsx`.
2. Correr `Rscript 20_procesamiento/21_generar_fuentes.R` desde la raíz del repo.
3. Verificar el resumen impreso en stdout (totales por ámbito, función, institución).
4. Commit del `.xlsx` modificado + `datos/fuentes.js` regenerado.

**No editar `datos/fuentes.js` a mano** — sus 3 primeras líneas son el aviso. El script auto-instala paquetes faltantes en su primera corrida y fuerza locale UTF-8 al inicio para preservar tildes.

## Cómo regenerar el preview social

`og-image.png` es la imagen que muestran WhatsApp, Facebook, LinkedIn y otros al compartir el link. Se genera a partir de `og-image.svg`:

```bash
bash scripts/regenerate-og-image.sh
```

Requiere Google Chrome o Chromium instalado. La salida es un PNG de 1200×630 en la raíz del repo.

## Variantes de diseño

En `variants/` viven tres direcciones visuales alternativas. Sirven como exploración paralela del mismo contenido.

| Variante | URL | Dirección |
|---|---|---|
| Clásico | `variants/classic.html` | Navy/azul, sidebar fija, sticky h2 (el sitio anterior) |
| Editorial | `variants/editorial.html` | Long-form serifa, columna angosta, paleta cálida |
| Institucional | `variants/institucional.html` | Alto contraste, geométrico, tono documento oficial |

Índice de las tres: `variants/index.html`.

## Paleta oficial SLEP Costa Central

| Hex | Uso |
|---|---|
| `#4A2746` | Morado — texto, brand |
| `#FFF6E0` | Crema — tinte de acento (no bg) |
| `#0062A0` | Azul — primario, enlaces |
| `#747474` | Gris — muted |
| `#75924E` | Verde — indicadores positivos |
| `#BCA493` | Beige — hairlines |
| `#E88663` | Coral — acento cálido |

Fondo de página siempre blanco.

## Versionado

La versión visible aparece en el footer y en la meta del hero (actualmente `2.1`). Convención: bump menor por cambios visuales o de contenido, bump mayor por reescrituras o cambios de identidad.

## Changelog

### 2.1 — 2026-05-27

- Sección "Fuentes utilizadas" en el index: matriz interactiva ámbito × función + buscador + lista de detalle. 67 fuentes, 12 instituciones, 6 funciones presentes.
- Pipeline de datos: Excel maestro en `10_insumos/fuentes/` → script R en `20_procesamiento/` → `datos/fuentes.js` consumido por el HTML.
- Prototipo experimental `variants/fuentes-galaxia.html`: galaxia de nodos agrupados por institución como cuarta entrada de la galería de variantes.
- Reorganización interna del repo en decenas (`10_insumos`, `20_procesamiento`, `30_documentacion`) — el sitio publicado y el workflow de Pages no cambiaron.

### 2.0 — 2026-05

- Promoción del diseño bento/dashboard a sitio principal: grilla compacta de tarjetas, KPIs prominentes en morado, azul, verde y coral.
- Paleta oficial SLEP Costa Central adoptada como sistema de diseño.
- `og-image.png` regenerado con la nueva identidad (morado + coral).
- Sidebar reemplaza el patrón de nav del clásico con brand mark y pills de navegación.
- El diseño anterior (v1.4 navy/azul) preservado como `variants/classic.html`.

### 1.4 — 2026-05

- Open Graph + Twitter Card con `og-image.png` (1200×630).
- Modo oscuro automático vía `prefers-color-scheme`.
- Modo impresión (`@media print`): timeline en grilla, glosario en dos columnas.
- Mini-mockups SVG específicos por categoría de producto.
- Fades laterales en la timeline con detección de scroll en los extremos.
- Animación de entrada con stagger para los hitos.
- Refactor: indicadores destacados pasan a renderizarse desde `const indicadores`.
- `scripts/regenerate-og-image.sh` para reproducir el preview social.

### 1.3 — 2026-05

- Nueva sección "Trayectoria" con línea de tiempo horizontal de 6 hitos.
- Sección "Ejemplos de trabajo" enriquecida con grid de 4 productos.
- Tarjeta de indicadores ampliada a tres barras animadas.

### 1.2 — 2026-04

- Versión base del rediseño unificado del sitio (estructura, tabs, glosario, equipo).
