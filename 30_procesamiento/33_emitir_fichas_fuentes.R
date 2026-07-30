# ==============================================================================
# 33_emitir_fichas_fuentes.R
#
# Proposito : fase 3 del encargo. Genera el .md de fichas DESDE el CSV. El .md
#             nunca se edita a mano: se regenera corriendo este script.
# Insumos   : 40_salidas/catalogo_fuentes.csv
#             40_salidas/solicitudes_al_titular.md (solo para contar pendientes)
# Salidas   : 40_salidas/catalogo_fuentes_fichas.md
# Contrato  : encargo seccion 7, con el esquema de 29 campos de las enmiendas
#             E1-E9. Cada ficha lista los 27 campos restantes (los 29 menos
#             id_fuente y dato, que van en el encabezado de la ficha).
#
# Forma exigida: sin tablas de mas de 4 columnas, URLs como texto plano, ningun
# caracter de barra vertical dentro de una celda de tabla.
# ==============================================================================

for (p in c("dplyr", "readr", "here", "glue")) {
  if (!requireNamespace(p, quietly = TRUE)) install.packages(p)
}

library(dplyr)
library(readr)
library(here)
library(glue)

RUTA_CSV  <- here("40_salidas", "catalogo_fuentes.csv")
RUTA_SOL  <- here("40_salidas", "solicitudes_al_titular.md")
RUTA_MD   <- here("40_salidas", "catalogo_fuentes_fichas.md")
VERSION   <- "1.0"
GENERADO  <- "2026-07-30"

catalogo <- read_csv(RUTA_CSV, show_col_types = FALSE, na = character())

# Los 27 campos de la ficha: el esquema menos id_fuente y dato.
CAMPOS_FICHA <- setdiff(names(catalogo), c("id_fuente", "dato"))
stopifnot("la ficha debe listar 27 campos" = length(CAMPOS_FICHA) == 27)

# Ninguna barra vertical puede entrar a una celda de tabla (forma exigida).
limpiar_celda <- function(x) gsub("|", "/", x, fixed = TRUE)

out <- character()
w <- function(...) out <<- c(out, ...)

# ---- 1. Encabezado ----
w(glue("# Catalogo de fuentes de datos del Area de Monitoreo"))
w("")
w(glue("- **Version:** {VERSION}"))
w(glue("- **Fecha de generacion:** {GENERADO}"))
w(glue("- **CSV de origen:** `40_salidas/catalogo_fuentes.csv`"))
w(glue("- **Generado por:** `30_procesamiento/33_emitir_fichas_fuentes.R`"))
w("")
w("> **Archivo generado. No se edita a mano.** Toda correccion se hace sobre el")
w("> script que declara las filas (`31_catalogo_fuentes_filas.R`), se revalida con")
w("> `32_validar_catalogo_fuentes.R` y se vuelve a emitir. Una edicion manual de")
w("> este archivo se pierde en la siguiente corrida.")
w("")

# ---- Estado de completitud (pedido explicito del titular) ----
w("## Estado de completitud")
w("")
w("Que parte de este catalogo esta verificada y que parte es promesa.")
w("")

est <- catalogo |> count(estado_verificacion, name = "fuentes", sort = TRUE) |>
  mutate(pct = sprintf("%.1f%%", 100 * fuentes / sum(fuentes)))
w("| Estado de verificacion | Fuentes | Porcentaje |")
w("|---|---|---|")
for (i in seq_len(nrow(est))) {
  w(glue("| {est$estado_verificacion[i]} | {est$fuentes[i]} | {est$pct[i]} |"))
}
w(glue("| **Total** | **{sum(est$fuentes)}** | **100,0%** |"))
w("")

n_desc <- sum(catalogo$url_descarga != "NA")
n_vars <- sum(catalogo$variables != "NA")
n_copia <- sum(catalogo$copia_local != "NA")
n_doc  <- sum(catalogo$documentacion_tecnica != "NA")

w("| Completitud de campos clave | Fuentes | De un total de |")
w("|---|---|---|")
w(glue("| Con enlace de descarga directo | {n_desc} | {nrow(catalogo)} |"))
w(glue("| Con nombres de variable | {n_vars} | {nrow(catalogo)} |"))
w(glue("| Con copia local en un proyecto hermano | {n_copia} | {nrow(catalogo)} |"))
w(glue("| Con documentacion tecnica identificada | {n_doc} | {nrow(catalogo)} |"))
w("")

