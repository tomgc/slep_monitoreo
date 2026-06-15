# 00_escanear_proyecto.R
#
# Propósito: generar un inventario (snapshot) de la estructura del repositorio
#   slep_monitoreo y dejarlo en 50_documentacion/estructura/. Sirve para que
#   futuras sesiones reconozcan rápido la disposición de archivos del proyecto.
#
# Salida: en 50_documentacion/estructura/ (solo dos versiones, sin timestamps)
#   - estructura_actual.txt / .md     (inventario de la corrida más reciente)
#   - estructura_anterior.txt / .md   (inventario de la corrida previa)
#   Cada corrida pisa: lo que era "actual" pasa a "anterior" y el escaneo nuevo
#   ocupa "actual". El directorio nunca acumula más de estos cuatro archivos.
#
# Excepción de R declarada (política sección 7): este es el ÚNICO script de R
#   del proyecto. NO procesa datos; es una herramienta de estructura. El sitio
#   no tiene pipeline de R (la feature Fuentes se retiró en v1.0).
#
# Excepción declarada a la política 7.3-7.4: la política define snapshots
#   sellados con timestamp y poda de retención 2. Para este sitio estático, que
#   cambia poco, se simplifica a dos versiones fijas (actual/anterior) que se
#   pisan en cada corrida. Decisión registrada en CLAUDE.md y en el traspaso v03.
#
# Uso: Rscript 00_escanear_proyecto.R  (ejecutar desde la raíz del repo).
# Solo base R (+ here si está disponible para anclar la raíz). Sin dependencias pesadas.

# --- Locale UTF-8 (evita que Rscript bajo locale C rompa tildes) ---
intentar_locale <- function(candidatos) {
  for (l in candidatos) {
    ok <- suppressWarnings(Sys.setlocale("LC_ALL", l))
    if (nzchar(ok)) return(invisible(ok))
  }
  invisible("")
}
intentar_locale(c("es_CL.UTF-8", "es_ES.UTF-8", "en_US.UTF-8", "C.UTF-8"))

# --- Anclar la raíz del repo ---
# Si 'here' está disponible, ancla por la raíz del proyecto; si no, asume que
# el script se ejecuta desde la raíz (getwd()).
if (requireNamespace("here", quietly = TRUE)) {
  raiz <- here::here()
} else {
  raiz <- getwd()  # se asume ejecución desde la raíz del repositorio
}

# --- Configuración de exclusiones ---
# No hay raíz de datos externa que excluir: el proyecto es un sitio público.
excluir_dir     <- c(".git", "_archivo", "handoff", ".claude", "node_modules")
excluir_archivo <- c(".DS_Store")

es_excluido <- function(ruta_rel) {
  partes <- strsplit(ruta_rel, "/", fixed = TRUE)[[1]]
  if (any(partes %in% excluir_dir)) return(TRUE)
  if (basename(ruta_rel) %in% excluir_archivo) return(TRUE)
  FALSE
}

# --- Recorrer el árbol (rutas relativas a la raíz) ---
archivos <- list.files(raiz, recursive = TRUE, all.files = TRUE,
                       no.. = TRUE, include.dirs = FALSE)
archivos <- archivos[!vapply(archivos, es_excluido, logical(1))]
archivos <- sort(archivos)

dirs <- list.dirs(raiz, recursive = TRUE, full.names = FALSE)
dirs <- dirs[nzchar(dirs)]
dirs <- dirs[!vapply(dirs, es_excluido, logical(1))]
dirs <- sort(unique(dirs))

# --- Tamaños de archivo ---
rutas_abs <- file.path(raiz, archivos)
tamanos <- file.info(rutas_abs)$size
tamanos[is.na(tamanos)] <- 0
tam_map <- setNames(tamanos, archivos)

formatear_tamano <- function(bytes) {
  if (bytes < 1024)      return(paste0(bytes, " B"))
  if (bytes < 1024^2)    return(paste0(format(round(bytes / 1024, 1), nsmall = 1), " KB"))
  paste0(format(round(bytes / 1024^2, 1), nsmall = 1), " MB")
}

# --- Conteo por extensión ---
extensiones <- tolower(tools::file_ext(archivos))
extensiones[extensiones == ""] <- "(sin extensión)"
conteo_ext <- sort(table(extensiones), decreasing = TRUE)

# --- Marca de tiempo (solo para el contenido del inventario) ---
ahora <- Sys.time()
fecha_legible <- format(ahora, "%Y-%m-%d %H:%M:%S")

# --- Construir el árbol indentado (carpetas + archivos, ordenado por ruta) ---
profundidad <- function(ruta_rel) {
  length(gregexpr("/", ruta_rel, fixed = TRUE)[[1]][gregexpr("/", ruta_rel, fixed = TRUE)[[1]] > 0])
}
es_dir_map <- c(setNames(rep(TRUE, length(dirs)), dirs),
                setNames(rep(FALSE, length(archivos)), archivos))
rutas_orden <- sort(c(dirs, archivos))

