# Log de cierre — versionado de `traspasos/` y `andamios/logs/` (encargo v2)

> **Encargo:** `50_documentacion/andamios/20260802_encargo_gitignore_memoria_v2.md`
> **Reemplaza a:** la v1, detenida en fase A. **Proyecto:** `slep_monitoreo`
> **Fecha:** 2026-08-02 · **Ejecutor:** Claude Code, modo autónomo.

---

## 1. Resumen ejecutivo

El barrido de gobernanza corrió **antes** de tocar `.gitignore` y devolvió **0
coincidencias identificatorias**: los 11 literales encontrados son la sigla
«RBD» usada como concepto, más `ISO-8859-1` (nombre de codificación en un
bloque de código R). `.gitignore` se reescribió y ahora versiona los 14
traspasos y los 4 logs, manteniendo ignorados encargos, maquetas y los dos
archivos de gobernanza no trackeados.

Se hicieron tres commits: `b93c71c` (19 archivos, 6 142 inserciones),
`6fb317b` (ESTADO.md) y el de este log. `CLAUDE.md` quedó corregido y sin
commitear, como pide el encargo.

**Dos hallazgos que el encargo no anticipaba y que ninguna regla de `.gitignore`
puede resolver:** `CLAUDE.md` y los cuatro archivos del escáner **ya estaban
trackeados**, es decir ya son públicos, pese a que la sección 3 los declara
«siguen ignorados». Detalle en §8.

---

## 2. Fase A — Estado real

### 2.1 `.gitignore` previo, íntegro

```
     1	# macOS
     2	.DS_Store
     3	
     4	# Archivo local (snapshots pre-reorganización, no se versionan)
     5	_archivo/
     6	
     7	# Config local del editor / MCP
     8	.claude/
     9	
    10	# Insumo de traspaso entregado (referencia local, no se versiona)
    11	handoff/
    12	
    13	# Traspasos de sesión: memoria interna, NO se publican (Pages sirve todo el repo)
    14	50_documentacion/traspasos/**
    15	POLITICA_PROYECTO.md
    16	SETTINGS_Y_PROMPTS_OPERACIONALES.md
    17	
    18	# Andamios de sesión: encargos y logs de ejecución, NO se publican
    19	50_documentacion/andamios/**
```

**Líneas que excluían:** la 14 para `traspasos/`, la 19 para `andamios/`.

### 2.2 Ya versionado en `50_documentacion/` antes del encargo

13 rutas: `activa/.gitkeep`, `activa/50_catalogo_project_cards.md`,
`activa/50_contrato_atlas_datos.md`, `activa/50_fundamento_seccion_formacion.md`,
`activa/ESTADO.md`, `activa/backlog_acumulativo.md`,
`activa/encargo_diseno_portafolio.md`, `estructura/.gitkeep`, los cuatro
archivos del escáner, y `traspasos/.gitkeep`.

### 2.3 Lo que entraría al índice

| Grupo | Archivos |
|---|---|
| `traspasos/` (raíz) | 2 — `v12`, `v14` |
| `traspasos/archivo/` | 12 — `v01` a `v11` y `v13` |
| `andamios/logs/` | 4 |
| **Total** | **18 archivos, 496 KB** |

**Discrepancia con los INSUMOS del encargo.** El encargo declara «v12, v13, v14
en la raíz; v01 a v11 en `archivo/`». El estado real es: `v12` y `v14` en la
raíz, y `v01`–`v11` **más `v13`** en `archivo/` (v13 se archivó en una sesión
anterior de hoy). El total de traspasos es 14, no 14 repartidos como decía. La
pregunta 6 de la auto-auditoría habla de «los 11 de `archivo/`»: son 12.

---

## 3. Fase B — Barrido de gobernanza (ejecutado ANTES de tocar `.gitignore`)

Comando exacto de la fase B del encargo, sobre `50_documentacion/traspasos/` y
`50_documentacion/andamios/logs/`. **7 líneas con coincidencia, 11 literales.**

