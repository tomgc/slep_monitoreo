# Contrato de datos del Atlas Celeste

> **Destino:** `50_documentacion/activa/50_contrato_atlas_datos.md`
> **Versión 1.** Generado en la sesión 10 de `slep_monitoreo`.
> **Fuente del esquema:** inspección programática de
> `design_handoff_atlas_celeste/atlas-data.js` (10 instituciones, 27 bases,
> 52 datos, 6 desafíos), no la descripción que el README hace de sí mismo.

Este documento es el contrato entre quien **produce** el catálogo de fuentes
(revisión bibliográfica documental) y quien lo **consume** (la tabla filtrable
de `docs/formacion.html` y, más adelante, el atlas). Un archivo que cumple
este contrato entra al sitio sin retrabajo; uno que no lo cumple se detecta
en la validación y no llega a producción.

---

## 1. Qué archivo se entrega

Un solo archivo, `atlas_datos.js`, que reemplaza íntegramente al catálogo
vigente. No se entregan altas sueltas para fusionar: la revisión documental
puede corregir entradas existentes y no solo agregar, y fusionar exigiría
reglas de resolución de conflictos que multiplican los modos de fallo sin
beneficio proporcional.

El archivo declara tres constantes y nada más:

```javascript
const ATLAS_INSTITUCIONES = [ /* ... */ ];
const ATLAS_DESAFIOS      = [ /* ... */ ];
const ATLAS_FRASES        = { /* ... */ };
```

**Sin `export`.** El sitio no tiene build ni módulos ES: carga los scripts con
`<script src>` clásico, igual que `data.js`. Un `export const` produciría
`SyntaxError` fuera de un `<script type="module">`. Este es el único cambio
obligatorio respecto del archivo del handoff, que sí usa `export`.

Los nombres cambian de `GALAXIAS`/`CONSTELACIONES`/`FRASES` a los prefijados
con `ATLAS_` porque conviven en el ámbito global con `PROYECTOS`, `HITOS` y
`EQUIPO` de `data.js`, y un nombre genérico como `FRASES` es candidato seguro
a colisionar con lo próximo que se agregue.

---

## 2. Esquema

Tres niveles anidados más los desafíos. La metáfora visual (sistema solar,
planeta, satélite) no aparece en los nombres de campo: los datos se nombran
por lo que son, para que la tabla y el atlas puedan leer el mismo archivo.

### 2.1 Institución (nivel 1)

| Campo | Tipo | Obligatorio | Regla |
|---|---|---|---|
| `id` | string | sí | minúsculas, dígitos y guion medio. Único en todo el archivo |
| `nombre` | string | sí | como se muestra. Siglas en mayúsculas (`MINEDUC`, `JUNAEB`) |
| `desc` | string | sí | una o dos oraciones. Qué es la institución y qué rol tiene |
| `color` | string | sí | hex de 6 dígitos. Ver §4 |
| `x`, `y` | number | sí | posición en el mapa, 0-100. Ver §5 |
| `bases` | array | sí | al menos una. Antes se llamaba `planetas` |

El campo `tipo` del catálogo original (`espiral`, `barrada`, `eliptica`,
`lenticular`, `irregular`) **se elimina**. El README lo declara legado y sin
uso, pero el prototipo sí lo consume en su método `capas()` para dibujar los
brazos del sistema. Si el atlas lo vuelve a necesitar, se deriva del número de
bases en tiempo de render: no es información sobre la institución y no
corresponde que la produzca una revisión documental.

### 2.2 Base de datos (nivel 2)

| Campo | Tipo | Obligatorio | Regla |
|---|---|---|---|
| `id` | string | sí | mismo formato. Único **dentro de su institución** |
| `nombre` | string | sí | nombre con que la institución la publica |
| `desde` | number | sí | año de la serie más antigua disponible. Entero de 4 dígitos |
| `url` | string | sí | página pública del emisor. `https://`, sin parámetros de sesión |
| `desc` | string | sí | qué contiene la base, en una o dos oraciones |
| `datos` | array | sí | al menos uno. Antes se llamaba `satelites` |

### 2.3 Dato (nivel 3)

| Campo | Tipo | Obligatorio | Regla |
|---|---|---|---|
| `id` | string | sí | mismo formato. Único **dentro de su base** |
| `nombre` | string | sí | cómo se le llama en la conversación técnica |
| `desde` | number | sí | año del primer registro de la serie. Puede ser anterior al `desde` de su base |
| `acceso` | string | sí | exactamente `"Acceso público"` o `"Acceso restringido"` |
| `desc` | string | sí | qué mide y a qué unidad de análisis refiere |
| `variables` | array de string | sí | entre 2 y 8. Nombres de variable, no oraciones |
| `url` | string | no | solo si la fuente del dato difiere de la de su base |
| `relaciones` | array de rutas | sí | puede ir vacío. Ver §3 |