lineas_arbol <- character(0)
for (r in rutas_orden) {
  sangria <- strrep("  ", profundidad(r))
  if (isTRUE(es_dir_map[[r]])) {
    lineas_arbol <- c(lineas_arbol, paste0(sangria, basename(r), "/"))
  } else {
    lineas_arbol <- c(lineas_arbol, paste0(sangria, basename(r), "  (", formatear_tamano(tam_map[[r]]), ")"))
  }
}

# --- Componer el contenido (texto plano y markdown) ---
encabezado_txt <- c(
  "Inventario de estructura — slep_monitoreo",
  paste0("Raíz: ", raiz),
  paste0("Generado: ", fecha_legible),
  paste0("Total de carpetas: ", length(dirs)),
  paste0("Total de archivos: ", length(archivos)),
  "",
  "Exclusiones: .git/ _archivo/ handoff/ .claude/ node_modules/ .DS_Store",
  strrep("=", 60),
  "ÁRBOL",
  strrep("-", 60)
)
conteo_txt <- c(
  "",
  strrep("-", 60),
  "CONTEO POR EXTENSIÓN",
  strrep("-", 60)
)
for (nm in names(conteo_ext)) {
  conteo_txt <- c(conteo_txt, sprintf("  %-18s %d", nm, conteo_ext[[nm]]))
}
lineas_txt <- c(encabezado_txt, lineas_arbol, conteo_txt)

encabezado_md <- c(
  "# Inventario de estructura — slep_monitoreo",
  "",
  paste0("- **Raíz:** `", raiz, "`"),
  paste0("- **Generado:** ", fecha_legible),
  paste0("- **Total de carpetas:** ", length(dirs)),
  paste0("- **Total de archivos:** ", length(archivos)),
  paste0("- **Exclusiones:** `.git/` `_archivo/` `handoff/` `.claude/` `node_modules/` `.DS_Store`"),
  "",
  "## Árbol",
  "",
  "```"
)
conteo_md <- c(
  "```",
  "",
  "## Conteo por extensión",
  "",
  "| Extensión | Archivos |",
  "| --- | ---: |"
)
for (nm in names(conteo_ext)) {
  conteo_md <- c(conteo_md, sprintf("| %s | %d |", nm, conteo_ext[[nm]]))
}
lineas_md <- c(encabezado_md, lineas_arbol, conteo_md)

# --- Escritura UTF-8 explícita ---
escribir_utf8 <- function(lineas, ruta) {
  con <- file(ruta, open = "w", encoding = "UTF-8")
  on.exit(close(con))
  writeLines(lineas, con, useBytes = FALSE)
}

dir_estructura <- file.path(raiz, "50_documentacion", "estructura")
dir.create(dir_estructura, showWarnings = FALSE, recursive = TRUE)

actual_txt    <- file.path(dir_estructura, "estructura_actual.txt")
actual_md     <- file.path(dir_estructura, "estructura_actual.md")
anterior_txt  <- file.path(dir_estructura, "estructura_anterior.txt")
anterior_md   <- file.path(dir_estructura, "estructura_anterior.md")

# --- Rotacion actual -> anterior, luego escritura del nuevo "actual" ---
# Esquema de dos versiones fijas (excepcion declarada a la politica 7.3-7.4):
#   1. Lo que era "actual" pasa a "anterior" (pisando el anterior previo).
#   2. El escaneo nuevo se escribe como "actual".
# Atomico: la rotacion del paso 1 ocurre solo si "actual" existe; si la
# escritura del paso 2 falla, se detiene con error (no deja el directorio
# en estado inconsistente: "anterior" ya rotado, "actual" a medio escribir).
rotar <- function(desde, hacia) {
  if (file.exists(desde)) {
    ok <- file.rename(desde, hacia)
    if (!ok) stop("No se pudo rotar ", basename(desde), " -> ", basename(hacia))
  }
}
rotar(actual_txt, anterior_txt)
rotar(actual_md, anterior_md)

escritura_ok <- tryCatch({
  escribir_utf8(lineas_txt, actual_txt)
  escribir_utf8(lineas_md, actual_md)
  TRUE
}, error = function(e) {
  message("ERROR al escribir el inventario nuevo: ", conditionMessage(e))
  FALSE
})

if (!escritura_ok) {
  stop("La escritura del inventario fallo tras rotar. Revisar estructura_anterior.* ",
       "(tiene la version previa) y volver a correr.")
}

# --- Resumen a stdout ---
cat("Inventario generado (esquema actual/anterior, sin timestamps):\n")
cat("  ", actual_md, "\n", sep = "")
cat("  ", actual_txt, "\n", sep = "")
if (file.exists(anterior_md)) {
  cat("Version previa rotada a: estructura_anterior.txt / estructura_anterior.md\n")
} else {
  cat("Primera corrida: aun no hay estructura_anterior.* (se creara en la proxima).\n")
}
cat("Carpetas: ", length(dirs), " | Archivos: ", length(archivos), "\n", sep = "")
