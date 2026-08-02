# Traspaso de cierre v10 — slep_monitoreo

## 1. Identificación

| Campo | Valor |
|---|---|
| Proyecto | `slep_monitoreo` |
| Versión del traspaso | v10 |
| Fecha | 2026-07-30 |
| Sesión | 10 (Claude Opus 5) |
| Foco | Enlaces profundos por proyecto y construcción de la segunda página del sitio (formación en uso de datos educativos), con el contrato de ingesta y el validador del catálogo que la alimenta. Cierre de la deuda de gobernanza del repositorio: blindaje de andamios, respaldo y borrado de las cinco ramas `claude/*`. |
| Entorno | macOS · Git · GitHub Pages desde `main` y `docs/` · sitio estático HTML/CSS/JS sin build ni dependencias |
| Repositorio | `https://github.com/tomgc/slep_monitoreo.git` · rama `main` |
| Directorio local | `/Users/tomgc/Projects/slep_monitoreo/` |
| Protocolo vigente | `POLITICA_PROYECTO.md` v5.5 · `SETTINGS_Y_PROMPTS_OPERACIONALES.md` v15 · `encargo_autonomo_claude_code_v1.md` v1.1 |
| Modo de trabajo | Asistente-de-Claude-Code: el chat planifica, diagnostica y genera; Claude Code ejecuta en disco |
| Archivos principales modificados | `docs/data.js`, `docs/app.js`, `docs/index.html`, `docs/styles.css` |
| Archivos principales creados | `docs/formacion.html`, `docs/formacion.js`, `docs/formacion.css`, `docs/atlas_datos.js`, `00_validar_atlas.js`, `50_documentacion/activa/50_contrato_atlas_datos.md` |

## 2. Resumen ejecutivo

La sesión se abrió con la prioridad de commitear el cierre de la sesión 9 y descubrió que una sesión paralela ya lo había hecho: los cuatro commits existían y `main` estaba sincronizada, lo que convirtió el pendiente P1 en una verificación en lugar de un trabajo. Con eso liberado se ejecutó P3, el campo `id` en los doce proyectos de `data.js` más los enlaces profundos `#p=<id>`, enganchados por envoltura para no tocar el lightbox ni el visor a resolución completa, que son invariantes del handoff anterior. El titular corrigió entonces tres premisas que cambiaron el rumbo previsto: el sitio aún no está difundido, el atlas será un artefacto vivo alimentado por una revisión bibliográfica en curso, y no un entregable congelado a reconstruir desde el handoff. Eso reordenó el trabajo hacia producir primero el contrato de ingesta del catálogo, para que la sesión paralela escriba contra un esquema conocido, junto con un validador ejecutable que verifica forma e integridad referencial y devuelve 0 o 1. Sobre ese esquema se construyó la segunda página, `docs/formacion.html`, con una tabla filtrable de las 52 fuentes que lee el mismo archivo que consumirá el atlas, más una barra de navegación sticky compartida por ambas páginas. La sesión cerró la deuda de gobernanza pendiente desde la sesión 9: los andamios quedaron blindados hacia adelante, las cinco ramas `claude/*` se respaldaron como bundles con restauración verificada por comparación de SHA y luego se borraron del remoto, y los seis commits acumulados se pushearon a producción con autorización explícita. Queda pendiente el atlas propiamente tal, que ya tiene especificación auditada y fuente de datos definida, y la llegada del catálogo revisado que reemplazará al provisorio.

## 3. Estado al cierre

### Qué funciona

| Componente | Estado | Última verificación |
|---|---|---|
| Sitio en producción | Publicado desde `main` y `docs/` | push `450ea9f..952d89b` confirmado por Git |
| Enlaces profundos `#p=<id>` | Verificado por el titular en navegador | apertura directa, escritura al abrir, limpieza al cerrar, `id` inexistente inocuo |
| Página de formación | Verificada por el titular en navegador | filtros combinables, pregunta del ámbito, limpieza de filtros |
| Barra de navegación | Adherida y marcando página activa en ambas páginas | verificación visual del titular |
| Validador del catálogo | `node 00_validar_atlas.js docs/atlas_datos.js` → exit 0, 5 avisos | corrida de la sesión |
| Repositorio | Árbol limpio, `main` sincronizada en `0 0`, una sola rama remota | `git status --short` vacío |
| Respaldo de ramas | Cinco bundles verificados, restauración probada por SHA idéntico | `git bundle verify` ×5 más restauración end-to-end |

### Qué no funciona

Nada reportado como defecto activo al cierre. Los dos defectos de la sesión se corrigieron dentro de ella (ver §6).

### Delta respecto de v09

- El pendiente P1 de v09 resultó ya ejecutado por una sesión paralela; se verificó en lugar de ejecutarse.
- El sitio dejó de ser single-page: son dos páginas con navegación compartida.
- `data.js` tiene una llave estable por proyecto por primera vez; `orden` deja de ser el único identificador y sigue sin servir como llave de URL.
- El catálogo del atlas existe en el repositorio como `docs/atlas_datos.js`, en un esquema propio distinto del que entregó el handoff.
- Existe un contrato de ingesta y un validador ejecutable donde antes no había ninguno.
- `50_documentacion/andamios/**` quedó blindado; el remoto pasó de seis ramas a una.

## 4. Registro detallado de cambios

### 4.1 Verificación del cierre de la sesión 9

**Archivos:** ninguno. **Categoría:** Arquitectura del repositorio.

**Qué se hizo.** Se emitió un encargo de cinco fases para commitear el cierre de la sesión 9 y la fase 0 encontró el árbol limpio, `main` sincronizada y los cuatro commits ya existentes (`eccb9f4` capturas, `450ea9f` escáner, `f61b011` backlog y `ESTADO.md`, `a11d75e` portafolio).

**Por qué.** El traspaso v09 declaraba el cierre sin commitear y una sesión paralela lo ejecutó entre ambas sesiones. Es la tercera vez que ocurre en el proyecto (ver entrada 59 del backlog).

**Cómo se verificó.** `git status --short` vacío, `git rev-list --left-right --count @{u}...HEAD` en `0 0`, y verificación de que cada commit contuviera lo esperado (`eccb9f4` con 24 binarios modificados, 0 altas y 0 bajas).

