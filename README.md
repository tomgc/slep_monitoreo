# Área de Monitoreo — SLEP Costa Central

Sitio institucional de presentación del Área de Monitoreo de Procesos y Resultados Educativos. Publicado en **<https://tomgc.github.io/monitoreo/>** vía GitHub Pages desde la rama `main`.

## Stack

Página única, estática, sin dependencias externas. Todo el CSS y JS vive inline en `index.html`. Compatible con cualquier navegador moderno.

```
.
├── index.html              # Sitio completo (HTML + CSS + JS inline)
├── og-image.svg            # Fuente del preview social (1200x630)
├── og-image.png            # Renderizado para Open Graph / Twitter
├── scripts/
│   └── regenerate-og-image.sh
└── README.md
```

## Cómo editar el contenido

Todos los datos están como `const` al inicio del bloque `<script>` en `index.html`, agrupados por tipo. Para actualizar contenido, editar el array correspondiente:

| Dato | Variable | Campos |
|---|---|---|
| Equipo | `equipo` | `nombre`, `cargo`, `mail` |
| Glosario | `glosario` | `sigla`, `def` |
| Ámbitos de actuación | `lineasDeTrabajo` | clave (`establecimientos`, `central`, `capacidades`) → texto HTML |
| Hitos de la trayectoria | `hitos` | `fecha`, `titulo`, `desc` |
| Productos / entregables | `productos` | `categoria`, `titulo`, `desc`, `icono` (clave de `ICONS`) |
| Indicadores destacados | `indicadores` | `titulo`, `items[]` con `label` y `valor` (0–100) |

Las siglas declaradas en `glosario` reciben tooltips automáticos en todo párrafo de la primera sección, en las descripciones de hitos y en las de productos.

## Cómo regenerar el preview social

`og-image.png` es la imagen que muestran WhatsApp, Facebook, LinkedIn y otros al compartir el link. Se genera a partir de `og-image.svg`:

```bash
bash scripts/regenerate-og-image.sh
```

Requiere Google Chrome o Chromium instalado. El script busca el binario en rutas estándar de macOS y Linux. La salida es un PNG de 1200×630 en la raíz del repo.

Editar el diseño en `og-image.svg` y volver a correr el script para propagar cambios.

## Versionado

La versión visible aparece en el footer de `index.html` (actualmente `1.4`). Convención: bump menor por cambios visuales o de contenido, bump mayor por reescrituras.

## Changelog

### 1.4 — 2026-05

- Open Graph + Twitter Card con `og-image.png` (1200×630).
- Modo oscuro automático vía `prefers-color-scheme`.
- Modo impresión (`@media print`): timeline en grilla, glosario en dos columnas, ocultamiento de nav y barra de progreso.
- Mini-mockups SVG específicos por categoría de producto (reporte, dashboard, análisis, taller).
- Fades laterales en la timeline con detección de scroll en los extremos.
- Animación de entrada con stagger para los hitos.
- Enlace al sitio institucional del SLEP Costa Central en el footer.
- Refactor: indicadores destacados pasan a renderizarse desde `const indicadores`, consistente con el resto de los datasets.
- `scripts/regenerate-og-image.sh` para reproducir el preview social desde `og-image.svg`.
- README expandido.

### 1.3 — 2026-05

- Nueva sección "Trayectoria" con línea de tiempo horizontal de 6 hitos.
- Sección "Ejemplos de trabajo" enriquecida con grid de 4 productos.
- Tarjeta de indicadores ampliada a tres barras animadas.

### 1.2 — 2026-04

- Versión base del rediseño unificado del sitio (estructura, tabs, glosario, equipo).
