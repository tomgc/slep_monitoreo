# 20_insumos — Insumos de solo lectura

Esta carpeta guarda los insumos del pipeline del catálogo de fuentes. **Nada de
aquí se edita**: son datos de entrada, y toda corrección se hace en el código
que los consume, no en ellos (política §1.3.5).

## Qué hay

### `resultado_reconocimiento_fuentes.md`

El **reconocimiento de fuentes**: un inventario de **74 URLs candidatas** de
portales, repositorios y sistemas que publican datos educativos y de contexto en
Chile, repartidas en diez lotes temáticos (A a J) y agrupadas en 25
instituciones emisoras.

Producido el **2026-07-29** por una investigación de reconocimiento con Claude
Research, ejecutada desde el brief que acompaña a este archivo.

> **Sus filas son candidatas, no verificadas.** El reconocimiento barre y
> propone; no abre las páginas ni confirma que existan, que respondan, ni que
> contengan lo que su nombre sugiere. Las marcas `no observable` y `no vista`
> que aparecen en sus celdas son **ausencias declaradas** del propio
> reconocimiento, no propiedades de la fuente.

Conserva su nombre original por la excepción de la política §1.2.4: es un dato
heredado de una fuente externa y renombrarlo rompería su trazabilidad con el
brief.

Estructura, para quien lo parsee: un párrafo de preámbulo y un separador antes
del bloque de metadatos (no es front matter YAML); un bloque de cinco metadatos;
diez secciones `## Lote A.` a `## Lote J.`, cada una con **una sola tabla de
diez columnas**; y tres secciones finales que **no** son tablas de lote
—`Hallazgos destacados`, `Vacios y sospechas` y `Conteo final`— y que deben
excluirse del parseo de filas.

### `brief_research_reconocimiento_fuentes_v2.md`

Las **instrucciones que produjeron** el archivo anterior: rol, objetivo,
contexto y línea base, alcance, los diez lotes de instituciones a barrer,
método, la especificación del producto con sus diez columnas en orden, y los
criterios de aceptación.

Es **copia** de
`herramientas_dev/prompts/catalogo_fuentes/brief_research_reconocimiento_fuentes_v2.md`,
que sigue siendo su casa: la biblioteca de prompts vive en `herramientas_dev` y
este proyecto no la reemplaza. La copia está aquí para que el insumo no llegue
huérfano de sus criterios: sin el brief, quien abra esta carpeta no puede saber
por qué el inventario tiene diez lotes ni esas diez columnas.

## Qué las verifica

El reconocimiento es el **paso 1 de 2**. El paso 2 es el pipeline de esta misma
raíz:

```
20_insumos/  ──►  30_procesamiento/  ──►  40_salidas/
```

- `30_procesamiento/31_catalogo_fuentes_filas.R` declara las filas del catálogo,
  producto de abrir cada URL candidata una por una y observar lo que la página
  efectivamente publica. Es la **fuente** del catálogo.
- `30_procesamiento/32_validar_catalogo_fuentes.R` valida el CSV consolidado
  contra el esquema y los vocabularios controlados, y aborta sin emitir si algo
  falla.
- `30_procesamiento/33_emitir_fichas_fuentes.R` genera las fichas en Markdown
  desde el CSV.

El resultado de esa verificación vive en `40_salidas/`, y **ninguno de sus
archivos se edita a mano**: el `.md` de fichas se regenera desde el CSV, y el
CSV se regenera desde el script.

## Trazabilidad de la verificación

`40_salidas/log_verificacion_fuentes.csv` registra una línea por cada una de las
74 URLs candidatas, con el resultado de abrirla. Ese log es lo que permite
afirmar que ninguna fila del reconocimiento quedó sin destino.

Las fuentes que no se pudieron completar desde la sesión están declaradas en
`40_salidas/solicitudes_al_titular.md`, agrupadas por lo que necesitan del
titular.