**Hallazgo asociado.** El P1 de v09 pedía commitear el traspaso v09, que está gitignoreado desde la entrada 61. Lo commiteable del cierre nunca incluyó el traspaso; el pendiente estaba mal formulado en su origen.

### 4.2 Campo `id` y enlaces profundos `#p=<id>`

**Archivos:** `docs/data.js` (+17), `docs/app.js` (+75, 0 eliminadas). **Categoría:** Interacción y JS.

**Qué se hizo.** Se agregó el campo `id` a los doce proyectos de `data.js`, antes de `orden`, con un comentario de cabecera que lo documenta como llave de URL y prerrequisito de los códigos QR del catálogo impreso. En `app.js` se agregó el bloque `ENLACES PROFUNDOS (#p=<id>)`: lectura del hash al cargar, escritura al abrir una reseña, limpieza al cerrar, y escucha de `hashchange`.

**Por qué (C.11).** Compartir la reseña de un proyecto por correo era imposible; además el catálogo de Project Cards necesita una llave estable para sus QR, y `orden` no sirve porque se renumera al insertar proyectos (entrada 68 del backlog).

**Cómo se verificó (B.4).** `node --check` sobre ambos archivos; recuento programático de doce `id`; verificación de que los nueve slugs derivados coincidan exactamente con el prefijo de su primera captura; `diff` confirmando 0 líneas eliminadas en `app.js`. El titular verificó en navegador los cuatro casos: apertura directa por hash, escritura al abrir, limpieza al cerrar e `id` inexistente.

**Decisión de implementación.** El enganche es por **envoltura** de `openLightbox` y `closeLightbox`, no por edición de sus cuerpos, porque el lightbox y el visor full-res son invariantes 🔒 heredados del handoff de diseño. El diff del bloque LIGHTBOX es literalmente vacío.

**Trampa encontrada.** `$("#lbClose").addEventListener("click", closeLightbox)` había capturado la referencia original antes de la envoltura, así que el botón de cerrar no veía la versión envuelta y no limpiaba el hash. Se resolvió con `removeEventListener` sobre la referencia base más un re-registro que llama por nombre. Los demás disparadores (clic en el fondo, tecla Escape) ya llamaban por nombre y resolvían la envoltura solos.

**Slugs asignados.** Nueve derivados del nombre de archivo de sus capturas (`asistencia`, `resguardo`, `estandares`, `idps`, `categorias`, `parvularia`, `inicial`, `costapresente`, `ael`) y tres nuevos para los proyectos sin capturas (`simce`, `trayectorias`, `rendimiento`).

### 4.3 Blindaje de los andamios

**Archivos:** `.gitignore` (+1), destrackeo de dos archivos. **Categoría:** Arquitectura del repositorio.

**Qué se hizo.** Se agregó `50_documentacion/andamios/**` al `.gitignore` y se destrackearon con `git rm --cached -r` los dos andamios de la sesión 9.

**Por qué.** El commit `f61b011` de la sesión paralela los publicó, pese a que tanto la sección 7 del encargo como el propio log declaraban que el log no se commitea. Contienen rutas locales de la máquina del titular y el detalle de las ramas ajenas.

**Alternativas consideradas.** (A) dejarlos públicos y corregir la declaración contradictoria; (B) blindar hacia adelante; (C) reescribir historia con force push. Se eligió B por ser el mismo remedio aplicado en la entrada 60 a los documentos de protocolo, y porque C es desproporcionado para contenido que no es sensible en el sentido de la gobernanza de datos del proyecto.

**Alcance declarado.** El blindaje opera hacia adelante. `f61b011` ya está en `origin/main`, así que ambos archivos siguen siendo recuperables del historial público de GitHub.

**Cómo se verificó.** `git check-ignore -v` devolviendo la regla `.gitignore:19`; confirmación de que los dos archivos siguen en disco con su tamaño íntegro tras el `git rm --cached`; `git ls-files 50_documentacion/andamios` sin salida.

### 4.4 Auditoría del handoff `design_handoff_atlas_celeste`

**Archivos:** ninguno (producto de análisis). **Categoría:** Documentación.

**Qué se hizo.** Inventario del bundle (9 archivos, 396 KB), lectura íntegra del README, anatomía del prototipo y cuatro barridos de colisión contra el sitio.

**Por qué.** El aprendizaje 2 de la sesión 9 establece que un handoff de Claude Design necesita auditoría de integración y no lectura. La sesión 9 encontró seis trampas en el handoff anterior integrándolo a ciegas.

**Hallazgos.**

| Hallazgo | Evidencia |
|---|---|
| El prototipo no corre | `<script src="./support.js">` referenciado y ausente del bundle |
| Runtime propietario | 27 etiquetas `<sc-for>` / `<sc-if>`, 157 interpolaciones `{{expr}}`, `class Component extends DCLogic` |
| Cero reutilización de estilos | 0 tokens `var(--)`, 0 atributos `class`, 116 estilos inline con hex literales |
| Incompatibilidad de tema | fondo `#050A16` contra el tema claro de `colors_and_type.css` |
| Módulo ES | `atlas-data.js` con `export const`; el sitio carga scripts clásicos |
| Fuentes renombradas | 4 de 6 rutas no resuelven (`gobCL_Heavy` frente a `gobCL_900`) |
| Sin colisiones | 0 clases y 0 identificadores globales en común con el sitio |

**Dos afirmaciones del README desmentidas por el código.** Declara `tipo` como legado sin uso, y el prototipo lo consume en `capas()` con cinco valores en uso. Declara `url` del dato como opcional "si difiere de la base", y los 52 datos la omiten, de modo que `fichaUrl` (L567) cae siempre a la URL de la base y ningún enlace apunta al dato concreto.

**Lo aprovechable.** La lógica pura es portable tal cual: `buscar()`, `irSat()`, el zoom exponencial centrado en el cursor (`exp(-deltaY*0.0012)` con reposicionamiento del pan), el umbral de 5px que distingue arrastre de clic, y `capas()` para la geometría orbital.

### 4.5 Contrato de datos del atlas y validador

**Archivos:** `50_documentacion/activa/50_contrato_atlas_datos.md` (301 líneas), `00_validar_atlas.js` (267 líneas). **Categoría:** Reproducibilidad y tooling.

