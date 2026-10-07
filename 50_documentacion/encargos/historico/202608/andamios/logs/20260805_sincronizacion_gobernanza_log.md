# Log — sincronización de la gobernanza en disco y relevamiento de estado

> **Encargo:** `50_documentacion/andamios/20260805_encargo_sincronizacion_gobernanza.md`
> **Proyecto:** `slep_monitoreo` · **Sesión 18** · **Fecha:** 2026-08-05
> **Pendiente que cierra:** P3 del traspaso v17.
> **Ejecución:** Claude Code, modo autónomo secuencial. **Detenido en la Fase 1**
> por la regla de detención del propio encargo; reanudado por decisión del
> titular con un alcance distinto del previsto.
>
> **Nota de plantilla.** El encargo pide seguir la plantilla fija de
> `encargo_autonomo_claude_code_v1.md` §4. Ese archivo no existe en el
> filesystem del proyecto: vive en la knowledge base de la cartera y el grep
> sobre el repositorio solo devuelve una cita en `SETTINGS` línea 540. Se usan
> las secciones que el propio encargo enumera en su Fase 4, más identificación y
> estado al cierre. Se declara para que el revisor sepa que la estructura se
> reconstruyó, no se copió.

---

## 1. Resumen

El encargo pedía commitear la sincronización de `POLITICA_PROYECTO.md` a v5.6 y
de `SETTINGS_Y_PROMPTS_OPERACIONALES.md` a v16, y luego relevar estado. **La
sincronización ya estaba hecha y verificada; el commit resultó imposible.** Los
dos documentos de gobernanza están ignorados por git y nunca han estado
versionados, de modo que la Fase 2 solo podía ejecutarse con `git add -f`, que
el invariante 🔒 3 prohíbe por su nombre.

La ejecución se detuvo ahí y reportó, en vez de resolverlo por su cuenta. El
titular optó por la **vía 1**: P3 se cierra sin commit de gobernanza, porque
`.gitignore:21-22` no es un defecto sino la regla vigente de la cartera. El
trabajo efectivo del turno pasó a ser otro: corregir la afirmación falsa que
`ESTADO.md` hacía sobre las versiones en disco, correr el escáner y dejar este
registro.

Lo que costó: el encargo describía un estado de git que no podía existir. Dos
de sus premisas eran falsas y una tercera —la divergencia— también. Detectarlas
consumió la Fase 0 y la Fase 1 completas antes de poder afirmar nada.

---

## 2. Inventario de commits

| Hash | Mensaje | Rutas |
|---|---|---|
| `663fb40` | `docs(estado): corrige la version de gobernanza declarada en ESTADO.md` | `50_documentacion/activa/ESTADO.md` |
| *(este log)* | `docs(log): registra la ejecucion detenida del encargo de sincronizacion` | `50_documentacion/andamios/logs/20260805_sincronizacion_gobernanza_log.md` |

**El commit que el encargo pedía en su Fase 2 no existe y no debe existir.**
Ningún `git push`. Los tres commits del cierre de la sesión 17 siguen sin
publicar, por decisión del titular.

---

## 3. Cambios sustantivos

### 3.1 El hallazgo: los documentos de gobernanza no son versionables

```
$ git check-ignore -v 50_documentacion/activa/POLITICA_PROYECTO.md
.gitignore:21:POLITICA_PROYECTO.md	50_documentacion/activa/POLITICA_PROYECTO.md

$ git check-ignore -v 50_documentacion/activa/SETTINGS_Y_PROMPTS_OPERACIONALES.md
.gitignore:22:SETTINGS_Y_PROMPTS_OPERACIONALES.md	50_documentacion/activa/SETTINGS_Y_PROMPTS_OPERACIONALES.md
```

Ambos con `git ls-files` vacío y ausentes de `HEAD`: nunca estuvieron
versionados. El `.gitignore` lo declara en su línea 20, encabezando ambas
reglas: *«Gobernanza: viven en la knowledge base del Project, no en el
repositorio»*. No es una omisión heredada, es una decisión de cartera.

**Consecuencia sobre el encargo:** su Fase 2 era irrealizable. Los `git add`
que prescribe son operaciones nulas sobre rutas ignoradas, y la única forma de
stagearlas —`git add -f`— está prohibida por el invariante 3. No hay redacción
del commit que salve esto: el conflicto es entre la tarea y un invariante.

### 3.2 La sincronización, verificada en disco

