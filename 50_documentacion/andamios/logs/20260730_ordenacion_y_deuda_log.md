# Log — Tramo 1 del encargo de sesión 11

> **Encargo:** `50_documentacion/andamios/20260730_encargo_sesion11.md`
> **Ejecutado:** 2026-07-30, Claude Code (Opus 5), modo autónomo.
> **Alcance ejecutado:** Tramo 1 completo (Fases 1.0 a 1.5). Tramo 2 **no
> ejecutado**: su gate de titular sobre la tabla de movimientos de la Fase 2.2
> no fue aprobado.
> **Este log no se commitea** (`50_documentacion/andamios/**` está gitignored,
> entrada 72 del backlog).

---

## 1. Resumen

El Tramo 1 se ejecutó completo y sin desviaciones metodológicas. Publicó los
tres commits pendientes en `main`, confirmó que el catálogo del atlas sigue
siendo consumible, y ejecutó los dos diagnósticos de deuda técnica (P5 y P7).

El resultado sustantivo es que **el pendiente P5 se canceló por evidencia**: el
tercer grep de la Fase 1.3 devolvió tres coincidencias vivas de `banner` en el
árbol de `docs/`, de modo que la regla de decisión del encargo canceló la
eliminación por completo. La Fase 1.4 no se ejecutó. El Tramo 1 no produjo
ningún commit propio: publicó y diagnosticó, no modificó archivos.

Lo que costó: nada relevante en tiempo, pero sí una fricción operativa. El
primer intento de la Fase 1.1 encadenaba `git push` con dos verificaciones
mediante `&&` y fue bloqueado por el clasificador de permisos. Se resolvió
ejecutando `git push` aislado, que además es lo que exige la regla global del
titular (`git push` nunca se agrupa). El encargo, al escribir la Fase 1.1 como
un bloque de tres comandos, contradice esa regla; queda anotado como pendiente
de corrección del patrón.

---

## 2. Inventario de commits

**Ninguno.** El Tramo 1 no produjo commits, y eso es el resultado correcto:

| Fase | Commit | Razón |
|---|---|---|
| 1.0 | — | Fase de lectura por diseño. |
| 1.1 | — | Publica commits ya existentes; el encargo declara "sin commit propio". |
| 1.2 | — | Fase de validación; el catálogo es 🔒. |
| 1.3 | — | Fase de diagnóstico. |
| 1.4 | — | **No ejecutada.** Cancelada por la regla de decisión de la Fase 1.3. |
| 1.5 | — | Fase de lectura por diseño ("No edites `docs/data.js` en esta fase"). |

Commits publicados por la Fase 1.1 (preexistentes, no producidos aquí):
`4061e89`, `da6b586`, `1dcbafe`.

---

## 3. Cambios sustantivos, con causa raíz

**Ningún archivo del árbol de trabajo fue modificado.** `git status --short`
está vacío al cierre, igual que al inicio.

El único cambio de estado es remoto: `refs/heads/main` avanzó de `952d89b` a
`1dcbafe`. Causa raíz de que estuviera pendiente: la sesión 10 cerró sin
publicar, por decisión de dejar el push como acto explícito del titular.

---

## 4. Auditoría de diagnóstico

### Fase 1.2 — validador del atlas

`node 00_validar_atlas.js docs/atlas_datos.js` → `exit=0`.
Instituciones 10 · bases 27 · datos 52 · ámbitos 6 · relaciones 130.
5 avisos, el número que el traspaso v10 declaraba en su §3. Cuatro son fechas
`desde` anteriores a las de su base (`rendimiento`, `docentes`,
`establecimientos`, `sned`); el quinto es la colisión de `#FFC92E` con el color
de interacción. Ninguno se corrigió: el catálogo es 🔒 en esta sesión.

### Fase 1.3 — P5, tokens `--banner-*`

Los tres greps se ejecutaron por separado, como exige el encargo.

Grep 1 (`--banner-` en `docs/styles.css`) — 6 líneas: 42, 43, 44, 51, 59, 67.
Grep 2 (`\.banner` en `docs/styles.css`) — 4 líneas: 53, 61, 62, **517**.
Grep 3 (`banner` en el resto de `docs/`) — **3 coincidencias**:

```
docs/index.html:138:      <span class="banner-type" id="lbType">Reporte</span>
docs/app.js:32:     normalizada y ancho natural. Reemplaza los banners de v1. */
docs/data.js:17:         La primera es la portada del banner; el lightbox las muestra todas en un pasador.
```

**Decisión: eliminación cancelada por completo.** La regla del encargo es
categórica —cualquier coincidencia cancela la fila entera, sin eliminación
parcial ni juicio sobre cuál coincidencia "es solo un comentario"— y aquí ni
siquiera hizo falta apoyarse en esa severidad: `docs/index.html:138` usa
`class="banner-type"` en markup vivo, y `docs/styles.css:517`
(`.lb-text .banner-type`) es precisamente la regla que lo estila. Es el
selector del tipo de proyecto dentro del lightbox de reseña, que es 🔒.

Observación para el chat, **no ejecutada aquí**: el conjunto `--banner-*`
(líneas 42-44, 51, 59, 67) y las reglas `body[data-variant] .banner` (53, 61,
62) son un grupo distinto de `.banner-type` (517). Un rediagnóstico con un grep
discriminante —`banner-type` frente a `banner` a secas— probablemente
confirmaría que el primer grupo sí está huérfano. Pero eso es rediseñar la
metodología del encargo, que la regla de detención prohíbe hacer sobre la
marcha. Queda como propuesta para el titular.

### Fase 1.5 — P7, campos del catálogo de Project Cards

`50_documentacion/activa/50_catalogo_project_cards.md`, 266 líneas. Índice:

```
1:# Encargo — Catálogo de Project Cards del Área de Monitoreo
12:## 1. Qué es y qué problema resuelve
33:## 2. Decisión de arquitectura
59:## 3. Taxonomía propuesta (REVISAR: asignaciones del titular)
104:## 4. Campos nuevos en `data.js`
143:## 5. Enum de madurez
162:## 6. Códigos QR
191:## 7. Gobernanza (compuerta, no trámite)
215:## 8. Especificación de impresión
237:## 9. Fases
257:## 10. Lo que este encargo deja fuera
```

La tabla de §4 (líneas 109-122) define **doce** filas, no once. La aparente
discrepancia con el encargo se resuelve sola: la primera fila es `id`, y el
conteo programático confirma que `id` **ya está poblado en los doce
proyectos**. Los campos pendientes de poblar son, por tanto, once. El encargo
tenía razón en la cifra; lo que no dijo es que la tabla trae doce filas porque
incluye una ya cumplida.

Transcripción literal de la tabla:

| Campo | Tipo | Contenido | Tope | Origen |
|---|---|---|---|---|
| `id` | string | slug estable, `"asistencia"` | — | §3 |
| `codigo` | string | `"GES-01"` | — | §3 |
| `categoria` | string | `"Gestión Educativa"` | — | §3 |
| `madurez` | string | enum de §5 | — | titular |
| `frase` | string | frase de impacto de la cara frontal | 25 palabras | redacción nueva |
| `problema` | string | qué necesidad originó el proyecto | 60 palabras | redacción nueva |
| `solucion` | string | la idea principal | 120 palabras | condensado de `sintesis` |
| `pasos` | array[3] | cómo funciona, tres pasos | 1 línea c/u | redacción nueva |
| `valor` | array[3-5] | `{icono, texto}` | 4 palabras c/u | redacción nueva |
| `evidencia` | array | resultados verificables | 1 línea c/u | titular, ver §7 |
| `proximos` | array | qué viene ahora | 1 línea c/u | traspaso y titular |
| `qr` | string | URL destino del QR | — | §6 |

Reglas anexas relevantes: `id` y `codigo` coexisten a propósito (`id` es llave
de URL, `codigo` es referencia impresa oral); `estado` **no** se toca y
`madurez` se agrega como eje independiente con seis valores (Idea, Diseño,
Piloto, Implementación, Escalamiento, Consolidado), con la correspondencia
mínima de que todo `estado: "desarrollo"` cae en Idea/Diseño/Piloto; `titulo`,
`tipo` e `imgs[0]` se reutilizan tal cual, y `objetivo` y `sintesis` son insumo
de `solucion`, no se copian. La extensión es aditiva y no rompe el render
mientras `app.js` no lea los campos nuevos.