**Qué se hizo.** Se produjo el contrato de ingesta del catálogo, derivado de la inspección programática del archivo y no de la descripción del README, y un validador ejecutable que lo verifica.

**Por qué.** El titular declaró que una sesión paralela está produciendo el catálogo por revisión bibliográfica documental y que lo entregará como archivo. Sin contrato previo, ese archivo llegaría en un esquema arbitrario y habría que reescribir 52 fichas.

**Esquema definido.** Renombres de `planetas`/`satelites`/`estrellas` a `bases`/`datos`/`datos`; constantes `ATLAS_INSTITUCIONES`, `ATLAS_AMBITOS`, `ATLAS_FRASES`; eliminación del campo `tipo`; prohibición de `export` e `import`.

**Por qué el prefijo `ATLAS_`.** Las constantes conviven en el ámbito global con `PROYECTOS`, `HITOS` y `EQUIPO` de `data.js`. Un nombre genérico como `FRASES` es candidato seguro a colisionar con lo próximo que se agregue, y una redeclaración global produce `SyntaxError` que deja el sitio en blanco (misma trampa que la entrada 62 del backlog encontró con `estadoLabel`).

**Qué valida.** Forma de los campos, dominios cerrados, formato de identificadores, resolución de las rutas de tres segmentos, reciprocidad de relaciones, rangos y distancia mínima de posiciones, colisiones de color, y presencia de `export`/`import` antes de evaluar. Distingue errores que bloquean de avisos que no.

**Qué no valida, declarado en el propio contrato.** Que las URL resuelvan, que los años sean correctos, que las descripciones sean ciertas. La veracidad la revisa el titular.

**Por qué Node y no R.** El artefacto validado es el mismo archivo que el navegador ejecutará: se carga con el intérprete real del sitio en vez de reimplementar el parseo. El proyecto ya usa `node --check` como verificación observable.

**Cómo se verificó.** Corrida contra el catálogo del handoff convertido: detectó los 41 fallos de reciprocidad y 5 avisos, sin falsos positivos. Tras corregir el catálogo, exit 0.

**Corrección aplicada durante la construcción.** La regla "el `desde` del dato nunca es anterior al de su base" se degradó de error a aviso: un portal puede publicar series anteriores a su propia creación, y el catálogo real tiene cuatro casos legítimos (Datos Abiertos existe desde 2004 y publica rendimiento desde 2002).

### 4.6 Catálogo provisorio `docs/atlas_datos.js`

**Archivos:** `docs/atlas_datos.js` (1312 líneas). **Categoría:** Estructura de contenido.

**Qué se hizo.** Conversión del catálogo del handoff al esquema del contrato: 10 instituciones, 27 bases, 52 datos, 6 ámbitos, 130 relaciones.

**Por qué.** Sin datos la página no se puede construir ni verificar, y el titular pidió partir por la tabla.

**Completado de recíprocas.** El catálogo original tenía 89 relaciones y 41 sin recíproca, el 46%. Se completaron automáticamente, llegando a 130. No es inventar información: una relación afirma que dos datos se cruzan, cruzarse es simétrico, y declarar el otro extremo es una consecuencia lógica de una afirmación ya hecha.

**Estado declarado en la cabecera del archivo.** PROVISORIO, no verificado contra las fuentes, se reemplaza íntegro cuando llegue el producto de la revisión documental.

### 4.7 Página de formación y tabla filtrable

**Archivos:** `docs/formacion.html` (160), `docs/formacion.js` (180), `docs/formacion.css` (217). **Categoría:** Estructura de contenido.

**Qué se hizo.** Segunda página del sitio con `<head>`, Open Graph y footer propios, tres secciones (propósito, repositorio de fuentes, atlas en espera) y una tabla filtrable de las 52 fuentes con cuatro filtros combinables: búsqueda de texto, institución, acceso y ámbito de indagación.

**Por qué.** El titular definió la segunda página como espacio de formación en uso de datos educativos, con el repositorio de fuentes como primer contenido.

**Decisión estructural.** La tabla **no tiene datos propios**: `formacion.js` recorre `ATLAS_INSTITUCIONES` y aplana a una fila por dato. Cuando llegue el catálogo revisado, la tabla se actualiza sin tocar el render. Es la misma fuente que consumirá el atlas.

**Detalles de implementación.** El texto de búsqueda se precalcula una vez por fila y se normaliza sin acentos, de modo que `matricula` encuentra `Matrícula`. El enlace de cada dato cae al de su base cuando no tiene uno propio, replicando la resolución del prototipo. Sin catálogo cargado, la página lo declara en vez de mostrar una sección vacía.

**Cómo se verificó.** `node --check`; simulación del aplanado y de los filtros contra el catálogo real (52 filas, 0 sin enlace, las 30 rutas de los 6 ámbitos resuelven, búsqueda sin tildes con 8 coincidencias, filtro combinado con 2, filtro imposible con 0). El titular verificó en navegador.

### 4.8 Barra de navegación compartida

**Archivos:** `docs/styles.css` (+79), `docs/index.html` (+10). **Categoría:** Layout y composición.

**Qué se hizo.** Barra mínima adherida al borde superior, presente en ambas páginas, con la marca del Área y dos enlaces.

**Por qué.** Con dos páginas y sin barra, la segunda es indescubrible. La sesión 5 eliminó la navegación anterior por estar muerta (entrada 42 del backlog); esta tiene destino real.

**Decisión de accesibilidad.** La página activa se marca con `aria-current="page"` y no con una clase, para que el estado sea el mismo para el lector de pantalla y para la vista.

**Degradación declarada.** Sin soporte de `color-mix`, un `@supports not` deja el fondo opaco: se pierde el velo, no la legibilidad.

### 4.9 Respaldo, borrado de ramas y push

**Archivos:** cinco bundles en `_archivo/20260730/ramas_claude/` más su `MANIFIESTO.md` (ruta ignorada, no versionada). **Categoría:** Arquitectura del repositorio.

**Qué se hizo.** Las cinco ramas `origin/claude/*` se respaldaron como bundles (296 KB en total), se verificó la restauración comparando SHA, se borraron del remoto y se pushearon los seis commits acumulados.

