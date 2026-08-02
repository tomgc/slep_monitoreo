# Log de cierre — sesión 15: normalización de `docs/atlas.*` y renombre `ambito` → `desafio`

> **Encargo:** `50_documentacion/andamios/20260802_encargo_sesion15.md`
> **Proyecto:** `slep_monitoreo` · **Fecha de ejecución:** 2026-08-02
> **Ejecutor:** Claude Code, modo autónomo.

---

## 1. Resumen ejecutivo

La fase A determinó que **`main` nunca contuvo el tablero experimental**: el
escenario real es E2 en su variante de "no corresponde revertir". El tablero
vive solo en `wip/atlas_tablero_v3` (commit `6894986`) y `main` conserva el
atlas legítimo introducido por `8e823c7` el 2026-07-31. No se revirtió nada.

La fase B completó el renombre `ambito` → `desafio` en los cuatro artefactos
(contrato, catálogo, validador y consumidores), con el validador en `exit=0` y
cero residuo de `ambito` en `.js`. Ningún valor de dato del catálogo ni ningún
texto visible al usuario final cambió.

La fase C verificó ambas páginas en navegador sin errores de consola. El cuarto
commit (este log) **quedó pendiente**: `50_documentacion/andamios/**` está
excluido por `.gitignore:19`. Ver sección 7.

---

## 2. Fase A — Diagnóstico y normalización

### 2.1 Paso A0, salida íntegra

```
=== branch ===
main
=== log -8 ===
112ffb7 docs: backlog sesion 14 (entradas 99-106) y estado del proyecto
d79852b docs: fundamento de la seccion Formacion (proposito, linea editorial, orden de elementos)
411f7cb Registra las entradas 89-94 y actualiza ESTADO.md
72bd488 Antepone el atlas a la tabla en la pagina de formacion
2863033 Retira UNESCO y OECD del catalogo por alcance nacional
8e823c7 Agrega el render del atlas a la pagina de formacion
0e7b809 Deja el brief del reconocimiento junto a su insumo, con un README que lo explica
21aebf5 Actualiza ESTADO.md al cierre de la sesion 11
=== log -6 atlas.js atlas.css ===
8e823c7 Agrega el render del atlas a la pagina de formacion
=== branch --contains 6894986 ===
  wip/atlas_tablero_v3
=== ls -l ===
-rw-r--r--@ 1 tomgc  staff  12334 Aug  1 10:17 docs/atlas.css
-rw-r--r--@ 1 tomgc  staff  22491 Aug  1 10:17 docs/atlas.js
=== status --short ===
 M 50_documentacion/estructura/estructura_actual.md
 M 50_documentacion/estructura/estructura_actual.txt
 M 50_documentacion/estructura/estructura_anterior.md
 M 50_documentacion/estructura/estructura_anterior.txt
```

### 2.2 Evidencia adicional recogida (tamaños de blob por commit)

```
=== tamano en main HEAD ===   22491  12334
=== tamano en 8e823c7 ===     22491  12334
=== tamano en 6894986 (wip)=  18728  10794
=== tamano en 6894986~1 ===   22491  12334
=== 6894986~1 es? ===         411f7cb Registra las entradas 89-94 y actualiza ESTADO.md
=== diff arbol vs main HEAD (docs) ===  (vacio = identico)
=== diff main HEAD vs 6894986 (docs) ===
 docs/atlas.css | 638 +++++-----
 docs/atlas.js  | 889 +++++++------
 2 files changed, 681 insertions(+), 846 deletions(-)
```

```
=== fecha de 8e823c7 ===  2026-07-31 14:09:14 -0400  Agrega el render del atlas a la pagina de formacion
=== fecha de 6894986 ===  2026-08-01 10:17:04 -0400  wip: tablero del atlas sin revision visual, punto de guardado
=== 'tablero' en la version de main ===  0 coincidencias
=== 'tablero' en la version de wip  ===  4 coincidencias
```

Encabezado de la versión de `main` (`8e823c7`):

```
   Atlas de los datos educativos
   Área de Monitoreo · SLEP Costa Central
   Consume las tres constantes globales de atlas_datos.js
```

Encabezado de la versión de `wip` (`6894986`):

```
   Atlas de los datos educativos — tablero de dos mitades
   Área de Monitoreo · SLEP Costa Central
   Dos caras enfrentadas sobre el mismo catálogo:
```

