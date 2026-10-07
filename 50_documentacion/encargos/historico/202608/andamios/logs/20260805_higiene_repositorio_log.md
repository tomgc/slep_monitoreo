# Log — higiene técnica del repositorio: código muerto del atlas y diagnóstico de ordenación

> **Encargo:** `50_documentacion/andamios/20260805_encargo_higiene_repositorio.md`
> **Proyecto:** `slep_monitoreo` · **Sesión 17** · **Fecha:** 2026-08-05
> **Ejecución:** Claude Code, modo autónomo secuencial, en dos turnos: el
> primero se detuvo en la Fase 0 y el segundo completó de la Fase 2 al cierre.
> **Cierra:** P13. **Avanza:** P10, solo en su fase de diagnóstico.

---

## 1. Fase 0 — Detención y reanudación

La primera ejecución **se detuvo en la Fase 0**, por la condición declarada en
el propio encargo: el árbol no estaba limpio.

```
$ git status --short
 M 50_documentacion/activa/50_contenido_seccion_formacion.md

$ git log --oneline origin/main..main | wc -l
      47

$ git branch --list
* main
  wip/atlas_tablero_v3
```

Los 47 commits sin pushear coincidieron con lo declarado en el encargo. El
árbol limpio, no. Lo pendiente era el texto del elemento 7 de la sección
Formación (+116/−4 líneas, v5 → v6 del documento de contenido), trabajo
editorial ajeno a este encargo. No se tocó por cuenta propia.

El titular lo identificó como suyo y aprobado, y autorizó commitearlo en un
commit propio antes de reanudar. Hecho eso, el árbol quedó limpio y la
ejecución retomó **desde la Fase 2**: el titular dio la Fase 1 por válida con
la evidencia que el turno anterior ya había producido.

---

## 2. Fase 1 — Clasificación completa

Ejecutada en el turno de la detención, en modo solo lectura. Se reproduce
completa porque el encargo la exige en el log.

### 2.1 El patrón del encargo está inflado

El encargo pide `git grep -n "atlas\.js\|atlas\.css"`. Ese patrón devuelve
**125 coincidencias**, pero captura como subcadena `00_validar_atlas.js`, que
es el validador del catálogo y no tiene relación con los archivos a archivar.

Acotado a los dos archivos reales con
`git grep -nE "(^|[^_A-Za-z0-9-])atlas\.(js|css)"`, el total baja a **84
coincidencias**.

### 2.2 Las 84 coincidencias, clasificadas

**Referencias vivas: 0.** **Menciones en documentación: 84.**

| Archivo | Coincidencias | Grupo |
|---|---:|---|
| `50_documentacion/andamios/logs/20260802_normalizacion_y_renombre_log.md` | 21 | documentación |
| `50_documentacion/traspasos/archivo/traspaso_cierre_v12.md` | 19 | documentación |
| `50_documentacion/traspasos/archivo/traspaso_cierre_v13.md` | 17 | documentación |
| `50_documentacion/traspasos/archivo/traspaso_cierre_v14.md` | 9 | documentación |
| `50_documentacion/traspasos/archivo/traspaso_cierre_v15.md` | 7 | documentación |
| `50_documentacion/activa/backlog_acumulativo.md` | 6 | documentación |
| `50_documentacion/traspasos/traspaso_cierre_v16.md` | 4 | documentación |
| `50_documentacion/activa/ESTADO.md` | 1 | documentación |

Ningún archivo servido aparece en la tabla.

### 2.3 Los tres controles del encargo

1. **`.html` de `docs/`.** Solo hay dos: `formacion.html` e `index.html`. La
   única mención de «atlas» en ambos es `docs/formacion.html:204`, el
   `<script src="atlas_datos.js"></script>` — el consumidor legítimo, protegido
   por el invariante. `index.html` no menciona atlas en ninguna forma.
2. **Referencias dentro de `docs/`.** Una sola coincidencia:
   `docs/atlas_datos.js:3`, un comentario que documenta cómo validar el archivo
   con `node 00_validar_atlas.js`. No es una carga.
3. **Identificadores globales de `atlas.js`.** Cero. El archivo está envuelto
   de principio a fin en una IIFE con `"use strict"` y su propia cabecera lo
   declara: *«Todo vive dentro de una IIFE: este archivo no agrega ninguna
   constante al ámbito global»*. No puede existir consumidor por identificador
   porque no expone ninguno.

**Conclusión:** el código estaba efectivamente muerto. Cero filas canceladas.

---

## 3. Fase 2 — Archivado

### 3.1 Estado de `_archivo/` frente a git, y su consecuencia

```
$ git check-ignore -v _archivo/
.gitignore:5:_archivo/	_archivo/

$ git ls-files _archivo/
(vacío)
```

**`_archivo/` está ignorado.** Se aplicó la **rama (b)** del encargo, y se
declara con las palabras que el encargo exige: *el movimiento equivale, ante
git, a un borrado de `docs/` más dos archivos no versionados*. El historial
conserva el contenido y `wip/atlas_tablero_v3` conserva el tablero.

Consecuencias operativas:

