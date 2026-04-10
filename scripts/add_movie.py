#!/usr/bin/env python3
"""
add_movie.py — Agrega un título a la colección buscando en TMDB.

Uso:
    python scripts/add_movie.py "El secreto de sus ojos"
    python scripts/add_movie.py "Parasite" --year 2019
    python scripts/add_movie.py "Senna" --lang en-US

Flujo:
    1. Busca en TMDB por título (opcionalmente filtra por año).
    2. Muestra las coincidencias numeradas.
    3. El usuario elige la correcta.
    4. Descarga metadatos y portada.
    5. Actualiza data/movies.json.
"""

from __future__ import annotations

import argparse
import sys
from pathlib import Path

# Agregar el directorio del script al path para importar tmdb_lib
sys.path.insert(0, str(Path(__file__).resolve().parent))

import tmdb_lib


def format_result(i: int, r: dict) -> str:
    title = r.get("title") or r.get("original_title") or "(sin título)"
    orig = r.get("original_title") or ""
    year = (r.get("release_date") or "")[:4] or "????"
    rating = r.get("vote_average", 0)
    overview = (r.get("overview") or "")[:100]
    if len(r.get("overview") or "") > 100:
        overview += "…"

    line = f"  [{i}] {title}"
    if orig and orig != title:
        line += f"  ({orig})"
    line += f"  [{year}]  ★ {rating:.1f}"
    if overview:
        line += f"\n      {overview}"
    return line


def main() -> None:
    parser = argparse.ArgumentParser(
        description="Agrega una película o documental a la colección desde TMDB.",
    )
    parser.add_argument("title", help="Título a buscar en TMDB")
    parser.add_argument("--year", type=int, default=None, help="Año de estreno (opcional, para refinar)")
    parser.add_argument("--lang", default=tmdb_lib.DEFAULT_LANG, help="Idioma para metadatos (default: es-ES)")
    parser.add_argument("--auto", action="store_true", help="Elegir automáticamente el primer resultado")
    args = parser.parse_args()

    # 1. Buscar
    print(f'\nBuscando "{args.title}" en TMDB…\n')
    try:
        results = tmdb_lib.search_movies(args.title, year=args.year, lang=args.lang)
    except tmdb_lib.TMDBError as e:
        print(f"Error: {e}", file=sys.stderr)
        sys.exit(1)

    if not results:
        print("No se encontraron resultados. Probá con otro nombre o agregá --year.")
        sys.exit(0)

    # 2. Mostrar
    show = results[:10]
    for i, r in enumerate(show, 1):
        print(format_result(i, r))
        print()

    # 3. Elegir
    if args.auto:
        choice = 1
        print(f"(--auto) Seleccionando [{choice}] automáticamente.\n")
    else:
        try:
            raw = input(f"Elegí un número (1-{len(show)}) o 0 para cancelar: ").strip()
            choice = int(raw)
        except (ValueError, EOFError):
            print("Cancelado.")
            sys.exit(0)

    if choice < 1 or choice > len(show):
        print("Cancelado.")
        sys.exit(0)

    selected = show[choice - 1]
    tmdb_id = selected["id"]

    # ¿Ya existe en la colección?
    collection = tmdb_lib.load_collection()
    idx = tmdb_lib.find_in_collection(collection, tmdb_id)
    if idx >= 0:
        existing = collection[idx]
        print(f'"{existing["title"]}" ya está en la colección (tmdb_id={tmdb_id}).')
        try:
            ans = input("¿Actualizar los datos? (s/N): ").strip().lower()
        except EOFError:
            ans = "n"
        if ans not in ("s", "si", "sí", "y", "yes"):
            print("Sin cambios.")
            sys.exit(0)
        allow_update = True
    else:
        allow_update = False

    # 4. Descargar metadatos y portada
    sel_title = selected.get("title") or selected.get("original_title") or ""
    print(f'\nDescargando datos de "{sel_title}"…')
    try:
        entry = tmdb_lib.add_movie_by_tmdb_id(tmdb_id, lang=args.lang, allow_update=allow_update)
    except tmdb_lib.TMDBError as e:
        print(f"Error: {e}", file=sys.stderr)
        sys.exit(1)

    # 5. Confirmar
    tipo = "Documental" if entry.get("type") == "documentary" else "Película"
    print(f'\n  ✓ {tipo} agregada: {entry["title"]} ({entry.get("year", "?")})')
    print(f'    Director(es): {", ".join(entry.get("directors") or ["-"])}')
    print(f'    Géneros: {", ".join(entry.get("genres") or ["-"])}')
    if entry.get("poster_path"):
        print(f"    Portada: {entry['poster_path']}")
    print()
    print("Ahora podés hacer commit y push para actualizar el sitio:")
    print('    git add data/movies.json posters/')
    print(f'    git commit -m "Agregar: {entry["title"]} ({entry.get("year", "")})"')
    print("    git push")
    print()


if __name__ == "__main__":
    main()
