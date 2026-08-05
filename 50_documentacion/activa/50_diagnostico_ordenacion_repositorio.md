# Diagnóstico de ordenación del repositorio

> **Destino:** `50_documentacion/activa/50_diagnostico_ordenacion_repositorio.md`
> **Proyecto:** `slep_monitoreo` · **Sesión 17** · **Fecha:** 2026-08-05
> **Qué es:** contraste entre la estructura real del repositorio y la regla de
> ordenación vigente. **No ejecuta ningún movimiento.** Los que propone se
> aprueban o se descartan en una sesión posterior.
>
> **Este archivo NO es el marcador de §4.7.3 punto 7.** Ese marcador se llama
> `50_ordenacion_repositorio.md`, lo crea el último commit de una ordenación
> **ya ejecutada** y apaga el gatillo de §1.2.2 punto 4bis. Aquí no se ha
> ejecutado ninguna ordenación, de modo que el gatillo debe seguir encendido y
> el nombre reservado. Ver §6.

---

## 1. Qué manda la regla, en sus propios términos

La regla de ordenación es la **§4.7 de `SETTINGS_Y_PROMPTS_OPERACIONALES.md`**
(no de `POLITICA_PROYECTO.md`; ver §6). Se apoya en las secciones 1.2, 1.3.1,
1.5, 2 y 7.2 de `POLITICA_PROYECTO.md`.

Pone el árbol al día con la política. **No toca el pipeline:** mueve, renombra
y archiva documentación. Nada se borra: todo lo que sale del árbol vivo va a
`_archivo/YYYYMMDD/` conservando su ruta relativa. Se ejecuta una vez por
proyecto; el mantenimiento posterior lo hace el cierre de sesión.

**Precondiciones bloqueantes (§4.7.1),** que se verifican antes de tocar nada:
árbol e índice limpios, `git stash list` vacío, cero divergencia con el
remoto, y **la rama de trabajo no puede ser `main`**. La rama propia se llama
`ordenacion/<AAAAMMDD>` y el protocolo termina en PR, nunca en merge.

**Alcance: cuatro bloques, un commit por bloque (§4.7.2).**

1. **Traspasos.** `traspasos/` queda con un solo archivo, el de la última
   sesión cerrada; el resto va a `traspasos/archivo/` con `git mv`. Aserción de
   cierre: `ls 50_documentacion/traspasos/*.md` devuelve una línea. Incluye
   actualizar las copias locales de la política y de SETTINGS si están por
   debajo de v5.5 / v14.
2. **Obsoletos y duplicados.** Candidatos a `_archivo/YYYYMMDD/` con **grado de
   certeza** declarado: alto se mueve, medio exige grep previo, bajo no se
   mueve y se lista como duda. Una referencia viva **cancela la fila** y se
   reporta; no se "arregla la referencia" en el mismo paso. `andamios/` está
   congelado: sus archivos nunca son candidatos y una referencia dentro de
   `andamios/` es registro histórico, no referencia viva.
3. **Nomenclatura.** Los archivos de las subcarpetas de `50_*` llevan el
   prefijo de su decena, en minúsculas y snake_case. Antes de renombrar,
   **grep del nombre en la política y en SETTINGS**: si aparece fijado por
   nombre, no se renombra. Todo renombre que proceda actualiza sus referencias
   en el mismo commit.
4. **Escáner.** `00_escanear_proyecto.R` debe excluir del barrido
   `node_modules/`, `packrat/` y `venv/`.

**Prohibido (§4.7.4):** borrar, `cp` + `rm` donde corresponde `git mv`, mover
grado medio o bajo sin grep, renombrar un archivo citado por nombre en la
política o en SETTINGS, tocar `30_procesamiento/`, reescribir rutas dentro de
`andamios/`, y mezclar la ordenación con cambios de contenido.

---

## 2. Estructura real, medida

Fuente: `git ls-files` y recorrido del árbol, ejecutados el 2026-08-05. No se
usó el escáner: sus cuatro salidas están fuera del árbol versionado desde la
sesión 16 y no son fuente para este diagnóstico.

**Archivos versionados, por carpeta de primer nivel:**

| Carpeta | Archivos versionados |
|---|---:|
| `docs/` | 47 |
| `50_documentacion/` | 33 |
| `40_salidas/` | 4 |
| `30_procesamiento/` | 3 |
| `20_insumos/` | 3 |
| `.github/` | 1 |
| raíz (`CLAUDE.md`, `.gitignore`, los dos `00_*`) | 4 |

