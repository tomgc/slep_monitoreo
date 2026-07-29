# Encargo — Catálogo de Project Cards del Área de Monitoreo

> **Destino:** `50_documentacion/activa/50_catalogo_project_cards.md`
> **Origen:** documento "Proyecto Editorial — Catálogo de Proyectos e
> Innovación" aportado por el titular el 2026-07-29 (sesión 9).
> **Decisión de arquitectura:** opción B, fuente única en `docs/data.js`.
> **Estado:** encargo aprobado en su dirección general; las asignaciones de
> código, categoría y madurez de §3 están marcadas como revisables.

---

## 1. Qué es y qué problema resuelve

El documento fuente propone reemplazar la presentación por diapositivas por
un catálogo físico de tarjetas A5, una por proyecto, que cualquier persona
pueda tomar y leer en dos minutos sin explicación previa. Define cinco
niveles de evolución (impresas → PDF → micrositio → repositorio →
catálogo interactivo).

**Hallazgo central:** el sitio `slep_monitoreo` ya cubre los niveles 3 a 5
de esa escala, y `docs/data.js` ya contiene, para los 12 proyectos, los
campos `titulo`, `tipo`, `objetivo`, `sintesis`, `imgs` y `estado`. El
catálogo impreso no es un proyecto nuevo: es **un segundo soporte del mismo
contenido**.

**Riesgo que este encargo existe para evitar:** redactar los textos de las
tarjetas por fuera de `data.js` produce dos versiones del mismo proyecto que
divergen a la primera corrección. Toda la arquitectura de abajo se deriva de
esa única restricción.

---

## 2. Decisión de arquitectura

`docs/data.js` es la **fuente única**. Se extiende con los campos que la
tarjeta necesita y que el sitio hoy no usa. De esa misma fuente se generan
dos salidas:

| Salida | Archivo | Consumo |
|---|---|---|
| Sitio (ya existe) | `docs/index.html` + `docs/app.js` | web pública |
| Tarjetas (nuevo) | `docs/cards.html` + `docs/cards.css` | impresión a PDF A5 desde el navegador |

`cards.html` carga el mismo `data.js` con un `<script src="data.js">` y
renderea las 12 tarjetas (cara frontal y posterior) en un `@page` A5. El PDF
se produce con "Imprimir → Guardar como PDF" desde Chrome. Cero
dependencias externas, tipografías locales, en línea con POLITICA §5.5.

**Alternativas descartadas.** Diseño manual en Canva o InDesign (rápido para
tres tarjetas, insostenible a doce y sin vínculo con el sitio). Proyecto
hermano en R con Quarto o typst (mejor control tipográfico de imprenta, pero
abre repositorio y ciclo de vida propios para un entregable que hoy cabe en
el stack existente). Si en el futuro la imprenta exige control de CMYK y
sangrado real, C se reevalúa: este encargo no cierra esa puerta, porque los
datos ya estarían normalizados.

---

## 3. Taxonomía propuesta (REVISAR: asignaciones del titular)

El documento fuente define seis categorías de color y un sistema de códigos,
pero no los asigna a proyectos concretos. Propuesta a partir de los `titulo`
y `tipo` reales de `docs/data.js` (fuente: `grep -nE '^\s*(orden|estado|tipo|titulo):' docs/data.js`
y `sed -n '10,35p' docs/data.js`, ejecutados en la sesión 9).

**Corrección de un supuesto.** `data.js` **no tiene campo `id`**: cada
proyecto es `orden`, `tipo`, `titulo`, `objetivo`, `sintesis`, `estado` e
`imgs`. Los slugs que el backlog usa desde la sesión 6 (`asistencia`,
`resguardo`) viven únicamente en los nombres de archivo de las capturas, y
los tres proyectos con `imgs: []` no tienen ninguno. La columna `id` de la
tabla es por lo tanto un **campo a crear** (§4), no un dato existente.