| # | Ruta:línea | Literal | Grupo |
|---|---|---|---|
| 1 | `traspasos/archivo/traspaso_cierre_v08.md:49` | `RBD` | **Discute la norma** — «Ningún nombre de establecimiento educacional ni RBD entró a `data.js`» |
| 2 | `traspasos/archivo/traspaso_cierre_v08.md:116` | `RBD` (×2) | **Discute la norma** — «las tres minutas nombran establecimientos … POLITICA §6.4 recoge la condición contractual de la Agencia de Calidad de no identificar establecimientos por nombre». Enuncia la regla; no nombra ninguno |
| 3 | `traspasos/archivo/traspaso_cierre_v09.md:285` | `RBD` | **Discute la norma** — «el `grep` de privacidad … solo devolvió la línea que prohíbe los RBD» |
| 4 | `traspasos/archivo/traspaso_cierre_v11.md:252` | `8859-1` | **Genérica** — falso positivo: es `ISO-8859-1` en `iconv(rawToChar(b), "latin1", "UTF-8")`, un nombre de codificación de caracteres |
| 5 | `andamios/logs/20260802_politica_gitignore_log.md:111` | `rbd`, `escuela `, `liceo `, `colegio ` | **Discute la norma** — es la fila de tabla del log v1 que transcribe el propio patrón de búsqueda |
| 6 | `andamios/logs/20260802_politica_gitignore_log.md:124` | `RBD` | **Discute la norma** — cita textual del pasaje 2 |
| 7 | `andamios/logs/20260802_politica_gitignore_log.md:132` | `RBD` | **Discute la norma** — «ningún archivo contiene nombres de establecimientos, RBD, RUT…» |

**Conteo por grupo:**

| Grupo | Líneas | Literales |
|---|---|---|
| Discute la norma | 6 | 10 |
| Genérica | 1 | 1 |
| **Identificatoria** | **0** | **0** |

**0 coincidencias identificatorias.** Ningún nombre de establecimiento o jardín
infantil, ningún RBD real, ningún RUT, ningún correo, ninguna ruta del data
root, ninguna credencial, ningún resultado atribuible a una comunidad concreta.
No se editó ningún archivo. Se prosiguió a la fase C.

---

## 4. Fase C — Reescritura de `.gitignore`

### 4.1 Bloque nuevo (líneas 13-29)

```gitignore
# Memoria del proyecto: los traspasos de cierre y los logs de encargos
# ejecutados SE VERSIONAN y, por lo tanto, se publican. Este repositorio es
# publico por diseno: todo lo que entre queda legible en
# github.com/tomgc/slep_monitoreo, aunque Pages sirva solo main:/docs.
# Se redactan bajo esa condicion: sin nombres de establecimientos, RBD, RUT,
# correos ni rutas locales.

# Gobernanza: viven en la knowledge base del Project, no en el repositorio.
POLITICA_PROYECTO.md
SETTINGS_Y_PROMPTS_OPERACIONALES.md

# Andamios de sesion: instrumentos de un turno. El encargo y la maqueta
# caducan al ejecutarse; el log del encargo es memoria y se versiona.
50_documentacion/andamios/*
!50_documentacion/andamios/logs/
50_documentacion/andamios/logs/*
!50_documentacion/andamios/logs/*.md
```

La exclusión `50_documentacion/traspasos/**` se **eliminó** en vez de negarse
con `!`: sin regla que los excluya, los traspasos son versionables sin
necesidad de negación, y la regla más simple es la que menos se rompe. El
comentario falso de la línea 13 («Pages sirve todo el repo») se reemplazó por
el motivo verdadero.

Los dos archivos de gobernanza conservan su regla de nombre desnudo, que
coincide a cualquier profundidad y por eso sigue alcanzándolos en
`50_documentacion/activa/`.

### 4.2 `git check-ignore`, antes y después