**Por qué se respaldaron las cinco y no solo las tres con contenido ajeno.** Cuesta lo mismo y evita depender del juicio sobre cuál "no contenía nada recuperable": `create-org-chart-website-0PLfc` tiene diff neto vacío, pero su historia sí contiene el trabajo del organigrama.

**Riesgo que elimina el borrado.** Cuatro de las cinco ramas escriben en rutas de la raíz anteriores al traslado del sitio a `docs/`; un merge accidental sobrescribiría el docroot.

**Cómo se verificó.** `git bundle verify` en las cinco con "complete history"; restauración en limpio del bundle de la rama con más commits propios y comparación de SHA contra la rama remota (`5979148...` idéntico, 39 commits, árbol desplegado); registro del SHA de cada rama antes de borrarla; `git branch -r` final con una sola rama.

**SHA de las ramas borradas, para trazabilidad:**

| Rama | SHA al borrar | Bundle |
|---|---|---|
| `claude/create-org-chart-website-0PLfc` | `f82a97654f427ab13223eed5521e46c5aeea6235` | 51.663 B |
| `claude/improve-portfolio-site-4tPUA` | `2fd7de8d7a73c80f2ff095b93b8aa3769acbdc6a` | 52.231 B |
| `claude/movie-collection-site-1lvPi` | `48cc88f2d10095b518f4912898960ca353d6ca8e` | 63.545 B |
| `claude/paper-summary-website-BcpBc` | `169da97fa3d74fb7793e8a23c164037878a1ff3c` | 56.745 B |
| `claude/update-org-chart-design-H6N2e` | `59791480fef939b7716c2674aaeda14a9d158aa2` | 69.309 B |

**Push:** `450ea9f..952d89b main -> main`, avance rápido, sin force, contador final `0 0`.

### 4.10 Archivado del handoff del atlas

**Archivos:** `design_handoff_atlas_celeste/` movido a `_archivo/20260730/handoff_atlas/`. **Categoría:** Arquitectura del repositorio.

**Qué se hizo.** Movimiento con `mv` plano, no `git mv`, porque el directorio nunca estuvo trackeado. Sigue el precedente de `design_handoff_portafolio_pliego/` de la sesión 9.

**Cómo se verificó.** Los 9 archivos del handoff íntegros en destino; ruta original inexistente; `_archivo/` confirmado ignorado antes de mover nada.

## 5. Backlog acumulativo

Vive en `50_documentacion/activa/backlog_acumulativo.md`. Esta sesión agrega las entradas **70-81** (12 nuevas), llevando el total de 69 a 81. Sin reescritura ni renumeración de entradas anteriores.

## 6. Bugs de la sesión

### 6.1 Encabezado de la tabla cortaba la primera fila

- **Síntoma observable:** al desplazar la tabla de fuentes, la primera fila quedaba cortada por la mitad bajo el encabezado, de forma permanente. Reportado por el titular con captura.
- **Causa raíz:** el `<thead>` se declaró `position: sticky` con `top: 56px` para acompañar a la barra de navegación, que ya es sticky. Dos elementos adheridos en el mismo eje producen la mutilación de la fila que queda entre ambos.
- **Solución exacta:** `docs/formacion.css`, se eliminó `position: sticky`, `top` y `z-index` del selector `.fm-tabla thead th`, más la regla móvil `top: 50px` que quedó sin objeto.
- **Criterio de verificación:** desplazar la tabla completa sin que ninguna fila quede parcialmente oculta.
- **Patrón general aprendido:** un segundo elemento sticky en el mismo eje que uno ya existente no se compone, compite. Antes de declarar `position: sticky` hay que verificar si ya existe otro adherido en el mismo eje y decidir cuál de los dos vale más.
- **Estado:** resuelto.

### 6.2 Mayúsculas sostenidas en el encabezado de la tabla

- **Síntoma observable:** los rótulos de columna se mostraban en versalitas (`DATO`, `INSTITUCIÓN`, `BASE`). Reportado por el titular.
- **Causa raíz:** se introdujo `text-transform: uppercase` en `.fm-tabla thead th`, contradiciendo el reset de `docs/styles.css` L34, que existe precisamente para anular las mayúsculas del design system.
- **Solución exacta:** `docs/formacion.css`, eliminado `text-transform: uppercase` y ajustado `letter-spacing` de `0.04em` a `0.01em` y el tamaño de 12px a 12.5px, que compensan la pérdida de peso visual sin mayúsculas.
- **Criterio de verificación:** `grep -c uppercase docs/formacion.css` devuelve 0.
- **Patrón general aprendido:** el archivo CSS nuevo de una página hereda las reglas globales del sitio, incluidos sus resets. Antes de escribir una propiedad que un reset global anula, hay que comprobar si el reset existe: la regla del sitio es sentence case sin ALL CAPS salvo siglas, y está escrita.
- **Principio violado:** consistencia con la identidad ya fijada del sitio.
- **Estado:** resuelto. Registrado además en §15 como error del asistente, porque la regla existía por escrito.

## 7. Aprendizajes y restricciones descubiertas

1. **Un `git bundle` creado desde una ref remota no se restaura con `git clone`.** `git bundle create <dest> origin/rama` guarda la referencia tal cual, bajo `refs/remotes/`, y un bundle sin `refs/heads/*` ni `HEAD` hace que `clone` produzca un repositorio vacío pese a contener todos los objetos. La restauración correcta es `git init` más `git fetch <bundle> 'refs/remotes/origin/rama:refs/heads/rama'` más `checkout`. `git bundle create` no admite renombrar refs. **Contexto:** documentar un respaldo con un procedimiento de restauración no probado equivale a no tener respaldo. **Principio:** B.4, la verificación observable.

2. **Reasignar una función declarada no alcanza a los listeners ya registrados por referencia.** Si `addEventListener("click", fn)` recibió `fn` antes de que `fn` fuera envuelta, ese listener sigue apuntando a la función original. Los llamados por nombre dentro de otro closure sí resuelven la envoltura. **Contexto:** el botón de cerrar del lightbox no habría limpiado el hash. **Solución:** `removeEventListener` sobre la referencia base y re-registro que llame por nombre.

3. **La unicidad de identificadores en una estructura anidada es por ámbito, no global.** En el catálogo del atlas, `puntajes` existe en `agencia.simce` y en `demre.paes`, y ambas son correctas porque la llave real es la ruta de tres segmentos. **Consecuencia:** ningún `id` suelto sirve como identificador; todo lo que apunte a un dato debe usar la ruta completa.