| `orden` | `id` (campo nuevo) | Título abreviado | Categoría propuesta | Código |
|---:|---|---|---|---|
| 1 | `asistencia` | Minuta de asistencia mensual | 🟩 Gestión Educativa | GES-01 |
| 2 | `resguardo` | Reportes del Modelo de Resguardo | 🟩 Gestión Educativa | GES-02 |
| 3 | `simce` | Minutas de resultados Simce 2025 | 🟨 Comunicación | COM-01 |
| 4 | `estandares` | Motor de Estándares de Aprendizaje | 🟦 Ciencia de Datos | DAT-01 |
| 5 | `idps` | Motor de IDPS | 🟦 Ciencia de Datos | DAT-02 |
| 6 | `categorias` | Motor de Categoría de Desempeño | 🟦 Ciencia de Datos | DAT-03 |
| 7 | `parvularia` | Monitoreo de aprendizajes en parvularia | 🟩 Gestión Educativa | GES-03 |
| 8 | `inicial` | Trayectorias de egresados de jardines | 🟥 Investigación | INV-01 |
| 9 | `costapresente` | CostaPresente | 🟧 Innovación | INN-01 |
| 10 | `ael` | Alertas de Anótate en la Lista | 🟧 Innovación | INN-02 |
| 11 | `desvinculacion` | Trayectorias educativas interrumpidas | 🟥 Investigación | INV-03 |
| 12 | `rendimiento` | Diagnóstico histórico del rendimiento | 🟥 Investigación | INV-02 |

**Notas de la propuesta.**

- El prefijo de Innovación se fija en `INN` y no en `INO`, para no colisionar
  visualmente con `INV` de Investigación.
- 🟪 Inteligencia Artificial (`IA-NN`) queda declarada y sin proyectos. Es
  correcto que una categoría exista vacía: señala una línea de trabajo
  reconocida, no un hueco.
- Los códigos numeran dentro de cada categoría, no de forma global. Esto
  hace que el código sobreviva a la inserción de proyectos nuevos, a
  diferencia del campo `orden`, que se renumera (como ocurrió en la sesión 8
  al insertar el proyecto Simce).
- El código, una vez impreso, **es permanente**: nunca se reasigna aunque el
  proyecto cambie de nombre o se archive.

---

## 4. Campos nuevos en `data.js`

Se agregan por proyecto. Los nombres siguen snake_case sin tildes, como el
resto del archivo.

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

**Por qué `id` y `codigo` coexisten.** Son identificadores de audiencias
distintas: `id` es la llave de la URL (legible, compartible por correo) y
`codigo` es la referencia impresa que se dice en voz alta en una reunión
("revisen la tarjeta DAT-03"). Colapsarlos en uno haría que reclasificar un
proyecto de categoría rompiera enlaces ya compartidos. `id` se puebla para
los doce proyectos antes que cualquier otro campo nuevo, porque es
prerrequisito de la Fase 1.

**Reutilización sin duplicar.** `titulo` y `tipo` se usan tal cual en el
encabezado de la tarjeta; `imgs[0]` es la imagen principal de la cara
frontal; `objetivo` y `sintesis` son el insumo del que se condensa
`solucion`, no se copian.

**Impacto en el sitio:** ninguno mientras `app.js` no lea los campos nuevos.
La extensión de `data.js` es aditiva y no rompe el render actual, lo que
permite poblarla de forma incremental.

---

## 5. Enum de madurez

El documento fuente define seis estados (Idea, Diseño, Piloto,
Implementación, Escalamiento, Consolidado). `data.js` hoy tiene solo
`estado: "vigente" | "desarrollo"`, que **controla el render** (los
`desarrollo` van al final con el marcador "Próximamente").

**Decisión:** no se toca `estado`; se agrega `madurez` con el enum de seis
valores. Son dos ejes distintos: `estado` responde "¿se muestra publicado en
el sitio?", `madurez` responde "¿en qué punto de su ciclo está?". Colapsarlos
obligaría a decidir, por ejemplo, si un piloto en marcha es "vigente" o
"desarrollo", pregunta que hoy no existe y que no conviene inventar.

Correspondencia mínima verificable: todo proyecto con `estado: "desarrollo"`
tiene `madurez` en `Idea`, `Diseño` o `Piloto`. La asignación concreta de los
doce valores es del titular.

---

## 6. Códigos QR

**Regla del documento fuente, adoptada:** el QR nunca apunta al PDF de la
propia tarjeta; debe ampliar la experiencia.

**Destino propuesto:** el proyecto abierto en el sitio,
`https://tomgc.github.io/slep_monitoreo/#p=<id>`.

**Prerrequisito técnico (bloqueante), en dos partes:**

1. **No existe la llave.** Hay que poblar el campo `id` de §4 en los doce
   proyectos. Sin él no hay nada estable a lo que apuntar: `orden` se
   renumera al insertar un proyecto (ocurrió en la sesión 8 con el Simce), y
   un QR ya impreso apuntando a un número que se corrió es un enlace roto en
   papel.
2. **No existen los enlaces profundos.** Abrir la reseña de un proyecto por
   URL exige agregar en `app.js` la lectura del hash al cargar y su escritura
   al abrir el lightbox. Cambio acotado (una función de lectura, una línea en
   `openLightbox()`), con valor por sí mismo: también permite compartir un
   proyecto por correo.