Sobre `url`: en el catálogo actual los 52 datos lo omiten, y el prototipo cae
a la URL de la base. Eso significa que hoy **ningún enlace apunta al dato
concreto**, solo al portal del emisor. Si la revisión documental encuentra la
página específica de un dato, incluirla aquí mejora directamente la utilidad
de la tabla.

### 2.4 Desafío educativo

| Campo | Tipo | Obligatorio | Regla |
|---|---|---|---|
| `id` | string | sí | único entre desafíos |
| `nombre` | string | sí | dos o tres palabras |
| `pregunta` | string | sí | pregunta educativa real, terminada en signo de cierre |
| `datos` | array de rutas | sí | mínimo 3, máximo 8. Antes se llamaba `estrellas` |

Un desafío con datos de una sola institución no es un desafío: su valor está en
cruzar emisores. La validación lo advierte sin bloquear.

### 2.5 Frases

Objeto con cinco claves de texto (`universo`, `institucion`, `base`, `dato`,
`desafio`), una frase cada una. Son el eslogan por nivel del atlas. Si no se
tocan, se conservan las actuales.

---

## 3. Rutas y relaciones

Una ruta identifica un dato y tiene exactamente tres segmentos separados por
punto:

```
institucion.base.dato
```

Ejemplo real del catálogo vigente: `mineduc.datos-abiertos.asistencia`.

Como la unicidad de `base` y `dato` es por ámbito y no global, **ningún `id`
sirve como identificador por sí solo**: la ruta completa es la llave. El
catálogo actual ya tiene un caso, `puntajes`, que existe tanto en
`agencia.simce` como en `demre.paes`; no es un error, pero explica por qué
todo lo que apunte a un dato debe hacerlo con la ruta de tres segmentos.

**Reciprocidad.** Una relación afirma que dos datos se cruzan, y cruzarse es
simétrico: si A se cruza con B, B se cruza con A. En el catálogo vigente hay
89 relaciones declaradas y 41 de ellas no tienen su recíproca, es decir casi
la mitad. En la tabla eso se traduce en que un dato muestra una conexión que
su contraparte no muestra. La regla del contrato es que **toda relación se
declara en ambos extremos**; el validador lista las que falten y el arreglo es
mecánico.

Una relación no describe cómo se cruzan dos fuentes, solo que se cruzan. El
método del cruce es conocimiento interno del Área y no entra al catálogo
(criterio ya fijado en el backlog, entrada 69).

---

## 4. Colores institucionales

El color pertenece a la institución y sale de la paleta del SLEP, no del
emisor real: es un código visual del atlas, no la identidad corporativa de
cada organismo.

| Token | Hex | Asignado hoy a |
|---|---|---|
| `--mark-blue` | `#2A8FD9` | MINEDUC |
| `--ocean` | `#0062A0` | DEP |
| `--coral` | `#E88663` | Agencia de Calidad |
| `--mark-green` | `#9BC93E` | JUNAEB |
| `--mark-yellow` | `#FFC92E` | DEMRE |
| `--mark-red` | `#EE2D49` | Superintendencia |
| `--sand` | `#BCA493` | INE |
| `--mark-pink` | `#F8A0AE` | Desarrollo Social |
| `--olive` | `#75924E` | JUNJI |
| `--cream` | `#FFF6E0` | UNESCO · OECD |

Los diez valores de la paleta ya están tomados. **Una institución nueva no
inventa un color:** deja el campo con el hex de la paleta que le corresponda
por afinidad temática y se anota la colisión; resolverla es decisión de
diseño, no de la revisión documental. `#FFC92E` está además reservado como
color de interacción del atlas (hover), así que reutilizarlo en una
institución nueva es la peor opción disponible.

---

## 5. Posiciones en el mapa

`x` e `y` son porcentajes del viewport. El catálogo actual ocupa `x` entre 30
y 76, e `y` entre 16 y 84: la franja izquierda queda libre a propósito para el
encabezado del atlas.

Reglas: `x` entre 30 y 88, `y` entre 12 y 88, y **distancia euclídea mínima de
12 entre dos instituciones cualesquiera** para que los sistemas no se pisen.
El validador la calcula. Si una institución nueva no encuentra hueco, se deja
en `x: 0, y: 0` y el validador la reporta como pendiente de ubicación: es
trabajo de diseño, no de la revisión.

