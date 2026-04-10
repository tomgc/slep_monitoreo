"""
tmdb_lib.py — Helpers compartidos para hablar con la API de TMDB y
mantener actualizado data/movies.json + posters/.

Solo usa la stdlib (urllib + json) para no requerir `pip install`.

Convenciones:
    - Lee la API key de la env var TMDB_API_KEY o, si no, del archivo
      `.tmdb_key` en la raíz del repo (gitignored).
    - Soporta tanto la API key v3 (string corto) como el Read Access
      Token v4 (JWT que empieza con "ey").
"""

from __future__ import annotations

import json
import os
import sys
import urllib.parse
import urllib.request
from datetime import date
from pathlib import Path
from typing import Any

# ---------------------------------------------------------------------------
# Rutas del proyecto
# ---------------------------------------------------------------------------

REPO_ROOT = Path(__file__).resolve().parent.parent
DATA_FILE = REPO_ROOT / "data" / "movies.json"
POSTERS_DIR = REPO_ROOT / "posters"
KEY_FILE = REPO_ROOT / ".tmdb_key"

TMDB_API_BASE = "https://api.themoviedb.org/3"
TMDB_IMAGE_BASE = "https://image.tmdb.org/t/p"
POSTER_SIZE = "w500"  # buen balance calidad/peso

DEFAULT_LANG = "es-ES"


# ---------------------------------------------------------------------------
# Clave de API
# ---------------------------------------------------------------------------

class TMDBError(RuntimeError):
    pass


def load_api_key() -> tuple[str, str]:
    """Devuelve (api_key, kind) donde kind es 'v3' o 'v4'."""
    key = os.environ.get("TMDB_API_KEY", "").strip()
    if not key and KEY_FILE.exists():
        key = KEY_FILE.read_text(encoding="utf-8").strip()

    if not key:
        raise TMDBError(
            "No se encontró la API key de TMDB.\n"
            "Definila en la variable de entorno TMDB_API_KEY o creá el archivo "
            f"{KEY_FILE} con la clave.\n"
            "Cómo obtenerla → ver scripts/README.md"
        )

    kind = "v4" if key.startswith("ey") and "." in key else "v3"
    return key, kind


# ---------------------------------------------------------------------------
# HTTP a TMDB
# ---------------------------------------------------------------------------

def _request(path: str, params: dict[str, Any] | None = None) -> dict:
    api_key, kind = load_api_key()
    params = dict(params or {})

    headers = {"User-Agent": "movies-collection-script/1.0", "Accept": "application/json"}
    if kind == "v4":
        headers["Authorization"] = f"Bearer {api_key}"
    else:
        params["api_key"] = api_key

    qs = urllib.parse.urlencode(params, doseq=True)
    url = f"{TMDB_API_BASE}{path}?{qs}"

    req = urllib.request.Request(url, headers=headers)
    try:
        with urllib.request.urlopen(req, timeout=20) as resp:
            return json.loads(resp.read().decode("utf-8"))
    except urllib.error.HTTPError as e:
        body = e.read().decode("utf-8", errors="ignore")
        raise TMDBError(f"TMDB {e.code} en {path}: {body}") from e
    except urllib.error.URLError as e:
        raise TMDBError(f"Error de red llamando a TMDB: {e}") from e


def search_movies(query: str, year: int | None = None, lang: str = DEFAULT_LANG) -> list[dict]:
    params = {"query": query, "include_adult": "false", "language": lang}
    if year:
        params["year"] = str(year)
    data = _request("/search/movie", params)
    return data.get("results", [])


def get_movie_details(tmdb_id: int, lang: str = DEFAULT_LANG) -> dict:
    return _request(
        f"/movie/{tmdb_id}",
        {
            "language": lang,
            "append_to_response": "credits,keywords,external_ids",
        },
    )


# ---------------------------------------------------------------------------
# Mapeo TMDB → entrada de movies.json
# ---------------------------------------------------------------------------

def _year_from_release_date(s: str | None) -> int | None:
    if not s or len(s) < 4:
        return None
    try:
        return int(s[:4])
    except ValueError:
        return None


def _detect_type(genres: list[str]) -> str:
    return "documentary" if any(g.lower() == "documentary" or g.lower() == "documental" for g in genres) else "movie"


def _resolve_language_name(details: dict) -> str:
    iso = details.get("original_language") or ""
    for lang in details.get("spoken_languages", []) or []:
        if lang.get("iso_639_1") == iso:
            # preferimos el nombre traducido si existe; sino el inglés
            return lang.get("name") or lang.get("english_name") or iso
    return iso