| Archivo | Encabezado | Líneas | Cierre |
|---|---|---:|---|
| `POLITICA_PROYECTO.md` | `Versión 5.6 — vigente` | 904 (eran 836 en v5.5) | glosario completo, entrada `DRY_RUN` |
| `SETTINGS_Y_PROMPTS_OPERACIONALES.md` | `Versión 16` | 1542 | §4.7.4, lista de prohibiciones completa |

Ninguno truncado. Las secciones que el encargo anuncia están presentes:
`§5.2bis Invariante de entorno (locale UTF-8)` en la línea 436 de POLITICA, y
el paso `4ter` de §1.2.2 en SETTINGS. **P3 está materialmente cerrado**; lo que
no tiene es rastro en el historial, y no puede tenerlo.

### 3.3 Corrección de `ESTADO.md`

`ESTADO.md:32` declaraba que las copias en disco estaban en v5.5 y v15. Era
cierto al escribirse y dejó de serlo. Se corrigió lo que hoy es falso y nada
más:

- «En que vamos» deja de listar el desfase entre los pendientes abiertos y
  registra P3 como cerrado, explicando por qué no deja commit.
- «Proximo paso» pasa de P3 a **P1, la redacción del elemento 3**, que era la
  prioridad 2 de la §11.4 del traspaso v17 y asciende al cerrarse P3.
- El conteo de commits sin pushear pasa de 2 a 5.
- `ultima_actividad` **no se tocó**: ya declaraba `2026-08-05`.
- `sesion_actual` **no se tocó**: sigue en `v17`. Ver §7.

### 3.4 Escáner

```
Carpetas: 16 | Archivos: 123
Version previa rotada a: estructura_anterior.txt / estructura_anterior.md
```

Corrió sin error. Sus cuatro salidas siguen ignoradas por `.gitignore:34`,
comprobado una por una con `check-ignore` tras la corrida, y `git status
--porcelain` quedó vacío: ninguna entró al índice.

---

## 4. Bugs y contingencias

**Contingencia 1 · Glob de zsh en la Fase 3.2.** El comando
`grep -rl "asegurar_locale_utf8" . --include=*.R` falló con
`(eval):15: no matches found: --include=*.R`: zsh intentó expandir `*.R` en el
directorio de trabajo antes de pasar el argumento. Es exactamente el riesgo que
el propio encargo declara en su contrato de entorno, aunque su bloque de
comandos no lo protegía. Resuelto citando el patrón: `--include="*.R"`.
Resultado sin cambios: 0 archivos.

**No hubo bugs de código.** Nada se ejecutó sobre `docs/`, sobre el pipeline ni
sobre datos.

---

## 5. Verificación de los ocho invariantes

| # | Invariante | Estado | Evidencia |
|---|---|---|---|
| 1 | Ningún `git push` | **PASA** | Divergencia `0 5` al cierre: local adelantado, remoto intacto |
| 2 | Ningún `--force`, `reset --hard`, `rebase` ni tag | **PASA** | Ninguno ejecutado; `git tag` sigue devolviendo solo `v2.1`, preexistente |
| 3 | Nunca `add -A`, `add .`, `add -f`, `commit -a` | **PASA** | Staging por ruta explícita en los dos commits. Es el invariante que forzó la detención |
| 4 | Los cuatro de `estructura/` no se commitean | **PASA** | `check-ignore` exit 0 en los cuatro tras correr el escáner; `git status --porcelain` vacío |
| 5 | No editar fuera de gobernanza y el log | **FALLA declarada, autorizada** | Se editó `ESTADO.md`, que el invariante 5 excluye expresamente. Lo ordenó el titular al elegir la vía 1, con el encargo ya detenido y su alcance redefinido. Se registra como desviación, no como cumplimiento |
| 6 | No crear `50_ordenacion_repositorio.md` ni `50_locale_utf8.md` | **PASA** | Ambos ausentes: `ls` devuelve 0 para los dos |
| 7 | No corregir referencias a versiones superadas | **PASA con matiz** | De las 17 coincidencias inventariadas en la Fase 3.3 no se tocó ninguna. La corrección de `ESTADO.md:32` no es una de ellas por la vía del invariante 7: no es un enunciado histórico sino una declaración de estado presente que había pasado a ser falsa |
| 8 | No se borra nada | **PASA** | Ninguna supresión. El escáner rota `estructura_anterior`, que es su comportamiento normal y afecta a archivos ignorados |