**Presente en disco pero fuera de Git,** por `.gitignore`: `_archivo/` (línea
5), `.claude/` (8), `handoff/` (11), `POLITICA_PROYECTO.md` y
`SETTINGS_Y_PROMPTS_OPERACIONALES.md` (21-22), `50_documentacion/andamios/*`
salvo `logs/*.md` (26-29), `50_documentacion/estructura/*` salvo `.gitkeep`
(34-35), `50_documentacion/handoffs/*` salvo `.gitkeep` (39-40).

---

## 3. Inventario de lo conforme

| Punto | Regla | Evidencia |
|---|---|---|
| Traspaso vigente | §1.3.1 y bloque 1 | `ls 50_documentacion/traspasos/*.md` devuelve **una** línea: `traspaso_cierre_v16.md`. Los 15 superados están en `traspasos/archivo/` |
| Copias de gobernanza | Bloque 1 | Local: política **v5.5**, SETTINGS **v15**. El mínimo exigido es v5.5 / v14: cumplen |
| Prefijo `50_` en `activa/` | §2 | 4 de 5 archivos no exceptuados lo llevan: `50_catalogo_project_cards.md`, `50_contenido_seccion_formacion.md`, `50_contrato_atlas_datos.md`, `50_fundamento_seccion_formacion.md` |
| Excepciones de nombre | §2 | `ESTADO.md` y `backlog_acumulativo.md` están en la lista cerrada de excepciones por contrato de cartera. No se renombran |
| Correlativos del pipeline | §1.2.4 modo "con orden interno" | `31_catalogo_fuentes_filas.R`, `32_validar_catalogo_fuentes.R`, `33_emitir_fichas_fuentes.R` |
| Orquestadores en raíz | §2 | `00_escanear_proyecto.R` y `00_validar_atlas.js`. La política admite varios `00_*` |
| `andamios/` congelado | §1.3 punto 7 | Sus rutas internas no se han reescrito. El `.gitignore` deja fuera los encargos y solo versiona `logs/*.md` |
| `_archivo/` fuera de Git | §1.5 | `.gitignore:5`. Contiene `20260729/`, `20260730/`, `20260805_atlas_muerto/` y `log_reorganizacion.csv` |
| Nada se borra | §4.7.4 | El archivado del atlas de esta misma sesión usó `mv` a `_archivo/`, no borrado |

**Excepciones ya declaradas en `CLAUDE.md`,** que no cuentan como
incumplimiento: ausencia de `00_run_all.R` (el pipeline tiene una compuerta
humana y no corre de extremo a extremo), ausencia de `10_utils/` (la política
§1.4 exige duplicación real y todavía no la hay), el hueco resultante en la
decena 10, y `docs/` como carpeta sin prefijo de decena (GitHub Pages solo
admite la raíz o `/docs`).

---

## 4. Inventario de lo no conforme

### 4.1 `50_documentacion/activa/encargo_diseno_portafolio.md`

**Regla que incumple:** §2, prefijo `50_` para los archivos de `activa/`, por
la regla 1.2.4 modo "sin orden interno". No figura en la lista cerrada de
excepciones.

**Verificación hecha:** grep de su nombre en `POLITICA_PROYECTO.md` y en
`SETTINGS_Y_PROMPTS_OPERACIONALES.md` devuelve **0 coincidencias en ambos**, de
modo que ningún contrato externo fija su nombre y el renombre procede.

**Referencias que habría que actualizar en el mismo commit** (bloque 3): una en
`50_documentacion/activa/50_catalogo_project_cards.md:265` y una en
`50_documentacion/activa/backlog_acumulativo.md:201`. Las de
`traspasos/archivo/` y las de `traspasos/traspaso_cierre_v16.md` son registro
histórico sellado y **no se reescriben**.

**Movimiento que lo resolvería:** `git mv` a `50_encargo_diseno_portafolio.md`,
con las dos referencias vivas actualizadas en el mismo commit.

**Duda de fondo, que el renombre no resuelve:** es un *encargo*, y los encargos
viven en `andamios/`, no en `activa/`. Nació en `activa/` en la sesión 8 y ahí
quedó. Si se decide moverlo a `andamios/`, el renombre sobra: los archivos de
`andamios/` no llevan prefijo de decena. Las dos vías son excluyentes y la
elección es del titular.