### 2.3 Escenario determinado

**E2, en su variante de "`main` nunca tuvo el tablero"** (último párrafo del
paso A2 del encargo). Evidencia, toda de historial y contenido, no de tamaños:

1. `git branch --contains 6894986` devuelve **solo** `wip/atlas_tablero_v3`. El
   commit del tablero no está en el historial de `main`, lo que descarta E1.
2. `docs/atlas.js` y `docs/atlas.css` fueron tocados en `main` por **un solo
   commit**, `8e823c7` (2026-07-31), anterior al tablero.
3. La versión de `main` no contiene la palabra «tablero» ni una sola vez; la de
   `wip` la contiene cuatro veces y se declara «tablero de dos mitades» en su
   encabezado.
4. El árbol de trabajo en `main` es idéntico a `main` HEAD (`git diff` vacío en
   `docs/`).

**Premisa del encargo corregida.** La sección 2 del encargo supone que el
tablero está en `main` y cita «18,3 KB y 10,5 KB» como el estado *anterior* al
tablero. Es al revés: 18 728 B y 10 794 B (= 18,3 KB y 10,5 KB exactos) son los
tamaños **del tablero mismo**, hoy en `6894986`. Los tamaños de `main`
(22 491 B y 12 334 B) son los del atlas original de `8e823c7`. El escáner del
2026-08-01 09:57 midió el árbol de trabajo sucio, no lo committeado en `main`,
y de ahí nace la confusión. Esto explica también por qué
`git checkout 6894986~1 -- docs/atlas.js docs/atlas.css` no produjo cambios:
`6894986~1` es `411f7cb`, cuyos blobs son idénticos a los de `main` HEAD.

### 2.4 Decisión y justificación

**No se revirtió nada.** La meta aprobada del paso A2 es que `main` no cargue el
tablero experimental, y `main` ya cumple esa meta sin intervención. Revertir
habría reemplazado el atlas legítimo por otra cosa. El encargo prevé
explícitamente este desenlace y ordena declararlo y pasar a la fase B.

Verificación de cierre de fase A: `node --check` en `exit=0` sobre los tres JS
de la versión de `main`, y `git status --short docs/` vacío.

---

## 3. Fase B — Renombre `ambito` → `desafio`

### 3.1 Clasificación de ocurrencias

