# ==============================================================================
# 32_validar_catalogo_fuentes.R
#
# Proposito : fase 2 del encargo. Valida el CSV consolidado contra el esquema y
#             los vocabularios controlados. Si algo falla, imprime la tabla de
#             incumplimientos, llama a stop() y NO se emite nada.
# Insumos   : 40_salidas/catalogo_fuentes.csv
# Salidas   : ninguna. Devuelve exit 0 si valida, exit 1 si no.
# Contrato  : encargo seccion 6, con el esquema de 29 campos de las enmiendas
#             E1-E9.
#
# El CSV no se corrige a mano: si falla, se corrige el script que lo genera
# (31_catalogo_fuentes_filas.R) y se vuelve a emitir.
# ==============================================================================

for (p in c("dplyr", "readr", "tibble", "here", "purrr")) {
  if (!requireNamespace(p, quietly = TRUE)) install.packages(p)
}

library(dplyr)
library(readr)
library(tibble)
library(here)

RUTA_CSV <- here("40_salidas", "catalogo_fuentes.csv")

# ---- Esquema y vocabularios (constantes nombradas, no literales dispersos) ----

CAMPOS <- c(
  "id_fuente", "ambito_monitoreo", "subambito", "dato", "descripcion",
  "variables", "base_datos", "emisor", "via_de_acceso", "nivel_acceso",
  "url_referencia", "url_descarga", "formato", "detalle_tecnico",
  "unidad_de_analisis", "llaves_de_union", "desagregacion_territorial",
  "cobertura_temporal", "periodicidad", "mes_publicacion", "datos_personales",
  "documentacion_tecnica", "condiciones_de_uso", "usos_en_monitoreo",
  "estado_verificacion", "fecha_verificacion", "observaciones", "copia_local",
  "fuente_equivalente"
)

VOCABULARIOS <- list(
  ambito_monitoreo = c("1. Comunidades educativas", "2. SLEP", "3. Contexto"),
  subambito = c(
    "1.1 Trayectorias estudiantiles", "1.2 Desarrollo social y personal",
    "1.3 Aprendizajes y resultados", "1.4 Instrumentos de gestion educativa",
    "2.1 Gestion institucional del SLEP",
    "2.2 Dimension educativa de instrumentos de gestion",
    "2.3 Indices, analisis y estudios", "3.1 Contexto socioterritorial"),
  via_de_acceso = c(
    "Portal de datos abiertos", "Descarga directa desde sitio institucional",
    "API", "Consulta web sin descarga", "Entrega via DEP",
    "Sistema con credenciales", "Solicitud formal (Ley 20.285)",
    "Reporte en PDF"),
  nivel_acceso = c("Abierto", "Abierto con registro", "Institucional mediado",
                   "Restringido por solicitud"),
  unidad_de_analisis = c("Estudiante", "Docente o asistente", "Curso",
                         "Establecimiento", "Sostenedor", "Comuna", "Region",
                         "Nacional", "Jardin infantil"),
  desagregacion_territorial = c("Establecimiento", "Comuna", "Region", "Nacional"),
  periodicidad = c("Anual", "Semestral", "Trimestral", "Bimestral", "Mensual",
                   "Semanal", "Por evento", "Sin periodicidad definida"),
  datos_personales = c("Sin datos de personas", "Identificador enmascarado (MRUN)",
                       "RUT o identificador directo", "Datos personales sensibles"),
  estado_verificacion = c("Verificada", "URL viva sin descarga confirmada",
                          "Enlace roto", "No encontrada", "Declarada sin verificar")
)

# `formato` es multivalor: se valida por token, separados por "; ".
VOC_FORMATO <- c("csv", "xlsx", "zip", "rar", "txt", "json", "api", "pdf",
                 "html", "shapefile", "sin descarga")

PATRON_ID <- "^F[0-9]{3}$"

# ---- Lectura ----
catalogo <- read_csv(RUTA_CSV, show_col_types = FALSE, na = character())

incumplimientos <- tibble(
  columna = character(), fila = character(),
  valor_observado = character(), valor_esperado = character()
)

anotar <- function(inc, columna, fila, observado, esperado) {
  bind_rows(inc, tibble(columna = columna, fila = as.character(fila),
                        valor_observado = as.character(observado),
                        valor_esperado = esperado))
}

# ---- 1. Los 29 nombres de columna, exactos y en orden ----
if (!identical(names(catalogo), CAMPOS)) {
  faltan  <- setdiff(CAMPOS, names(catalogo))
  sobran  <- setdiff(names(catalogo), CAMPOS)
  detalle <- if (length(faltan) || length(sobran)) {
    paste0("faltan: ", paste(faltan, collapse = ", "),
           " | sobran: ", paste(sobran, collapse = ", "))
  } else "mismos nombres, orden distinto"
  incumplimientos <- anotar(incumplimientos, "<esquema>", "-", detalle,
                            "los 29 campos exactos y en orden")
}

