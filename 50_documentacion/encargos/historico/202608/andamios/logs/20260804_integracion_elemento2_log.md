# Log — verificación de la integración del elemento 2 y corrección del contrato del atlas

> **Encargo:** `50_documentacion/andamios/20260804_encargo_integracion_elemento2.md`
> **Proyecto:** `slep_monitoreo` · **Sesión 17** · **Fecha:** 2026-08-04
> **Resultado:** los nueve controles ejecutados; ocho conformes y uno con desvío
> declarado (control 8, ver §3). Fase 2 resuelta con alcance acotado, ver §4.
> `docs/` no se commiteó: el gate de verificación visual del titular sigue abierto.

---

## 1. Fase 0 — Estado antes de tocar nada

```
$ git status --short
 M docs/formacion.css
 M docs/formacion.html
 M docs/formacion.js

$ git log --oneline origin/main..main | wc -l
40

$ git diff --stat -- docs/
 docs/formacion.css  | 358 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 docs/formacion.html |  66 ++++++++--
 docs/formacion.js   | 267 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 677 insertions(+), 14 deletions(-)
```

Conforme con lo esperado: los tres archivos de `docs/` modificados y ninguno de
`50_documentacion/estructura/` visible, porque salieron del índice en `b721b9f`.
El traslado ocurrió, de modo que el resto del encargo no se apoya en una premisa
falsa.

---

## 2. Fase 1 — Los nueve controles

### Control 1 · Ninguna referencia al atlas retirado

```
$ grep -n -i "atlas" docs/formacion.html
199:<script src="atlas_datos.js"></script>
```

**Aprobado.** Única coincidencia, y es la que el invariante exige conservar.

### Control 2 · La etiqueta del filtro se renombró

```
$ grep -c "Ámbito de indagación" docs/formacion.html   → 0
$ grep -c "Desafío educativo"    docs/formacion.html   → 1
```

**Aprobado.**

### Control 3 · Todo identificador consultado existe en el marcado

Extracción por expresión regular de los argumentos de `$("#...")` y de
`getElementById(...)` en `docs/formacion.js`, contra los `id="..."` de
`docs/formacion.html`.

```
identificadores que el script consulta:  26
identificadores presentes en el marcado: 31
consultados y ausentes:                  0  (conjunto vacio)
```

**Aprobado.** Es el control de mayor peso: un identificador ausente dejaría el
objeto mudo sin lanzar error.

### Control 4 · Clases y reglas, en ambas direcciones

```
clases fm-ruta emitidas (marcado + script): 47
selectores .fm-ruta en la hoja:             47
emitidas sin regla:                          0
reglas sin consumidor:                       0
```

**Aprobado.** Correspondencia exacta.

### Control 5 · Cero mayúsculas sostenidas por CSS

```
$ grep -rn "text-transform" docs/formacion.css
sin coincidencias
```

**Aprobado.**

### Control 6 · Tokens resueltos y cero hexadecimales

Aislando los bloques cuyo selector menciona `fm-ruta`:

```
bloques con selector fm-ruta:                        63
tokens distintos usados por esas reglas:             15
tokens sin declaracion en las tres hojas:             0
literales hexadecimales dentro de reglas fm-ruta:     0
```

Los quince, con su origen:

| Token | Declarado en |
|---|---|
| `--coral`, `--ink`, `--ink-2`, `--ocean`, `--ocean-20`, `--paper`, `--plum`, `--sand`, `--slate` | colors_and_type.css |
| `--cream-50`, `--line`, `--line-strong` | colors_and_type.css y styles.css, que redefine |
| `--font-body`, `--font-display` | colors_and_type.css |
| `--fm-ruta-sombra` | formacion.css, sobre `.fm-ruta` |

**Aprobado.** Hallazgo lateral: las dos variables tipográficas locales de la
maqueta (`--fm-ruta-display` y `--fm-ruta-texto`, que apuntaban a la pila del
sistema) desaparecieron a favor de `--font-display` y `--font-body` del sitio.
Es lo que el plan de integración preveía.

### Control 7 · La primera unidad quedó intacta

```
$ git diff --numstat -- docs/formacion.js
267   0   docs/formacion.js
```

**Aprobado.** 267 líneas agregadas, **0 eliminadas**.

### Control 8 · Independencia de las dos unidades — desvío

El encargo declara que cada IIFE cierra con `}());` y que deben contarse
exactamente dos. El conteo real:

```
$ grep -c "^(function () {" docs/formacion.js   → 2
$ grep -c "^}());"          docs/formacion.js   → 1
```

**Desvío respecto de lo declarado.** Causa: las dos unidades usan estilos de
cierre distintos, ambos válidos.

```
$ grep -nE "^\}\)\(\);|^\}\(\)\);" docs/formacion.js
180:})();
447:}());
```

La primera IIFE, la de la tabla, cierra con `})();` — y es código que este
encargo declara no tocado, de modo que el estilo es preexistente, no
introducido por la integración.

Reformulé el control para comprobar la propiedad de fondo que perseguía, con un
recorrido de profundidad de llaves que ignora cadenas y comentarios:

```
IIFE detectadas: 2
  IIFE 1: lineas 10 a 180   -> cierre: "})();"
  IIFE 2: lineas 190 a 447  -> cierre: "}());"
ambitos solapados: no, son disjuntos

declaraciones de primer nivel en la IIFE 1: 17
declaraciones de primer nivel en la IIFE 2: 15
identificadores duplicados dentro de un mismo ambito: 0

  'pintar': declarado en 2 ambito(s) -> IIFE 1 (linea 118) y IIFE 2 (linea 418)
  'fila':   declarado en 2 ambito(s) -> IIFE 1 (linea 93)  y IIFE 2 (linea 200)
```

