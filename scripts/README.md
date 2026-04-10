# Scripts de gestión — Colección de películas

Scripts en Python 3.9+ para agregar títulos a la colección usando la API
de [TMDB](https://www.themoviedb.org/) (The Movie Database). No requieren
instalar dependencias externas (solo la stdlib).

---

## 1. Obtener una API key de TMDB (gratis)

1. Andá a <https://www.themoviedb.org/signup> y creá una cuenta.
2. Confirmá tu email haciendo click en el enlace que te mandan.
3. Iniciá sesión y andá a **Perfil → Configuración → API**
   (<https://www.themoviedb.org/settings/api>).
4. En la sección **Request an API Key**, hacé click en **click here** (bajo
   la descripción de Developer).
5. Aceptá los términos de uso.
6. Completá el formulario:
   - **Type of use**: Personal
   - **Application name**: Mi colección de películas (o lo que quieras)
   - **Application URL**: la URL de tu GitHub Pages o `N/A`
   - **Application summary**: "Sitio estático personal para organizar mi
     colección de películas y documentales."
7. Enviá el formulario. TMDB te da al instante:
   - **API Key (v3 auth)**: un string corto tipo `a1b2c3d4e5f6…`
   - **API Read Access Token (v4 auth)**: un JWT largo que empieza con `ey…`

   Cualquiera de los dos sirve. El script los detecta automáticamente.

## 2. Configurar la clave

Elegí **una** de estas opciones:

### Opción A: Variable de entorno (recomendada)

```bash
export TMDB_API_KEY="tu_clave_aquí"
```

Para que persista, agregala a tu `~/.bashrc`, `~/.zshrc` o `.envrc`.

### Opción B: Archivo local en la raíz del repo

```bash
echo "tu_clave_aquí" > .tmdb_key
```

Este archivo ya está en `.gitignore` — nunca se commitea.

---

## 3. Uso

### Agregar un título

```bash
python scripts/add_movie.py "El secreto de sus ojos"
```

El script busca en TMDB, te muestra hasta 10 coincidencias numeradas,
elegís la correcta y listo: descarga la portada y actualiza `data/movies.json`.

Opciones:

| Flag     | Descripción                                         |
|----------|-----------------------------------------------------|
| `--year` | Año de estreno para refinar la búsqueda             |
| `--lang` | Idioma de metadatos (default: `es-ES`)              |
| `--auto` | Elige automáticamente el primer resultado           |

Ejemplos:

```bash
python scripts/add_movie.py "Parasite" --year 2019
python scripts/add_movie.py "Senna" --lang en-US
python scripts/add_movie.py "Roma" --auto
```

### Importar varios títulos de golpe

Creá un archivo de texto con un título por línea (opcionalmente con año
separado por coma):

```
El secreto de sus ojos, 2009
Parasite, 2019
Senna, 2010
Roma
The Act of Killing, 2012
```

```bash
python scripts/bulk_import.py lista.txt
python scripts/bulk_import.py lista.txt --auto   # sin preguntar
```

También acepta stdin:

```bash
echo -e "Parasite\nRoma" | python scripts/bulk_import.py - --auto
```

---

## 4. Publicar los cambios

Después de agregar títulos:

```bash
git add data/movies.json posters/
git commit -m "Agregar: Título de la película (año)"
git push
```

GitHub Pages se actualiza automáticamente al pushear a la rama configurada.

---

## Estructura de datos

Cada entrada en `data/movies.json` tiene este esquema:

```json
{
  "tmdb_id": 1234,
  "imdb_id": "tt1234567",
  "title": "Título en español",
  "original_title": "Título original",
  "type": "movie",
  "year": 2019,
  "runtime": 132,
  "original_language": "Español",
  "countries": ["Argentina"],
  "genres": ["Drama", "Thriller"],
  "keywords": ["venganza", "memoria"],
  "directors": ["Juan José Campanella"],
  "writers": ["Eduardo Sacheri", "Juan José Campanella"],
  "cast": ["Ricardo Darín", "Soledad Villamil"],
  "synopsis": "Texto de la sinopsis…",
  "tmdb_rating": 8.2,
  "poster_path": "posters/1234.jpg",
  "added_date": "2026-04-10"
}
```

- `type` se detecta automáticamente: si TMDB clasifica el título como
  "Documentary"/"Documental", se marca `"documentary"`, sino `"movie"`.
- `genres[0]` es el género primario; el resto son subgéneros.
- `keywords` son las etiquetas (tags) de TMDB para ese título.
