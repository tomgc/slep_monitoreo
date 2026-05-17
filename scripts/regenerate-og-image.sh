#!/usr/bin/env bash
# Regenera og-image.png a partir de og-image.svg.
#
# Requiere: Google Chrome (o Chromium) instalado.
# Salida:   og-image.png a 1200x630, listo para Open Graph / Twitter Card.
#
# Uso:      bash scripts/regenerate-og-image.sh
#           (ejecutar desde la raíz del repo)

set -euo pipefail

# Resolución estándar de Open Graph
WIDTH=1200
HEIGHT=630

SVG="og-image.svg"
OUT="og-image.png"

# Buscar Chrome / Chromium en rutas conocidas
CHROME_CANDIDATES=(
    "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
    "/Applications/Chromium.app/Contents/MacOS/Chromium"
    "/usr/bin/google-chrome"
    "/usr/bin/chromium"
    "/usr/bin/chromium-browser"
)

CHROME=""
for candidate in "${CHROME_CANDIDATES[@]}"; do
    if [ -x "$candidate" ]; then
        CHROME="$candidate"
        break
    fi
done

if [ -z "$CHROME" ]; then
    echo "Error: no se encontró Chrome/Chromium en ninguna ruta conocida." >&2
    echo "Instalar Google Chrome o ajustar CHROME_CANDIDATES en este script." >&2
    exit 1
fi

if [ ! -f "$SVG" ]; then
    echo "Error: no se encuentra $SVG en el directorio actual." >&2
    echo "Ejecutar este script desde la raíz del repo." >&2
    exit 1
fi

echo "Regenerando $OUT desde $SVG (${WIDTH}x${HEIGHT})..."

"$CHROME" \
    --headless \
    --disable-gpu \
    --no-sandbox \
    --hide-scrollbars \
    --window-size="${WIDTH},${HEIGHT}" \
    --screenshot="$OUT" \
    "file://$(pwd)/$SVG" >/dev/null 2>&1

if [ ! -f "$OUT" ]; then
    echo "Error: Chrome no produjo $OUT." >&2
    exit 1
fi

echo "Listo: $OUT ($(file -b "$OUT"))"
