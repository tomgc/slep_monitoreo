# Traspaso de cierre — slep_monitoreo — v08

## 1. Identificación

- **Proyecto:** slep_monitoreo (sitio institucional estático del Área de Monitoreo del SLEP Costa Central).
- **Versión de traspaso:** v08.
- **Fecha:** 2026-07-29.
- **Sesión:** 8. Foco: construir la entrada del proyecto de minutas Simce 2025 en `data.js` (prioridad 1 heredada de v07) y encargar el rediseño del portafolio. Cierre anticipado por detección de una sesión paralela escribiendo en el mismo repositorio.
- **Modelo:** Claude Opus 5 (cambio respecto de las sesiones 1-7, que registran Claude Opus 4.8).
- **Entorno:** desarrollo en Claude (chat) como asistente de Claude Code; ejecución en disco y Git por Claude Code en `/Users/tomgc/Projects/slep_monitoreo/`. GitHub Pages.
- **Archivos principales modificados:** `data.js`, `50_documentacion/activa/ESTADO.md`, `50_documentacion/activa/backlog_acumulativo.md`, `50_documentacion/activa/encargo_diseno_portafolio.md` (nuevo).

> **Advertencia de versión de protocolo.** Esta sesión operó con
> `POLITICA_PROYECTO.md` v5.2 y `SETTINGS_Y_PROMPTS_OPERACIONALES.md` v7,
> las versiones presentes en la knowledge base del Project. Durante la
> sesión, una sesión paralela commiteó `POLITICA_PROYECTO.md` v5.5 y
> `SETTINGS_Y_PROMPTS_OPERACIONALES.md` v14 (commit `1c9c2bc`). Este
> traspaso está redactado según v5.2 / v7 y puede no cumplir requisitos
> introducidos en las versiones nuevas. **Acción obligatoria antes de la
> sesión 9:** actualizar la knowledge base del Project con v5.5 y v14, y
> revisar este documento contra ellas.

## 2. Resumen ejecutivo

La sesión cumplió la prioridad 1 heredada de v07: se construyó la entrada del proyecto de minutas Simce 2025 a partir de los tres PDF aportados por el usuario, se insertó en `data.js` como `orden: 3` (agrupada con los motores Simce, renumerando los proyectos posteriores) y se desplegó verificada en producción. En el camino se hizo higiene de Git: se absorbió la rama huérfana `gobernanza/v14` en `main` mediante avance rápido, se commiteó el registro documental del cierre de v07 (backlog 47-53 y `ESTADO.md`) que había quedado sin versionar, y se subieron cuatro commits acumulados desde el 30 de junio. El rediseño del portafolio para dar protagonismo a las imágenes se delegó a Claude Design mediante un encargo escrito, y quedó a la espera del handoff. Al intentar la optimización de las 26 capturas, el comando falló porque `assets/proyectos` no existe en la raíz: el sitio se había movido a `docs/`. La investigación reveló una sesión paralela de Claude Code trabajando sobre el mismo repositorio en tiempo real (commits a las 10:30, 11:29, 11:48, 11:50 y 11:51), que reorganizó el sitio, corrigió el workflow de Pages, fusionó dos PR y actualizó los documentos de gobernanza. Se cerró la sesión sin intentar reconciliar ese estado. La sesión acumuló cinco errores del asistente, documentados en §15.

## 3. Estado al cierre