- El movimiento se hizo con `mv`, **no** con `git mv`: el destino no está
  versionado y `git mv` no aplica.
- El commit 1 contiene **solo las dos supresiones en `docs/`**. Ni los archivos
  en su destino ni el `README.md` de la carpeta de archivo entraron al commit,
  por estar bajo `.gitignore:5`, verificado con `check-ignore` sobre el propio
  README.
- El mensaje del commit sigue siendo correcto, como anticipaba el encargo.

### 3.2 Qué se movió

`docs/atlas.js` (594 líneas, 22 522 bytes) y `docs/atlas.css` (478 líneas,
12 340 bytes) → `_archivo/20260805_atlas_muerto/`.

Se dejó en esa carpeta un `README.md` con qué eran los dos archivos, el commit
en que dejaron de tener consumidor (`5e58276`) y dónde vive la otra copia del
tablero (`wip/atlas_tablero_v3`).

`docs/atlas_datos.js` **no se tocó**, conforme al invariante.

### 3.3 Las dos reglas huérfanas

Grep previo, como exige el encargo:

```
$ git grep -n "fm-atlas-espera\|fm-atlas-foot" -- 'docs/*.html' 'docs/*.js'
(vacío)
```

Solo aparecían en `docs/formacion.css:200` y `:208`, y en los traspasos v12 y
v13 como deuda registrada. **Se retiraron**, junto con el comentario de bloque
«atlas en espera» que las encabezaba y que no describe ninguna otra regla: 16
líneas eliminadas, cero insertadas. El balance de llaves del archivo quedó en
110 / 110.

### 3.4 Verificación en navegador, no pedida por el encargo

Como el commit 1 retira dos archivos de una página publicada y el commit 2
edita su CSS, se sirvió el sitio en local y se cargó
`http://localhost:8000/docs/formacion.html`:

- **Red:** 11 peticiones, **todas 200**. Ninguna a `atlas.js` ni a `atlas.css`.
  `atlas_datos.js` responde 200.
- **Consola:** cero errores.
- **DOM:** 0 nodos con `id` o `class` que contengan «atlas»; la tabla trae sus
  **50 filas**; `ATLAS_INSTITUCIONES` tiene 9 entradas y `ATLAS_DESAFIOS`, 6.
- **Hojas de estilo cargadas:** `styles.css` y `formacion.css`.

Archivar no rompió nada de lo publicado.

---

## 4. Fase 3 — Diagnóstico de ordenación

Emitido en `50_documentacion/activa/50_diagnostico_ordenacion_repositorio.md`,
321 líneas. **Ningún movimiento ejecutado.**

Resultado: **4 incumplimientos** y **4 casos dudosos**, más 9 movimientos
propuestos ordenados por riesgo, de los cuales 7 quedan marcados como
«requiere decisión del titular».

Incumplimientos: el encargo de diseño del portafolio sin prefijo `50_` en
`activa/`; las exclusiones `packrat/` y `venv/` ausentes en
`00_escanear_proyecto.R`; la carpeta `handoff/` de la raíz, que duplica el rol
de `50_documentacion/handoffs/`; y el sufijo `_v2` de un insumo, cuya excepción
existe de hecho pero no está declarada.

Dudosos: si `20_insumos/` y `40_salidas/` deben llevar prefijo de decena; si
`solicitudes_al_titular.md` es salida regenerable o documento vivo; el estatuto
de `50_documentacion/handoffs/`, que la política no reconoce; y la ausencia de
`activa/decisiones/`.

---

## 5. Hallazgos no previstos por el encargo

### 5.1 La §4.7 no está donde el encargo dice

El encargo sitúa la regla de ordenación en la «§4.7 de `POLITICA_PROYECTO.md`».
Esa sección **no existe**: la §4 de la política es el orquestador
`00_run_all.R` y no tiene subsecciones; el grep de «4.7» sobre el documento
devuelve 0 coincidencias. La §4.7 «Ordenación del repositorio» vive en
`SETTINGS_Y_PROMPTS_OPERACIONALES.md`, línea 1389. Sección correcta, documento
equivocado. El diagnóstico se hizo contra la sección real.

### 5.2 El nombre pedido para el diagnóstico está reservado — el hallazgo con consecuencia

El encargo pide emitir el diagnóstico como
`50_documentacion/activa/50_ordenacion_repositorio.md`. Ese nombre está
reservado por §4.7.3 punto 7 para el **marcador** que crea el último commit de
una ordenación **ya ejecutada**, y cuya sola existencia **apaga el gatillo** de
§1.2.2 punto 4bis, el que hace que la ordenación se vuelva a proponer en cada
apertura del proyecto.

Emitir un diagnóstico con ese nombre habría marcado el proyecto como ordenado
sin haber movido un solo archivo, y habría silenciado la propuesta en las
aperturas siguientes. El documento se emitió como
`50_diagnostico_ordenacion_repositorio.md`. El gatillo sigue encendido, que es
lo correcto.

### 5.3 Contradicción interna entre el invariante §2 y la Fase 2.3

