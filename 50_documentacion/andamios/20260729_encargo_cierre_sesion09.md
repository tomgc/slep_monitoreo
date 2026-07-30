# Encargo autónomo — Cierre operativo de la sesión 9 (`slep_monitoreo`)

Redactado según `encargo_autonomo_claude_code_v1.md` v1.1, sección 2.

---

## 1. Encabezado de contrato

**Modo y disciplina.** Modo autónomo, secuencial. Ejecuta las cinco fases en
este turno, en orden estricto, sin pedir confirmación entre fases: la ruta ya
fue aprobada por el titular. No fragmentes.

**Regla de detención.** Detente y reporta SOLO en estos tres casos:

- (a) Un invariante 🔒 de la sección 3 te obligaría a violarlo para continuar.
- (b) Un dato real del repositorio contradice un supuesto de este encargo (por
  ejemplo, un conteo de archivos que no coincide con el declarado).
- (c) Una fase declara explícitamente un gate del titular.

Fuera de esos tres casos, resuelve con autonomía: rutas rotas, warnings,
herramientas ausentes con alternativa prevista, contingencias declaradas.

**Reglas canónicas heredadas** (referenciadas, no reexplicadas):
`POLITICA_PROYECTO.md` §1.5 (nada se borra, todo se archiva), §3 (commits
atómicos, un cambio conceptual por commit, jamás `git add -A`), §6 (gobernanza
de datos, repositorio público). `SETTINGS_Y_PROMPTS_OPERACIONALES.md` §1.2.6
(rutas completas, sin asumir `cd`).

**Contrato de entorno.**

1. **ENTORNO:** filesystem local del titular vía Claude Code, macOS, terminal
   con `git`, `node` y `Rscript` disponibles.
2. **INSUMOS:** ninguno externo. Todo lo que este encargo necesita ya está en
   el filesystem del proyecto; ningún paso depende de un archivo que llegue
   "aparte" por el chat.
3. **POSICIÓN:** toda ruta se escribe completa desde
   `/Users/tomgc/Projects/slep_monitoreo`. Ningún comando asume `cd` previo ni
   estado de terminal heredado.

**Regla de encadenamiento.** Los pasos de verificación NO van unidos con `&&`.
Un `grep` sin coincidencias devuelve 1 y cortaría la cadena, saltándose la
verificación siguiente sin avisar (error observado en esta misma sesión). Usa
`;` o `|| true` en todo paso de comprobación.

---

## 2. Contexto mínimo suficiente

`slep_monitoreo` es un sitio institucional estático del Área de Monitoreo del
SLEP Costa Central, publicado por GitHub Pages desde `main` y la carpeta
`docs/`. Repositorio **público**. Stack: HTML, CSS y JS vanilla, sin build y
sin dependencias. El contenido de los 12 proyectos vive en `docs/data.js`; la
presentación en `docs/index.html`, `docs/styles.css`, `docs/colors_and_type.css`
y `docs/app.js`.

| Ruta | Qué es |
|---|---|
| `/Users/tomgc/Projects/slep_monitoreo/docs/` | el sitio publicado |
| `/Users/tomgc/Projects/slep_monitoreo/docs/assets/proyectos/` | 26 capturas PNG de proyectos |
| `/Users/tomgc/Projects/slep_monitoreo/design_handoff_portafolio_pliego/` | handoff de diseño ya consumido |
| `/Users/tomgc/Projects/slep_monitoreo/50_documentacion/` | gobernanza, traspasos, andamios |
| `/Users/tomgc/Projects/slep_monitoreo/00_escanear_proyecto.R` | escáner de estructura |
| `/Users/tomgc/Projects/slep_monitoreo/_archivo/` | archivo local, ignorado por git |

**Qué se hizo antes en esta sesión.** Se reconcilió el repositorio tras una
sesión paralela (`main` sincronizada, ramas residuales eliminadas), se restauró
el blindaje de los documentos de protocolo, se materializó el encargo del
catálogo de Project Cards y se implementó el rediseño del portafolio (el
"pliego de capturas") sobre `docs/app.js`, `docs/styles.css` y
`docs/index.html`. Ese trabajo está en el árbol sin commitear: es la fase 1.

**Cambio de contexto que motiva la fase 4.** Hasta el rediseño, las 26 capturas
vivían detrás de un click en el lightbox. Con el pliego se renderizan en la
página. Su peso dejó de ser deuda cosmética y pasó a afectar la primera carga
del sitio.

---

## 3. Invariantes 🔒

- 🔒 **I1. Nada se borra.** Todo lo que sale del árbol vivo va a
  `_archivo/20260729/` conservando su ruta relativa.
- 🔒 **I2. Ningún `git push`.** El encargo deja commits locales. La publicación
  la autoriza el titular después de revisar.
