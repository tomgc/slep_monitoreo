# 20_procesamiento/21_generar_fuentes.R
#
# Genera datos/fuentes.js desde el Excel maestro de Fuentes.
# Lee 10_insumos/fuentes/fuentes_informacion_2026.xlsx (hoja "Fuentes de información"),
# normaliza columnas y emite window.FUENTES = [...].
#
# NO editar datos/fuentes.js a mano: re-correr este script.

# Locale UTF-8 (Rscript desde shell puede entrar en locale "C", lo que rompe
# tildes y warnings de iconv).
intentar_locale <- function(candidatos) {
  for (l in candidatos) {
    ok <- suppressWarnings(Sys.setlocale("LC_ALL", l))
    if (nzchar(ok)) return(invisible(ok))
  }
  invisible("")
}
intentar_locale(c("es_CL.UTF-8", "es_ES.UTF-8", "en_US.UTF-8", "C.UTF-8"))

# Warnings inmediatos
options(warn = 1)

# --- 1. Auto-instalación de paquetes ---
paquetes <- c("readxl", "dplyr", "janitor", "glue", "jsonlite", "here")
faltantes <- paquetes[!vapply(paquetes, requireNamespace, logical(1), quietly = TRUE)]
if (length(faltantes) > 0) {
  install.packages(faltantes, repos = "https://cloud.r-project.org")
}
suppressPackageStartupMessages({
  library(readxl)
  library(dplyr)
  library(janitor)
  library(glue)
  library(jsonlite)
  library(here)
})

# --- 2. Helpers ---

# Limpieza universal de strings: NBSP → espacio, colapsa espacios horizontales
# múltiples, trim, "" / "NA" → NA. Preserva \n para luego splittear funciones.
limpiar_string <- function(x) {
  if (length(x) == 0) return(character(0))
  x <- as.character(x)
  x <- gsub(" ", " ", x, fixed = TRUE)
  x <- gsub("[ \t]+", " ", x, perl = TRUE)
  x <- trimws(x)
  x[x == "" | x == "NA"] <- NA_character_
  x
}

# Primera frase: hasta el primer . ? ! o \n
primera_frase <- function(x) {
  if (length(x) == 0 || is.na(x) || !nzchar(trimws(x))) return(NA_character_)
  m <- regmatches(x, regexpr("^[^.?!\n]+[.?!]?", x, perl = TRUE))
  if (length(m) == 0 || !nzchar(m)) return(trimws(x))
  trimws(m)
}

# Primera letra de ámbito → "A" o "B", o NA
primera_letra_ambito <- function(x) {
  if (is.na(x)) return(NA_character_)
  l <- toupper(substr(trimws(x), 1, 1))
  if (l %in% c("A", "B")) l else NA_character_
}

# Sí / No → "publica" / "privada" / "indefinido"
normalizar_si_no <- function(x) {
  if (is.na(x)) return("indefinido")
  v <- tolower(trimws(x))
  v <- gsub("[áÁ]", "a", v)
  v <- gsub("[éÉ]", "e", v)
  v <- gsub("[íÍ]", "i", v)
  v <- gsub("[óÓ]", "o", v)
  v <- gsub("[úÚ]", "u", v)
  v <- gsub("[ñÑ]", "n", v)
  v <- gsub("[^a-z]", "", v)
  if (identical(v, "si")) return("publica")
  if (identical(v, "no")) return("privada")
  "indefinido"
}

# Fechas: POSIXct/Date → "YYYY-MM-DD", otros → string limpio
formatear_columna_fecha <- function(col) {
  if (inherits(col, "POSIXct") || inherits(col, "POSIXt") || inherits(col, "Date")) {
    out <- format(col, "%Y-%m-%d")
    out[is.na(col)] <- NA_character_
    out
  } else {
    limpiar_string(col)
  }
}