El invariante §2 declara que `docs/formacion.css` **no se edita**. La Fase 2.3
ordena editarlo para retirar las dos reglas huérfanas, y la lista de commits le
destina un commit propio.

Se resolvió a favor de la instrucción específica: el encargo dedica un commit a
esa edición, de modo que la intención es inequívoca, y las dos reglas no tienen
marcado, por lo que retirarlas no puede alterar lo que el titular verificó en
navegador. La verificación de §3.4 lo confirma. Se declara por si el titular
prefiere revertir el commit 2.

### 5.4 Las versiones de gobernanza citadas no son las locales

El encargo declara heredar `POLITICA_PROYECTO.md` v5.6 y
`SETTINGS_Y_PROMPTS_OPERACIONALES.md` v16. Las copias locales en
`50_documentacion/activa/` son **v5.5** y **v15**. No bloquea nada: el bloque 1
de §4.7 exige v5.5 y v14 como mínimo y ambas lo cumplen. Pero si en la
knowledge base existen v5.6 y v16, el diagnóstico se hizo contra la versión
anterior.

### 5.5 Corrección de premisa registrada en el encargo

El encargo afirma que las dos reglas huérfanas «quedaron sin marcado al retirar
la sección Atlas», es decir, en el commit `5e58276` de esta sesión. **Falso:**
ya estaban huérfanas desde la sesión 12. `traspaso_cierre_v12.md:72` y `:400`
las registran como deuda cosmética sin efecto, y `traspaso_cierre_v13.md:61` y
`:219` las arrastran como deuda heredada. El origen es el reemplazo del
marcador «en desarrollo», no el commit de esta sesión.

Por instrucción del titular, la corrección se anotó **en el propio encargo**,
como bloque de cita visible junto a la instrucción afectada, y **no** se
reescribió el traspaso: la memoria sellada no se toca. La instrucción no
cambió; cambió desde cuándo existe la deuda.

### 5.6 El escáner excluye `handoffs` por nombre

`00_escanear_proyecto.R` línea 46 excluye del barrido `handoff` **y**
`handoffs`, de modo que `50_documentacion/handoffs/` es invisible para el
inventario. Se anota porque es relevante para el movimiento 3 del diagnóstico:
si `handoff/` se archiva, esa exclusión queda muerta.

---

## 6. Auto-auditoría

1. **Toda cifra proviene de un comando de este turno.** Las 84 coincidencias,
   las 50 filas de la tabla, los 20 archivos de `handoff/`, las 321 líneas del
   diagnóstico, los 47 commits de la Fase 0: todas verificadas.
2. **Ninguna afirmación de estado sin su salida de git.** Reproducidas arriba.
3. **Ignorado, versionado o servido se verificó siempre por comando:**
   `check-ignore` para `_archivo/`, para el README de destino, para el encargo
   y para este log; `ls-files` para `_archivo/`; `grep` para lo servido.
4. **Ningún archivo fue borrado.** La única supresión del turno:

```
$ git log --diff-filter=D --name-status --oneline 53282d5..HEAD
f0f5f00 archiva el codigo muerto del atlas fuera del sitio publicado
D	docs/atlas.css
D	docs/atlas.js
```

Y el contenido sobrevive intacto, comparando el objeto en disco contra el
objeto en el commit anterior al movimiento:

```
atlas.js   disco=41eed969…  en_git=41eed969…  IDENTICO
atlas.css  disco=abe63b5b…  en_git=abe63b5b…  IDENTICO
```

Las dos «supresiones» del commit 1 son exactamente lo que la rama (b)
anticipaba: la vista que git tiene de un movimiento hacia una carpeta ignorada.

---

## 7. Hashes

| # | Hash | Mensaje |
|---|---|---|
| 0 | `62b8969` | redacta el elemento 7 de la seccion formacion |
| 1 | `f0f5f00` | archiva el codigo muerto del atlas fuera del sitio publicado |
| 2 | `37d44ad` | retira las reglas huerfanas de la seccion del atlas |
| 3 | `91993d8` | emite el diagnostico de ordenacion del repositorio |

El commit 0 no pertenece al encargo: es el trabajo pendiente que provocó la
detención de la Fase 0, commiteado aparte por instrucción del titular para
dejar el árbol limpio. El commit de este log cierra la serie.

---

## 8. Estado al cierre

- `docs/` ya no publica `atlas.js` ni `atlas.css`. `atlas_datos.js` sigue
  sirviéndose y alimentando la tabla, verificado en navegador.
- `_archivo/20260805_atlas_muerto/` conserva los dos archivos y su README,
  fuera de git por diseño.
- `docs/formacion.css` quedó sin las dos reglas huérfanas heredadas de la
  sesión 12.
- El diagnóstico de ordenación está emitido y **no se ejecutó ninguno de sus
  nueve movimientos**. Siete requieren decisión del titular.
- El gatillo de §1.2.2 punto 4bis **sigue encendido**: el marcador
  `50_ordenacion_repositorio.md` no se creó.
- Ningún `push`. Ningún `--force`. Ningún `reset`. Ningún tag. Ningún
  `git add -A`. La rama `wip/atlas_tablero_v3` no se tocó.