- **Qué funciona:** el sitio en producción (`https://tomgc.github.io/slep_monitoreo/`) con 12 proyectos, incluido el nuevo proyecto Simce en `orden: 3`. Verificado el 2026-07-29 por `curl` contra `data.js` en producción y por `gh run list` (workflow de Pages en verde).
- **Qué no funciona:** nada roto reportado. Riesgo latente resuelto por la sesión paralela: el workflow publicaba el repositorio completo (`path: '.'`) y el sitio se movió a `docs/`; el commit `443bfbf` ("publica solo docs/, no el repositorio completo") corrige esa combinación.
- **Estado de Git al cierre (fuente: `git reflog` y `git rev-parse` del 2026-07-29 11:43):**
  - `HEAD` → `1c9c2bc`, en la rama `gobernanza/v14` (de la sesión paralela, no de esta).
  - `main` local → `70a4503` (nuestros commits), **atrasada** respecto de `origin/main`.
  - `origin/main` → `4c54c43` (merge del PR #5).
  - Ramas vivas: `main`, `gobernanza/v14`, `chore/pages-docs`, `chore/pages-workflow`, con sus contrapartes en `origin`.
  - Árbol de trabajo con el sitio en `docs/` y cambios sin commitear.
- **Delta respecto a v07:** +1 proyecto en el portafolio (Simce, sin capturas); +1 encargo de diseño; registro documental de v07 versionado; rama huérfana `gobernanza/v14` (la original, del 30 de junio) absorbida y borrada; estructura del repositorio reorganizada por una sesión paralela.

## 4. Registro detallado de cambios

| # | Commit / artefacto | Cambio | Categoría |
|---|---|---|---|
| 54 | `ed884ce` | Entrada del proyecto de minutas Simce 2025 en `data.js`, `orden: 3` | Estructura de contenido |
| 55 | `70a4503` | Registro documental del cierre de v07 versionado (backlog 47-53 y `ESTADO.md`) | Reproducibilidad y tooling |
| 56 | `encargo_diseno_portafolio.md` | Encargo escrito del rediseño del portafolio, delegado a Claude Design | Por confirmar (ver §5) |
| 57 | (sin ejecutar) | Pendiente registrado: repositorio interno de documentación y código del Área | Por confirmar (ver §5) |
| 58 | (sin ejecutar) | Pendiente registrado: optimización de capturas, intentada y abortada | Reproducibilidad y tooling |

Detalle de la entrada 54: la reseña se redactó a partir de los tres PDF (`Minuta_n_1`, `Minuta_n_2`, `Minuta_n_3`), con `tipo: "Minuta · Resultados Simce"`, un `objetivo` y cinco párrafos de `sintesis` (uno de contexto, uno por minuta y uno de cierre). `imgs: []`, es decir, el proyecto se publica con el marcador "Próximamente". Ningún nombre de establecimiento educacional ni RBD entró a `data.js`. La inserción en `orden: 3` renumeró los proyectos 3-11 a 4-12 preservando su orden relativo; la renumeración se hizo programáticamente y se validó con `node --check`.

Detalle de la entrada 55: los cambios en `ESTADO.md` (destilación de v07) y en `backlog_acumulativo.md` (entradas 47-53) existían en el árbol de trabajo sin commitear desde el cierre de la sesión 7. Se agruparon en un commit porque son un mismo cambio conceptual: documentar el cierre de v07.

## 5. Backlog acumulativo

**El bloque de la sesión 8 NO se fusionó en `50_documentacion/activa/backlog_acumulativo.md`.** Razón: el archivo creció de 20,1 KB a 26,5 KB durante esta sesión (fuente: escáner de v07 y escáner del 2026-07-29 12:06:38), lo que indica que la sesión paralela escribió en él. Fusionar a ciegas arriesgaba colisión de numeración correlativa, que la política declara permanente y no renumerable.

**Acción obligatoria en la apertura de la sesión 9:** leer `backlog_acumulativo.md` completo, verificar cuál es la última entrada numerada realmente existente, y recién entonces incorporar las entradas de abajo con la numeración que corresponda. Los números 54-58 son provisionales.

### Sesión 8 (Claude Opus 5) — 2026-07-29

Foco: construir la entrada del proyecto de minutas Simce 2025 (prioridad 1 heredada de v07) y encargar el rediseño del portafolio. Cierre anticipado por sesión paralela sobre el mismo repositorio.

54. **Entrada del proyecto de minutas Simce 2025** (`ed884ce`). Solicitud: construir el proyecto en `data.js` a partir de tres PDF (uno por ámbito: variación de puntajes, Estándares de Aprendizaje, IDPS). Se redactó `tipo`, `titulo`, `objetivo` y cinco párrafos de `sintesis` a partir del contenido de las minutas, respetando la terminología institucional ("establecimiento educacional" completo en la primera mención de cada párrafo). Se insertó como `orden: 3` para agruparlo con los tres motores Simce/IDPS/Categorías, renumerando programáticamente los proyectos 3-11 a 4-12 sin alterar su orden relativo. `estado: "vigente"` con `imgs: []`, a la espera de la decisión de gobernanza sobre las capturas. Validado con `node --check` y verificado en producción por `curl`. Categoría: Estructura de contenido.

55. **Registro documental del cierre de v07 versionado** (`70a4503`). Deuda heredada detectada al abrir: `ESTADO.md` (destilado de v07) y `backlog_acumulativo.md` (entradas 47-53) llevaban desde el 27 de julio modificados en el árbol de trabajo sin commitear. Se agruparon en un commit por ser un mismo cambio conceptual. En la misma pasada se absorbió por avance rápido la rama `gobernanza/v14` original (creada el 30 de junio, sin trabajo propio, donde había caído por error el commit del Simce) y se borró, y se subieron los cuatro commits acumulados desde el 30 de junio a `origin/main`. Categoría: Reproducibilidad y tooling.

56. **Encargo escrito del rediseño del portafolio** (`50_documentacion/activa/encargo_diseno_portafolio.md`). Solicitud: dar más protagonismo a las imágenes del portafolio y recorrer los proyectos uno por uno, en vez de una lista de solo texto. Se presentaron tres direcciones (carrusel de proyectos, grilla de mosaicos, banner invertido) con recomendación por el carrusel. El usuario optó por delegar la ejecución a Claude Design, de modo que el producto de esta sesión es el encargo, no el rediseño: contexto del sitio y audiencia, problema a resolver, dirección preferida y alternativas, datos del contenido (12 proyectos, 3 sin capturas, títulos largos, proporciones variables), restricciones técnicas (sin dependencias, tipografías locales, móvil, accesibilidad de teclado), qué queda fuera (lightbox y visor full-res) y entregable esperado. Categoría: por confirmar contra el catálogo de §3 del backlog; no se inventó una categoría nueva.

57. **Pendiente registrado: repositorio interno del Área** (sin ejecutar). Solicitud del usuario: una segunda salida consistente en un repositorio con documentación completa, scripts y todo lo necesario para que los profesionales del equipo de monitoreo puedan retomar cualquier proyecto del Área y seguir desarrollándolo. Se registró con la observación de que por alcance (todos los proyectos del Área), por gobernanza (contendría scripts que tocan datos de estudiantes, luego repositorio privado y rama B de POLITICA §8.3) y por ciclo de vida propio, no es una salida de `slep_monitoreo` sino un proyecto hermano que requiere sesión NEW PROJECT. Categoría: por confirmar contra el catálogo de §3 del backlog.

58. **Pendiente registrado: optimización de las 26 capturas, intentada y abortada** (sin ejecutar). Se preparó una pasada de recompresión PNG sin pérdida con `oxipng --opt max --strip safe --preserve`, como primer paso reversible antes de evaluar WebP. El comando falló al no encontrar `assets/proyectos`: el sitio había sido movido a `docs/` por la sesión paralela y el escáner con el que se trabajaba estaba desactualizado. Además `oxipng` no está instalado en la máquina. Pendiente vigente, ahora sobre `docs/assets/proyectos/`. Categoría: Reproducibilidad y tooling.

**Delta del backlog (sesión 8):** 5 entradas provisionales (54-58, numeración a confirmar), sin reescritura ni renumeración de las anteriores. Dos de ellas (57, 58) son pendientes registrados sin ejecutar, siguiendo el precedente de la entrada 46. Dos categorías quedan por confirmar contra el catálogo completo de §3, que no se tuvo a la vista en esta sesión. El resumen estadístico y la tabla §3 no se actualizaron por la misma razón de §5.

## 6. Bugs de la sesión

Ningún bug de código. Los cinco incidentes de la sesión fueron errores del asistente, registrados en §15.

## 7. Aprendizajes y restricciones descubiertas

- **Un escáner adjunto no es prueba del estado actual; el árbol de trabajo puede tener una versión más vieja que la commiteada.** El `estructura_actual.md` adjuntado en la apertura describía la estructura plana previa a `docs/`. Regla: en la apertura, contrastar el escáner adjunto contra `git ls-files` o `ls` antes de declarar la estructura conforme. Contexto: sin ese contraste, toda ruta que el asistente construya es ficción, como ocurrió con `assets/proyectos`.
- **Archivos del escáner modificados no son ruido inocuo.** El traspaso v07 los declara "ruido permanente" y hay que dejarlos fuera del staging, pero un escáner re-corrido sobre una estructura sin cambios no produce diferencias de contenido. Regla: un diff en `50_documentacion/estructura/` significa que la estructura cambió; leerlo antes de ignorarlo. Contexto: la señal estuvo visible desde el primer `git status` de la sesión y se descartó por cuatro horas.
- **Las puntas de rama no dicen qué commits existen.** `git branch -vv` muestra dónde apunta cada rama, no qué es alcanzable desde ella. Regla: para afirmar que un commit no existe, usar `git branch -a --contains <sha>` o `git log --all`, nunca inferirlo de la punta.
- **Los bloques para Claude Code se pegan en una shell interactiva.** En zsh, `interactive_comments` está apagada por defecto y las líneas con `#` producen `command not found`. Regla: sin comentarios `#` dentro del bloque; las explicaciones van en la prosa del mensaje, fuera del bloque.
- **Un repositorio puede tener más de un agente escribiendo a la vez.** Regla: si aparecen commits, ramas o archivos que ninguna acción de la sesión explica, detenerse y verificar `git reflog --date=iso` antes de seguir operando.

## 8. Decisiones de diseño

- **Proyecto Simce en `orden: 3` con renumeración**, sobre agregarlo al final como `orden: 10`. Elegido por el asistente de forma autónoma y reportado. Justificación: agrupa la minuta con los tres motores Simce/IDPS/Categorías y la renumeración es mecánica en un archivo que se entrega completo. Tensión declarada: B.3 (cambios quirúrgicos) contra coherencia temática del portafolio; se resolvió a favor de la coherencia porque la renumeración preserva el orden relativo de todos los proyectos.
- **`tipo: "Minuta · Resultados Simce"`**, sobre reutilizar `"Minuta · Dirección Ejecutiva"`. Justificación: los tipos existentes declaran audiencia y las minutas Simce no la explicitan en el documento; se prefirió describir el contenido antes que inventar el destinatario. Marcado como revisable por el usuario.
- **Delegar el rediseño a Claude Design mediante un encargo escrito**, sobre ejecutarlo en esta sesión. Decisión del usuario. Implicancia: el rediseño llega como handoff externo y habrá que integrarlo contra el `docs/` reorganizado, no contra la estructura plana.
- **Cerrar la sesión sin reconciliar el estado de Git.** Decisión del asistente, aceptada por el usuario. Alternativa descartada: sincronizar `main` con `origin/main` y rebasar. Justificación: la sesión paralela seguía escribiendo (último commit a las 11:51, doce minutos antes del cierre); operar sobre un blanco móvil arriesga perder trabajo ajeno.

## 9. Constantes y parámetros vigentes

| Constante | Valor | Archivo | Nota |
|---|---|---|---|
| Raíz publicada por Pages | `docs/` | `.github/workflows/static.yml` | cambio de esta jornada (`443bfbf`), antes el repositorio completo |
| Proyectos en el portafolio | 12 (10 vigentes, 2 en desarrollo) | `docs/data.js` | antes 11 |
| Proyectos sin capturas | 3 (Simce, y los 2 en desarrollo) | `docs/data.js` | el marcador dejó de ser caso marginal |
| `orden` del proyecto Simce | 3 | `docs/data.js` | renumeró 3-11 a 4-12 |
| Capturas de proyectos | 26 PNG, ~9 MB | `docs/assets/proyectos/` | ruta cambiada desde `assets/proyectos/` |

## 10. Arquitectura de archivos

Cambio estructural mayor, **no ejecutado por esta sesión**: el sitio se movió de la raíz a `docs/` (commit `00a1af3`, 2026-07-29 10:30) y el workflow de Pages se ajustó para publicar solo esa carpeta (`443bfbf`). Escáner al cierre: `50_documentacion/estructura/estructura_actual.md`, generado 2026-07-29 12:06:38, 10 carpetas y 66 archivos. El escáner al cierre confirma además que `traspaso_cierre_v07.md` ya está en `50_documentacion/traspasos/` (12,0 KB), lo que cierra el hueco documental detectado durante la sesión.

## 11. Pendientes y ruta sugerida

**Inventario:**

1. **Reconciliar el estado de Git y del protocolo.** `main` local está atrás de `origin/main`; `HEAD` quedó en `gobernanza/v14`; hay cambios sin commitear; existen cuatro ramas vivas. **Tipo:** deuda técnica. **Impacto:** bloqueante para cualquier trabajo en disco. **Dependencia:** saber si la sesión paralela terminó. **Complejidad:** Baja si la sesión paralela cerró, Media si sigue abierta. **Criterio de éxito:** una sola rama de trabajo, `main` sincronizada con `origin/main`, árbol limpio salvo el escáner.
2. **Actualizar la knowledge base del Project** con `POLITICA_PROYECTO.md` v5.5 y `SETTINGS_Y_PROMPTS_OPERACIONALES.md` v14, y revisar este traspaso contra ellas. **Tipo:** documentación. **Impacto:** alto (el protocolo es contrato). **Complejidad:** Baja, tarea del usuario.
3. **Fusionar el bloque de backlog de la sesión 8** en `backlog_acumulativo.md` con la numeración correcta, tras leer el archivo actual. **Tipo:** documentación. **Complejidad:** Baja.
4. **Integrar el handoff de Claude Design** (rediseño del portafolio). **Tipo:** mejora visual. **Dependencia:** el handoff, bloqueante. **Complejidad:** Media-Alta. **Precaución:** integrarlo contra `docs/`, no contra la estructura plana. **Criterio de éxito:** portafolio rediseñado, sin dependencias externas, con la tarjeta sin captura resuelta y verificado en móvil.
5. **Capturas del proyecto Simce.** Compuerta de gobernanza abierta desde la apertura de esta sesión: las tres minutas nombran establecimientos educacionales con RBD y comuna, y el sitio es público; POLITICA §6.4 recoge la condición contractual de la Agencia de Calidad de no identificar establecimientos por nombre en ningún output. Opciones planteadas: solo portada y páginas metodológicas; tablas con nombre y RBD difuminados; sin capturas. Recomendación entregada: la primera. **Tipo:** gobernanza y contenido. **Dependencia:** decisión del usuario y, preferentemente, el rediseño ya integrado. **Complejidad:** Baja.
6. **Optimización de las 26 capturas** (~9 MB; `parvularia-1.png` 703,6 KB), ahora en `docs/assets/proyectos/`. Primer paso reversible: recompresión sin pérdida con `oxipng` (requiere `brew install oxipng`). Solo si el ahorro es insuficiente, evaluar WebP, que exige `git mv` más reescritura de rutas en `data.js` en commit aparte. **Tipo:** deuda técnica. **Complejidad:** Baja-Media. **Criterio de éxito:** payload reducido, portafolio idéntico visualmente, cero 404.
7. **Repositorio interno de documentación y código del Área.** **Tipo:** proyecto hermano, no pendiente de este proyecto. **Complejidad:** Alta. **Precaución:** rama B de POLITICA §8.3 (repositorio privado, dos raíces), porque contendría scripts que tocan datos de estudiantes. **Sugerencia:** sesión NEW PROJECT dedicada.

**Evaluación de deuda técnica:** la zona frágil de esta jornada no fue el código sino la coordinación. Dos agentes escribieron sobre el mismo repositorio sin saberlo, y el mecanismo que debía prevenirlo (el escáner como fuente de verdad de la estructura) falló porque el artefacto adjunto era más viejo que el commiteado. Conviene que la sesión 9 evalúe si el protocolo de apertura debe incluir una verificación de estado de Git, y no solo del árbol de archivos.

**Auditoría de cierre (POLITICA 5.6, preguntas "Cierre"):**
- ¿Nombres de archivos y carpetas sin tildes, ñ ni espacios? Sí.
- ¿Outputs reproducibles e idempotentes? N/A (sitio estático sin pipeline de datos).
- ¿Decisiones metodológicas como constantes nombradas? N/A.
- El resto de preguntas "Cierre" aplican a proyectos con pipeline R.
- Deuda nueva detectada: los pendientes 1, 2 y 3 de §11 nacen de esta auditoría.

**Ruta sugerida para la sesión 9:** prioridad 1, pendiente 1 (reconciliar Git), porque nada más es ejecutable con seguridad hasta que el repositorio tenga un solo estado conocido. Prioridad 2, pendientes 2 y 3 (protocolo y backlog al día). Prioridad 3, según lo que haya llegado: si el handoff de diseño está, el pendiente 4; si no, el pendiente 6. Diferir: pendiente 5 hasta tener el rediseño, y pendiente 7 a sesión propia.

## 12. Instrucciones específicas para la próxima sesión

- ⚠️ NO ejecutar ningún comando de escritura hasta confirmar que la sesión paralela terminó y que `HEAD`, `main` y `origin/main` están en un estado conocido.
- ⚠️ NO fusionar el bloque de backlog de §5 sin leer antes `backlog_acumulativo.md` completo: la numeración 54-58 es provisional.
- ⚠️ NO commitear los archivos de `50_documentacion/estructura/`; staging siempre selectivo, nunca `git add -A`.
- ⚠️ NO ejecutar `git push` sin aprobación explícita del usuario.
- ✅ ANTES de declarar la estructura conforme en la apertura, contrastar el escáner adjunto contra `git ls-files` o `ls -la` de la raíz.
- ✅ ANTES de ignorar un diff en `50_documentacion/estructura/`, leerlo: significa que la estructura cambió.
- ✅ ANTES de afirmar cualquier estado del repositorio, verificarlo con un comando de esta sesión y declarar la fuente.
- ✅ ANTES de escribir un bloque para Claude Code, verificar que no contenga comentarios `#`.
- ✅ ANTES de entregar un archivo, llamar a la herramienta que lo hace visible al usuario; escribirlo en disco no es entregarlo.
- 🔒 El sitio se publica desde `docs/`. Toda ruta de `data.js`, `app.js`, `index.html`, `styles.css`, `colors_and_type.css` y `assets/` lleva ese prefijo.
- 🔒 Reemplazar archivos a mano es tarea del usuario (POLITICA §0.4); a Claude Code se le encargan comandos, no reemplazos manuales.
- 🔒 La revisión de datos identificables en capturas y `data.js` es responsabilidad del usuario (gobernanza); Claude no ve el contenido de las capturas.

## 13. Fragmentos de código de referencia

Renumeración programática del campo `orden` tras insertar un proyecto, preservando el orden relativo (la forma correcta en este proyecto; se ejecutó sobre el archivo completo, nunca por fragmentos):

```python
import re
src = open('data.js').read()
n = 0
def rep(m):
    global n
    n += 1
    return "orden: %d," % n
ini = src.index("const PROYECTOS")
fin = src.index("\n];", ini)
head, body, tail = src[:ini], src[ini:fin], src[fin:]
body = re.sub(r"orden: \d+,", rep, body)
open('data.js', 'w').write(head + body + tail)
```

Verificación de existencia real de un commit en cualquier rama, en vez de inferirlo de las puntas:

```
git branch -a --contains <sha>
git log --all --oneline -12
```

## 14. Reapertura

- **Nombre del chat:** `slep_monitoreo, sesión 9 (Claude Opus 5)`.
- **Mensaje de apertura pre-armado:** "Tipo CONTINUATION. El protocolo (POLITICA_PROYECTO.md + SETTINGS_Y_PROMPTS_OPERACIONALES.md) vive en la knowledge base del Project y se lee desde ahí; verifica que estén en v5.5 y v14 antes de empezar. Adjunto el traspaso v08 y el escáner recién corrido. La sesión 8 cerró con el repositorio en estado inconsistente por una sesión paralela: la prioridad 1 es reconciliarlo."
- **Documentos para la próxima sesión:**
  1. *Protocolo en knowledge base (NO adjuntar, solo verificar que estén al día):* `POLITICA_PROYECTO.md` v5.5, `SETTINGS_Y_PROMPTS_OPERACIONALES.md` v14.
  2. *Opcionales según foco:* `CLAUDE.md` si se corre en Claude Code; `docs/styles.css` y `docs/colors_and_type.css` si llega el handoff de diseño; `encargo_diseno_portafolio.md` para contrastar el handoff contra lo pedido.
  3. *Específicos de la sesión (SÍ adjuntar):* `traspaso_cierre_v08.md`; `estructura_actual.md` recién corrido; `backlog_acumulativo.md` (imprescindible para fusionar el bloque de §5 con la numeración correcta); el handoff de Claude Design si llegó.
- **Nota final:** si algún archivo listado cambió entre sesiones, adjuntar la versión más actualizada y avisarlo en la apertura. En particular, `backlog_acumulativo.md` cambió durante la sesión 8 por acción de la sesión paralela.

## 15. Errores del asistente (POLITICA 0.5)

| momento | disparador | qué pasó | regla violada | causa raíz | salvaguarda presente | patrón |
|---|---|---|---|---|---|---|
| Entrega de la prioridad 1 | usuario lo corrigió ("¿me ibas a pasar un archivo?") | Se escribió `data.js` en disco y se dio la ruta de destino sin llamar a la herramienta que lo hace visible, dejando el artefacto inaccesible | `userPreferences`, materialización: el artefacto se entrega como archivo | Se dio por cumplida la materialización al escribir el archivo, sin verificar que el usuario pudiera verlo | `userPreferences` | nuevo |
| Mensaje a Claude Code de la prioridad 1 | usuario lo corrigió ("según la política yo reemplazo los archivos") | Se instruyó a Claude Code a reemplazar `data.js`, siendo tarea manual del usuario | POLITICA §0.4 (tareas mecánicas manuales) y `userPreferences`, autonomía | Se armó el mensaje como una secuencia de un extremo a otro sin separar qué paso ejecuta cada actor | POLITICA + `userPreferences` | nuevo |
| Diagnóstico de la rama `gobernanza/v14` | asistente lo señaló espontáneamente | Se afirmó que los seis commits de la sesión 7 no estaban en `main` ni en la rama, cuando eran la punta de `origin/main` | Traspaso v07 §12: verificar el estado del repositorio antes de afirmarlo | Se dedujo ausencia de las puntas de `git branch -vv`, que no informan qué commits son alcanzables; hipótesis presentada como hecho | Traspaso v07 §12 y `userPreferences` (marcador de fuente) | nuevo |
| Instrucción de push | usuario lo señaló sin nombrarlo error (los `command not found: #` en su salida) | Se incluyeron comentarios `#` en un bloque destinado a pegarse en zsh interactivo, que los rechaza | `userPreferences`, mensajes a Claude Code: bloque copiable y ejecutable tal cual | Se escribió el bloque como script, sin considerar que se pega en una shell interactiva con `interactive_comments` apagada | `userPreferences` y SETTINGS §2.3.6 | nuevo |
| Toda la sesión, desde el acuse de recibo hasta el intento de optimizar capturas | asistente lo señaló al fallar `du: assets/proyectos: No such file or directory` | Se operó sobre un escáner desactualizado que describe una estructura plana ya inexistente, y se declaró "estructura conforme al escáner" en la auditoría de apertura sin contrastarla con el repositorio | POLITICA §0.2 (no deducir rutas) y SETTINGS §1.2.2.2 (comparar el árbol del escáner con la estructura real y marcar desviaciones) | Se trataron los cuatro archivos de `estructura/` modificados como ruido permanente heredado del traspaso, cuando un escáner re-corrido sobre una estructura sin cambios no produce diferencias de contenido: el diff era la señal de que el mapa no calzaba | POLITICA §0.2, SETTINGS §1.2.2, traspaso v07 §12 | variante del tercer error de esta tabla: afirmar estado del repositorio sin verificarlo |

**Lectura del conjunto.** Tres de los cinco errores (el tercero, el cuarto y el quinto) comparten raíz: dar por conocido un estado que no se verificó en el momento, sea el del repositorio, el de la shell o el de la estructura de archivos. Las salvaguardas existentes ya cubren los tres casos por escrito. Para el análisis cruzado entre proyectos que POLITICA §0.5 persigue, la pregunta útil no es si la regla existe (existe), sino por qué el asistente considera "verificado" algo que solo leyó en un documento heredado. Si este patrón aparece en la tabla de errores de otro proyecto de la cartera, la salvaguarda a reformular es la definición de fuente válida, no el énfasis con que se repite la regla.