# Parsear el string de funciones (puede traer varias separadas por \n).
# Devuelve list(num = integer[], label = character[]).
parsear_funciones <- function(texto) {
  if (is.na(texto) || !nzchar(trimws(texto))) {
    return(list(num = integer(0), label = character(0)))
  }
  t <- gsub(" ", " ", texto, fixed = TRUE)
  partes <- strsplit(t, "\r\n|\n|\r", perl = TRUE)[[1]]
  partes <- trimws(partes)
  partes <- partes[nzchar(partes)]

  nums <- integer(length(partes))
  labels <- character(length(partes))
  for (i in seq_along(partes)) {
    m <- regmatches(partes[i], regexec("^(\\d+)\\.\\s*(.+)$", partes[i], perl = TRUE))[[1]]
    if (length(m) == 3) {
      nums[i]   <- as.integer(m[2])
      labels[i] <- gsub("[ \t]+", " ", m[3], perl = TRUE)
    } else {
      nums[i]   <- NA_integer_
      labels[i] <- gsub("[ \t]+", " ", partes[i], perl = TRUE)
    }
  }
  list(num = nums, label = labels)
}

# --- 3. Diccionario explícito de normalizaciones de institución ---
# No inventar mapeos. Agregar entradas solo cuando el usuario confirme.
#
# Las claves con tilde usan í ("í") para evitar problemas de copy-paste
# entre editores; los bytes coinciden con los del Excel (verificado por hexdump).
normalizaciones_inst <- c(
  "Centro de Estudios Mineduc (CEM -SIGE)" = "Centro de Estudios Mineduc (CEM)",

  # Junji: 3 variantes del Excel colapsan a la forma canónica
  # "Junta Nacional de Jardines Infantiles y Salas Cunas (Junji)"
  # (sin tilde en "Jardines", con sufijo "(Junji)")
  "Junta Nacional de Jardínes Infantiles y Salas Cunas (Junji)"            = "Junta Nacional de Jardines Infantiles y Salas Cunas (Junji)",
  "Junta Nacional de Jardínes Infantiles y Salas Cunas (Junji - Gesparvu)" = "Junta Nacional de Jardines Infantiles y Salas Cunas (Junji)",
  "Junta Nacional de Jardines Infantiles y Salas Cunas"                         = "Junta Nacional de Jardines Infantiles y Salas Cunas (Junji)"

  # Casos pendientes de input del usuario (no normalizar todavía):
  # - "CNT-CEM" (2 filas): ¿es Centro de Estudios Mineduc?
  # - "Base de datos SIGE - CNT / DEP" (4 filas): parece base de datos, no institución.
)

# --- 4. Leer Excel ---
ruta_xlsx <- here::here("10_insumos", "fuentes", "fuentes_informacion_2026.xlsx")
stopifnot("No existe el Excel maestro" = file.exists(ruta_xlsx))

hojas <- excel_sheets(ruta_xlsx)
cat("Hojas detectadas en el Excel:\n  ", paste(hojas, collapse = " | "), "\n\n", sep = "")
hoja_principal <- hojas[grepl("fuentes", hojas, ignore.case = TRUE)]
if (length(hoja_principal) == 0) stop("No encontré una hoja con 'fuentes' en el nombre.")
hoja_principal <- hoja_principal[1]
cat("Leyendo hoja: '", hoja_principal, "'\n\n", sep = "")

raw <- read_excel(ruta_xlsx, sheet = hoja_principal) |> clean_names()

cat("Filas leídas: ", nrow(raw), "\n", sep = "")
cat("Columnas detectadas (después de clean_names):\n")
for (n in names(raw)) cat("  - ", n, "\n", sep = "")
cat("\n")

# --- 5. Check defensivo de columnas esperadas ---
columnas_esperadas <- c(
  "variable_o_indicador", "nombre_base_de_datos", "fuente_de_informacion",
  "proveedor_de_la_informacion_al_slep", "ambito_de_actuacion",
  "principal_funcion_unidad_de_monitoreo_a_la_que_responde",
  "tipo_de_modalidad_oferta_educativa", "unidad_de_analisis",
  "informacion_publica", "periodicidad", "fecha_de_corte",
  "fecha_de_extraccion", "fecha_publicacion_envio", "consideraciones"
)
faltantes_cols <- setdiff(columnas_esperadas, names(raw))
if (length(faltantes_cols) > 0) {
  cat("ATENCIÓN: columnas esperadas faltantes (se rellenan como NA):\n")
  for (c in faltantes_cols) {
    cat("  - ", c, "\n", sep = "")
    raw[[c]] <- NA
  }
  cat("\n")
}