# ---- 2. id_fuente: sin duplicados, patron, correlativo sin saltos ----
dup <- catalogo$id_fuente[duplicated(catalogo$id_fuente)]
for (d in dup) incumplimientos <- anotar(incumplimientos, "id_fuente", d, d, "identificador unico")

malos <- catalogo$id_fuente[!grepl(PATRON_ID, catalogo$id_fuente)]
for (m in malos) incumplimientos <- anotar(incumplimientos, "id_fuente", m, m, PATRON_ID)

esperado_corr <- sprintf("F%03d", seq_len(nrow(catalogo)))
saltos <- which(catalogo$id_fuente != esperado_corr)
for (i in saltos) {
  incumplimientos <- anotar(incumplimientos, "id_fuente", catalogo$id_fuente[i],
                            catalogo$id_fuente[i], esperado_corr[i])
}

# ---- 3. Vocabularios controlados ----
for (col in names(VOCABULARIOS)) {
  validos <- c(VOCABULARIOS[[col]], "NA")
  fuera <- which(!catalogo[[col]] %in% validos)
  for (i in fuera) {
    incumplimientos <- anotar(incumplimientos, col, catalogo$id_fuente[i],
                              catalogo[[col]][i],
                              paste(VOCABULARIOS[[col]], collapse = " | "))
  }
}

# `formato`, multivalor separado por "; "
for (i in seq_len(nrow(catalogo))) {
  v <- catalogo$formato[i]
  if (v == "NA") next
  tokens <- trimws(strsplit(v, ";", fixed = TRUE)[[1]])
  malos_tok <- setdiff(tokens, VOC_FORMATO)
  for (t in malos_tok) {
    incumplimientos <- anotar(incumplimientos, "formato", catalogo$id_fuente[i], t,
                              paste(VOC_FORMATO, collapse = " | "))
  }
}

# ---- 4. fecha_verificacion parsea en toda fila Verificada ----
verificadas <- which(catalogo$estado_verificacion == "Verificada")
for (i in verificadas) {
  f <- suppressWarnings(as.Date(catalogo$fecha_verificacion[i], format = "%Y-%m-%d"))
  if (is.na(f)) {
    incumplimientos <- anotar(incumplimientos, "fecha_verificacion",
                              catalogo$id_fuente[i], catalogo$fecha_verificacion[i],
                              "fecha AAAA-MM-DD en toda fila Verificada")
  }
}

# ---- 5. Ninguna celda vacia ----
for (col in names(catalogo)) {
  vacias <- which(is.na(catalogo[[col]]) | trimws(catalogo[[col]]) == "")
  for (i in vacias) {
    incumplimientos <- anotar(incumplimientos, col, catalogo$id_fuente[i],
                              "<vacia>", "texto, o el literal NA")
  }
}

# ---- 6. fuente_equivalente: las rutas resuelven y son reciprocas ----
for (i in seq_len(nrow(catalogo))) {
  v <- catalogo$fuente_equivalente[i]
  if (v == "NA") next
  destinos <- trimws(strsplit(v, ";", fixed = TRUE)[[1]])
  for (d in destinos) {
    if (!d %in% catalogo$id_fuente) {
      incumplimientos <- anotar(incumplimientos, "fuente_equivalente",
                                catalogo$id_fuente[i], d, "un id_fuente existente")
      next
    }
    vuelta <- trimws(strsplit(catalogo$fuente_equivalente[catalogo$id_fuente == d],
                              ";", fixed = TRUE)[[1]])
    if (!catalogo$id_fuente[i] %in% vuelta) {
      incumplimientos <- anotar(incumplimientos, "fuente_equivalente",
                                catalogo$id_fuente[i], paste(d, "no declara la vuelta"),
                                "equivalencia declarada en ambos extremos")
    }
  }
}

# ---- Resultado ----
cat("== Fase 2. Validacion del catalogo consolidado ==\n")
cat("  archivo :", RUTA_CSV, "\n")
cat("  filas   :", nrow(catalogo), "\n")
cat("  campos  :", ncol(catalogo), "\n\n")

if (nrow(incumplimientos) > 0) {
  cat("INCUMPLIMIENTOS:", nrow(incumplimientos), "\n\n")
  print(as.data.frame(incumplimientos), row.names = FALSE)
  stop("El catalogo NO valida. No se emite nada. Corrige 31_catalogo_fuentes_filas.R ",
       "y vuelve a emitir; el CSV no se edita a mano.", call. = FALSE)
}

cat("  1. Los 29 nombres de columna, exactos y en orden .... OK\n")
cat("  2. id_fuente unico, patron F### y correlativo ....... OK\n")
cat("  3. Vocabularios controlados sin valores fuera ....... OK\n")
cat("  4. fecha_verificacion parsea en las Verificadas ..... OK\n")
cat("  5. Ninguna celda vacia .............................. OK\n")
cat("  6. fuente_equivalente resuelve y es reciproca ....... OK\n\n")
cat("RESULTADO: el catalogo valida. Puede emitirse.\n")