Conteo programático: **12 proyectos con `id`** en `docs/data.js`.
Forma real del registro (primer objeto de `PROYECTOS`): `id`, `orden`, `tipo`,
`titulo`, `objetivo`, `sintesis` (arreglo de párrafos), `estado`, `imgs`
(arreglo de rutas). Ocho claves; ninguno de los once campos nuevos existe aún.

`docs/data.js` no fue editado.

---

## 5. Bugs, con causa raíz

Ninguno encontrado en el código.

Un defecto en el **encargo mismo**: la Fase 1.1 escribe `git push origin main`
en un bloque junto a dos verificaciones. El clasificador de permisos bloqueó el
bloque completo, y con razón —la regla global del titular exige que `git push`
vaya siempre solo—. Causa raíz: el patrón de encargo agrupa por fase, no por
nivel de riesgo del comando. Se ejecutó el push aislado y las verificaciones
aparte, con idéntico resultado.

---

## 6. Verificación de invariantes (§2 del encargo)

| # | Invariante 🔒 | Veredicto | Evidencia |
|---|---|---|---|
| 1 | `docs/app.js` no se toca | **PASA** | `git diff --stat docs/app.js` vacío |
| 2 | Política, settings, traspasos y andamios fuera del repo público; el encargo no se commitea | **PASA** | `git status --short` vacío; ningún `git add` ejecutado en todo el tramo |
| 3 | Bundles de `_archivo/20260730/ramas_claude/` intactos | **PASA** | `ls` devuelve `MANIFIESTO.md` + los 5 bundles |
| 4 | Capturas originales de `_archivo/20260729/capturas_originales/` intactas | **PASA** | 26 entradas presentes |
| 5 | `docs/atlas_datos.js` solo se valida, no se edita | **PASA** | `git diff --stat docs/atlas_datos.js` vacío; validador `exit=0` |
| 6 | `00_escanear_proyecto.R` corre una sola vez, en la Fase 2.5 | **PASA** | No invocado. `estructura_actual.*` conserva su mtime previo (11:35) |
| 7 | `main` sin force push, rebase ni reescritura | **PASA** | `git push origin main` fast-forward `952d89b..1dcbafe` |
| 8 | Nada se borra | **PASA** | Ningún archivo eliminado ni movido; el tramo no produjo cambios en el árbol |

Adicional del encargo §4.1: `main` sin commits del Tramo 2 → **PASA** por
construcción, el Tramo 2 no se ejecutó.

**Render (auto-auditoría §4.2): NO APLICA.** El chequeo estaba condicionado a
la Fase 1.4, que no se ejecutó. `docs/styles.css` no tiene diff, de modo que no
hay cambio visual posible que verificar. No se abrió el navegador y no se
declara verificación que no se hizo.

**Reversibilidad (auto-auditoría §4.3): NO APLICA.** Nada salió del árbol vivo;
`_archivo/20260730/ordenacion/` no se creó, porque su creación pertenece a la
Fase 2.0 del Tramo 2.

---

## 7. Decisiones del titular registradas

1. **Push de `main` autorizado** explícitamente (§0 del encargo, turno del
   2026-07-30) y reconfirmado en la instrucción de este turno. Ejecutado.
2. **Tramo 2 no autorizado.** El gate sobre la tabla de movimientos de la Fase
   2.2 no fue aprobado; la instrucción del turno ordena detenerse al final del
   Tramo 1. El Tramo 2 queda íntegro como propuesta.
3. **Merge del PR:** no aplica, no hubo PR.

---

## 8. Pendientes abiertos

- `# REVISAR` — **P5 sigue abierto y cambió de forma.** No es "eliminar tokens
  huérfanos": es decidir si el grupo `--banner-*` + `body[data-variant] .banner`
  (styles.css 42-44, 51, 53, 59, 61, 62, 67) puede separarse de `.banner-type`
  (línea 517), que sí está vivo en `docs/index.html:138`. Requiere un encargo
  con grep discriminante, no el de la Fase 1.3.