### 4.2 `00_escanear_proyecto.R` — exclusiones incompletas

**Regla que incumple:** bloque 4 y política §7.2, que exigen excluir del
barrido `node_modules/`, `packrat/` y `venv/`.

**Estado real,** línea 46 del script: excluye `.git`, `_archivo`, `handoff`,
`handoffs`, `.claude` y `node_modules`. **Faltan `packrat` y `venv`**; el grep
de ambos nombres en el script devuelve 0.

**Efecto hoy:** ninguno medible. Ni `packrat/` ni `venv/` existen en el
proyecto, que no es un proyecto de R con dependencias congeladas ni tiene
entorno de Python. El incumplimiento es de forma, no de cifras: los totales que
declaran los traspasos no están midiendo una dependencia.

**Movimiento que lo resolvería:** agregar los dos nombres al vector
`excluir_dir` y a las dos líneas que imprimen las exclusiones en el manifiesto
(114 y 137). Es una edición de un script transversal, no del pipeline, de modo
que §4.7.4 no lo prohíbe.

### 4.3 `handoff/` en la raíz — duplica un rol ya reubicado

**Regla que incumple:** §1.1, que no contempla ninguna carpeta `handoff/` en la
raíz, y §1.6, que veta las carpetas cuyo rol ya tiene lugar propio. La sesión
16 creó `50_documentacion/handoffs/` justamente para alojar los paquetes de
diseño, y `CLAUDE.md` la declara como su destino.

**Estado real:** 20 archivos, 1,0 MB, ignorada por `.gitignore:11`. Contiene un
sitio completo de traspaso (`site/index.html`, `data.js`, `app.js`,
`styles.css`, fuentes y logos) más `LÉEME-DESPLIEGUE.md` y
`PROMPT-PARA-CLAUDE.md`. Es el insumo de traspaso de una sesión antigua, no un
handoff de diseño de los que hoy alimentan el trabajo.

**Grado de certeza: medio.** Nada la declara superada por escrito; lo que la
deja sin rol es la existencia de `50_documentacion/handoffs/`. Exige grep
previo antes de mover, que este diagnóstico no ejecuta porque no mueve nada.

**Movimiento que lo resolvería:** `mv` a `_archivo/YYYYMMDD/handoff/`
conservando ruta relativa. Al estar ignorada, el movimiento es invisible para
git y no genera commit: es higiene de disco. **Consecuencia colateral a
considerar:** `00_escanear_proyecto.R` excluye `handoff` por nombre; si la
carpeta desaparece, esa exclusión queda muerta y conviene retirarla en el
mismo paso que 4.2.

### 4.4 Nombres con sufijo de versión en `20_insumos/`

**Regla que incumple:** §2, "sin sufijos de versión en scripts vivos
(`_v3`, `_final`, `_nuevo`)". `20_insumos/brief_research_reconocimiento_fuentes_v2.md`
lleva `_v2`.

**Atenuante fuerte:** la regla dice *scripts vivos*, y esto es un insumo de
solo lectura, no un script. Su propia cabecera declara que su ruta de origen
era `herramientas_dev/prompts/catalogo_fuentes/brief_research_reconocimiento_fuentes_v2.md`,
y `20_insumos/README.md` lo documenta como tal. Encaja en la excepción de
§1.2.4 para datos heredados de fuentes externas, aunque `CLAUDE.md` solo
invoque esa excepción para `resultado_reconocimiento_fuentes.md`.

**Movimiento que lo resolvería:** ninguno. Lo que falta es **declarar la
excepción** en `CLAUDE.md`, extendiéndola a los tres archivos de `20_insumos/`
en vez de a uno solo. Se lista aquí porque hoy la excepción no cubre este
archivo, no porque el archivo deba cambiar.

---

## 5. Casos dudosos, declarados como dudosos

Ninguno de estos se resuelve en este diagnóstico. Todos tienen historia propia
y su clasificación depende de una decisión que no me corresponde.

### 5.1 `20_insumos/`, `30_procesamiento/`, `40_salidas/` — ¿llevan prefijo sus archivos?

La política §1.2.4 abre con "**todos** los archivos llevan prefijo numérico" y
acto seguido describe **dos** modos: el "sin orden interno", cuyos ejemplos son
`10_utils/` y las subcarpetas de `50_*`, y el "con orden interno", cuyo ejemplo
es `30_procesamiento/`. `20_insumos/` y `40_salidas/` no aparecen en ninguno de
los dos. El bloque 3 de §4.7, que es la regla operativa, acota su alcance a
"los archivos de las subcarpetas de `50_*`" y no las menciona.