4. **Una relación simétrica declarada en un solo extremo es deuda de datos, no un bug.** El 46% de las relaciones del catálogo del handoff no tenía recíproca. La validación automática de reciprocidad convierte un defecto invisible en un error bloqueante detectable.

5. **Un handoff de Claude Design es especificación, no código.** El segundo handoff del proyecto lo confirma: prototipo con runtime propietario ausente, cero tokens, cero clases, tema opuesto al del sitio. Su valor está en la especificación de comportamiento y en la lógica pura portable, no en los archivos.

6. **El README de un handoff no es fuente primaria de la forma de sus datos.** Dos afirmaciones del README (campo `tipo` sin uso, `url` del dato opcional) resultaron falsas al inspeccionar el código. La inspección programática es la fuente; la descripción es el protocolo.

7. **Verificar la procedencia de un adjunto antes de consumirlo.** Dos archivos adjuntos en el cierre pertenecían a `slep_aprendizajes_ep` y no a este proyecto. Escribir el cierre sobre ellos habría corrompido el backlog de dos proyectos a la vez. **Regla:** todo archivo adjunto que sea memoria de proyecto (backlog, escáner, traspaso) se verifica contra el nombre del proyecto en su encabezado antes de leerlo.

8. **Un portal de datos puede publicar series anteriores a su propia creación.** La regla que parecía obvia (el dato no puede ser más antiguo que su base) es falsa en el dominio: Datos Abiertos existe desde 2004 y publica rendimiento desde 2002. Las reglas de validación derivadas de intuición se degradan a aviso hasta confirmarse contra el dominio.

## 8. Decisiones de diseño

| # | Decisión | Alternativas | Justificación | Implicancia |
|---|---|---|---|---|
| D1 | Página aparte para formación | Sección más del index | Audiencia, ciclo de vida y frecuencia de actualización propios; fundirlas convierte la portada en un documento de dos temas | Obliga a duplicar `<head>`, OG y footer; aceptable con dos páginas, insostenible desde cuatro |
| D2 | Barra sticky compartida | Enlace en hero y retorno en footer | Sin barra, la segunda página es indescubrible | Reintroduce una nav que la sesión 5 eliminó, ahora con destino real |
| D3 | Reemplazo total del catálogo, no fusión | Entregas incrementales fusionadas | La revisión documental puede corregir entradas existentes y no solo agregar; fusionar exige reglas de conflicto que multiplican los modos de fallo | El archivo entregado sustituye íntegro a `docs/atlas_datos.js` |
| D4 | Tabla primero, atlas después | Atlas completo fiel al handoff; adoptar React solo para esa página | La tabla cumple el propósito declarado y hace revisable el catálogo; invierte el riesgo, porque los errores del catálogo se descubren antes de construir cuatro vistas encima | El atlas queda como pendiente con especificación auditada |
| D5 | Enganche del hash por envoltura | Editar los cuerpos de `openLightbox`/`closeLightbox` | El lightbox y el visor full-res son invariantes 🔒 del handoff anterior | El diff del bloque LIGHTBOX es vacío; a cambio, el patrón es menos legible y exige el comentario que lo explica |
| D6 | Blindar andamios hacia adelante | Dejarlos públicos; reescribir historia | Mismo remedio que la entrada 60; reescribir historia publicada es desproporcionado para contenido no sensible | Lo publicado en `f61b011` sigue en el historial de GitHub |
| D7 | Respaldar las cinco ramas, no tres | Respaldar solo las de contenido ajeno | Cuesta lo mismo y no depende del juicio sobre cuál es prescindible | 296 KB en `_archivo/`, ruta ignorada |
| D8 | Validador en Node | Reimplementar la validación en R | El artefacto validado es el mismo archivo que ejecutará el navegador; se carga con el intérprete real | Excepción declarada a la preferencia de R, análoga a la del escáner |

## 9. Constantes y parámetros

Constantes nuevas introducidas en esta sesión, declaradas en el contrato (`50_documentacion/activa/50_contrato_atlas_datos.md`) y aplicadas en `00_validar_atlas.js`:

| Constante | Valor | Archivo | Motivo |
|---|---|---|---|
| `ACCESO_VALIDO` | `["Acceso público", "Acceso restringido"]` | `00_validar_atlas.js` | Dominio cerrado del campo `acceso` |
| `VARS_MIN` / `VARS_MAX` | 2 / 8 | `00_validar_atlas.js` | Rango de variables por dato |
| `DATOS_AMBITO_MIN` / `MAX` | 3 / 8 | `00_validar_atlas.js` | Rango de datos por ámbito de indagación |
| `DIST_MIN` | 12 | `00_validar_atlas.js` | Distancia euclídea mínima entre instituciones en el mapa |
| `X_MIN` / `X_MAX` / `Y_MIN` / `Y_MAX` | 30 / 88 / 12 / 88 | `00_validar_atlas.js` | Rango de posiciones; la franja izquierda queda libre para el encabezado del atlas |
| `PREFIJO_HASH` | `"#p="` | `docs/app.js` | Prefijo de los enlaces profundos |

Las constantes vigentes del sitio (paleta, tipografía, escalas) siguen en `docs/colors_and_type.css`; ninguna cambió en esta sesión.

## 10. Arquitectura de archivos

Escáner al cierre: `50_documentacion/estructura/estructura_actual.md`, generado el **2026-07-30 11:35:06**, con **13 carpetas y 77 archivos**.

Cambios estructurales de la sesión:

- `docs/` suma cuatro archivos: `formacion.html`, `formacion.js`, `formacion.css`, `atlas_datos.js`.
- La raíz suma `00_validar_atlas.js`, siguiendo el precedente de `00_escanear_proyecto.R`.
- `50_documentacion/activa/` suma `50_contrato_atlas_datos.md`, con el prefijo de decena que exige la política §2.
- `design_handoff_atlas_celeste/` salió de la raíz hacia `_archivo/20260730/handoff_atlas/`.
- `_archivo/20260730/ramas_claude/` guarda los cinco bundles y su manifiesto (ruta ignorada, fuera del repositorio).