# --- 6. Mapeo + limpieza universal de strings ---
fuentes <- raw |>
  mutate(
    nombre_largo      = limpiar_string(variable_o_indicador),
    base_datos        = limpiar_string(nombre_base_de_datos),
    institucion       = limpiar_string(fuente_de_informacion),
    proveedor         = limpiar_string(proveedor_de_la_informacion_al_slep),
    modalidad         = limpiar_string(tipo_de_modalidad_oferta_educativa),
    unidad_analisis   = limpiar_string(unidad_de_analisis),
    periodicidad      = limpiar_string(periodicidad),
    nota              = limpiar_string(consideraciones),
    ambito            = vapply(ambito_de_actuacion, primera_letra_ambito, character(1)),
    acceso            = vapply(informacion_publica, normalizar_si_no, character(1)),
    fecha_corte       = formatear_columna_fecha(fecha_de_corte),
    fecha_extraccion  = formatear_columna_fecha(fecha_de_extraccion),
    fecha_publicacion = formatear_columna_fecha(fecha_publicacion_envio)
  )
fuentes$nombre_corto <- vapply(fuentes$nombre_largo, primera_frase, character(1))

# --- 7. Parsear funciones (split por \n + extraer número + label) ---
funciones_parsed <- lapply(
  fuentes$principal_funcion_unidad_de_monitoreo_a_la_que_responde,
  parsear_funciones
)
fuentes$funcion_num   <- lapply(funciones_parsed, \(x) x$num)
fuentes$funcion_label <- lapply(funciones_parsed, \(x) x$label)

# --- 8. Aplicar normalizaciones de institución ---
mask <- !is.na(fuentes$institucion) & fuentes$institucion %in% names(normalizaciones_inst)
n_norm <- sum(mask)
if (n_norm > 0) {
  cat("Normalizaciones aplicadas a 'institucion': ", n_norm, " fila(s)\n", sep = "")
  for (origen in names(normalizaciones_inst)) {
    if (origen %in% fuentes$institucion[mask]) {
      cat("  - '", origen, "' -> '", normalizaciones_inst[[origen]], "'\n", sep = "")
    }
  }
  fuentes$institucion[mask] <- normalizaciones_inst[fuentes$institucion[mask]]
  cat("\n")
}

# --- 9. ID único y estable ---
fuentes <- fuentes |>
  mutate(
    id_base = make_clean_names(paste(
      coalesce(variable_o_indicador, ""),
      coalesce(nombre_base_de_datos, ""),
      coalesce(proveedor_de_la_informacion_al_slep, ""),
      sep = "_"
    ))
  ) |>
  group_by(id_base) |>
  mutate(
    id = if_else(row_number() == 1, id_base, paste0(id_base, "-", row_number()))
  ) |>
  ungroup() |>
  select(-id_base)

# --- 10. Construir filas como list-of-lists (control total sobre arrays) ---
filas <- lapply(seq_len(nrow(fuentes)), function(i) {
  list(
    id                = fuentes$id[i],
    nombre_corto      = fuentes$nombre_corto[i],
    nombre_largo      = fuentes$nombre_largo[i],
    base_datos        = fuentes$base_datos[i],
    institucion       = fuentes$institucion[i],
    proveedor         = fuentes$proveedor[i],
    ambito            = fuentes$ambito[i],
    funcion_num       = I(as.list(fuentes$funcion_num[[i]])),
    funcion_label     = I(as.list(fuentes$funcion_label[[i]])),
    modalidad         = fuentes$modalidad[i],
    unidad_analisis   = fuentes$unidad_analisis[i],
    acceso            = fuentes$acceso[i],
    periodicidad      = fuentes$periodicidad[i],
    fecha_corte       = fuentes$fecha_corte[i],
    fecha_extraccion  = fuentes$fecha_extraccion[i],
    fecha_publicacion = fuentes$fecha_publicacion[i],
    nota              = fuentes$nota[i],
    usos_unidad       = I(list())
  )
})