| Grupo | Ocurrencia | Archivo | Resolución |
|---|---|---|---|
| Renombrable | `ATLAS_AMBITOS` (declaración) | `docs/atlas_datos.js:1159` | → `ATLAS_DESAFIOS` |
| Renombrable | clave `"ambito"` de `ATLAS_FRASES` | `docs/atlas_datos.js:1239` | → `"desafio"` |
| Renombrable | `ATLAS_AMBITOS`, `DATOS_AMBITO_MIN/MAX`, `AMB`, `"ambitos"`, `"ambito["`, clave esperada `ambito` | `00_validar_atlas.js` (32, 74, 86, 190, 193, 201-202, 210) | → `DESAFIOS` / `DATOS_DESAFIO_*` / `DES` / `desafio` |
| Renombrable | `ATLAS_AMBITOS`, `AMB`, `st.ambito`, nivel `"ambito"`, `data-ambito`, `.atlas-ambitos`, `atBtnAmb`/`elBtnAmb`, `vistaAmbito()`, `preview(ambitoId)`, clave `ambito` de `PIE`, `.atlas-cabecera-amb` | `docs/atlas.js` (26 líneas) | → equivalentes con `desafio`/`DES` |
| Renombrable | `.atlas-ambitos`, `.atlas-cabecera-amb` | `docs/atlas.css` (72, 73, 83, 84, 281, 290, 298) | → `.atlas-desafios`, `.atlas-cabecera-des` |
| Renombrable | `ATLAS_AMBITOS`, `AMBITOS`, `selAmb`, `amb`, `rutasAmbito`, `elAmbito`, `#fmAmbito` | `docs/formacion.js` (56, 78-83, 141-158, 168, 175) | → equivalentes con `desafio`/`DES` |
| Renombrable | `for="fmAmbito"` / `id="fmAmbito"` | `docs/formacion.html:119-120` | → `fmDesafio`. Única razón para tocar el HTML: sin esto se rompe el selector `#fmDesafio` de `formacion.js` (invariante 🔒 lo autoriza para exactamente este caso) |
| Renombrable | `ATLAS_AMBITOS`, §2.4, clave `ambito`, prosa del esquema | `50_contrato_atlas_datos.md` (7, 29, 47, 99, 103, 108, 114, 267, 285, 298) | → `ATLAS_DESAFIOS`, «Desafío educativo», `desafio`, «desafíos» |
| Intocable | «no agrega ninguna constante al **ámbito** global» | `docs/atlas.js:9` | Es *scope* de JavaScript, no el agrupador |
| Intocable | «conviven en el **ámbito** global con `PROYECTOS`…» | `50_contrato_atlas_datos.md:39` | Ídem, *scope* de JavaScript |
| Intocable | «la unicidad de `base` y `dato` es por **ámbito** y no global» | `50_contrato_atlas_datos.md:130` | Es *alcance de unicidad* dentro del padre, no el agrupador |
| Intocable | «Cada minuta aborda un **ámbito** distinto de la entrega de la Agencia» | `docs/data.js:62` | Prosa editorial del portafolio, otro sentido |
| Intocable | «organiza las evaluaciones … por **ámbito**, núcleo y objetivo de aprendizaje» | `docs/data.js:133` | Ámbitos de las Bases Curriculares de Parvularia |
| Texto visible | «Ámbitos de indagación» (botón del atlas) | `docs/atlas.js:93` | Sin tocar (🔒) |
| Texto visible | «Ámbito» (miga de pan) | `docs/atlas.js:272` | Sin tocar (🔒) |
| Texto visible | «Ámbito de indagación · » (eyebrow) | `docs/atlas.js:461` | Sin tocar (🔒) |
| Texto visible | «Datos de este ámbito» (`<h4>`) | `docs/atlas.js:473` | Sin tocar (🔒) |
| Texto visible | «Los ámbitos de indagación conectan datos…» (nota) | `docs/formacion.html:88` | Sin tocar (🔒) |
| Texto visible | «Ámbito de indagación» (etiqueta del filtro) | `docs/formacion.html:119` | Sin tocar (🔒). Solo cambió el `for` del `<label>`, no su texto |

**Nota sobre los ámbitos de actuación del Área.** El encargo pide nombrarlos si
aparecen. **No aparece ninguno** en los archivos inventariados: ni `docs/`, ni
el validador, ni el contrato mencionan los tres mandatos del Área. Las únicas
ocurrencias «intocables» son de otros sentidos de la palabra (scope de JS,
alcance de unicidad, ámbitos curriculares de Parvularia, prosa del portafolio).

**Mensajes del validador.** Las tres ocurrencias acentuadas de
`00_validar_atlas.js` (comentario de sección, aviso «un ámbito gana valor
cruzando emisores», resumen «| ámbitos: ») **sí** se renombraron, por
instrucción explícita del paso B1.3 («mensajes de error»). No violan el
invariante de texto visible: el validador es una herramienta de línea de
comandos del titular, no la interfaz del sitio.

### 3.2 Archivos modificados

| Archivo | Líneas cambiadas |
|---|---|
| `50_documentacion/activa/50_contrato_atlas_datos.md` | 10 |
| `00_validar_atlas.js` | 14 |
| `docs/atlas_datos.js` | 2 |
| `docs/atlas.js` | 34 |
| `docs/atlas.css` | 9 |
| `docs/formacion.js` | 13 |
| `docs/formacion.html` | 2 |

### 3.3 Método del renombre

Mapa de tokens explícito, ordenado de más específico a más genérico, con
límites de palabra (`\b`) en las abreviaturas cortas. Motivo: `cambiar`
contiene la subcadena `amb` (`docs/atlas.js:582`), de modo que un reemplazo
ciego la habría destruido. Verificado después: `cambiar` intacto y es el único
token con `amb` que sobrevive en los seis archivos de código.

El reemplazo se aplicó sin capa de codificación, a nivel de bytes ASCII, para
no alterar los bytes UTF-8 del texto acentuado.

### 3.4 Salida del validador (paso B2)