| Ruta | Antes | Después | Esperado |
|---|---|---|---|
| `traspasos/traspaso_cierre_v14.md` | IGNORADO | **versionable** | versionable ✓ |
| `traspasos/archivo/traspaso_cierre_v01.md` | IGNORADO | **versionable** | versionable ✓ |
| `andamios/logs/20260802_politica_gitignore_log.md` | IGNORADO | **versionable** | versionable ✓ |
| `andamios/logs/20260802_normalizacion_y_renombre_log.md` | IGNORADO | **versionable** | versionable ✓ |
| `andamios/20260802_encargo_gitignore_memoria_v2.md` | IGNORADO | **IGNORADO** | IGNORADO ✓ |
| `andamios/20260731_maqueta_tablero.html` | IGNORADO | **IGNORADO** | IGNORADO ✓ |
| `activa/POLITICA_PROYECTO.md` | IGNORADO | **IGNORADO** | IGNORADO ✓ |
| `activa/SETTINGS_Y_PROMPTS_OPERACIONALES.md` | IGNORADO | **IGNORADO** | IGNORADO ✓ |
| `estructura/estructura_actual.md` | no ignorado | **versionable** | IGNORADO ✗ |
| `CLAUDE.md` | no ignorado | **versionable** | IGNORADO ✗ |

**8 de 10 coinciden.** Las dos que no coinciden ya estaban así **antes** de
tocar nada: son archivos **trackeados**, y git no aplica reglas de ignore a un
archivo trackeado. Ninguna reescritura de `.gitignore` puede cambiarlo, de modo
que no se hizo un segundo intento: la regla de detención 3 apunta a reglas mal
escritas, y estas no lo están. Ver §8.

---

## 5. Fase D — Corrección de las afirmaciones falsas

### 5.1 `CLAUDE.md` del proyecto — pasaje 1 (bloque `traspasos/`)

**Antes:**

> `traspasos/` — traspasos de cierre de sesión y `backlog_acumulado.md`
> (snake_case). **Gitignored**: no se versionan porque el repositorio es
> público y su contenido no debe serlo. Al no versionarse, este repo queda
> fuera de la regla 1.3.1 de `POLITICA_PROYECTO.md` v5.5 … Revisar esa
> exclusión está pendiente de decisión del titular.

**Después:**

> `traspasos/` — traspasos de cierre de sesión y `backlog_acumulado.md`
> (snake_case). **Versionados** desde el 2026-08-02, por decisión del titular:
> son el registro metodológico del trabajo del Área, del mismo tipo que el
> backlog que ya era público. El repositorio es público por diseño, de modo que
> se redactan sabiendo que quedan legibles en `github.com/tomgc/slep_monitoreo`:
> sin nombres de establecimientos, RBD, RUT, correos ni rutas locales. Al
> versionarse, este repo vuelve a quedar dentro de la regla 1.3.1 de
> `POLITICA_PROYECTO.md` … y del bloque 1 del protocolo §4.7 de
> `SETTINGS_Y_PROMPTS_OPERACIONALES.md`, que la ejecuta.

Consecuencia sustantiva, no cosmética: al versionarse, **vuelven a regir** la
regla 1.3.1 y el bloque 1 del protocolo §4.7, de los que este repo estaba
exento precisamente por no versionar los traspasos.

### 5.2 `CLAUDE.md` del proyecto — pasaje 2 (sección del escáner)

**Antes:**

> Los traspasos de sesión y `backlog_acumulado.md` NO se versionan: viven en
> `50_documentacion/traspasos/` pero están **gitignored** porque GitHub Pages
> publica todo el repo y no deben ser públicos. Se adjuntan a mano al abrir
> cada sesión.

**Después:**