Hoy: `20_insumos/README.md`, `brief_research_...md` y
`resultado_reconocimiento_fuentes.md` no llevan `20_`;
`40_salidas/catalogo_fuentes.csv`, `catalogo_fuentes_fichas.md`,
`log_verificacion_fuentes.csv` y `solicitudes_al_titular.md` no llevan `40_`.
`30_procesamiento/` sí cumple, por el modo con orden interno.

**La duda:** si el enunciado general manda, faltan siete prefijos; si manda el
alcance del bloque 3, no falta ninguno. Se inclina hacia lo segundo, porque la
regla operativa es más específica que el enunciado, pero el texto admite las
dos lecturas y renombrar siete archivos de un pipeline que ya corrió no es
reversible sin costo: `31_`, `32_` y `33_` los leen y escriben por nombre.

### 5.2 `40_salidas/solicitudes_al_titular.md` — ¿salida o documento vivo?

Vive en `40_salidas/`, que la política §1.3 define como write-only desde el
pipeline. Pero el traspaso v11 describe un flujo donde **el titular marca
entradas como resueltas sin borrarlas**, es decir, lo edita a mano. Un archivo
que se escribe desde fuera del pipeline no es una salida en el sentido de la
§1.3, y 16 coincidencias en backlog y traspasos lo tratan como el mapa vivo de
lo que falta del catálogo.

**La duda:** si es documento vivo, su lugar es `activa/` con prefijo `50_`; si
es salida regenerable, se queda donde está. La respuesta depende de si
`33_emitir_fichas_fuentes.R` lo regenera o solo lo crea la primera vez, y de si
el titular acepta que un reproceso pise sus marcas de resuelto. No lo resuelvo
por inspección del nombre.

### 5.3 `50_documentacion/handoffs/` — carpeta versionada que no versiona nada

Existe en el árbol con un único archivo versionado, su `.gitkeep`; sus 26
archivos reales están ignorados por `.gitignore:39-40`. Alberga dos paquetes de
Claude Design: `20260730_atlas_celeste/` y
`20260803_elemento2_recorrido_datos/`.

**La duda:** la política §1.1 no contempla `handoffs/` como subcarpeta de
`50_documentacion/`. La sesión 16 la creó por decisión propia y `CLAUDE.md` la
describe, pero ni la política ni SETTINGS la reconocen. O se declara como
excepción del proyecto —igual que `docs/`—, o se propone a la política como
subcarpeta canónica, o se archiva su contenido una vez integrado el diseño. Las
tres son defendibles. Nota de coherencia: el paquete del atlas celeste
corresponde a la metáfora que esta misma sesión acaba de retirar del sitio, de
modo que su vigencia es dudosa por partida doble.

### 5.4 `50_documentacion/activa/decisiones/` — prevista y ausente

La política §1.1 la contempla (`YYYYMMDD_decision_<tema>.md`) y el proyecto no
la tiene. No es un incumplimiento: es una carpeta opcional sin uso. Se anota
porque las decisiones del proyecto hoy viven dispersas en traspasos y en el
backlog, y crear la carpeta solo tiene sentido si se decide migrar alguna.

---

## 6. Dos premisas del encargo que no se sostienen

Se registran aquí porque afectan a la trazabilidad de este documento.

**Primera: la ubicación de la regla.** El encargo de la sesión 17 sitúa la
regla de ordenación en la "§4.7 de `POLITICA_PROYECTO.md`". Esa sección no
existe: la §4 de la política es el orquestador `00_run_all.R` y no tiene
subsecciones; el grep de "4.7" sobre el documento devuelve 0 coincidencias. La
§4.7 «Ordenación del repositorio» está en
`SETTINGS_Y_PROMPTS_OPERACIONALES.md`, línea 1389. El encargo nombra la sección
correcta en el documento equivocado, y este diagnóstico usa la sección real.