```
check_datos=0
check_atlas=0
check_formacion=0
=== validador ===
Catálogo: /Users/tomgc/Projects/slep_monitoreo/docs/atlas_datos.js
Instituciones: 9 | bases: 25 | datos: 50 | desafíos: 6 | relaciones: 124

AVISOS (5) — no bloquean
  ! institucion[mineduc].base[datos-abiertos].dato[rendimiento]: desde (2002) es anterior al de su base (2004); confirmar que la base publica serie histórica previa
  ! institucion[mineduc].base[datos-abiertos].dato[docentes]: desde (2003) es anterior al de su base (2004); confirmar que la base publica serie histórica previa
  ! institucion[mineduc].base[datos-abiertos].dato[establecimientos]: desde (1992) es anterior al de su base (2004); confirmar que la base publica serie histórica previa
  ! institucion[mineduc].base[gestion].dato[sned]: desde (1996) es anterior al de su base (2008); confirmar que la base publica serie histórica previa
  ! color: #FFC92E es además el color de interacción del atlas; conviene no usarlo en instituciones nuevas

RESULTADO: válido. El archivo puede depositarse en docs/atlas_datos.js.
exit=0
```

Conteos idénticos a los de antes del renombre (9 / 25 / 50 / 6 / 124) y los
mismos cinco avisos: prueba de que ningún valor de dato cambió.

Grep final de residuo:

```
=== residuo ambito en *.js ===
grep_exit=1 (1 = sin coincidencias)
```

### 3.5 Hashes de los tres commits

| # | Hash | Mensaje |
|---|---|---|
| 1 | `4980b2c` | actualiza el contrato del atlas: ambito de indagacion pasa a desafio educativo |
| 2 | `5b1de70` | renombra ATLAS_AMBITOS a ATLAS_DESAFIOS en el catalogo y el validador |
| 3 | `9ae92ab` | actualiza los consumidores del atlas al identificador desafio |

---

## 4. Fase C — Verificación funcional

Servidor estático local sobre `docs/`, ambas páginas cargadas por HTTP. (El
protocolo `file://` no sirve: el panel lo renderiza como instantánea estática
y no ejecuta JavaScript, de modo que no prueba nada.)

### 4.1 `formacion.html`

- **Consola: sin mensajes.** Ni errores ni advertencias.
- Estado tras la carga: `typeof ATLAS_DESAFIOS === "object"` con 6 entradas;
  `typeof ATLAS_AMBITOS === "undefined"` (no queda residuo global);
  claves de `ATLAS_FRASES` = `universo, institucion, base, dato, desafio`.
- Tabla: 50 filas, resumen «50 fuentes de 9 instituciones».
- Selector `#fmDesafio` presente, con 7 opciones (Todos + los 6 desafíos).
- **Filtro por desafío:** al elegir «Asistencia y permanencia» el resumen pasa a
  «5 de 50 fuentes» y aparece la pregunta «¿Por qué disminuye la asistencia
  escolar?». Funciona.
- Atlas: renderiza las 9 instituciones. El botón «Ámbitos de indagación»
  (`#atBtnDes`) abre el menú con los 6 desafíos y sus preguntas.
- **Vista de desafío:** al elegir «Asistencia y permanencia» el atlas cambia de
  nivel, la miga muestra «Instituciones › Asistencia y permanencia», aparece la
  cabecera `.atlas-cabecera-des` con el rótulo visible «Ámbito de indagación ·
  Asistencia y permanencia», la pregunta, y la constelación de los 5 datos
  conectados. El pie muestra «Haz clic en un dato para ver su ficha · Esc para
  volver», lo que confirma que `PIE["desafio"]` resuelve: es la prueba directa
  de que la clave renombrada se consume bien de punta a punta.
- `.atlas-cabecera-amb` ya no existe en el DOM; `.atlas-cabecera-des` sí.

### 4.2 `index.html`

- Carga correctamente, **sin mensajes de consola**. El portafolio no se vio
  afectado, como se esperaba: no consume el catálogo del atlas.

### 4.3 Correcciones

Ninguna. No hizo falta enmendar el commit 3.

---

## 5. Auto-auditoría adversarial