Verificación contra la política: la estructura respeta las decenas y la nomenclatura. `50_documentacion/traspasos/` queda con un solo archivo a la vista tras el archivado de este cierre, cumpliendo la regla 1.3.1.

## 11. Pendientes y ruta sugerida

### 11.1 Inventario

| # | Pendiente | Tipo | Contexto | Impacto | Dependencias | Complejidad | Criterio de éxito |
|---|---|---|---|---|---|---|---|
| P1 | Versionar el cierre de la sesión 10 | documentación | Escáner, traspaso v10, backlog y `ESTADO.md` sin commitear | Bajo, pero deja el árbol sucio | ninguna | baja | `git status --short` vacío y `ls 50_documentacion/traspasos/*.md` devuelve una línea |
| P2 | Recibir y depositar el catálogo revisado | funcionalidad | Producto de la sesión paralela de revisión bibliográfica | Alto: es el contenido real de la página | entrega del titular | baja (la validación es automática) | `node 00_validar_atlas.js` exit 0 y la tabla renderiza el catálogo nuevo |
| P3 | Construir el atlas | funcionalidad | Especificación auditada en §4.4; datos definidos por el contrato | Alto: es el objeto que el titular pidió | P2 idealmente resuelto | alta (sesión propia, o dos) | Cuatro vistas navegables con zoom, paneo y constelaciones, sobre `ATLAS_INSTITUCIONES` |
| P4 | Revisar el catálogo contra las fuentes | gobernanza | El catálogo provisorio no está verificado; el sitio aún no se difunde | Alto: el Área firma cada afirmación | P2 | media, es trabajo del titular | Cada fuente confirmada contra el sitio de su emisor |
| P5 | Tokens `--banner-*` huérfanos | deuda técnica | Heredado de la entrada 62; `styles.css` conserva tokens y reglas `body[data-variant] .banner` sin markup que las use | Bajo, deuda inerte | ninguna | baja | `grep -c "banner" docs/styles.css` acorde a lo que el markup usa |
| P6 | Construir la entrada del proyecto Simce | funcionalidad | Pendiente desde la sesión 7; espera tres PDF del titular | Medio | entrega del titular | media | Proyecto `simce` con capturas y reseña en `data.js` |
| P7 | Fase 0 del catálogo de Project Cards | funcionalidad | Encargo cerrado en la entrada 68; el campo `id` que era su prerrequisito ya existe | Medio | ninguna | media | Los once campos nuevos poblados en `data.js` |
| P8 | Ordenación del repositorio (§4.7) | deuda técnica | No existe `50_documentacion/activa/50_ordenacion_repositorio.md`; gatillo 4bis encendido | Bajo | árbol limpio y rama propia | media | El marcador existe y los cuatro bloques quedaron ejecutados |
| P9 | Enlaces por dato en el catálogo | mejora | Los 52 datos caen a la URL de su base; ninguno apunta a su página específica | Medio para la utilidad de la tabla | P2 | baja | Los datos con página propia tienen su `url` |

### 11.2 Evaluación de deuda técnica

**Zonas frágiles.** El enganche por envoltura de `app.js` es correcto pero exige que quien lo lea entienda por qué existe; el comentario lo explica, pero un cambio futuro en los listeners del lightbox podría romperlo en silencio. El catálogo provisorio es el riesgo mayor: es contenido no verificado publicado en un sitio institucional, mitigado solo por el hecho de que el sitio aún no se difunde.

**Oportunidades.** El validador puede crecer para verificar que las URL resuelvan, en un modo con red separado del modo reproducible. La tabla y el atlas comparten fuente, así que cualquier campo nuevo del contrato beneficia a ambos sin trabajo doble.

### 11.3 Auditoría de cierre (política 5.6, preguntas de cierre)

| # | Pregunta | Respuesta |
|---|---|---|
| 2 | ¿El pipeline corre de cero sin intervención manual? | No aplica en sentido estricto: sitio estático sin pipeline. El equivalente sí se cumple: `node --check` sobre los tres JS y `node 00_validar_atlas.js` corren de cero y son reproducibles. |
| 5 | ¿Cada transformación crítica tiene check de validación? | **Sí**, y es nuevo de esta sesión: la ingesta del catálogo, que es la transformación crítica del atlas, tiene validador ejecutable con criterio binario. |
| 6 | ¿Los outputs son reproducibles e idempotentes? | **Sí.** El aplanado de la tabla es una función pura del catálogo; el validador no escribe nada; la conversión del catálogo se generó por script. |
| 7 | ¿Decisiones metodológicas como constantes nombradas? | **Sí.** Los rangos y dominios del contrato viven como constantes al inicio de `00_validar_atlas.js` (§9), no como números mágicos en medio del flujo. |
| 8 | ¿Nombres de archivos y carpetas sin tildes, ñ ni espacios? | **Sí** en todo lo generado esta sesión. Nota: el archivo `Atlas Celeste.dc.html` del handoff tiene espacios y mayúsculas, y salió del árbol vivo al archivarse. |

Sin respuestas "no": esta sesión no agrega pendientes por auditoría.

### 11.4 Ruta sugerida para la próxima sesión

**Prioridad 1 — Versionar el cierre de la sesión 10 (P1).** Bloquea cualquier trabajo nuevo. Complejidad baja. Criterio: árbol limpio y un solo traspaso a la vista.

**Prioridad 2 — Depositar el catálogo revisado si llegó (P2), o el atlas si no (P3).** Es una bifurcación real. Si el catálogo llegó, depositarlo es barato y hace que la tabla muestre contenido verificado, lo que a su vez habilita difundir el sitio. Si no llegó, la sesión se dedica al atlas sobre el catálogo provisorio, que para efectos de construcción sirve igual porque el esquema es el mismo.

**Prioridad 3 — Fase 0 del catálogo de Project Cards (P7).** Su prerrequisito (el campo `id`) se resolvió en esta sesión, y es trabajo de datos que no compite con el atlas por el mismo archivo.

**Conviene diferir.** P5 (tokens huérfanos) es cosmético e inerte. P6 espera entrega del titular. P8 exige árbol limpio y rama propia, y su bloque 1 ya está hecho de facto. P9 depende de P2.

## 12. Instrucciones específicas para la próxima sesión