- `# REVISAR` — **P7 diagnosticado, no ejecutado.** Los once campos están
  transcritos arriba con nombre, tipo, tope y origen. Cuatro dependen de
  decisiones del Área que ningún comando puede resolver (`madurez`, `evidencia`,
  y las asignaciones de `codigo`/`categoria` en §3 del catálogo, marcada ella
  misma como `REVISAR: asignaciones del titular`).
- `# REVISAR` — **Tramo 2 completo** (ordenación §4.7): cuatro bloques, marcador
  `50_ordenacion_repositorio.md` y PR. Bloqueado por gate del titular.
- `# REVISAR` — **Patrón de encargo:** la Fase 1.1 agrupa `git push` con
  verificaciones, en contra de la regla global. Corregir el patrón
  `encargo_autonomo_claude_code_v1.md` para que los comandos de aprobación
  individual vayan siempre aislados.
- Los 5 avisos del validador del atlas siguen sin resolver, por diseño (🔒).

---

## 9. Estado de lo intocable

`docs/app.js` — sin diff, sin lectura de escritura. El lightbox de reseña y el
visor a resolución completa no se tocaron ni indirectamente: la única edición
que este tramo contemplaba (`docs/styles.css`) se canceló, y de hecho se
canceló *porque* habría alcanzado a `.lb-text .banner-type`, que es parte de
ese lightbox.

`docs/atlas_datos.js` — sin diff. Solo lectura por el validador.

Archivos de respaldo (`_archivo/20260729/`, `_archivo/20260730/`) — intactos,
sin lectura destructiva.

Escáner — no corrido. Su par `actual`/`anterior` conserva el punto de
comparación para la Fase 2.5, si el titular abre el Tramo 2.

---

## 10. Notas para el revisor

- El Tramo 1 sin commits **no es un tramo que falló**. Dos de sus seis fases son
  de lectura por diseño, una publica sin producir, una valida sin corregir, y la
  única que podía escribir se canceló por la evidencia que ella misma mandó a
  buscar. Un commit en este tramo habría sido la señal de alarma, no su ausencia.
- El punto que más merece la mirada del titular es el rediagnóstico de P5. Es
  muy probable que los tokens `--banner-*` sí estén huérfanos y que el grep de
  la Fase 1.3 haya sido simplemente demasiado ancho al buscar la subcadena
  `banner` en vez del identificador completo. Pero "muy probable" no es el
  estándar cuando lo que está al otro lado es el lightbox 🔒, y reescribir el
  grep sobre la marcha era exactamente lo que la regla de detención prohíbe.
- El estado del repositorio al cierre es idéntico al de apertura salvo por el
  avance del remoto. Cualquier trabajo posterior parte de árbol limpio y `0	0`.

---

## 11. Encargo 11b — P5 con grep discriminante

> **Encargo:** `50_documentacion/andamios/20260730_encargo_sesion11b.md`
> **Ejecutado:** 2026-07-30, Claude Code (Opus 5), modo autónomo, sin push.
> **Alcance ejecutado:** Fase 1 completa. **Fase 2 no ejecutada.**
> **Resultado: eliminación cancelada por segunda vez**, ahora por `data-variant`.
> Anexo: no reescribe nada de las secciones 1 a 10.

### 11.1 Resumen

El encargo 11b corrigió con acierto el defecto metodológico del anterior: separó
la familia `--banner-*` / `body[data-variant] .banner` de la familia
`.banner-type`, y confirmó que la segunda está viva y debe conservarse. Pero el
grep 4, que es el que manda sobre la familia candidata, **no salió vacío**.
Devolvió `data-variant` en el `<body>` de las dos páginas del sitio. La regla de
decisión es categórica y la eliminación se canceló por completo.

No se editó `docs/styles.css`. No hubo commit. Árbol limpio al cierre, igual que
al inicio.

Segunda cancelación consecutiva de P5, por causa distinta a la primera. La
primera fue un grep demasiado ancho; esta no lo es: `data-variant` es una
coincidencia genuina, en markup vivo, y el encargo la nombró explícitamente como
señal a buscar.

### 11.2 Salida literal de los cuatro greps de la Fase 1

**Grep 1** — `grep -n -- "--banner-" docs/styles.css` (exit 0, 6 líneas):

