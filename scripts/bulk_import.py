#!/usr/bin/env python3
"""
bulk_import.py — Importa una lista de títulos a la colección desde TMDB.

Uso:
    python scripts/bulk_import.py lista.txt
    python scripts/bulk_import.py lista.txt --auto
    echo -e "Parasite\\nRoma\\nSenna" | python scripts/bulk_import.py -

Formato del archivo:
    Un título por línea. Opcionalmente podés agregar el año con una coma:
        El secreto de sus ojos, 2009
        Parasite
        Senna, 2010

Modos:
    Interactivo (default): para cada título muestra coincidencias y pedís
                           que elijas.
    --auto:               toma automáticamente el primer resultado de TMDB.
"""

from __future__ import annotations

import argparse
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

import tmdb_lib


def parse_line(line: str) -> tuple[str, int | None]:
    """Parsea 'Título, 2009' → ('Título', 2009) o 'Título' → ('Título', None)."""
    line = line.strip()
    if not line:
        return "", None
    # intentar split por la última coma
    if "," in line:
        parts = line.rsplit(",", 1)
        candidate = parts[1].strip()
        if candidate.isdigit() and 1880 <= int(candidate) <= 2100:
            return parts[0].strip(), int(candidate)
    return line, None


def format_result(i: int, r: dict) -> str:
    title = r.get("title") or r.get("original_title") or "(sin título)"
    year = (r.get("release_date") or "")[:4] or "????"
    return f"  [{i}] {title} [{year}]  ★ {r.get('vote_average', 0):.1f}"


def process_title(
    query: str,
    year: int | None,
    lang: str,
    auto: bool,
) -> bool:
    """Procesa un único título. Devuelve True si se agregó/actualizó."""
    print(f'\n{"="*60}')
    print(f'Buscando: "{query}"{f" ({year})" if year else ""}')
    print("=" * 60)

    try:
        results = tmdb_lib.search_movies(query, year=year, lang=lang)
    except tmdb_lib.TMDBError as e:
        print(f"  ✗ Error: {e}", file=sys.stderr)
        return False

    if not results:
        print("  ✗ Sin resultados.")
        return False

    show = results[:8]

    if auto:
        choice = 1
        r = show[0]
        t = r.get("title") or r.get("original_title") or ""
        y = (r.get("release_date") or "")[:4]
        print(f"  (auto) → {t} [{y}]")
    else:
        for i, r in enumerate(show, 1):
            print(format_result(i, r))
        print()
        try:
            raw = input(f"  Elegí (1-{len(show)}) o 0 para saltar: ").strip()
            choice = int(raw)
        except (ValueError, EOFError):
            print("  → Saltado.")
            return False
        if choice < 1 or choice > len(show):
            print("  → Saltado.")
            return False

    selected = show[choice - 1]
    tmdb_id = selected["id"]

    # verificar duplicado
    collection = tmdb_lib.load_collection()
    idx = tmdb_lib.find_in_collection(collection, tmdb_id)
    if idx >= 0:
        print(f'  → Ya existe: "{collection[idx]["title"]}" — saltando.')
        return False

    try:
        entry = tmdb_lib.add_movie_by_tmdb_id(tmdb_id, lang=lang)
    except tmdb_lib.TMDBError as e:
        print(f"  ✗ Error descargando datos: {e}", file=sys.stderr)
        return False

    tipo = "Doc" if entry.get("type") == "documentary" else "Pel"
    print(f'  ✓ [{tipo}] {entry["title"]} ({entry.get("year", "?")})')
    return True


def main() -> None:
    parser = argparse.ArgumentParser(
        description="Importa múltiples títulos a la colección desde TMDB.",
    )
    parser.add_argument(
        "file",
        help='Archivo con un título por línea, o "-" para stdin',
    )
    parser.add_argument("--auto", action="store_true", help="Elegir automáticamente el primer resultado")
    parser.add_argument("--lang", default=tmdb_lib.DEFAULT_LANG, help="Idioma TMDB (default: es-ES)")
    args = parser.parse_args()

    # Leer líneas
    if args.file == "-":
        lines = sys.stdin.read().splitlines()
    else:
        p = Path(args.file)
        if not p.exists():
            print(f"Error: no se encontró el archivo '{args.file}'", file=sys.stderr)
            sys.exit(1)
        lines = p.read_text(encoding="utf-8").splitlines()

    titles = [(q, y) for q, y in (parse_line(l) for l in lines) if q]

    if not titles:
        print("No se encontraron títulos en el input.")
        sys.exit(0)

    print(f"\n{len(titles)} título(s) a procesar.\n")

    added = 0
    failed = 0
    skipped = 0

    for query, year in titles:
        ok = process_title(query, year, args.lang, args.auto)
        if ok:
            added += 1
        else:
            # distinguir "ya existe" vs "error" no es esencial aquí
            skipped += 1

    print(f"\n{'='*60}")
    print(f"Resultado: {added} agregada(s), {skipped} saltada(s)/error(es).")
    print("=" * 60)

    if added > 0:
        print("\nPara publicar los cambios:")
        print('    git add data/movies.json posters/')
        print(f'    git commit -m "Agregar {added} título(s) vía bulk_import"')
        print("    git push")
    print()


if __name__ == "__main__":
    main()