---

## 6. Flujo de alimentación

```
  revisión documental  ──►  atlas_datos.js  ──►  node 00_validar_atlas.js
                                                        │
                                          ┌─────────────┴─────────────┐
                                       falla                        pasa
                                          │                           │
                                 se corrige y repite      docs/atlas_datos.js
                                                                      │
                                                    tabla filtrable + atlas
```

1. **Producción.** La sesión de revisión escribe `atlas_datos.js` siguiendo
   este contrato.
2. **Validación.** `node 00_validar_atlas.js <ruta>` desde la raíz del
   proyecto. Devuelve 0 si el archivo es consumible y 1 si no; distingue
   errores (bloquean) de advertencias (no bloquean). Es la misma clase de
   verificación observable que `node --check` sobre `app.js`.
3. **Depósito.** Si valida, el archivo se copia a `docs/atlas_datos.js` y se
   commitea como un cambio conceptual propio, separado de cualquier cambio de
   código.
4. **Revisión de contenido.** El titular revisa el catálogo antes de que el
   sitio se difunda. La validación verifica forma e integridad referencial;
   **no verifica que los hechos sean ciertos**. Que una base exista desde tal
   año o que su acceso sea público es una afirmación que el Área firma.
5. **Ampliación.** Agregar instituciones, bases o datos es agregar objetos al
   arreglo y volver al paso 2. Ninguna ampliación toca la lógica de render.

### Qué NO hace este flujo

- No verifica que las URL resuelvan (requeriría red y rompería la
  reproducibilidad de la validación).
- No detecta un año equivocado ni una descripción errada.
- No decide colores ni posiciones de instituciones nuevas.

---

## 7. Plantilla mínima

```javascript
/* Catálogo del Atlas Celeste de los Datos Educativos.
   Contrato: 50_documentacion/activa/50_contrato_atlas_datos.md
   Validar con: node 00_validar_atlas.js docs/atlas_datos.js */

const ATLAS_INSTITUCIONES = [
  {
    id: "mineduc",
    nombre: "MINEDUC",
    desc: "Ministerio de Educación. Rectoría del sistema y mayor productor de datos educativos del país.",
    color: "#2A8FD9",
    x: 44, y: 42,
    bases: [
      {
        id: "datos-abiertos",
        nombre: "Datos Abiertos",
        desde: 2004,
        url: "https://datosabiertos.mineduc.cl",
        desc: "Portal de bases públicas del Centro de Estudios del Mineduc.",
        datos: [
          {
            id: "asistencia",
            nombre: "Asistencia",
            desde: 2011,
            acceso: "Acceso público",
            desc: "Asistencia media mensual por estudiante y establecimiento.",
            variables: ["asistencia media", "días asistidos", "días trabajados", "matrícula del período"],
            relaciones: ["mineduc.datos-abiertos.matricula", "junaeb.sinae.ive"]
          }
        ]
      }
    ]
  }
];

const ATLAS_DESAFIOS = [
  {
    id: "asistencia",
    nombre: "Asistencia y permanencia",
    pregunta: "¿Por qué disminuye la asistencia escolar?",
    datos: [
      "mineduc.datos-abiertos.asistencia",
      "mineduc.datos-abiertos.matricula",
      "junaeb.sinae.ive"
    ]
  }
];

const ATLAS_FRASES = {
  universo: "El problema no es la falta de datos: tenemos millones de estrellas, pero pocos mapas para comprenderlas.",
  institucion: "Cada institución es un sistema solar: sus bases de datos lo orbitan como planetas.",
  base: "Cada base de datos es un planeta: al acercarnos vemos los datos que lo componen.",
  dato: "El conocimiento aparece cuando conectamos los puntos.",
  desafio: "Las preguntas educativas dibujan constelaciones entre datos distantes."
};
```

---

## 8. Checklist de entrega

- [ ] Tres constantes declaradas con `const`, sin `export`, sin `import`.
- [ ] Todo `id` en minúsculas, dígitos y guion medio.
- [ ] Toda base con `url` `https://` de la página pública del emisor.
- [ ] Todo dato con `acceso` en uno de los dos valores exactos.
- [ ] Todo dato con entre 2 y 8 variables.
- [ ] Toda ruta de `relaciones` y de desafíos resuelve a un dato existente.
- [ ] Toda relación declarada en ambos extremos.
- [ ] `desde` de la base es el año en que existe la base; el del dato, el de su serie.
- [ ] `node 00_validar_atlas.js <archivo>` devuelve 0.