- 🔒 **I3. `git add` con rutas explícitas.** Nunca `git add -A`, nunca
  `git add .`, nunca `git commit -a`.
- 🔒 **I4. Los cuatro archivos de `50_documentacion/estructura/` no se
  commitean en este encargo.** Son salida del escáner y se regeneran; su commit
  de hoy ya se hizo en `19d0b99`.
- 🔒 **I5. `_archivo/` debe estar ignorado por git antes de archivar nada.** El
  repositorio es público y la fase 4 deposita ahí 26 PNG originales. Si no lo
  está, es caso de detención (a).
- 🔒 **I6. Las capturas se recomprimen, no se redimensionan.** Ancho y alto en
  píxeles de cada PNG deben ser idénticos antes y después. Cambiar dimensiones
  rompería el pliego, que normaliza por altura y deja el ancho a la proporción
  real de cada captura.
- 🔒 **I7. Legibilidad sobre peso.** Las capturas son tableros con texto y
  cifras. Si un archivo no baja de 250 KB sin degradar su texto, se deja como
  está y se reporta. Un tablero ilegible es peor que un tablero pesado.
- 🔒 **I8. La fase 3 es de solo lectura.** Prohibido `git branch -d`,
  `git branch -D`, `git push --delete`, `git merge`, `git cherry-pick` y
  `git rebase` sobre cualquier rama `claude/*`.
- 🔒 **I9. Ningún contenido nuevo entra a `docs/`.** Ninguna fase agrega
  archivos ni texto a la carpeta publicada; si algún paso lo hiciera, es caso
  de detención (a).

---

## 4. Fases

Orden con criterio: las cuatro primeras son deterministas (su término se
verifica contra una regla o un conteo); la última es convergente (su criterio
final es visual y lo cierra el titular), por eso va al final.

### Fase 0 — Lectura del estado real (no modificar sin leer)

```bash
cd /Users/tomgc/Projects/slep_monitoreo ; git rev-parse --abbrev-ref HEAD ; git status --short ; git log --oneline -3 ; git stash list ; grep -n "_archivo" .gitignore || echo "AUSENTE _archivo EN .gitignore"
```

**Esperado:** rama `main`; `git status --short` lista `.gitignore`, los cuatro
archivos de `50_documentacion/estructura/`, `docs/app.js`, `docs/index.html`,
`docs/styles.css`, y el no trackeado `design_handoff_portafolio_pliego/`; stash
vacío; `_archivo` presente en `.gitignore`.

**Si `_archivo` está ausente:** detención por 🔒 I5.
**Si la rama no es `main` o el stash no está vacío:** detención por (b).

### Fase 1 — Commits pendientes (determinista)

Dos cambios conceptuales, dos commits.

```bash
cd /Users/tomgc/Projects/slep_monitoreo && git add .gitignore && git commit -m "chore(gitignore): blinda traspasos/** para cubrir el archivado"
```

```bash
cd /Users/tomgc/Projects/slep_monitoreo && git add docs/app.js docs/styles.css docs/index.html && git commit -m "feat(portafolio): pliego de capturas con altura normalizada y ancho natural"
```

**Verificación (va entre la generación y el avance, y lo condiciona):**

```bash
cd /Users/tomgc/Projects/slep_monitoreo ; node --check docs/app.js ; echo "check=$?" ; git log --oneline -2 ; git status --short
```

**Criterio de término:** `check=0`; `git log` muestra los dos commits nuevos;
`git status --short` ya NO lista `.gitignore` ni nada bajo `docs/`, y sí sigue
listando los cuatro de `50_documentacion/estructura/` (🔒 I4). Si difiere,
detente y reporta.

### Fase 2 — Archivar el handoff de diseño (determinista)

`design_handoff_portafolio_pliego/` ya fue consumido: el pliego está
implementado. Contiene 67,5 KB de runtime de Claude Design (`support.js`), seis
`.otf` que duplican `docs/fonts/` y cuatro `.dc.html` con espacios y paréntesis
en el nombre, fuera de la norma de nombres de `POLITICA_PROYECTO.md` §2. No se
versiona: se archiva.

```bash
cd /Users/tomgc/Projects/slep_monitoreo && mkdir -p _archivo/20260729 && mv design_handoff_portafolio_pliego _archivo/20260729/handoff_diseno
```

**Verificación:**

```bash
cd /Users/tomgc/Projects/slep_monitoreo ; ls _archivo/20260729/handoff_diseno/ | wc -l ; ls -d design_handoff_portafolio_pliego 2>&1 | head -1 ; git status --short
```