def build_entry(details: dict, poster_local_path: str | None) -> dict:
    credits = details.get("credits") or {}
    crew = credits.get("crew") or []
    cast_raw = credits.get("cast") or []

    directors = [c.get("name") for c in crew if c.get("job") == "Director"]
    writers_jobs = {"Screenplay", "Writer", "Author", "Story", "Novel"}
    writers: list[str] = []
    for c in crew:
        if c.get("department") == "Writing" or c.get("job") in writers_jobs:
            name = c.get("name")
            if name and name not in writers:
                writers.append(name)

    cast = [c.get("name") for c in sorted(cast_raw, key=lambda x: x.get("order", 999))][:8]

    genres = [g.get("name") for g in (details.get("genres") or []) if g.get("name")]
    countries = [c.get("name") for c in (details.get("production_countries") or []) if c.get("name")]
    keywords = [k.get("name") for k in ((details.get("keywords") or {}).get("keywords") or []) if k.get("name")]

    external_ids = details.get("external_ids") or {}
    imdb_id = external_ids.get("imdb_id") or details.get("imdb_id")

    return {
        "tmdb_id": details.get("id"),
        "imdb_id": imdb_id,
        "title": details.get("title") or details.get("original_title") or "",
        "original_title": details.get("original_title") or "",
        "type": _detect_type(genres),
        "year": _year_from_release_date(details.get("release_date")),
        "runtime": details.get("runtime") or None,
        "original_language": _resolve_language_name(details),
        "countries": countries,
        "genres": genres,
        "keywords": keywords,
        "directors": [d for d in directors if d],
        "writers": writers,
        "cast": [c for c in cast if c],
        "synopsis": details.get("overview") or "",
        "tmdb_rating": round(float(details.get("vote_average") or 0), 1),
        "poster_path": poster_local_path,
        "added_date": date.today().isoformat(),
    }


# ---------------------------------------------------------------------------
# Descarga de portadas
# ---------------------------------------------------------------------------

def download_poster(tmdb_id: int, remote_poster_path: str | None) -> str | None:
    """Descarga la portada en posters/{tmdb_id}.jpg y devuelve la ruta relativa
    al repo (lista para usar como atributo `src` en el HTML)."""
    if not remote_poster_path:
        return None

    POSTERS_DIR.mkdir(parents=True, exist_ok=True)
    filename = f"{tmdb_id}.jpg"
    local_path = POSTERS_DIR / filename
    rel_path = f"posters/{filename}"

    if local_path.exists() and local_path.stat().st_size > 0:
        return rel_path

    url = f"{TMDB_IMAGE_BASE}/{POSTER_SIZE}{remote_poster_path}"
    req = urllib.request.Request(url, headers={"User-Agent": "movies-collection-script/1.0"})
    try:
        with urllib.request.urlopen(req, timeout=30) as resp:
            local_path.write_bytes(resp.read())
    except (urllib.error.HTTPError, urllib.error.URLError) as e:
        print(f"  ! No se pudo descargar la portada: {e}", file=sys.stderr)
        return None

    return rel_path


# ---------------------------------------------------------------------------
# Persistencia de movies.json
# ---------------------------------------------------------------------------

def load_collection() -> list[dict]:
    if not DATA_FILE.exists():
        return []
    text = DATA_FILE.read_text(encoding="utf-8").strip()
    if not text:
        return []
    return json.loads(text)


def save_collection(movies: list[dict]) -> None:
    DATA_FILE.parent.mkdir(parents=True, exist_ok=True)
    DATA_FILE.write_text(
        json.dumps(movies, ensure_ascii=False, indent=2) + "\n",
        encoding="utf-8",
    )


def find_in_collection(movies: list[dict], tmdb_id: int) -> int:
    """Devuelve el índice del título o -1 si no está."""
    for i, m in enumerate(movies):
        if m.get("tmdb_id") == tmdb_id:
            return i
    return -1


# ---------------------------------------------------------------------------
# Flujo de alto nivel — agregar un único título
# ---------------------------------------------------------------------------

def add_movie_by_tmdb_id(tmdb_id: int, lang: str = DEFAULT_LANG, *, allow_update: bool = False) -> dict:
    """Trae los detalles, descarga la portada y persiste en movies.json.
    Devuelve la entrada agregada (o actualizada).
    """
    details = get_movie_details(tmdb_id, lang=lang)
    poster_local = download_poster(details.get("id"), details.get("poster_path"))
    entry = build_entry(details, poster_local)

    movies = load_collection()
    idx = find_in_collection(movies, entry["tmdb_id"])
    if idx >= 0:
        if not allow_update:
            return movies[idx]
        movies[idx] = entry
    else:
        movies.append(entry)

    save_collection(movies)
    return entry