# Solicitudes pendientes por bloque, leidas del propio archivo de solicitudes.
if (file.exists(RUTA_SOL)) {
  sol <- readLines(RUTA_SOL, warn = FALSE)
  fila_a <- grep("^\\| \\*\\*A\\*\\*", sol, value = TRUE)
  fila_b <- grep("^\\| \\*\\*B\\*\\*", sol, value = TRUE)
  fila_c <- grep("^\\| \\*\\*C\\*\\*", sol, value = TRUE)
  extraer <- function(x) {
    if (!length(x)) return(NA_character_)
    p <- trimws(strsplit(x, "|", fixed = TRUE)[[1]])
    gsub("\\*", "", p[length(p)])
  }
  w("| Solicitudes pendientes al titular | Fuentes | Que se necesita |")
  w("|---|---|---|")
  w(glue("| Bloque A | {extraer(fila_a)} | Descargar el archivo y ponerlo a disposicion |"))
  w(glue("| Bloque B | {extraer(fila_b)} | Abrir desde navegador, por 403 o falla de transporte |"))
  w(glue("| Bloque C | {extraer(fila_c)} | Acceso con credenciales institucionales |"))
  w("")
  w(glue("**Quedan {extraer(fila_a)} solicitudes en el bloque A, ",
         "{extraer(fila_b)} en el B y {extraer(fila_c)} en el C.** ",
         "Mientras esas fuentes no se resuelvan, sus fichas conservan sus `NA`: ",
         "el catalogo no las inventa."))
  w("")
  w("El detalle vive en `40_salidas/solicitudes_al_titular.md`.")
  w("")
}

# ---- 2. Como leer este catalogo ----
w("## Como leer este catalogo")
w("")
w("1. La unidad de la ficha es una **fuente de datos**: un conjunto publicado por un emisor, no un portal ni un archivo suelto. Un portal con quince conjuntos produce quince fichas mas, si corresponde, la del portal mismo.")
w("2. `NA` significa **no observado**, nunca cero ni vacio. Una ficha con seis `NA` vale mas que una completa adivinada: lo que no se abrio no se escribe.")
w("3. `estado_verificacion` dice que tan firme es la ficha. **Verificada**: se abrio y se observo. **URL viva sin descarga confirmada**: el host respondio pero el contenido no se pudo recuperar. **Enlace roto** y **No encontrada**: la direccion ya no resuelve. **Declarada sin verificar**: existe segun el reconocimiento, nadie la abrio.")
w("4. Los campos multivalor (`formato`, `variables`, `llaves_de_union`, `fuente_equivalente`) separan sus valores con punto y coma.")
w("5. `copia_local` nombra la **raiz de datos** de un proyecto hermano donde el archivo ya esta descargado, no el repositorio. Cuando aparece, los campos tecnicos se leyeron de esa copia y no de la pagina web.")
w("")

# ---- 3. Resumen ----
w("## Resumen")
w("")

resumir <- function(col, titulo) {
  t <- catalogo |> count(.data[[col]], name = "fuentes", sort = TRUE)
  w(glue("### Por {titulo}"))
  w("")
  w(glue("| {titulo} | Fuentes |"))
  w("|---|---|")
  for (i in seq_len(nrow(t))) {
    w(glue("| {limpiar_celda(t[[col]][i])} | {t$fuentes[i]} |"))
  }
  w(glue("| **Total** | **{sum(t$fuentes)}** |"))
  w("")
}

resumir("emisor", "emisor")
resumir("nivel_acceso", "nivel de acceso")
resumir("subambito", "subambito")
resumir("estado_verificacion", "estado de verificacion")

# ---- 4. Indice ----
w("## Indice")
w("")
for (sa in sort(unique(catalogo$subambito))) {
  filas <- catalogo |> filter(subambito == sa) |> arrange(id_fuente)
  w(glue("**{sa}**"))
  w("")
  for (i in seq_len(nrow(filas))) {
    w(glue("- `{filas$id_fuente[i]}` {filas$dato[i]}"))
  }
  w("")
}

# ---- 5. Fichas ----
w("## Fichas")
w("")
for (sa in sort(unique(catalogo$subambito))) {
  w(glue("### {sa}"))
  w("")
  filas <- catalogo |> filter(subambito == sa) |> arrange(id_fuente)
  for (i in seq_len(nrow(filas))) {
    w(glue("#### {filas$id_fuente[i]} · {filas$dato[i]}"))
    w("")
    for (campo in CAMPOS_FICHA) {
      w(glue("- **{campo}:** {filas[[campo]][i]}"))
    }
    w("")
  }
}

# ---- 6. Vacios conocidos ----
w("## Vacios conocidos")
w("")
w("Las fuentes cuyo `estado_verificacion` no es `Verificada`, con su observacion.")
w("")
vacios <- catalogo |> filter(estado_verificacion != "Verificada") |> arrange(id_fuente)
w("| Fuente | Estado | Observacion |")
w("|---|---|---|")
for (i in seq_len(nrow(vacios))) {
  w(glue("| {vacios$id_fuente[i]} {limpiar_celda(vacios$dato[i])} | ",
         "{vacios$estado_verificacion[i]} | {limpiar_celda(vacios$observaciones[i])} |"))
}
w("")
w(glue("**{nrow(vacios)} de {nrow(catalogo)} fuentes** no estan verificadas."))
w("")

# ---- Escritura ----
writeLines(out, RUTA_MD, useBytes = TRUE)

cat("== Fase 3. Emision de las fichas ==\n")
cat("  filas del CSV      :", nrow(catalogo), "\n")
cat("  campos por ficha   :", length(CAMPOS_FICHA), "\n")
cat("  lineas del .md     :", length(out), "\n")
cat("  escrito            :", RUTA_MD, "\n")