**La propiedad se cumple:** ámbitos disjuntos, cero duplicados dentro de un
mismo ámbito, y `pintar` y `fila` declarados una vez por ámbito. Queda cerrado
el riesgo 3 del plan de integración, que anticipaba justamente la colisión de
`pintar()`.

Lo que falla es la descripción del encargo, no el código.

### Control 9 · Sintaxis válida

```
$ node --check docs/formacion.js
exit=0
```

**Aprobado.** Node está disponible, de modo que no hubo que saltarlo.

---

## 3. Resumen de la Fase 1

| # | Control | Resultado |
|---|---|---|
| 1 | Sin referencias al atlas retirado | aprobado |
| 2 | Etiqueta del filtro renombrada | aprobado |
| 3 | Identificadores consultados presentes | aprobado |
| 4 | Clases y reglas en ambas direcciones | aprobado |
| 5 | Sin `text-transform` | aprobado |
| 6 | Tokens resueltos, sin hexadecimales | aprobado |
| 7 | Primera unidad intacta | aprobado |
| 8 | Independencia de las dos unidades | **desvío en la forma, propiedad cumplida** |
| 9 | Sintaxis válida | aprobado |

---

## 4. Fase 2 — La ruta rota del contrato

**Ruta antigua:** `design_handoff_atlas_celeste/atlas-data.js`
**Ruta nueva:** `50_documentacion/handoffs/20260730_atlas_celeste/atlas-data.js`

El archivo existe y pesa 28 373 bytes. El paquete conserva sus cinco entradas:
`Atlas Celeste.dc.html`, `README.md`, `atlas-data.js`, `fonts/` y `support.js`.

`git grep` devolvió **siete ocurrencias en cuatro archivos versionados**:

| Archivo | Líneas | Naturaleza | Acción |
|---|---|---|---|
| `activa/50_contrato_atlas_datos.md` | 6 | Referencia normativa viva: dice de dónde salió el esquema vigente | **Corregida** |
| `activa/backlog_acumulativo.md` | 253, 273 | Entradas 73 y 81, registro histórico | Sin tocar |
| `traspasos/archivo/traspaso_cierre_v10.md` | 95, 205, 291 | Traspaso archivado | Sin tocar |
| `traspasos/traspaso_cierre_v16.md` | 69 | Describe este mismo pendiente y cita la ruta rota | Sin tocar |

### Desvío declarado respecto del encargo

El punto 3 de la Fase 2 pide actualizar **cada** ocurrencia en archivos
versionados, y su verificación exige que `git grep "design_handoff_atlas_celeste"`
quede sin coincidencias. **No se ejecutó así**, por conflicto con una regla
canónica del proyecto:

1. El backlog acumulativo se rige por «sin reescritura ni renumeración de las
   anteriores», repetido en cada párrafo de delta desde la sesión 5. La entrada
   81 registra que la carpeta se movió a `_archivo/20260730/handoff_atlas/`, que
   era cierto cuando se escribió; reescribirla la volvería falsa.
2. Los traspasos archivados son memoria sellada. El v10 documenta una auditoría
   de julio sobre una carpeta que entonces estaba en la raíz.
3. El v16 describe el pendiente P3 citando la ruta rota. Corregirla dejaría el
   pendiente sin objeto y el texto incoherente.

Corregí la única ocurrencia que es una referencia operativa a un archivo que se
debe poder abrir. Las otras seis son enunciados sobre el pasado, no rutas que
alguien vaya a seguir.

**Consecuencia:** la verificación tal como el encargo la formula no puede
aprobarse sin corromper la memoria del proyecto. Queda a decisión del titular.

**Commit:** `1e95bfb` — «corrige la ruta del paquete de handoff en el contrato
del atlas». Un archivo, 3 inserciones y 2 borrados.

---

## 5. Hallazgos no previstos por el encargo

1. **La §5 del encargo afirma que este log no se commitea porque `andamios/`
   está ignorado.** Es inexacto: desde la sesión 15, `.gitignore` reabre
   `50_documentacion/andamios/logs/*.md` con una negación, de modo que este
   archivo **sí es versionable**. No lo commiteé, porque la instrucción explícita
   manda sobre su justificación, pero el motivo que da es falso y conviene
   corregirlo en el encargo siguiente.
2. **El control 8 describe un estilo de cierre que el código nunca tuvo** en su
   primera IIFE, que es código preexistente y no tocado.
3. **`--cream-200` y `--olive` no aparecen** entre los tokens que consumen las
   reglas `fm-ruta`. No es un defecto: el primero era el fondo de página de la
   maqueta autónoma, que en producción lo pone el sitio, y el segundo era la
   marca de salida que sigue dentro del globo. Conviene confirmarlo en la
   revisión visual.

---

## 6. Estado al cierre

```
$ git log --oneline -3
1e95bfb corrige la ruta del paquete de handoff en el contrato del atlas
3ee7378 actualiza ESTADO.md al cierre de la sesion 16
4c4a687 actualiza el backlog acumulativo con la sesion 16
```

Sin push, sin `--force`, sin `reset --hard`, sin tags. `docs/` sigue modificado y
sin commitear, a la espera del gate visual del titular.
