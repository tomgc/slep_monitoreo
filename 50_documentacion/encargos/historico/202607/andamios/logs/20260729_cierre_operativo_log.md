# Log de cierre operativo — sesión 9 (`slep_monitoreo`)

Andamio de ejecución. Registro congelado; no se actualiza después.
Encargo ejecutado: `50_documentacion/andamios/20260729_encargo_cierre_sesion09.md`.
Plantilla: `encargo_autonomo_claude_code_v1.md` §4 (diez apartados).

---

## 1. Resumen de la sesión

Entró el cierre operativo de la sesión 9 en modo autónomo secuencial: seis fases
(0 a 5). **Cuatro se completaron, dos quedaron detenidas** por la regla (b) de la
sección 1 del encargo.

- **Fase 0 (lectura del estado):** PASA.
- **Fase 1 (dos commits pendientes):** PASA. Dos commits locales creados.
- **Fase 2 (archivar el handoff):** **DETENIDA por (b).** El conteo real del
  directorio no coincide con el declarado en el encargo. El `mv` no se ejecutó.
- **Fase 3 (regenerar el escáner):** **NO EJECUTADA**, por dependencia de la
  fase 2 (ver apartado 8).
- **Fase 4 (inventario de ramas `claude/*`):** PASA. Cinco fichas, solo lectura.
- **Fase 5 (optimizar las 26 capturas):** PASA. 9,21 MB → 2,39 MB (−74 %),
  ningún archivo sobre 250 KB, dimensiones intactas, sin commitear.

**Estado final del árbol:** dos commits locales sin publicar; los cuatro archivos
del escáner y los 24 PNG recomprimidos modificados sin indexar;
`design_handoff_portafolio_pliego/` sigue en su ruta original, no trackeado.

---

## 2. Inventario de commits

Todos locales. **Ningún `git push`** (🔒 I2).

### Fase 1

| Hash | Tipo | Título | Qué hizo |
|---|---|---|---|
| `79b2579` | chore | `chore(gitignore): blinda traspasos/** para cubrir el archivado` | Amplía el patrón de `.gitignore` a `traspasos/**` para que el archivado quede cubierto. 1 archivo, +1/−1. |
| `0c9adee` | feat | `feat(portafolio): pliego de capturas con altura normalizada y ancho natural` | Materializa el rediseño del portafolio: las capturas se renderizan en la página con altura normalizada y ancho a la proporción real. 3 archivos, +212/−86. |

Ninguna otra fase commiteó. Las fases 2 y 3 no llegaron a commit (detenidas); la
fase 4 es de solo lectura; la fase 5 es gate explícito del titular (5.7).

---

## 3. Por cada cambio sustantivo

### 3.1 Los dos commits de la fase 1

- **Qué:** se indexó y commiteó, con rutas explícitas (🔒 I3), primero
  `.gitignore` y luego los tres archivos del pliego.
- **Por qué:** dos cambios conceptuales distintos → dos commits atómicos
  (`POLITICA_PROYECTO.md` §3).
- **Archivos:** `.gitignore`; `docs/app.js`, `docs/styles.css`,
  `docs/index.html`.
- **Cómo se verificó:** `node --check docs/app.js` → `check=0`; `git log
  --oneline -2` muestra ambos; `git status --short` ya no lista `.gitignore` ni
  nada bajo `docs/` salvo los PNG de la fase 5.
- **Tensión resuelta:** ninguna. Fase limpia, sin sorpresas.

### 3.2 Recompresión de las 26 capturas (fase 5)

- **Qué:** 24 de los 26 PNG se recomprimieron con `pngquant --quality=70-92
  --speed 1`. Dos (`resguardo-2.png` 236 KB, `asistencia-1.png` 224 KB) ya
  estaban bajo el umbral de 250 KB y **no se tocaron**: sus bytes son idénticos
  a los del respaldo.
- **Por qué:** con el pliego, las capturas se renderizan en la página en vez de
  vivir tras un click en el lightbox; su peso pasó a afectar la primera carga.
- **Decisión de diseño forzada por el entorno:** `oxipng` **no está instalado**
  (`oxipng not found`). La pasada sin pérdida de 5.4 no se pudo ejecutar. El
  encargo prevé esta contingencia: solo manda detenerse si faltan las tres
  herramientas. Se aplicó la prelación restante, saltando a 5.5 (`pngquant`
  sobre los excedidos). **No se instaló nada** sin autorización. `sips` quedó
  sin usar: su ganancia es menor y `pngquant` ya cumplió la meta con holgura.