**Segunda, y con consecuencia:** el encargo pide emitir este contenido como
`50_documentacion/activa/50_ordenacion_repositorio.md`. Ese nombre está
reservado por §4.7.3 punto 7 para el **marcador** que crea el último commit de
una ordenación ya ejecutada, y cuya sola existencia **apaga el gatillo** de
§1.2.2 punto 4bis, que es lo que hace que la ordenación se vuelva a proponer en
cada apertura. Emitir un diagnóstico con ese nombre apagaría el gatillo sin que
se haya movido un solo archivo: el proyecto quedaría marcado como ordenado sin
estarlo. Por eso el documento se llama
`50_diagnostico_ordenacion_repositorio.md`. Si el titular prefiere el nombre
original, el cambio es un `git mv`, pero conviene entonces ejecutar antes la
ordenación que el marcador certifica.

**Nota sobre las versiones citadas.** El encargo declara heredar
`POLITICA_PROYECTO.md` v5.6 y `SETTINGS_Y_PROMPTS_OPERACIONALES.md` v16. Las
copias locales son **v5.5** y **v15**. No bloquea nada —el bloque 1 exige v5.5
y v14 como mínimo, y ambas lo cumplen—, pero si en la knowledge base existen
v5.6 y v16, este diagnóstico se hizo contra la versión anterior y conviene
recontrastarlo.

---

## 7. Tabla de movimientos propuestos

Ordenada por riesgo, de menor a mayor. **Ninguno se ejecuta en este encargo.**

| # | Movimiento | Riesgo | Por qué ese riesgo | Requiere decisión del titular |
|---|---|---|---|---|
| 1 | Agregar `packrat` y `venv` a `excluir_dir` en `00_escanear_proyecto.R` (líneas 46, 114, 137) | **Muy bajo** | Ninguna de las dos carpetas existe; la salida del escáner no cambia. Cierra el bloque 4 | No |
| 2 | Declarar en `CLAUDE.md` la excepción de §1.2.4 para los tres archivos de `20_insumos/`, no solo para uno | **Muy bajo** | Es documentar un estado que ya existe. No mueve ni renombra nada | No |
| 3 | Mover `handoff/` de la raíz a `_archivo/YYYYMMDD/handoff/` | **Bajo** | Carpeta ignorada por git: el movimiento no genera commit ni toca el historial. Reversible con un `mv`. Exige grep previo por ser grado medio | **Sí** — nada la declara superada por escrito |
| 4 | Retirar `handoff` de las exclusiones del escáner, si se ejecuta el 3 | **Bajo** | Solo tiene sentido encadenado al 3; suelto, deja de excluir una carpeta que sigue existiendo | Encadenado al 3 |
| 5 | `git mv` de `encargo_diseno_portafolio.md` a `50_encargo_diseno_portafolio.md`, con sus dos referencias vivas actualizadas | **Medio** | Renombre limpio —cero coincidencias en política y SETTINGS—, pero toca dos documentos de `activa/` en el mismo commit | **Sí** — y antes hay que resolver el 6, que puede dejarlo sin objeto |
| 6 | Decidir si ese encargo pertenece a `activa/` o a `andamios/` | **Medio** | Es una decisión de clasificación, no un movimiento. Excluyente con el 5 | **Sí** |
| 7 | Decidir el estatuto de `50_documentacion/handoffs/`: excepción declarada, propuesta a la política, o archivado tras integrar | **Medio** | Afecta a dos paquetes de diseño, uno de ellos de la metáfora ya retirada | **Sí** |
| 8 | Decidir si `40_salidas/solicitudes_al_titular.md` es salida regenerable o documento vivo de `activa/` | **Medio-alto** | Si es documento vivo y se queda en `40_salidas/`, un reproceso puede pisar las marcas de resuelto del titular | **Sí** |
| 9 | Resolver la lectura de §1.2.4 para `20_insumos/` y `40_salidas/`, y renombrar los siete archivos si la lectura amplia gana | **Alto** | `31_`, `32_` y `33_` leen y escriben esos archivos por nombre: renombrar sin tocar los scripts rompe el pipeline, y tocarlos lo prohíbe §4.7.4 | **Sí** — es una duda de interpretación de la política, no del proyecto |

**Advertencia de precondiciones.** Cuando se decida ejecutar cualquiera de los
movimientos 3 a 9, §4.7.1 exige antes: árbol e índice limpios, `git stash list`
vacío, cero divergencia con el remoto y **una rama que no sea `main`**. Hoy el
trabajo ocurre en `main` y hay commits locales sin pushear, de modo que la
ejecución no puede empezar sin abrir `ordenacion/<AAAAMMDD>` y sincronizar
primero. Los movimientos 1 y 2 no son ordenación en el sentido de §4.7 —no
mueven ni renombran nada— y pueden hacerse por la vía normal.