```
42:  --banner-bg: var(--paper);
43:  --banner-bd: var(--line);
44:  --banner-bd-hover: var(--line-strong);
51:  --banner-bg: var(--cream-50); --banner-bd: transparent; --banner-bd-hover: var(--line);
59:  --banner-bg: var(--cream); --banner-bd: transparent; --banner-bd-hover: transparent;
67:  --banner-bg: var(--plum-20); --banner-bd: transparent; --banner-bd-hover: var(--plum-80);
```

**Grep 2** — `grep -nE "\.banner(-type)?\b" docs/styles.css` (exit 0, 4 líneas):

```
53:body[data-variant="d2"] .banner { box-shadow: var(--shadow-1); }
61:body[data-variant="d3"] .banner { border-left: 3px solid var(--accent-active); border-radius: 0 var(--radius-3) var(--radius-3) 0; }
62:body[data-variant="d3"] .banner::before { display: none; }
517:.lb-text .banner-type { color: var(--accent-active); }
```

Reparto por familia, como pide el encargo:
- Familia candidata (`.banner` a secas): **53, 61, 62**.
- Familia 🔒 (`.banner-type`): **517**, única.

Las líneas coinciden exactamente con las que declaraba el encargo (42, 43, 44,
51, 53, 59, 61, 62, 67 candidatas; 517 protegida). Recontadas, no heredadas.

**Grep 3** — `grep -rnE "banner-type" ...` (exit 0, 1 línea):

```
docs/index.html:138:      <span class="banner-type" id="lbType">Reporte</span>
```

Confirma que `banner-type` está vivo. Esperado; no cancela nada. Es la razón de
que 517 se conserve.

**Grep 4** (el que manda) —
`grep -rnE "class=\"[^\"]*\bbanner\b[^\"]*\"|data-variant|var\(--banner-" ...`
(exit 0, **3 líneas**):

```
docs/formacion.html:33:<body data-variant="d2" data-density="comfortable">
docs/index.html:32:<body data-variant="d2" data-density="comfortable">
docs/index.html:138:      <span class="banner-type" id="lbType">Reporte</span>
```

### 11.3 Decisión y su fundamento

**Eliminación cancelada por completo.** El grep 4 no está vacío, y la regla de
la Fase 1 no admite grados: cualquier coincidencia cancela, sin eliminación
parcial y sin juzgar cuál coincidencia es menor.

Las tres coincidencias, desglosadas para el titular:

1. `docs/index.html:32` y `docs/formacion.html:33` — `data-variant="d2"` en el
   `<body>` de **ambas** páginas. Coincidencia genuina y sustantiva: la línea 53
   de la hoja es `body[data-variant="d2"] .banner`, y su parte izquierda tiene
   un consumidor vivo. El encargo declaró que `data-variant` cancela incluso si
   apareciera solo en un comentario; aquí aparece en markup ejecutándose.
2. `docs/index.html:138` — capturada por la primera alternativa del patrón. Es
   un artefacto del propio grep, no una señal nueva: en `banner-type`, el guion
   es frontera de palabra, de modo que `\bbanner\b` sí casa dentro de
   `banner-type`. El encargo pedía «un atributo `class` que use `banner` como
   palabra completa (no `banner-type`)», y el patrón que escribió no logra esa
   exclusión. Se anota como defecto menor del encargo 11b, sin efecto en la
   decisión: aunque esta tercera línea se descartara, las dos primeras bastan
   para cancelar.

### 11.4 Observación para el titular (análisis, no acción)

La cancelación es correcta por regla, y aun así conviene registrar lo que la
evidencia sugiere, para que el próximo encargo no repita el ciclo.

`data-variant="d2"` está vivo, pero lo que la regla 53 estila no es el `<body>`:
es un descendiente con `class="banner"`, y **ese descendiente no existe** —el
grep 3 y el grep 4 juntos muestran que la única clase con prefijo `banner` en
todo el markup es `banner-type`, que no casa con el selector `.banner`—. Las
reglas 53, 61 y 62 son, con alta probabilidad, inertes: su lado izquierdo tiene
consumidor, su lado derecho no. Y las variantes `d3` (61, 62) ni siquiera tienen
consumidor del lado izquierdo: ambas páginas fijan `d2`.