> Los traspasos de sesión y `backlog_acumulado.md` **sí se versionan** (desde el
> 2026-08-02) y viajan con el repositorio: ya no hay que adjuntarlos a mano al
> abrir cada sesión. Pages sirve solo `main` `/docs`, pero el repositorio
> completo es público y navegable en `github.com`: eso, y no Pages, es lo que
> determina qué queda a la vista. Los logs de encargos ejecutados
> (`50_documentacion/andamios/logs/*.md`) siguen la misma regla; los encargos y
> maquetas de `50_documentacion/andamios/` siguen ignorados por caducos.

`CLAUDE.md` quedó **modificado y sin commitear**, como ordena el encargo.

### 5.3 `ESTADO.md` — sección nueva

`ESTADO.md` no tenía una sección de condiciones permanentes; se agregó al final,
tras «Bloqueantes»:

> **## Condiciones permanentes**
> El repositorio es publico por diseno. Desde el 2026-08-02 los traspasos de
> cierre (`50_documentacion/traspasos/`) y los logs de encargos ejecutados
> (`50_documentacion/andamios/logs/`) se versionan, de modo que son contenido
> publicado: quedan legibles en `github.com/tomgc/slep_monitoreo` aunque Pages
> sirva solo `main` `/docs`. Se redactan bajo esa condicion, sin nombres de
> establecimientos, RBD, RUT, correos ni rutas locales. Los encargos y maquetas
> de `50_documentacion/andamios/` siguen ignorados: son instrumentos de un turno
> y caducan al ejecutarse.

### 5.4 Lo que NO se tocó: el `CLAUDE.md` global

El encargo habla de «`CLAUDE.md` §3, que describe esta raíz como un repositorio
privado de GitHub». Ese texto **no está** en el `CLAUDE.md` del proyecto (el
que figura en los INSUMOS), sino en el `CLAUDE.md` **global** del titular
(`~/.claude/CLAUDE.md` §3, «Arquitectura de dos raíces»: «Raíz de código: este
repo (GitHub privado)»).

No se editó, por dos razones: es un archivo de instrucciones globales que rige
**todos** los proyectos del titular, y su frase describe la arquitectura general
para proyectos con datos sensibles, no específicamente `slep_monitoreo`; además,
las reglas globales del propio titular exigen aprobación individual para editar
`~/.claude/CLAUDE.md`. Queda como pendiente en §9.

---

## 6. Fase E — Commits

| # | Hash | Mensaje | `--stat` |
|---|---|---|---|
| 1 | `b93c71c` | versiona los traspasos de cierre y los logs de andamios | 19 archivos, 6 142 inserciones, 4 borrados |
| 2 | `6fb317b` | declara en ESTADO.md que la memoria versionada es publica | 1 archivo, 11 inserciones |
| 3 | (este log) | documenta la politica de versionado de traspasos y logs | 1 archivo |

Los 19 archivos del commit 1 son: `.gitignore`, los 14 traspasos (2 de la raíz
y 12 de `archivo/`) y los 4 logs. Las 4 líneas borradas son las reglas viejas de
`.gitignore`. Ningún archivo de la sección 3 entró en ningún commit.

---

## 7. Auto-auditoría adversarial