- **Cómo se verificó:** ver apartados 6 y 9.

---

## 4. Auditoría de diagnóstico

No hubo auditoría de diagnóstico de cifras en este encargo. La fase 4 es un
inventario descriptivo; su resultado está en el apartado 8 y en el reporte al
chat.

---

## 5. Bugs encontrados y resueltos

Ningún bug de código. Dos hallazgos de otra naturaleza:

### 5.1 Supuesto errado del encargo sobre el handoff (causa de la detención)

- **Síntoma:** el criterio de término de la fase 2 exige que
  `ls _archivo/20260729/handoff_diseno/ | wc -l` dé **11**. El directorio de
  origen tiene **10** entradas.
- **Causa raíz:** el encargo declara "cuatro `.dc.html`"; hay **tres**. Un solo
  error de conteo del redactor explica ambas discrepancias: 3 reales + 1
  inexistente = las 11 declaradas. Verificado que no son archivos ocultos
  (`ls -A` también da 10, y `ls -a` solo añade `.` y `..`).
- **Fix:** ninguno aplicado. Es caso de detención (b), y el ejemplo literal que
  la sección 1 del encargo usa para definirla ("un conteo de archivos que no
  coincide con el declarado"). El `mv` **no se ejecutó**.
- **Verificación:** los otros tres supuestos de la fase 2 **sí** se confirmaron:
  `support.js` pesa 68 KB (declarado 67,5 KB), hay **seis** `.otf` en `fonts/`,
  y los `.dc.html` presentes tienen espacios y paréntesis en el nombre. El
  objeto es el correcto; solo el conteo está mal.

### 5.2 Degradación de un acento de color en la recompresión

- **Síntoma:** en la comparación visual de `parvularia-2.png` (el archivo de
  mayor reducción, −84 %), el marcador de acento **naranja** del ítem activo de
  la barra lateral ("Resumen del jardín") pierde su color y se ve apagado
  (gris-verde) en la versión recomprimida.
- **Causa raíz:** `pngquant` cuantiza a paleta. Un acento de pocos píxeles y
  color muy saturado, aislado sobre un fondo verde, es el candidato natural a
  perder su entrada de paleta.
- **Fix:** ninguno aplicado. **No** es una violación de 🔒 I7, que protege la
  legibilidad del **texto y las cifras de los tableros**: esas quedaron
  idénticas (ver apartado 6, I7). Pero es una pérdida visual real y es
  exactamente lo que el gate 5.7 existe para que el titular decida.
- **Pendiente para el titular:** ver apartado 10.

---

## 6. Verificación de invariantes

Los nueve 🔒 de la sección 3 del encargo.

| 🔒 | Estado | Evidencia |
|---|---|---|
| **I1. Nada se borra** | **PASA** | Único candidato a salir del árbol era el handoff, y la fase 2 se detuvo: sigue íntegro en su ruta. Los 26 PNG originales están respaldados en `_archivo/20260729/capturas_originales/` (verificado: 26 archivos, 9,3 MB) antes de tocar nada. |
| **I2. Ningún `git push`** | **PASA** | No se ejecutó ningún `git push` en ninguna variante. Las únicas operaciones de red fueron `git fetch --all --prune` (solo lectura, fase 4). Los dos commits son locales. |
| **I3. `git add` con rutas explícitas** | **PASA** | Los dos únicos `git add` fueron `git add .gitignore` y `git add docs/app.js docs/styles.css docs/index.html`. Ningún `git add -A`, ningún `git add .`, ningún `git commit -a`. |
| **I4. Los cuatro del escáner no se commitean** | **PASA** | `git status --short` los sigue mostrando como `M` sin indexar. No aparecen en el `--stat` de ninguno de los dos commits. |
| **I5. `_archivo/` ignorado antes de archivar** | **PASA** | Verificado **antes** de crear nada bajo `_archivo/`: `grep -n "_archivo" .gitignore` → `5:_archivo/`. Confirmado a posteriori: `git status --short` no lista nada bajo `_archivo/` pese a los 26 PNG depositados. |
| **I6. Se recomprime, no se redimensiona** | **PASA** | Doble verificación con métodos independientes. (a) `diff /tmp/dim_antes.txt /tmp/dim_despues.txt` (vía `sips`) → vacío, "DIMENSIONES IDENTICAS". (b) Check adversarial: lectura cruda del chunk IHDR de cada PNG en `python3/struct`, comparando respaldo contra árbol vivo → 26 archivos comparados, **0 discrepancias**. |
| **I7. Legibilidad sobre peso** | **PASA, con una salvedad no-textual** | Inspección visual directa del caso de mayor riesgo (`parvularia-2.png`, −84 %): todo el texto y todas las cifras de los tableros —titulares, etiquetas de los cinco niveles de logro, porcentajes, conteos entre paréntesis, el párrafo de nota al pie— son idénticamente legibles. La única degradación detectada es un acento de color de pocos píxeles, no texto (ver 5.2). No se bajó el rango de calidad en ninguna pasada. |
| **I8. La fase 3 es de solo lectura** | **PASA** | *(El encargo rotula "fase 3" en I8 pero la fase de ramas es la 4; se aplica a la de ramas, que es su objeto inequívoco.)* Sobre las ramas `claude/*` se ejecutaron únicamente `git branch -r`, `git log -1`, `git rev-list --count` y `git diff --stat`. Ningún `git branch -d`/`-D`, ningún `push --delete`, ningún `merge`, `cherry-pick` ni `rebase`. |
| **I9. Ningún contenido nuevo entra a `docs/`** | **PASA** | `git status --short docs/` lista exclusivamente 24 PNG como `M`: ningún `??`, ningún `A`, ningún `D`. El `--stat` de los dos commits toca `.gitignore` (fuera de `docs/`) y tres archivos preexistentes de `docs/`, todos modificaciones. Cero archivos creados bajo `docs/`. |

---

## 7. Decisiones del usuario registradas

Ninguna decisión tomada en gate durante la ejecución: el encargo se lanzó con la
ruta ya aprobada y en modo autónomo, sin interacción intermedia.

Decisiones **pendientes** de gate, que este encargo deja abiertas por diseño:

1. **Gate 5.7 (capturas):** aceptar o revertir la recompresión, tras revisar en
   el navegador.
2. **Gate de la sesión 10 (ramas `claude/*`):** qué hacer con las cinco ramas
   remotas. El encargo prohíbe expresamente proponer borrados.

---

## 8. Pendientes abiertos

### 8.1 Fase 2 — archivar el handoff (`# REVISAR`)

**No ejecutada.** Detención (b) por el conteo (ver 5.1).
`design_handoff_portafolio_pliego/` sigue en la raíz del proyecto, no trackeado,
con sus 10 entradas y 496 KB. La decisión sustantiva del encargo —el handoff ya
fue consumido y debe archivarse en vez de versionarse— **no está en disputa**:
lo único que falla es el número. Basta que el titular confirme "el conteo
correcto es 10" para que la fase corra tal cual, con su criterio de término
corregido.

Comando que quedó sin ejecutar:

```bash
cd /Users/tomgc/Projects/slep_monitoreo && mkdir -p _archivo/20260729 && mv design_handoff_portafolio_pliego _archivo/20260729/handoff_diseno
```

### 8.2 Fase 3 — regenerar el escáner (`# REVISAR`)

**No ejecutada, por decisión propia y con causa.** El criterio de término de la
fase 3 es que los totales del encabezado sean **menores** que antes de la fase 2
—precisamente porque el handoff salió del árbol escaneado—. Sin la fase 2 ese
criterio no puede cumplirse: los totales subirían, no bajarían, porque
`50_documentacion/andamios/` es nuevo en el árbol.

Razón de peso adicional: el escáner mantiene un par fijo actual/anterior y cada
corrida pisa. Correrlo ahora, y otra vez tras la fase 2, dejaría
`estructura_anterior.*` con un snapshot intermedio espurio y perdería el
snapshot de `19d0b99`, que es el punto de comparación útil. Se prefirió no
contaminar el par. La fase 3 debe correr **una sola vez, después** de la fase 2.

Totales vigentes, capturados antes de detenerse (generados 2026-07-29 14:49:49):
**13 carpetas, 83 archivos.**

### 8.3 Ramas `claude/*` (gate de la sesión 10)

Inventario en el reporte al chat. Cuatro de las cinco ramas contienen archivos
ajenos a `slep_monitoreo`. Sin propuesta de acción, por mandato del encargo.

---

## 9. Estado de cifras/datos críticos

Lo intocable quedó intacto:

- **Dimensiones en píxeles de las 26 capturas:** idénticas. Verificado por dos
  vías independientes (`sips` y lectura cruda del IHDR). 0 discrepancias en 26
  archivos.
- **Nómina de las 26 capturas:** idéntica. `diff` de los nombres del respaldo
  contra el árbol vivo → vacío. Ninguna alta, ninguna baja, ningún renombre.
- **Respaldo íntegro y previo:** los 26 originales se copiaron a
  `_archivo/20260729/capturas_originales/` (9,3 MB) **antes** de la primera
  recompresión. Se confirmó el conteo 26 antes de continuar.
- **Los dos PNG bajo el umbral:** `resguardo-2.png` y `asistencia-1.png` tienen
  el mismo tamaño en bytes antes y después. No fueron procesados.
- **Peso de la carpeta:** 9,21 MB → 2,39 MB. Meta del encargo (< 4 MB y ningún
  archivo > 250 KB): cumplida, con 0 excepciones que listar.
- **Sintaxis de `docs/app.js`:** `node --check` → 0.

---

## 10. Notas para el revisor

**Qué mirar con ojo crítico:**

1. **El acento de color perdido (5.2).** Es el hallazgo que más merece el ojo
   del titular. Al revisar el pliego en el navegador, conviene mirar los
   acentos de color saturado sobre fondos oscuros —marcadores de ítem activo,
   badges, indicadores de estado— y no solo el texto. El texto está bien; los
   acentos de pocos píxeles son el punto débil de la cuantización a paleta. Si
   el resultado no convence, la reversión es de un comando:

   ```bash
   cd /Users/tomgc/Projects/slep_monitoreo && cp _archivo/20260729/capturas_originales/*.png docs/assets/proyectos/
   ```

2. **La legibilidad se auditó en una captura, no en 26.** Se eligió
   `parvularia-2.png` por ser la de mayor reducción, es decir el peor caso
   plausible. No es una muestra exhaustiva y no se presenta como tal. Vale una
   pasada del titular por el resto, con atención a `parvularia-1.png` (la única
   que sigue sobre 150 KB tras la pasada, señal de detalle denso).

3. **La detención de la fase 2 es de forma, no de fondo.** Merece un juicio
   rápido para no arrastrarla: el error está en el encargo, no en el
   repositorio, y su corrección es cambiar un 11 por un 10.

**Deuda declarada:**

- `oxipng` no está en el entorno. La pasada sin pérdida nunca corrió, así que la
  compresión aplicada es **toda** con pérdida. Si el titular instala `oxipng`,
  hay margen para rehacer la fase 5 con la prelación completa: sin pérdida
  primero y `pngquant` solo sobre el residuo excedido, que con `oxipng -o 4`
  sería un subconjunto bastante menor de los 24.

**Qué conviene auditar en la próxima sesión:**

- El gate de las cinco ramas `claude/*`. Cuatro apuntan a proyectos ajenos
  (organigrama ×2, colección de películas, resúmenes de papers) y sus diffs
  contra `main` tocan rutas de la **raíz** (`index.html`, `app.js`,
  `styles.css`), es decir preceden al traslado del sitio a `docs/` (PR #4).
  Cualquier merge accidental sobrescribiría el docroot histórico. Son de abril
  de 2026.
- La quinta, `improve-portfolio-site-4tPUA`, sí es de este proyecto pero tiene
  **0** commits fuera de `main` y diff vacío: está completamente absorbida.
- El encargo de la fase 2 y la fase 3 pendientes, en ese orden.

---
---

# Adenda — 2026-07-30, cierre de las fases 2 y 3

Adenda fechada, autorizada por el titular como **única** actualización de este
andamio. El registro original de arriba **no se reescribió**: quedó tal como se
congeló al detenerse. Esta adenda solo consigna lo que cambió después.

*Nota de fecha: el log se rotula `20260729` por la sesión a la que pertenece; la
ejecución de estas dos fases ocurrió en la madrugada del 2026-07-30 (el escáner
sella `2026-07-30 05:59:12`).*

## A.0 Corrección del encargo, confirmada por el titular

1. **Conteo del handoff:** el correcto es **10** entradas y **3** `.dc.html`. El
   error era del redactor, no del repositorio. El criterio de término de la fase
   2 pasa a ser "el conteo es 10". Esto levanta la detención (b) descrita en 5.1.
2. **Alcance de 🔒 I8:** se refiere a la fase de inventario de ramas `claude/*`,
   que tras la renumeración es la **fase 4**, no la 3. Confirma la lectura que ya
   se había aplicado en el apartado 6.

Instrucciones adicionales del titular para esta corrida: no commitear la salida
del escáner (🔒 I4), ningún `git push` (🔒 I2), y **no tocar** las capturas de
`docs/assets/proyectos/`, que siguen a la espera del gate visual.

## A.1 Actualización del apartado 1 (resumen)

Las seis fases quedan así. **Las seis se completaron; ninguna queda detenida.**

- **Fase 0 (lectura del estado):** PASA.
- **Fase 1 (dos commits pendientes):** PASA. `79b2579` y `0c9adee`.
- **Fase 2 (archivar el handoff):** **PASA** con el criterio corregido.
- **Fase 3 (regenerar el escáner):** **PASA**, con una salvedad de conteo (A.4).
- **Fase 4 (inventario de ramas `claude/*`):** PASA.
- **Fase 5 (optimizar las 26 capturas):** PASA, sin commitear.

**Estado final del árbol tras la adenda:** los mismos dos commits locales sin
publicar, sin commits nuevos; nada indexado (`git diff --cached --stat` vacío);
sin indexar quedan los cuatro archivos del escáner y los 24 PNG recomprimidos;
el único `??` restante es `50_documentacion/andamios/` (el encargo y este log).
`design_handoff_portafolio_pliego/` ya no existe en la raíz.

## A.2 Actualización del apartado 6 — 🔒 I8

**I8. La fase de ramas es de solo lectura — PASA, sin la salvedad de lectura.**
La ambigüedad quedó resuelta por el titular (A.0.2): I8 aplica a la **fase 4**.
La evidencia original se mantiene intacta: sobre las ramas `claude/*` solo se
ejecutaron `git branch -r`, `git log -1`, `git rev-list --count` y `git diff
--stat`. Ningún `git branch -d`/`-D`, ningún `push --delete`, ningún `merge`,
`cherry-pick` ni `rebase`. La nota entre paréntesis del apartado 6 deja de ser
una interpretación propia y pasa a ser criterio confirmado.

**Invariantes cuya evidencia cambió con estas dos fases** (los demás conservan la
del apartado 6, sin alteración):

| 🔒 | Estado | Evidencia nueva |
|---|---|---|
| **I1. Nada se borra** | **PASA** | El handoff se **movió**, no se borró: `_archivo/20260729/handoff_diseno/` contiene sus **10** entradas íntegras, conservando la ruta relativa —los tres `.dc.html` con sus nombres originales (espacios y paréntesis incluidos), `README.md`, `fonts/`, `index-portafolio.html`, `portafolio.css`, `portafolio.js`, `reglas-del-proyecto.md`, `support.js`—. `_archivo/20260729/` alberga ahora `handoff_diseno` y `capturas_originales`. |
| **I2. Ningún `git push`** | **PASA** | `git log --oneline origin/main..HEAD` sigue mostrando exactamente los mismos dos commits de la fase 1. Ningún push en ninguna variante, ninguna operación de red en esta corrida. |
| **I3. `git add` con rutas explícitas** | **PASA** | No se ejecutó ningún `git add` en esta corrida. `git diff --cached --stat` vacío: nada indexado. |
| **I4. Los cuatro del escáner no se commitean** | **PASA** | Tras regenerarlos, `git status --short 50_documentacion/estructura` los muestra como los mismos cuatro `M` **sin indexar**. Cero commits nuevos. |
| **I5. `_archivo/` ignorado** | **PASA** | Confirmado con el handoff ya depositado: `git status --short` no arroja ninguna coincidencia de `_archivo`. Los 496 KB del handoff y los 9,3 MB de capturas originales son invisibles a git en un repositorio público. |
| **I6 / I7. Capturas** | **PASA, sin cambios** | Las capturas **no se tocaron** en esta corrida, por instrucción del titular. `git status --short docs/` sigue arrojando exactamente **24** líneas, todas `M`: ningún `D`, ningún `??`, ninguna alta. |
| **I9. Ningún contenido nuevo en `docs/`** | **PASA** | Las fases 2 y 3 no escriben en `docs/`: la 2 opera en la raíz y en `_archivo/`, la 3 en `50_documentacion/estructura/`. Confirmado por el conteo invariable de 24 líneas en `git status --short docs/`. |

## A.3 Cierre del pendiente 8.1 — fase 2

**CERRADO.** El pendiente marcado `# REVISAR` en 8.1 queda resuelto.

Comando ejecutado, el mismo que había quedado sin ejecutar:

```bash
cd /Users/tomgc/Projects/slep_monitoreo && mkdir -p _archivo/20260729 && mv design_handoff_portafolio_pliego _archivo/20260729/handoff_diseno
```

Verificación, con el criterio corregido:

- Conteo del destino: **10** (criterio corregido: 10). CUMPLE.
- Ruta original: `ls: design_handoff_portafolio_pliego: No such file or
  directory`. CUMPLE.
- `git status --short` ya **no** muestra `?? design_handoff_portafolio_pliego/`.
  CUMPLE.
- Sin commit, como manda la fase: el origen nunca estuvo trackeado y el destino
  está ignorado. CUMPLE.

Como se anticipó en 8.1, la decisión de fondo nunca estuvo en disputa y la fase
corrió tal cual, sin más ajuste que el número.

## A.4 Cierre del pendiente 8.2 — fase 3

**CERRADO, con una salvedad de conteo que conviene dejar por escrito.**

La fase corrió **una sola vez y después** de la fase 2, que era la razón por la
que se había postergado. Salida del escáner: `Carpetas: 13 | Archivos: 70`,
sellada `2026-07-30 05:59:12`.

| Métrica | Antes de la fase 2 | Después | Δ |
|---|---:|---:|---:|
| Carpetas | 13 | 13 | **0** |
| Archivos | 83 | 70 | **−13** |

**La salvedad:** el criterio literal de la fase 3 pide "un total de carpetas **y**
archivos menor que antes de la fase 2". Los archivos bajan 13, pero **las
carpetas quedan iguales**. No es un fallo del archivado: es una compensación
exacta. El handoff se llevó dos carpetas (su raíz y `fonts/`) y
`50_documentacion/andamios/` aportó dos nuevas (ella misma y `logs/`, creada por
este log). 13 − 2 + 2 = 13.

La aritmética de los archivos cierra igual: el handoff aportaba 15 archivos (9 en
su raíz —10 entradas menos el directorio `fonts/`— más 6 `.otf`), y entraron 2
nuevos (el encargo y este log). 83 − 15 + 2 = 70. Coincide con la salida del
escáner sin necesidad de ajuste.

**Verificación del sentido del criterio**, más allá del número: el handoff salió
del árbol escaneado. `grep -c "design_handoff" estructura_actual.txt` → **0**
coincidencias. Esto es lo que el criterio buscaba comprobar, y se cumple sin
ambigüedad.

Los cuatro archivos quedan como `M` sin indexar (🔒 I4). El commit del escáner lo
hará el titular junto con el cierre de la sesión.

## A.5 Qué sigue pendiente tras la adenda

Del apartado 8 original sobrevive un solo pendiente, más el gate abierto:

1. **Gate 5.7 — las capturas.** Sin cambios: 24 PNG recomprimidos sin indexar,
   esperando la revisión visual del titular en el navegador. Sigue vigente todo
   lo dicho en 5.2 y en el apartado 10, en particular el acento naranja perdido
   en `parvularia-2.png` y el comando de reversión.
2. **8.3 — las cinco ramas `claude/*`.** Sin cambios: gate de la sesión 10, sin
   propuesta de acción por mandato del encargo.
3. **Deuda de `oxipng`** (apartado 10). Sin cambios: la compresión aplicada sigue
   siendo toda con pérdida.

Nada de lo anterior fue tocado por esta adenda.

## A.6 Notas para el revisor sobre esta corrida

- **No hubo desviaciones nuevas más allá de la salvedad de A.4.** Ningún comando
  falló; ninguna aserción quedó incumplida. La salvedad de las carpetas se
  reporta por transparencia aritmética, no porque afecte el resultado: se explica
  por entero, y su causa —este mismo log y el encargo que lo generó— es un efecto
  del propio proceso de andamiaje, no del archivado.
- **Punto digno de un ojo crítico:** el criterio "totales menores" es frágil como
  prueba de que algo salió del árbol, porque cualquier archivo nuevo lo enmascara.
  Para encargos futuros conviene formularlo como una aserción directa —"`grep -c`
  del nombre archivado en el inventario debe dar 0"— en vez de una comparación de
  agregados. Es el mismo aprendizaje que la regla de encadenamiento de la sección
  1 del encargo: verificar la cosa, no su sombra estadística.
- El escáner rotó correctamente: `estructura_anterior.*` conserva ahora el
  snapshot de `19d0b99` (13 carpetas, 83 archivos), que era exactamente el punto
  de comparación que 8.2 buscaba proteger al no correr el escáner dos veces.