| # | Pregunta | Respuesta y evidencia |
|---|---|---|
| 1 | ¿El escenario de la fase A quedó determinado con historial, no con tamaños? | **Sí.** `git branch --contains 6894986` → solo `wip/atlas_tablero_v3`; `git log -- docs/atlas.js docs/atlas.css` → un único commit, `8e823c7`. Los tamaños se usaron solo como confirmación posterior, y de hecho el criterio de tamaño del encargo estaba invertido (§2.3) |
| 2 | ¿El tablero sigue alcanzable desde `wip/atlas_tablero_v3`? | **Sí.** `git branch --contains 6894986` → `wip/atlas_tablero_v3`; `git branch -v` → `wip/atlas_tablero_v3 6894986`. La rama no se tocó en absoluto |
| 3 | ¿`main` quedó sin el tablero, o se justificó por qué no correspondía revertir? | **Justificado: nunca lo tuvo.** `git log -- docs/atlas.*` da un solo commit (`8e823c7`, 2026-07-31, anterior al tablero); esa versión no contiene la palabra «tablero». `ls -l` tras el trabajo: 22 522 B y 12 340 B (los 31 y 6 bytes de más frente a `8e823c7` son el renombre de la fase B) |
| 4 | ¿El validador terminó en `exit=0`? | **Sí.** «RESULTADO: válido… exit=0», con los mismos conteos y avisos que antes del renombre |
| 5 | ¿Queda alguna ocurrencia de `ambito` en `.js`? | **No.** El grep del paso B2 devuelve vacío (`grep_exit=1`). Las acentuadas que quedan son las seis de texto visible y las dos de *scope* de JS, todas clasificadas en §3.1 |
| 6 | ¿Se modificó algún texto visible al usuario? | **No.** Diff revisado línea a línea: los cuatro literales de `atlas.js` (93, 272, 461, 473) y los dos de `formacion.html` (88, 119) quedaron verbatim. En `formacion.html` solo cambiaron los valores de `for` e `id`, nunca el contenido del `<label>` |
| 7 | ¿Se modificó algún valor de dato del catálogo? | **No.** `git show --stat 5b1de70` → `docs/atlas_datos.js \| 4 ++--`, es decir dos líneas: la declaración `const` y la clave de `ATLAS_FRASES`. Ningún `id`, nombre, pregunta ni lista `datos` cambió. Los conteos del validador lo confirman |
| 8 | ¿Se commiteó algún archivo de `50_documentacion/estructura/` o de gobernanza? | **No.** `git show --stat` de los tres commits lista exactamente 7 archivos: el contrato, el validador, y los cinco de `docs/`. Los cuatro de `estructura/` siguen modificados y sin commitear en `git status --short` |
| 9 | ¿Hubo algún `push`, `--force`, `reset --hard` o tag? | **No.** `main` quedó 25 commits por delante de `origin/main` (20 al inicio del encargo + 2 de documentación de la sesión previa + 3 de este encargo). El único tag del repo, `v2.1`, es del 2026-05-27 y es preexistente |
| 10 | ¿La sección Formación funciona en el navegador? | **Sí.** Sin errores de consola; tabla de 50 filas; filtro por desafío que reduce a 5 y muestra la pregunta; menú del atlas con los 6 desafíos; vista de desafío con miga, cabecera, pregunta y constelación. Detalle en §4 |

---

## 6. Decisiones autónomas tomadas

1. **No revertir `docs/atlas.*` en `main`.** El historial mostró que `main`
   nunca tuvo el tablero; revertir habría reemplazado el atlas legítimo. El
   encargo prevé este desenlace en el último párrafo del paso A2.
2. **Renombrar también las abreviaturas derivadas** (`AMB`→`DES`,
   `amb`→`des`, `selAmb`→`selDes`, `atBtnAmb`/`elBtnAmb`→`atBtnDes`/`elBtnDes`,
   `.atlas-cabecera-amb`→`.atlas-cabecera-des`). Motivo: el paso B0 incluye
   «variables locales» entre lo renombrable, y dejarlas habría producido un
   renombre a medias, más confuso que el nombre viejo.
3. **Tocar `docs/formacion.html`** para cambiar `for="fmAmbito"`/`id="fmAmbito"`
   a `fmDesafio`. Motivo: el invariante 🔒 autoriza tocarlo cuando un literal de
   identificador rompería tras el renombre, y este es exactamente ese caso. El
   texto del `<label>` no se tocó.
4. **Renombrar comentarios internos** de sección en `atlas.js`, `atlas.css` y
   el validador (por ejemplo «Menú de ámbitos» → «Menú de desafíos»). Son
   comentarios, no texto visible, y dejarlos habría contradicho el código que
   describen.
5. **No tocar `docs/formacion.css`.** Su única ocurrencia (línea 75) es un
   comentario y el archivo no define ningún selector con `ambito`; el encargo
   limita las hojas de estilo a las que sí lo definen. Queda como deuda menor.