| # | Pregunta | Respuesta y evidencia |
|---|---|---|
| 1 | ¿El barrido corrió **antes** de tocar `.gitignore`? | **Sí.** Orden real: fase A (lectura) → fase B (`grep` de gobernanza, §3) → recién entonces la edición de `.gitignore` (§4). En el momento del barrido `.gitignore` estaba intacto, según su propia salida de fase A |
| 2 | ¿Hubo coincidencias identificatorias? | **No: 0.** 7 líneas y 11 literales, todos clasificados en §3: 10 «discute la norma», 1 «genérica» (`ISO-8859-1`) |
| 3 | ¿Los tres archivos de gobernanza siguen ignorados? | **Dos de tres.** `POLITICA_PROYECTO.md` y `SETTINGS_Y_PROMPTS_OPERACIONALES.md`: IGNORADO y no trackeados ✓. `CLAUDE.md`: **no ignorado y ya trackeado antes de este encargo**. No lo versionó este trabajo. Ver §8 |
| 4 | ¿Los cuatro del escáner siguen ignorados? | **No lo estaban.** Los cuatro ya estaban **trackeados** desde antes; la regla canónica «no se commitean nunca» significa que no se commitean sus *modificaciones*, no que estén en `.gitignore`. Siguen modificados y sin commitear ✓. Ver §8 |
| 5 | ¿Encargos y maquetas siguen ignorados? | **Sí.** `20260802_encargo_gitignore_memoria_v2.md` y `20260731_maqueta_tablero.html` → IGNORADO en la tabla de §4.2 |
| 6 | ¿Entraron todos los traspasos, incluidos los de `archivo/`? | **Sí, los 14.** `git show --stat b93c71c` lista `v01`–`v11` y `v13` en `archivo/` (12, no 11 como decía el encargo) más `v12` y `v14` en la raíz |
| 7 | ¿Se usó `git add -A` o `git add -f`? | **No.** Los tres `git add` fueron por ruta explícita o patrón acotado (`traspasos/archivo/*.md`, `andamios/logs/*.md`). Ningún archivo necesitó `-f`: la regla nueva los admite sola |
| 8 | ¿Se editó el contenido de algún traspaso o log? | **No.** El commit 1 los agrega con `create mode`, sin modificaciones. El barrido de la fase B fue de solo lectura; ninguna coincidencia se «limpió» |
| 9 | ¿`CLAUDE.md` quedó corregido y sin commitear? | **Sí.** Aparece como ` M CLAUDE.md` en `git status --short` final y no figura en ninguno de los tres commits. Salvedad: quedó así por instrucción, pero al estar **trackeado** eso deja un archivo versionado sucio de forma indefinida, no un archivo ignorado como suponía el encargo. Ver §9 |
| 10 | ¿Hubo push, `--force`, `reset --hard`, tag o cambio de visibilidad? | **No.** Ninguno. `main` quedó local, 27 commits por delante de `origin/main`. No se ejecutó `gh repo edit` ni ningún verbo de escritura contra la API |

---

## 8. Hallazgo principal: la sección 3 describe mal el estado real

La sección 3 del encargo afirma que `CLAUDE.md` y los cuatro archivos del
escáner «siguen ignorados». Verificado antes de tocar nada:

| Archivo | Trackeado | Ignorado |
|---|---|---|
| `CLAUDE.md` | **sí** | no |
| `50_documentacion/estructura/estructura_actual.md` (y los otros 3) | **sí** | no |
| `50_documentacion/activa/POLITICA_PROYECTO.md` | no | **sí** |
| `50_documentacion/activa/SETTINGS_Y_PROMPTS_OPERACIONALES.md` | no | **sí** |

Es decir: `CLAUDE.md` y los cuatro del escáner **ya eran públicos** antes de
este encargo, y lo seguirán siendo. Esto **no lo causó** este trabajo y por eso
no activó la regla de detención 1: cumplir el encargo no obligó a versionarlos,
ya lo estaban.

Tampoco es corregible con `.gitignore`: git ignora únicamente archivos **no
trackeados**. Agregar `CLAUDE.md` a `.gitignore` no lo sacaría del repositorio;
solo crearía una regla inerte que afirma algo falso, exactamente el defecto que
este encargo vino a corregir en dos lugares. Sacarlos de verdad exige
`git rm --cached`, que los **elimina del repositorio** en el próximo push: es
una decisión del titular, no un paso mecánico, y queda fuera del alcance.

---

## 9. Decisiones autónomas y deuda nueva

### Decisiones autónomas

1. **Eliminar la regla de `traspasos/` en vez de negarla con `!`.** Sin regla que
   excluya, la negación es innecesaria; menos reglas, menos superficie de error.
2. **No agregar `CLAUDE.md` a `.gitignore`.** Sería una regla inerte sobre un
   archivo trackeado y una afirmación falsa más en un archivo que este encargo
   corrige precisamente por contener afirmaciones falsas.