- ⚠️ **NO** ejecutar `git push` sin autorización explícita del titular en el turno inmediatamente anterior. La autorización no se hereda entre encargos.
- ⚠️ **NO** encadenar con `&&` un paso de verificación a lo que debe condicionar: un `grep` sin coincidencias devuelve 1 y corta la cadena en silencio.
- ⚠️ **NO** correr `00_escanear_proyecto.R` más de una vez por sesión: rota un par fijo `actual`/`anterior` y la segunda corrida destruye el punto de comparación.
- ⚠️ **NO** restaurar un `git bundle` de este proyecto con `git clone`: usar el procedimiento del `MANIFIESTO.md` en `_archivo/20260730/ramas_claude/`.
- ⚠️ **NO** declarar una cifra sobre el catálogo sin recontarla programáticamente en el mismo turno.
- ✅ **ANTES** de leer un archivo de memoria de proyecto adjunto (backlog, escáner, traspaso), verificar el nombre del proyecto en su encabezado.
- ✅ **ANTES** de tocar `docs/atlas_datos.js`, correr `node 00_validar_atlas.js docs/atlas_datos.js` para conocer el estado de partida.
- ✅ **ANTES** de agregar cualquier constante global a un script de `docs/`, verificar que no colisione con `PROYECTOS`, `HITOS`, `EQUIPO`, `ATLAS_INSTITUCIONES`, `ATLAS_AMBITOS` ni `ATLAS_FRASES`: una redeclaración global deja el sitio en blanco.
- ✅ **ANTES** de declarar `position: sticky`, verificar si ya hay otro elemento adherido en el mismo eje.
- ✅ **ANTES** de escribir una propiedad CSS en una hoja de página, comprobar si un reset global de `styles.css` la anula o la contradice (L34: sentence case, sin ALL CAPS salvo siglas).
- 🔒 El lightbox de reseña y el visor a resolución completa **no se tocan**. El hash se engancha por fuera, por envoltura.
- 🔒 `POLITICA_PROYECTO.md`, `SETTINGS_Y_PROMPTS_OPERACIONALES.md`, `50_documentacion/traspasos/**` y `50_documentacion/andamios/**` permanecen fuera del repositorio público.
- 🔒 Los bundles de `_archivo/20260730/ramas_claude/` son el único respaldo de cinco ramas ya borradas del remoto. No se borran jamás.
- 🔒 Los originales de las capturas viven en `_archivo/20260729/capturas_originales/` y no se borran jamás.
- 🔒 El catálogo `docs/atlas_datos.js` es provisorio y no verificado: **el sitio no se difunde** hasta que el titular revise su contenido.

## 13. Fragmentos de código de referencia

**Enganche por envoltura sin tocar la función original** (`docs/app.js`). Patrón nuevo de esta sesión, aplicable a cualquier invariante que deba ganar un efecto lateral:

```javascript
const abrirBase = openLightbox;
const cerrarBase = closeLightbox;
let sincronizandoDesdeUrl = false;

openLightbox = function (p, startIndex) {
  abrirBase(p, startIndex);
  if (!sincronizandoDesdeUrl) escribirHash(p.id);
};
closeLightbox = function () {
  cerrarBase();
  if (!sincronizandoDesdeUrl) escribirHash("");
};

/* Los listeners registrados por referencia ANTES de la envoltura no la ven. */
$("#lbClose").removeEventListener("click", cerrarBase);
$("#lbClose").addEventListener("click", function () { closeLightbox(); });
```

**Evaluar un módulo con `export` sin build, para inspeccionarlo o validarlo:**

```javascript
const fs = require("fs"), vm = require("vm");
const src = fs.readFileSync(RUTA, "utf8").replace(/^\s*export\s+/gm, "");
const ctx = {}; vm.createContext(ctx);
vm.runInContext(src + "\nthis.__X = NOMBRE_CONSTANTE;", ctx, { timeout: 5000 });
const X = ctx.__X;   // `const` no se adjunta al contexto por sí solo
```

**Restauración correcta de un bundle creado desde una ref remota:**

```bash
git init carpeta-destino
git -C carpeta-destino fetch /ruta/al/archivo.bundle \
  'refs/remotes/origin/claude/<nombre>:refs/heads/<nombre>'
git -C carpeta-destino checkout <nombre>
```

Los patrones estables del proyecto (estructura de `data.js`, convenciones del sitio) viven en `CLAUDE.md` y en `50_documentacion/activa/50_contrato_atlas_datos.md`.

## 14. Reapertura

**Mensaje de apertura sugerido:**

> Tipo CONTINUATION. El protocolo (`POLITICA_PROYECTO.md` v5.5 + `SETTINGS_Y_PROMPTS_OPERACIONALES.md` v15) vive en la knowledge base del Project; verifica que estén al día antes de empezar. Adjunto el traspaso v10, el escáner al cierre y el backlog. La sesión 10 cerró con la segunda página del sitio publicada, el contrato y el validador del catálogo operativos, y el repositorio con una sola rama remota; el cierre quedó sin commitear, así que la prioridad 1 es versionarlo. Después: [depositar el catálogo revisado, que ya tengo / construir el atlas, porque el catálogo aún no llega].

**Documentos para la próxima sesión, en tres bloques:**

1. *Protocolo en knowledge base* (no se adjuntan; verificar que estén al día): `POLITICA_PROYECTO.md`, `SETTINGS_Y_PROMPTS_OPERACIONALES.md`, `encargo_autonomo_claude_code_v1.md`.
2. *Opcionales según el foco*: `CLAUDE.md` si correrá en Claude Code; `50_catalogo_project_cards.md` si se aborda P7.
3. *Específicos de la sesión* (sí se adjuntan): `traspaso_cierre_v10.md`; `estructura_actual.md` recién corrido; `backlog_acumulativo.md`; `50_contrato_atlas_datos.md` (es el esquema contra el que se trabaja); `docs/atlas_datos.js` y `docs/formacion.js` si el foco es el catálogo o la tabla; `docs/app.js`, `docs/styles.css` y `docs/formacion.css` si el foco es el atlas; el archivo del catálogo revisado si llegó.

**Nota final obligatoria:** `docs/app.js` (406 líneas), `docs/styles.css` (573 líneas) y `docs/data.js` cambiaron en esta sesión; adjunta las versiones de disco, no versiones anteriores. Verifica el nombre del proyecto en el encabezado de cada archivo de memoria antes de adjuntarlo: en esta sesión llegaron dos archivos de `slep_aprendizajes_ep` por error.