**Criterio de término:** el conteo es 11; la ruta original ya no existe;
`git status --short` no muestra `?? design_handoff_portafolio_pliego/`. No hay
commit en esta fase: el origen nunca estuvo trackeado y el destino está
ignorado.

### Fase 3 — Regenerar el inventario de estructura (determinista)

Las fases 1 y 2 cambiaron el árbol. El escáner debe reflejarlo, pero su salida
**no se commitea** en este encargo (🔒 I4): el commit del escáner lo hará el
titular junto con el cierre de la sesión.

```bash
cd /Users/tomgc/Projects/slep_monitoreo && Rscript 00_escanear_proyecto.R
```

```bash
cd /Users/tomgc/Projects/slep_monitoreo ; head -8 50_documentacion/estructura/estructura_actual.md ; git status --short 50_documentacion/estructura
```

**Criterio de término:** el encabezado declara un total de carpetas y archivos
menor que antes de la fase 2 (el handoff salió del árbol escaneado); los cuatro
archivos aparecen como `M` sin indexar.

### Fase 4 — Inventario de las ramas remotas `claude/*` (solo lectura)

El repositorio tiene cinco ramas remotas que ninguna sesión documentada
explica. Esta fase **describe**, no decide. Rige 🔒 I8.

```bash
cd /Users/tomgc/Projects/slep_monitoreo && git fetch --all --prune
```

```bash
cd /Users/tomgc/Projects/slep_monitoreo ; for b in $(git branch -r | grep 'origin/claude/' | tr -d ' '); do echo "=========== $b"; git log -1 --format='%h %ad %s' --date=short "$b"; echo "-- commits fuera de main:"; git rev-list --count main.."$b"; echo "-- archivos que tocaria:"; git diff --stat main..."$b" | tail -12; done
```

**Criterio de término:** una ficha por cada rama `claude/*`, con último commit
fechado, número de commits fuera de `main` y lista de archivos. Para cada una,
dictamina en el reporte si los archivos pertenecen a `slep_monitoreo` o a otro
proyecto (dos de los nombres sugieren un organigrama y una colección de
películas, ajenos a este repositorio). **No propongas borrar nada:** es un gate
del titular para la sesión 10.

### Fase 5 — Optimizar las 26 capturas (convergente)

**Meta verificable:** ningún archivo de `docs/assets/proyectos/` sobre 250 KB y
total de la carpeta bajo 4 MB, sin pérdida visible de legibilidad del texto de
los tableros. Rigen 🔒 I6 y 🔒 I7.

#### 5.1 Verificar herramientas (no asumir el entorno)

```bash
which oxipng pngquant sips ; oxipng --version 2>/dev/null ; pngquant --version 2>/dev/null ; true
```

Prelación: `oxipng` (sin pérdida) primero; `pngquant` (paleta, con pérdida
controlada) solo sobre lo que siga excedido; `sips` como respaldo, de ganancia
menor. **Si no existe ninguna de las tres:** detente y reporta, sugiriendo
`brew install oxipng pngquant`. No instales nada sin autorización.

#### 5.2 Respaldar los originales (obligatorio, antes de tocar nada)

```bash
cd /Users/tomgc/Projects/slep_monitoreo && mkdir -p _archivo/20260729/capturas_originales && cp docs/assets/proyectos/*.png _archivo/20260729/capturas_originales/
```

```bash
cd /Users/tomgc/Projects/slep_monitoreo ; ls _archivo/20260729/capturas_originales/*.png | wc -l ; du -sh _archivo/20260729/capturas_originales
```

**Criterio:** 26 archivos. Si difiere, detente: sin respaldo íntegro no se
optimiza (🔒 I1).

#### 5.3 Medición previa y registro de dimensiones

```bash
cd /Users/tomgc/Projects/slep_monitoreo/docs/assets/proyectos ; for f in *.png; do printf "%s\t%s\n" "$(du -k "$f" | cut -f1)" "$f"; done | sort -rn ; du -sh .
```

```bash
cd /Users/tomgc/Projects/slep_monitoreo/docs/assets/proyectos ; sips -g pixelWidth -g pixelHeight *.png > /tmp/dim_antes.txt 2>/dev/null ; wc -l /tmp/dim_antes.txt
```

#### 5.4 Pasada sin pérdida

```bash
cd /Users/tomgc/Projects/slep_monitoreo/docs/assets/proyectos && oxipng -o 4 --strip safe *.png
```

Repite la medición de 5.3. **Si ya ningún archivo supera 250 KB, salta 5.5.**

#### 5.5 Pasada con pérdida, solo sobre los excedidos

```bash
cd /Users/tomgc/Projects/slep_monitoreo/docs/assets/proyectos ; for f in *.png; do k=$(du -k "$f" | cut -f1); if [ "$k" -gt 250 ]; then pngquant --quality=70-92 --speed 1 --force --ext .png "$f"; fi; done ; true
```