**Generación de los QR:** SVG generados una vez y versionados en
`docs/assets/qr/<id>.svg`. No se usa un servicio en línea de generación,
porque introduciría una dependencia externa en tiempo de render (POLITICA
§5.5) y porque un QR generado en un tercero es un enlace que alguien más
puede reescribir.

---

## 7. Gobernanza (compuerta, no trámite)

Las tarjetas son un objeto **impreso que circula fuera de la institución**:
equipos ministeriales, universidades, municipalidades, visitas. El riesgo es
mayor que el del sitio, porque el papel no se corrige ni se retira.

- Ningún nombre de establecimiento educacional, ningún RBD, ningún dato
  individual de estudiantes o funcionarios entra a una tarjeta (POLITICA
  §6.4, condición contractual de la Agencia de Calidad).
- El campo `evidencia` es el punto de fuga: cifras como "95 establecimientos
  incorporados" son agregadas y publicables; cifras desagregadas por comuna
  pequeña pueden identificar. Toda cifra de `evidencia` la aporta y la
  aprueba el titular.
- Las imágenes de `imgs` fueron revisadas por el titular para el sitio, pero
  **la revisión para impresión es distinta**: en pantalla una captura se ve a
  ~900 px de ancho y en A5 se imprime a 300 dpi, donde texto que era
  ilegible pasa a leerse. Cada `imgs[0]` que llegue a una tarjeta se revisa
  de nuevo antes de mandar a imprenta.
- La terminología sigue SETTINGS §4.6.3.6: "establecimiento educacional"
  completo en la primera mención de cada párrafo, "establecimiento(s)" en las
  repeticiones, nunca "EE" en texto visible ni "colegio" como genérico.

---

## 8. Especificación de impresión

Del documento fuente: A5 vertical (148 × 210 mm), couché mate o opalina 300
g, doble cara, laminado mate, esquinas redondeadas opcionales.

```css
@page { size: 148mm 210mm; margin: 0; }
.card { width: 148mm; height: 210mm; page-break-after: always; }
```

**Advertencia de imprenta (a resolver con el proveedor antes de la Fase 4):**
esa hoja de estilo produce un PDF sin sangrado. Si la imprenta pide 3 mm de
sangrado, el `@page` pasa a `154mm 216mm` con el contenido desplazado 3 mm y
marcas de corte. Preguntar primero; rehacer las doce tarjetas por un margen
es trabajo evitable.

Segunda advertencia: el navegador exporta en RGB y la imprenta trabaja en
CMYK. Los azules saturados de la paleta SLEP son los que más se apagan en la
conversión. Conviene imprimir **una** tarjeta de prueba antes de las doce.

---

## 9. Fases

| Fase | Qué | Quién | Bloquea a |
|---|---|---|---|
| 0 | Aprobar la taxonomía de §3 y asignar los doce valores de `madurez` | titular | 2 |
| 1 | Campo `id` en los 12 proyectos + enlaces profundos `#p=<id>` en `app.js` | asistente + Claude Code | 4 |
| 2 | Extender `data.js` con los campos de §4, **solo 2 proyectos piloto** | asistente | 3 |
| 3 | `cards.html` + `cards.css`, prueba de impresión de las 2 piloto | asistente + titular | 4 |
| 4 | Completar los 12, generar los QR, portada e índice, PDF de la colección | asistente | — |

**Por qué dos proyectos piloto y no los doce.** Los topes de palabras del
documento fuente (25 / 60 / 120) son restrictivos, y no se sabe si el
contenido real de estos proyectos cabe en ellos hasta intentarlo. Redactar
doce tarjetas contra un formato no probado es doce veces el retrabajo si el
formato cede. Recomendación de piloto: `costapresente` (proyecto maduro, con
una sola captura, caso fácil) y `estandares` (título largo, tres capturas,
caso difícil). Si el formato aguanta esos dos extremos, aguanta los doce.

---

## 10. Lo que este encargo deja fuera

- El nivel 5 del documento fuente (catálogo interactivo con filtros por
  categoría, estado, impacto y año) en el sitio. Es una funcionalidad del
  sitio, no del catálogo impreso, y los campos `categoria` y `madurez` que
  esta Fase 2 introduce son justamente lo que la haría posible después.
- La caja, carpeta o archivador físico donde viven las tarjetas.
- El rediseño del portafolio delegado a Claude Design
  (`encargo_diseno_portafolio.md`): es otro entregable sobre los mismos
  datos, y no debe mezclarse con este en una misma tanda de cambios.