## 15. Errores del asistente

> **Nota sobre el campo `patron`:** el catálogo canónico `catalogo_patrones_errores_v3.md` no está en la knowledge base de este Project ni fue adjuntado en esta sesión. Las etiquetas `PAT-NN` de abajo son **propuestas y no verificadas contra el catálogo**; una sesión con acceso al catálogo debe confirmarlas o corregirlas. Se declara en vez de inventar una correspondencia.

### E1 — Mayúsculas sostenidas en el encabezado de la tabla

| Campo | Contenido |
|---|---|
| `momento` | Construcción de `docs/formacion.css`, entrega de la página de formación |
| `disparador` | Usuario lo corrigió ("veo ALLCAPS, que están prohibidas salvo para siglas") |
| `que_paso` | Se escribió `text-transform: uppercase` en `.fm-tabla thead th`, contradiciendo el reset de `docs/styles.css` L34 y la identidad declarada del sitio |
| `regla_violada` | `docs/styles.css` L34 y su comentario ("this site is sentence-case only"); identidad del sitio fijada desde la sesión 1 |
| `causa_raiz` | Se escribió la hoja de la página nueva como si fuera un archivo autónomo, sin comprobar qué reglas globales hereda. La convención del sitio estaba escrita en el archivo que la página carga primero |
| `salvaguarda_presente` | El propio `styles.css` del proyecto (no POLITICA ni SETTINGS: es una convención de este sitio) |
| `patron` | `PAT-01` propuesto, sobre afirmar sin leer: se escribió CSS sin haber leído el reset que lo contradice |
| `gatillo_observable` | `afirmar-sin-leer`: escribir una propiedad CSS en una hoja nueva sin haber consultado los resets globales del archivo que la precede en la cascada |
| `intentos_previos` | 0 |
| `costo` | Un ciclo de corrección y re-descarga del archivo por el titular |

### E2 — Procedimiento de restauración de bundle no probado

| Campo | Contenido |
|---|---|
| `momento` | Encargo de respaldo de las cinco ramas `claude/*`, fase 3 |
| `disparador` | Claude Code lo detectó al ejecutar y lo reportó con diagnóstico |
| `que_paso` | El encargo especificaba `git clone <bundle> <carpeta>` como prueba de restauración y como procedimiento a documentar, y ese comando produce un repositorio vacío cuando el bundle se creó desde una ref remota |
| `regla_violada` | SETTINGS §1.2.6, marcador de fuente: un comando incluido en un encargo es una premisa fáctica y exige fuente o marca de hipótesis; se escribió como hecho |
| `causa_raiz` | Se asumió que `git bundle` es simétrico con `git clone` sin verificar cómo guarda las refs. La fase existía justamente para probar la restauración, y su comando de prueba no estaba probado |
| `salvaguarda_presente` | SETTINGS §1.2.6 (marcador de fuente); POLITICA 5.6 pregunta 2 (correr de cero sin intervención manual) |
| `patron` | `PAT-01` propuesto, sobre comando afirmado sin verificar |
| `gatillo_observable` | `comando-entorno`: incluir en un encargo un comando cuyo comportamiento no se verificó en el entorno real |
| `intentos_previos` | 0 |
| `costo` | Ninguno en datos (el respaldo era válido); un ciclo de diagnóstico de Claude Code y la corrección del manifiesto |

### E3 — Premisa fáctica asumida sobre el estado de difusión del sitio

| Campo | Contenido |
|---|---|
| `momento` | Análisis del handoff del atlas, al plantear el gate de revisión del catálogo |
| `disparador` | Usuario lo corrigió ("primero: el sitio no está difundido aún") |
| `que_paso` | Se afirmó que publicar el catálogo equivalía a difundirlo con la firma del Área, tratando el sitio como difundido, y se construyó sobre esa premisa un gate bloqueante mal calibrado |
| `regla_violada` | SETTINGS §1.2.6, marcador de fuente: toda premisa fáctica de un encargo lleva marcador de fuente o de hipótesis |
| `causa_raiz` | La premisa venía de una inferencia razonable (el sitio está publicado en GitHub Pages) que se confundió con un hecho verificado (el sitio fue difundido a su audiencia). Publicado y difundido no son lo mismo, y la diferencia era consultable |
| `salvaguarda_presente` | SETTINGS §1.2.6; POLITICA §6 (gobernanza de datos) |
| `patron` | `PAT-01` propuesto, sobre premisa de encargo sin marcador |
| `gatillo_observable` | `encargos-premisas`: construir un gate bloqueante sobre un estado del mundo no verificado en la sesión |
| `intentos_previos` | 0 |
| `costo` | Un turno de corrección del titular; ninguna decisión ejecutada sobre la premisa errada |

### E4 — Cifra predicha como criterio de verificación

| Campo | Contenido |
|---|---|
| `momento` | Encargo de archivado del handoff, fase 5 |
| `disparador` | Claude Code lo reportó como desviación al obtener 10 en vez de 9 |
| `que_paso` | El encargo pedía "confirma que el conteo sea 9 archivos", cifra tomada de un inventario de un turno anterior y no recontada en el momento; un `.DS_Store` creado por Finder entre ambos momentos la invalidó |
| `regla_violada` | `userPreferences`, marcador de fuente: una cifra admite solo un recuento programático del mismo turno; un inventario anterior no es fuente |
| `causa_raiz` | Se trató un inventario del mismo día como estado permanente. El sistema de archivos cambia entre inventario y verificación, y el criterio debió expresarse como propiedad estable (los 9 archivos del handoff presentes) y no como conteo exacto |
| `salvaguarda_presente` | `userPreferences` (marcador de fuente); traspaso v09 §12 (recontar antes de declarar) |
| `patron` | `PAT-01` propuesto, sobre cifra heredada de un inventario previo |
| `gatillo_observable` | `cifras-datos`: usar como criterio de aceptación una cifra no recontada en el turno que la usa |
| `intentos_previos` | 0 |
| `costo` | Ninguno: Claude Code no se detuvo porque la condición de detención estaba bien formulada aparte, y diagnosticó la diferencia |

### Fricciones

Sin fricciones registradas en esta sesión.