6. **Renombre por mapa de tokens explícito** en vez de reemplazo global, para
   no destruir `cambiar` (`docs/atlas.js:582`).
7. **Servir el sitio por HTTP** en vez de `file://` para la fase C, porque el
   panel de vista previa renderiza `file://` como instantánea estática sin
   ejecutar JavaScript. Se usó un servidor estático temporal, ya detenido.

---

## 7. Hallazgos y deuda nueva

1. **La premisa central de la sección 2 del encargo estaba invertida** y quedó
   corregida en §2.3: el tablero nunca estuvo en `main`, y los tamaños citados
   como «estado anterior al tablero» son los del tablero. El origen del error
   es que el escáner del 2026-08-01 09:57 midió el árbol de trabajo sucio y no
   lo committeado. **Implicación operativa:** los tamaños del escáner no son
   evidencia del estado de `main`; para eso sirve `git cat-file -s`.

2. **El cuarto commit del encargo no se pudo ejecutar.** Este log vive en
   `50_documentacion/andamios/logs/`, y `.gitignore:19` excluye
   `50_documentacion/andamios/**`. Commitearlo exigiría `git add -f`, es decir
   pasar por encima de una exclusión deliberada, decisión que no es mecánica.
   Es el mismo patrón que ya bloqueó el traspaso de cierre v14 en
   `50_documentacion/traspasos/**` (`.gitignore:14`). Queda a decisión del
   titular: (a) dejar los andamios solo en local, (b) forzar el commit de este
   archivo puntual, (c) revisar la política de exclusión de `andamios/` y
   `traspasos/`. El propio archivo del encargo tampoco está versionado, lo que
   sugiere que la exclusión es intencional.

3. **P7 sigue abierta:** el destino de `wip/atlas_tablero_v3` no se decidió.
   La rama quedó intacta en `6894986`. Ahora se sabe con certeza que es la
   *única* copia del tablero: no existe en ningún otro punto del historial.

4. **`docs/formacion.css:75`** conserva el comentario «resumen y pregunta del
   ámbito». Deuda cosmética, deliberadamente fuera de alcance (decisión 5).

5. **Etiquetas visibles pendientes.** La interfaz sigue diciendo «Ámbito(s) de
   indagación» en seis lugares, por invariante. Su redacción contra el
   fundamento es la tarea siguiente, ahora sin obstáculo técnico: los
   identificadores ya están alineados.

6. **Posible recorte del menú del atlas.** En viewport de 800 px el desplegable
   de desafíos se extiende más allá del borde derecho del contenedor y las
   preguntas se ven cortadas. Es preexistente (el renombre no altera geometría)
   y no se corrigió por estar fuera de alcance.

7. **Los cuatro archivos de `50_documentacion/estructura/`** siguen modificados
   y sin commitear, como manda la regla canónica. Son ruido permanente en
   `git status`.

---

## 8. Estado final del repositorio

```
=== git log --oneline -8 ===
9ae92ab actualiza los consumidores del atlas al identificador desafio
5b1de70 renombra ATLAS_AMBITOS a ATLAS_DESAFIOS en el catalogo y el validador
4980b2c actualiza el contrato del atlas: ambito de indagacion pasa a desafio educativo
112ffb7 docs: backlog sesion 14 (entradas 99-106) y estado del proyecto
d79852b docs: fundamento de la seccion Formacion (proposito, linea editorial, orden de elementos)
411f7cb Registra las entradas 89-94 y actualiza ESTADO.md
72bd488 Antepone el atlas a la tabla en la pagina de formacion
2863033 Retira UNESCO y OECD del catalogo por alcance nacional

=== git status --short ===
 M 50_documentacion/estructura/estructura_actual.md
 M 50_documentacion/estructura/estructura_actual.txt
 M 50_documentacion/estructura/estructura_anterior.md
 M 50_documentacion/estructura/estructura_anterior.txt

=== git branch -v ===
* main                 9ae92ab [ahead 25] actualiza los consumidores del atlas al identificador desafio
  wip/atlas_tablero_v3 6894986 wip: tablero del atlas sin revision visual, punto de guardado
```

Estado capturado antes del cuarto commit, que quedó pendiente por lo indicado
en el hallazgo 2. Sin push, sin `--force`, sin `reset --hard`, sin tags nuevos.