El invariante 5 es la única desviación del turno y está declarada arriba con su
autorización. Un log que la diera por PASA estaría mintiendo.

---

## 6. Decisiones registradas

1. **Vía 1, del titular:** P3 se cierra sin commit de gobernanza.
   `.gitignore:21-22` es la regla vigente de cartera y **no se toca**. La
   alternativa —quitar los dos documentos del `.gitignore` para versionarlos—
   se planteó y se descartó por contradecir la decisión de que vivan en la
   knowledge base.
2. **De la ejecución:** no escribir este log durante la detención. Documentar
   como ejecutada una fase que no ocurrió es el mismo error que crear un
   marcador de estado sin el trabajo detrás.
3. **De la ejecución:** no correr el escáner mientras el encargo estaba
   detenido, para no rotar el snapshot anterior sin necesidad. Se corrió al
   reanudar, ya con instrucción explícita.
4. **De la ejecución:** commitear `ESTADO.md` **antes** de correr el escáner,
   de modo que la salida del escáner no pudiera contaminar el índice.

---

## 7. Pendientes abiertos

- **P1 · Redacción del elemento 3** de la sección Formación. Es el próximo paso
  declarado en `ESTADO.md`.
- **P2 · Los nueve movimientos del diagnóstico de ordenación.** Siete requieren
  decisión del titular. Ahora que la gobernanza en disco está en v5.6 y v16,
  **conviene recontrastar el diagnóstico**: se produjo leyendo v5.5 y v15, que
  es precisamente el riesgo que P3 describía.
- **Gatillo 4ter, invariante de locale UTF-8.** Bloqueado, no pendiente: no
  existe `10_utils/10_configuracion.R`, no hay ningún `.R` con
  `asegurar_locale_utf8`, y SETTINGS prohíbe improvisar el punto de arranque.
  Dónde vive ese punto en un proyecto sin `10_utils/` es decisión del titular.
- **# REVISAR · `sesion_actual` en `ESTADO.md`.** El frontmatter declara `v17`
  y este encargo se identifica como sesión 18. No se cambió porque la
  instrucción del titular enumeró qué corregir y no lo incluía, y porque el
  cuerpo del documento describe el trabajo de la 17. Si la sesión en curso es
  la 18, es una línea a corregir.
- **Los tres commits del cierre de la sesión 17** siguen sin pushear, más los
  dos de este turno. Total: 5.

---

## 8. Notas para el revisor

**Lo que salió bien:** la regla de detención funcionó. El encargo declaraba tres
casos de detención y se dieron dos; parar antes de tocar nada evitó un `git add
-f` que habría metido en el repositorio dos documentos que la cartera mantiene
deliberadamente fuera.

**Lo que costó:** el encargo describía un estado de git imposible. Esperaba ver
los dos archivos de gobernanza «modificados» en `git status`, cosa que no puede
ocurrir con archivos ignorados; esperaba divergencia `0 0` cuando había `0 3`; y
daba por ruido conocido cuatro archivos de `estructura/` que están ignorados
desde la sesión 16 y por lo tanto tampoco aparecen. Tres premisas sobre el mismo
comando, las tres falsas. La causa raíz es común: **el encargo se redactó desde
la descripción del proyecto y no desde una lectura del `.gitignore`.**

**Lo que conviene mirar dos veces:** la §5 de este log declara una FALLA en el
invariante 5. Está autorizada y explicada, pero es una desviación real y no
debería leerse al vuelo como si fuera un PASA.

**Precedente que deja este turno:** un pendiente puede cerrarse sin commit. P3
está cerrado porque el estado del disco es el correcto, aunque el historial no
lo registre. Para pendientes que viven fuera del árbol versionado, el criterio
de cierre es la verificación, no el hash.

---

## 9. Estado al cierre

- `POLITICA_PROYECTO.md` v5.6 y `SETTINGS_Y_PROMPTS_OPERACIONALES.md` v16 en
  disco, verificados por encabezado y longitud. Fuera del repositorio, por
  diseño.
- `ESTADO.md` ya no afirma nada falso sobre las versiones en disco.
- Escáner al día: 16 carpetas, 123 archivos.
- Los dos marcadores de estado siguen sin crear: los gatillos 4bis y 4ter
  siguen encendidos.
- `.gitignore` sin tocar.
- Sin push. Sin borrados. Sin ediciones en `docs/`, `30_procesamiento/` ni
  `40_salidas/`.