Repite la medición. **Si tras esta pasada algún archivo sigue sobre 250 KB, no
insistas bajando el rango de calidad** (🔒 I7): déjalo y lístalo en el reporte.

#### 5.6 Verificación de integridad

```bash
cd /Users/tomgc/Projects/slep_monitoreo/docs/assets/proyectos ; ls *.png | wc -l ; sips -g pixelWidth -g pixelHeight *.png > /tmp/dim_despues.txt 2>/dev/null ; diff /tmp/dim_antes.txt /tmp/dim_despues.txt && echo "DIMENSIONES IDENTICAS" ; cd /Users/tomgc/Projects/slep_monitoreo ; git status --short docs/assets/proyectos
```

**Criterio de término:** 26 archivos; el `diff` sale vacío (🔒 I6);
`git status --short` muestra solo `M` bajo `docs/assets/proyectos/`, ningún `D`
ni `??`. Si el `diff` no sale vacío, restaura desde
`_archivo/20260729/capturas_originales/` y reporta.

#### 5.7 NO commitear (gate del titular)

Esta fase **no commitea**. El titular revisa las capturas en el navegador antes
de aceptarlas. Deja el árbol con las modificaciones sin indexar y consigna en
el reporte el comando de restauración:

```bash
cd /Users/tomgc/Projects/slep_monitoreo && cp _archivo/20260729/capturas_originales/*.png docs/assets/proyectos/
```

---

## 5. Criterios de éxito, por fase

| Fase | Condición de término comprobable |
|---|---|
| 0 | `_archivo` en `.gitignore`; rama `main`; stash vacío |
| 1 | dos commits nuevos; `node --check docs/app.js` = 0; `git status` sin `.gitignore` ni `docs/` |
| 2 | 11 archivos en `_archivo/20260729/handoff_diseno/`; ruta original inexistente; sin `??` |
| 3 | encabezado del escáner con totales menores; cuatro `M` sin indexar |
| 4 | una ficha por rama `claude/*` con dictamen de pertenencia; cero comandos destructivos |
| 5 | 26 PNG; `diff` de dimensiones vacío; carpeta bajo 4 MB o lista explícita de excepciones; sin commitear |

---

## 6. Auto-auditoría antes de reportar

Antes de escribir el log, **re-deriva de forma independiente** las tres
afirmaciones de mayor riesgo, con comandos distintos a los que usaste para
producir el resultado (un check escrito por el mismo flujo que hizo el cambio
hereda sus puntos ciegos):

1. **Que las dimensiones no cambiaron.** No reutilices `/tmp/dim_antes.txt`:
   recalcula las dimensiones de los originales desde
   `_archivo/20260729/capturas_originales/` y compáralas contra
   `docs/assets/proyectos/`, archivo por archivo.
2. **Que las 26 capturas siguen siendo las mismas 26.** Compara los nombres de
   ambas carpetas con `diff <(ls ...) <(ls ...)`.
3. **Que nada se escribió dentro de `docs/` fuera de las capturas y de los tres
   archivos de la fase 1.** Verifícalo con `git status --short docs/` y
   `git show --stat` de los commits creados (🔒 I9).

Toda cifra que reportes debe recontarse programáticamente en ese momento. No
derives ningún número de memoria ni por aritmética manual.

---

## 7. Log de cierre

Al terminar, escribe el log en:

```
/Users/tomgc/Projects/slep_monitoreo/50_documentacion/andamios/logs/20260729_cierre_operativo_log.md
```

Crea el directorio si no existe. Sigue la plantilla fija de
`encargo_autonomo_claude_code_v1.md` §4, con sus diez apartados. Sé honesto:
incluye lo que costó, los comandos que fallaron y las aserciones que no se
cumplieron, no solo los éxitos. El apartado 6 (verificación de invariantes)
debe listar los nueve 🔒 de la sección 3, cada uno con PASA/FALLA y su
evidencia.

**El log NO se commitea.** Queda para revisión previa del titular.

---

## 8. Reporte final al chat

Devuelve al chat, en este orden:

1. Hashes cortos y títulos de los commits creados.
2. Salida de `git status --short` al terminar.
3. Tabla de capturas: archivo, KB antes, KB después, porcentaje; totales antes
   y después; lista de los que siguen sobre 250 KB.
4. Resultado literal de los tres checks adversariales de la sección 6.
5. Tabla del inventario de ramas `claude/*` con el dictamen de pertenencia.
6. Desviaciones: todo comando que falló, toda aserción incumplida, toda
   decisión que este encargo no anticipaba. Si no hubo ninguna, decláralo
   explícitamente.
7. Ruta del log.