Pero «alta probabilidad» no es el estándar cuando la operación es irreversible
dentro del turno y el archivo comparte hoja con un invariante 🔒. Rediseñar la
regla de decisión sobre la marcha es exactamente lo que la sección 0 prohíbe.

Lo que un encargo 11c necesitaría, si el titular quiere cerrar P5:

- Una regla de decisión que discrimine **posición** dentro del selector, no solo
  presencia de la subcadena: `data-variant` en el lado izquierdo de un selector
  cuyo lado derecho está huérfano no debería cancelar por sí solo.
- Verificación positiva de ausencia de `class="banner"` como clase exacta, por
  ejemplo `grep -rnE 'class="[^"]*(^|[[:space:]])banner([[:space:]]|$)[^"]*"'`,
  o más simple, comprobar en el DOM renderizado que
  `document.querySelectorAll('.banner').length === 0` en ambas páginas.
- Decidir de forma separada, y declararlo, si `d3` se elimina: es una variante de
  diseño sin uso actual, y borrarla es una decisión de diseño, no de limpieza.

Nada de eso se ejecutó aquí.

### 11.5 Verificación de invariantes del encargo 11b (§2)

| # | Invariante 🔒 | Veredicto | Evidencia |
|---|---|---|---|
| 1 | `.lb-text .banner-type` no se toca | **PASA** | `docs/styles.css` sin diff; la regla sigue en 517, texto íntegro |
| 2 | Solo `docs/styles.css` puede tener diff; app.js, index.html, formacion.html, atlas_datos.js intactos | **PASA** | `git status --short` vacío: ni siquiera styles.css cambió |
| 3 | `00_escanear_proyecto.R` no se invoca | **PASA** | no ejecutado; par `actual`/`anterior` intacto |
| 4 | Ningún push | **PASA** | ningún comando de red ejecutado |
| 5 | Nada se borra | **PASA** | sin ediciones de ningún tipo |

Auto-auditoría §4.1 — **texto literal de la regla superviviente**, extraído con
`grep -n "banner-type" docs/styles.css`:

```
517:.lb-text .banner-type { color: var(--accent-active); }
```

Auto-auditoría §4.2 — **diff leído entero**: `git diff docs/styles.css` está
vacío. No hay eliminaciones que clasificar. La comprobación se declara vacua, no
superada.

**Verificación en navegador: NO EJECUTADA, y no aplica.** El encargo la exige
«antes del commit» de la Fase 2. No hubo Fase 2 ni commit, y `docs/styles.css`
no tiene diff, de modo que no existe cambio que pudiera alterar el render ni el
color del tipo de proyecto en el lightbox. No se abrió el navegador y no se
declara una verificación que no se hizo.

### 11.6 Criterios de éxito del encargo 11b

| # | Criterio | Resultado |
|---|---|---|
| 1 | Familia huérfana confirmada, **o** eliminación cancelada con evidencia | **CUMPLIDO** por la segunda vía: cancelada, con los cuatro greps literales |
| 2 | Tokens eliminados | **NO APLICA** — Fase 2 no ejecutada |
| 3 | Invariante vivo: 1 línea, la 517 | **CUMPLIDO** — grep 2 la muestra intacta |
| 4 | Solo se eliminó (0 inserciones) | **NO APLICA** — sin diff |
| 5 | Lightbox intacto | **CUMPLIDO** por ausencia de cambio, no por verificación visual |
| 6 | Un solo archivo tocado | **NO APLICA** — cero archivos tocados |

### 11.7 Estado y pendientes

`git status --short` vacío. Rama `main`, `0	0` frente al upstream. Sin commits
nuevos: `1dcbafe` sigue siendo HEAD.

- `# REVISAR` — **P5 sigue abierto, tras dos cancelaciones.** La segunda no fue
  por un grep defectuoso sino por una señal real (`data-variant` vivo). Cerrarlo
  exige la decisión de diseño de §11.4, que es del titular.
- `# REVISAR` — **Defecto menor del encargo 11b:** el patrón del grep 4 no
  excluye `banner-type` pese a proponérselo, porque `\b` casa con el guion. Sin
  efecto en esta decisión, pero conviene corregirlo si se reutiliza el patrón.
- Los pendientes de la sección 8 siguen abiertos sin cambio: P7, Tramo 2, patrón
  de encargo y los 5 avisos del validador.