3. **No hacer un segundo intento de reglas tras el `check-ignore`.** Las dos
   filas que no coinciden con lo esperado no dependen de las reglas sino del
   estado trackeado de esos archivos. Un segundo intento habría fallado igual.
4. **No editar `~/.claude/CLAUDE.md`** (§5.4): es global, rige todos los
   proyectos y las reglas del titular exigen aprobación individual.
5. **Corregir además el pasaje 2 de `CLAUDE.md`** (sección del escáner), no solo
   el del bloque `traspasos/`: contenía la misma afirmación falsa sobre Pages y
   habría quedado contradiciendo al pasaje corregido.

### Deuda nueva

1. **`CLAUDE.md` queda trackeado y sucio.** El encargo pedía editarlo y no
   commitearlo, suponiéndolo ignorado. Al estar trackeado, la corrección queda
   sin commitear de forma indefinida y es candidata a colarse en un futuro
   `git add -A` ajeno. Conviene resolver en un turno: commitearla, o sacar
   `CLAUDE.md` del repositorio con `git rm --cached` si la intención original
   era que no fuera público.
2. **Los cuatro archivos del escáner son públicos.** Si la intención es que sean
   «ruido local», habría que sacarlos del índice; hoy solo se evita commitear sus
   cambios, lo que deja una versión congelada y desactualizada en el repositorio.
3. **`CLAUDE.md` §«Estructura», línea sobre las carpetas del pipeline de R**
   («Ninguna de las tres se publica: Pages sirve solo `main` `/docs`») incurre en
   la misma confusión ya corregida en otros dos puntos. Verificado:
   `20_insumos/` y `40_salidas/` tienen 7 archivos versionados (README, brief,
   resultado del reconocimiento, `catalogo_fuentes.csv`, fichas y logs) y por lo
   tanto **sí son públicos**. No hay problema de gobernanza (es un catálogo de
   fuentes públicas y `ESTADO.md` declara `maneja_sensibles: no`), pero la frase
   es inexacta. Fuera del alcance de este encargo.
4. **Los INSUMOS del encargo describen mal la ubicación de `v13`** y la
   auto-auditoría habla de 11 traspasos en `archivo/` cuando son 12 (§2.3).
5. **El `.gitkeep` de `50_documentacion/traspasos/`** ya no cumple función: la
   carpeta tiene contenido versionado. Se dejó por ser inocuo.

---

## 10. Estado final del repositorio

```
=== git log --oneline -5 ===
6fb317b declara en ESTADO.md que la memoria versionada es publica
b93c71c versiona los traspasos de cierre y los logs de andamios
9ae92ab actualiza los consumidores del atlas al identificador desafio
5b1de70 renombra ATLAS_AMBITOS a ATLAS_DESAFIOS en el catalogo y el validador
4980b2c actualiza el contrato del atlas: ambito de indagacion pasa a desafio educativo

=== git status --short ===
 M 50_documentacion/estructura/estructura_actual.md
 M 50_documentacion/estructura/estructura_actual.txt
 M 50_documentacion/estructura/estructura_anterior.md
 M 50_documentacion/estructura/estructura_anterior.txt
 M CLAUDE.md

=== git branch -v ===
* main                 6fb317b [ahead 27] declara en ESTADO.md que la memoria versionada es publica
  wip/atlas_tablero_v3 6894986 wip: tablero del atlas sin revision visual, punto de guardado
```

Estado capturado antes del commit 3, que agrega este log. Los cuatro del escáner
y `CLAUDE.md` quedan modificados y sin commitear, según lo previsto. Sin push,
sin `--force`, sin `reset --hard`, sin tags, sin cambio de visibilidad.

**La publicación efectiva ocurre cuando el titular autorice el push.** Hasta
entonces, los 18 archivos están versionados solo en `main` local.