json_pretty <- toJSON(filas, pretty = TRUE, auto_unbox = TRUE, na = "null")

# --- 11. Escribir como .js (UTF-8 explícito) ---
ruta_js <- here::here("datos", "fuentes.js")
dir.create(here::here("datos"), showWarnings = FALSE, recursive = TRUE)

timestamp <- format(Sys.time(), "%Y-%m-%d %H:%M:%S")
lineas <- c(
  "// Generado por 20_procesamiento/21_generar_fuentes.R",
  paste0("// Última actualización: ", timestamp),
  "// NO EDITAR A MANO. Editar el Excel en 10_insumos/fuentes/ y re-correr el script.",
  paste0("window.FUENTES = ", json_pretty, ";")
)
con <- file(ruta_js, open = "w", encoding = "UTF-8")
writeLines(lineas, con, useBytes = FALSE)
close(con)

cat("Escrito: ", ruta_js, " (", length(filas), " fuentes)\n\n", sep = "")

# --- 12. Resumen ---
n_funciones <- vapply(fuentes$funcion_num, length, integer(1))

cat("====== RESUMEN ======\n")
cat("Total de fuentes: ", nrow(fuentes), "\n\n", sep = "")

cat("Distribución por ámbito:\n")
amb <- ifelse(is.na(fuentes$ambito) | fuentes$ambito == "",
              "sin clasificar", fuentes$ambito)
print(table(amb, useNA = "ifany"))

cat("\nDistribución por acceso:\n")
print(table(fuentes$acceso, useNA = "ifany"))

cat("\nDistribución por función (una fila puede contar en varias):\n")
todas_funciones <- unlist(lapply(seq_len(nrow(fuentes)), function(i) {
  if (length(fuentes$funcion_num[[i]]) == 0) return(character(0))
  paste0(fuentes$funcion_num[[i]], ". ", fuentes$funcion_label[[i]])
}))
tab_func <- sort(table(todas_funciones), decreasing = TRUE)
for (n in names(tab_func)) cat("  ", sprintf("%3d", tab_func[[n]]), "  ", n, "\n", sep = "")

cat("\nFilas con MÁS DE UNA función: ", sum(n_funciones > 1), "\n", sep = "")
idx_multi <- which(n_funciones > 1)
for (i in idx_multi) {
  cat("  - id: ", fuentes$id[i], "\n", sep = "")
  cat("    nombre_corto: ", fuentes$nombre_corto[i], "\n", sep = "")
  cat("    funciones:    [", paste(fuentes$funcion_num[[i]], collapse = ", "), "]\n", sep = "")
}

cat("\nValores únicos de 'institucion' (post-normalización), por frecuencia:\n")
tab_inst_full <- sort(table(fuentes$institucion, useNA = "ifany"), decreasing = TRUE)
for (n in names(tab_inst_full)) {
  cat("  ", sprintf("%3d", tab_inst_full[[n]]), "  ", n, "\n", sep = "")
}

cat("\nFilas con campos críticos vacíos (ambito / funcion / institucion):\n")
problemas_lista <- list()
for (i in seq_len(nrow(fuentes))) {
  falta_ambito      <- is.na(fuentes$ambito[i])      || fuentes$ambito[i]      == ""
  falta_funcion     <- length(fuentes$funcion_num[[i]]) == 0
  falta_institucion <- is.na(fuentes$institucion[i]) || fuentes$institucion[i] == ""
  if (falta_ambito || falta_funcion || falta_institucion) {
    problemas_lista[[length(problemas_lista) + 1]] <- data.frame(
      id = fuentes$id[i],
      nombre_corto = fuentes$nombre_corto[i],
      falta_ambito = falta_ambito,
      falta_funcion = falta_funcion,
      falta_institucion = falta_institucion
    )
  }
}
if (length(problemas_lista) == 0) {
  cat("  (ninguna)\n")
} else {
  problemas <- dplyr::bind_rows(problemas_lista)
  print(as.data.frame(problemas), row.names = FALSE)
}

cat("\n====== FIN ======\n")
