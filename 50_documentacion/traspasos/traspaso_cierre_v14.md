# Traspaso de cierre — sesión 14

> **Destino:** `50_documentacion/traspasos/traspaso_cierre_v14.md`
> **Proyecto:** `slep_monitoreo` · **Fecha:** 2026-08-02 · **Modelo:** Claude Opus 5
> **Tipo de sesión:** CONTINUATION · **Traspaso anterior:** v13 (2026-08-01)
> **Naturaleza:** sesión de planificación. Sin código, sin maquetas, sin variantes visuales.

---

## 1. Estado de los archivos al cierre

| Archivo | Estado |
|---|---|
| `50_documentacion/activa/50_fundamento_seccion_formacion.md` | **Nuevo**, 13.1 KB, en su destino (fuente: `estructura_actual.md` generado 2026-08-02 11:08, leído en esta sesión) |
| `50_documentacion/activa/backlog_acumulativo.md` | Actualizado con la sesión 14, entradas 99-106 (fuente: ensamblado programático en esta sesión, 79.437 bytes) |
| `50_documentacion/traspasos/traspaso_cierre_v14.md` | Este archivo |
| `docs/atlas.js`, `docs/atlas.css` | Commiteados en `wip/atlas_tablero_v3`, commit `6894986` (fuente: reporte de terminal del titular en esta sesión). **Ver §6: hay una discrepancia por verificar** |
| Todo lo demás en `docs/` | Sin cambios: la sesión no tocó código |

Ningún archivo del sitio fue modificado. La sesión produjo dos documentos y un
commit de aislamiento.

---

## 2. Resumen ejecutivo

La sesión 13 cerró suspendiendo el desarrollo de la sección Formación tras tres
representaciones descartadas, con el diagnóstico de que la causa no estaba en
ninguna de las tres implementaciones sino en la ausencia de un fundamento
declarado. Esta sesión produjo ese fundamento.

Se resolvió primero la deuda técnica menor (el tablero sin commitear quedó
aislado en una rama local, sin tocar `main`, que es la rama publicada). Luego el
asistente propuso un índice de diez decisiones a cerrar, el titular lo aprobó, y
la sesión se condujo como una entrevista bloque por bloque. El producto es
`50_fundamento_seccion_formacion.md`, la fuente de verdad de la sección.

Los tres hallazgos que la próxima sesión no puede reconstruir por sí sola: el
propósito de la sección es **demostrativo y, por esa vía, formativo** (no
instrumental, como el asistente supuso tres veces); la metáfora celeste se
abandona como vocabulario estructural; y «ámbito de indagación» pasa a
**«desafío educativo»** para no colisionar con los tres ámbitos de actuación del
Área, que vienen de las Orientaciones ministeriales y no se alteran.

El estado es sano: sin bugs activos, sin bloqueantes, con el trabajo pendiente
convertido de «diseñar una representación» a «redactar el contenido que la
representación va a mostrar».

---

## 3. Verificaciones ejecutadas

| Qué | Resultado |
|---|---|
| Protocolo en knowledge base | `POLITICA_PROYECTO.md` y `SETTINGS_Y_PROMPTS_OPERACIONALES.md` presentes e indexados (fuente: `project_knowledge_search` en esta sesión) |
| Rama y estado de `docs/` antes del commit | Rama `main`; solo `docs/atlas.js` y `docs/atlas.css` modificados (fuente: reporte de terminal del titular) |
| Commit de aislamiento | `6894986b903f6dab9c52751299cb614d9a821329` en `wip/atlas_tablero_v3`, 2 archivos, 681 inserciones, 846 borrados, sin push (fuente: idem) |
| Estructura del repositorio | 99 archivos, 16 carpetas (fuente: `estructura_actual.md`, 2026-08-02 11:08) |
| Backlog ensamblado | 79.437 bytes, entradas 99-106 insertadas antes de §6, fila de sesión y total 98 → 106 actualizados (fuente: ensamblado en esta sesión) |

No se ejecutó `node --check` ni el validador del atlas: la sesión no modificó
código y correrlos no habría verificado nada de lo producido.

---

## 4. Delta respecto del traspaso anterior

v13 cerró con una sección suspendida, un diagnóstico correcto y ningún
instrumento para actuar sobre él. v14 entrega el instrumento. El delta de fondo
es que el criterio de aceptación de la sección Formación dejó de ser tácito: hoy
existen siete criterios escritos, un orden de verificación en dos pasos y un
presupuesto de dos intentos por elemento.

El segundo delta es terminológico y afecta artefactos ya existentes: el
renombre de «ámbito de indagación» a «desafío educativo» toca el contrato del
atlas, el catálogo y el validador. Ninguno se modificó en esta sesión.

---

## 5. Cambios de la sesión, uno por uno

### 5.1 Aislamiento del tablero sin commitear

- **Qué:** `docs/atlas.js` y `docs/atlas.css` pasaron a la rama local `wip/atlas_tablero_v3`.
- **Por qué:** `main` es la rama que sirve GitHub Pages. Commitear ahí un tablero sin revisión visual y con destino probable de descarte contamina la rama publicada; dejarlo sin commitear arrastra un árbol sucio a una sesión de planificación; revertirlo pierde el insumo.
- **Alternativas descartadas:** commit en `main`, dejarlo tal cual.
- **Estado:** commit `6894986`, sin push.

### 5.2 Documento de fundamento

- **Qué:** `50_fundamento_seccion_formacion.md`, once secciones (las diez del índice aprobado más una tabla de tareas derivadas).
- **Cómo se produjo:** entrevista por bloques. El asistente propuso el índice, el titular lo aprobó, y cada bloque cerró con una formulación registrada antes de pasar al siguiente.
- **Método deliberado:** el asistente entregó una recomendación explícita en cada bloque, y el titular la aceptó, la corrigió o la reemplazó. Tres recomendaciones fueron corregidas de raíz (propósito, protagonista de la sección, orden de los elementos): la corrección es la parte valiosa del método, no su fracaso.

### 5.3 Las diez decisiones cerradas

Resumidas; el texto canónico está en el fundamento.

1. **Propósito.** Demostrativo y por esa vía formativo. El catálogo es evidencia, no producto. La sección pertenece al tercer ámbito de actuación del Área.
2. **Audiencia.** Primaria: establecimientos, áreas del Servicio Local, pares externos (con énfasis en áreas de monitoreo de instalación reciente). Secundaria: cualquier interesado. Llegada doble: en frío desde la firma de correo, y proyectada en talleres. Piso técnico: contexto educativo sabido, procesamiento de datos no.
3. **Alcance.** Entender, no usar. Espacio en crecimiento. Casos reales solo en términos conceptuales; sin código, sin establecimientos, sin datos privados.
4. **Relación con el portafolio.** Capas paralelas, dos registros deliberadamente distintos, unidos por sistema visual y anclaje temático. Responden a mandatos distintos del Área.
5. **Línea editorial.** Primera persona plural en todo el sitio. Metáfora celeste abandonada. Bloques cortos intercalados con objetos interactivos; la didáctica manda.
6. **Promesa de uso.** Tres promesas acumulativas y ampliables. Cierre hacia portafolio y contacto. Recorrido lineal con ruta visible y salto posible.
7. **Inventario y orden.** Siete elementos; peso interactivo concentrado en el 2 (flujo con bifurcaciones), el 3 (un desafío en detalle con caso real) y el 6 (el cruce, protagonista).
8. **Publicación.** Tres etapas. Mínimo publicable: elementos 1 a 4 más cierre. Pendientes visibles mientras no se difunda; invisibles antes de difundir.
9. **Criterios de aceptación.** Siete criterios, verificación en dos pasos (descripción escrita, luego maqueta desechable) antes de código de producción.
10. **Regla de descarte.** Dos intentos por elemento; detención obligatoria ante criterio incumplido; vuelta al fundamento tras el segundo descarte.

### 5.4 Ruta de desarrollo acordada

| Sesión | Alcance |
|---|---|
| 1 | Redactar el texto de los elementos 1, 2 y 4; elegir el desafío educativo del elemento 3 con su caso real |
| 2 | Descripción escrita del recorrido completo (ruta visible, anclas, qué es interactivo) |
| 3 | Elemento 2: maqueta desechable del diagrama de flujo, luego producción |
| 4 | Elemento 3: maqueta desechable, luego producción |
| 5 | Etapa 1 completa (elementos 1, 4, 7), renombre visible a «desafío educativo», revisión en navegador |
| 6 | Etapa 2: catálogo integrado a la narración |
| 7 | Etapa 3: el cruce |

La próxima sesión es la 1 de esta ruta. Se eligió partir por contenido y no por
estructura porque sin el texto real y el caso elegido, la descripción del
recorrido vuelve a discutirse en abstracto, que es la condición exacta en que se
produjeron los tres descartes.

---

## 6. Bugs de la sesión

Ningún bug de código: la sesión no escribió ni ejecutó código.

**Una discrepancia observable, no resuelta.** El escáner del 2026-08-02 11:08
reporta `docs/atlas.js` en 22.0 KB y `docs/atlas.css` en 12.0 KB. El escáner del
2026-08-01 09:57 reportaba 18.3 KB y 10.5 KB (fuente: ambos `estructura_actual.md`,
leídos en esta sesión). Si el commit del tablero quedó en `wip/atlas_tablero_v3`
y el árbol volvió a `main`, los tamaños en `main` deberían ser los antiguos. Dos
explicaciones posibles: el escáner corrió estando en la rama `wip`, o el árbol de
`main` conserva los archivos nuevos. Verificar con:

```bash
cd /Users/tomgc/Projects/slep_monitoreo && git branch --show-current && \
  git status --short docs/ && ls -l docs/atlas.js docs/atlas.css
```

No es un bug: es una premisa de estado que no fue verificada en esta sesión y que
la próxima **no debe dar por buena**.

---

## 7. Decisiones de diseño y sus alternativas

| Decisión | Alternativa descartada | Razón |
|---|---|---|
| Propósito demostrativo-formativo | Propósito instrumental (buscar fuentes) | El titular corrigió: el sujeto del cambio es quien entiende cómo trabaja el Área |
| Protagonista: el cruce desafíos-fuentes | Un caso real paso a paso; el catálogo como inventario | El itinerario narrativo es que distintos desafíos convocan distintos datos y por tanto distintas fuentes |
| Metáfora celeste abandonada | Conservarla como recurso local | Fue el único vocabulario común a las tres representaciones descartadas |
| «Desafío educativo» | Renombrar «ámbito de actuación»; distinción tipográfica | El término ministerial no es del Área alterarlo |
| Catálogo dentro de la misma página | Página propia enlazada | Decisión del titular: la sección lo necesita para el cruce final |
| Rama `wip` para el tablero | Commit en `main`; revert | Preserva el insumo sin tocar la rama publicada |

---

## 8. Tensiones entre principios y cómo se resolvieron

**Llegada en frío contra uso en taller.** La primera exige narración completa y
autosuficiente; la segunda, bloques saltables y legibles a distancia. Se
resolvió con la ruta visible: recorrido lineal primario más mapa del recorrido
con salto posible. Por eso el índice o indicador de progreso no es un adorno y
quedó como criterio de aceptación, no como sugerencia.

**Catálogo protagonista contra catálogo no didáctico.** El bloque 5 concluyó que
un objeto didáctico opera sobre un caso acotado y que 83 filas no lo son; el
bloque 7 puso al catálogo como protagonista. Se resolvió distinguiendo el
catálogo como inventario (elemento 5, consulta) del catálogo leído desde los
desafíos (elemento 6, protagonista).

**Publicar con huecos contra demostrar método.** Mientras la audiencia es solo el
Área, ver lo que falta es útil; ante audiencia externa, un catálogo con huecos
declarados contradice lo que la sección demuestra. Se resolvió con una regla de
vencimiento explícita atada al acto de difundir la dirección.

---

## 9. Estado del repositorio

- Rama `main`, 20 commits por delante de `origin/main`, sin push autorizado (fuente: reporte de terminal del titular en esta sesión).
- Rama local `wip/atlas_tablero_v3` con el commit `6894986`.
- Modificados fuera de `docs/` al momento del reporte: `ESTADO.md`, `backlog_acumulativo.md` y los cuatro archivos del escáner en `50_documentacion/estructura/`. Los cuatro del escáner son ruido permanente y nunca se commitean.
- Los archivos de gobernanza (`POLITICA_PROYECTO.md`, `SETTINGS_Y_PROMPTS_OPERACIONALES.md`, `CLAUDE.md`) siguen en `.gitignore`.

---

## 10. Arquitectura de archivos

Sin cambios estructurales. Un archivo nuevo en una carpeta existente:
`50_documentacion/activa/50_fundamento_seccion_formacion.md`. El total pasó de
98 a 99 archivos (fuente: `estructura_actual.md` de 2026-08-01 y de 2026-08-02,
ambos leídos en esta sesión). La ubicación cumple la política: documento activo
de gobernanza de contenido, con prefijo `50_` como sus pares.

---

## 11. Pendientes y ruta sugerida

### P1 · Redactar el contenido de los elementos 1, 2 y 4 y elegir el caso del elemento 3

- **Tipo:** funcionalidad (contenido). **Complejidad:** media. **Dependencias:** ninguna.
- **Contexto:** es la sesión 1 de la ruta acordada en §5.4.
- **Enfoque:** trabajar en texto plano, sin HTML. El fundamento fija voz, piso técnico y no-alcance; el texto se juzga contra ellos.
- **Precauciones:** el caso real debe pasar el no-alcance (sin nombres de establecimientos, sin identificadores, sin código, sin resultados atribuibles). Elegir el desafío educativo más ilustrativo entre los seis del catálogo, no el más completo.
- **Criterio de éxito:** texto aprobado por el titular para los elementos 1, 2 y 4, y un desafío elegido con su caso descrito conceptualmente.

### P2 · Verificar el estado real de `docs/atlas.js` y `docs/atlas.css` en `main`

- **Tipo:** deuda técnica. **Complejidad:** trivial. **Bloquea:** nada, pero contamina cualquier commit futuro en `docs/`.
- **Contexto:** ver §6. Discrepancia de tamaños entre los dos escáneres.
- **Criterio de éxito:** saber si `main` tiene los archivos antiguos o los nuevos, y dejarlo como corresponda.

### P3 · Reescribir `index.html` a primera persona plural

- **Tipo:** contenido. **Dependencias:** conviene hacerlo junto a la sesión 5 de la ruta, cuando la etapa 1 fija la voz nueva y la incoherencia se vuelve visible.

### P4 · Revisar la barra de navegación

- **Tipo:** UX copy. Hoy dice «Portafolio / Formación en datos», que se lee como dos secciones de un sitio y no como dos mandatos de un área.

### P5 · Renombrar los identificadores internos de `ambito` a `desafio`

- **Tipo:** deuda técnica. **Alcance:** `docs/atlas_datos.js`, `50_contrato_atlas_datos.md` §2.4, `00_validar_atlas.js`, `docs/formacion.js`.
- **Precaución:** es un renombre transversal con validador de por medio; corre `node 00_validar_atlas.js docs/atlas_datos.js` después y exige `exit=0`.

### P6 · Resolver o retirar las fuentes pendientes del catálogo

- **Tipo:** deuda de datos. **Vence:** antes de difundir la dirección del sitio.
- **Contexto:** `40_salidas/solicitudes_al_titular.md` agrupa las pendientes por lo que requieren del titular.

### P7 · Decidir el destino definitivo del tablero en `wip/atlas_tablero_v3`

- **Tipo:** deuda técnica. **Cuándo:** cuando la etapa 3 defina el objeto del cruce. Si nada de ese código sirve, la rama se borra.

### Deuda técnica conocida, sin cambios

- `esc`, `porId`, `plural` y `buscar` duplicadas entre `atlas.js` y `formacion.js`.
- Peso Museo Sans 400 ausente; las solicitudes de 400 resuelven a 500.
- Payload de capturas, varios archivos sobre 400 KB.

### Auditoría de cierre

| # | Pregunta | Respuesta |
|---|---|---|
| 1 | ¿Todo lo producido está materializado como archivo? | Sí: fundamento, backlog y este traspaso |
| 2 | ¿El pipeline corre de cero sin intervención manual? | No aplica: la sesión no ejecutó pipeline |
| 3 | ¿Hay afirmaciones de estado sin fuente? | No. La única premisa no verificada está declarada como tal en §6 |
| 4 | ¿Quedaron decisiones tomadas solo en el chat? | No: las diez están en el fundamento |
| 5 | ¿El backlog quedó actualizado? | Sí, entradas 99-106 |

### Ruta sugerida para la próxima sesión

1. **P2 primero, en un turno.** Verificar el estado de `docs/` antes de cualquier otra cosa.
2. **P1 como foco completo.** Redacción de contenido, sin tocar HTML ni CSS.
3. **Diferir P3 a P7.** Ninguno aporta a la sesión de contenido y todos compiten por el mismo contexto.

---

## 12. Instrucciones específicas para la próxima sesión

- ⚠️ **NO** escribir HTML, CSS ni JS en la sesión de contenido. Si el asistente se descubre proponiendo una forma, volvió al modo que causó los tres descartes.
- ⚠️ **NO** dar por buena la premisa de que `main` tiene los archivos antiguos de `atlas.js` y `atlas.css`. Verificar primero (§6).
- ✅ **ANTES de** proponer cualquier texto, leer `50_fundamento_seccion_formacion.md` completo: voz, piso técnico, no-alcance y criterios de aceptación salen de ahí.
- ✅ **ANTES de** usar la palabra «ámbito», decidir cuál de los dos: ámbito de actuación (mandatos) o desafío educativo (agrupador del catálogo).
- 🔒 El fundamento es la fuente de verdad. Una decisión que lo contradiga obliga a cambiarlo por escrito antes de tomarla, no después.
- 🔒 Ningún `git push`, `--force`, `reset --hard` ni tag sin autorización explícita del titular.
- 🔒 Nunca `git add -A`. Los cuatro archivos del escáner en `50_documentacion/estructura/` no se commitean.

---

## 13. Fragmentos de código de referencia

Sin patrones nuevos: la sesión no produjo código. Los patrones estables del
proyecto viven en `CLAUDE.md` y en `POLITICA_PROYECTO.md`.

---

## 14. Reapertura

**Mensaje de apertura pre-armado para la próxima sesión:**

> Tipo CONTINUATION. El protocolo (`POLITICA_PROYECTO.md` v5.5 +
> `SETTINGS_Y_PROMPTS_OPERACIONALES.md` v15) vive en la knowledge base del
> Project; verifica que estén al día antes de empezar. Adjunto el traspaso v14,
> el escáner, el backlog y el documento de fundamento de la sección Formación.
>
> Esta sesión es la número 1 de la ruta de implementación: **redacción de
> contenido**, sin HTML, CSS ni JS. El objetivo es el texto de los elementos 1
> (quiénes somos y qué hacemos), 2 (cómo contribuimos desde los datos) y 4
> (todos los desafíos educativos), más la elección del desafío educativo del
> elemento 3 con su caso real del Área en términos conceptuales.
>
> Antes de empezar, resuelve en un turno la verificación pendiente del estado de
> `docs/atlas.js` y `docs/atlas.css` en `main` (ver §6 del traspaso v14).
>
> Estado: sin bugs activos, sin bloqueantes, 20 commits locales sin pushear.

**Documentos para la próxima sesión:**

1. *Protocolo en knowledge base* (no se adjuntan; se listan para verificar que
   esté al día): `POLITICA_PROYECTO.md`, `SETTINGS_Y_PROMPTS_OPERACIONALES.md`.
2. *Opcionales según el foco:* ninguno. La sesión no ejecuta en Claude Code ni
   emite encargos.
3. *Específicos de la sesión, se adjuntan:* `traspaso_cierre_v14.md`,
   `estructura_actual.md`, `backlog_acumulativo.md`,
   `50_fundamento_seccion_formacion.md`, `docs/atlas_datos.js` (para elegir el
   desafío educativo más ilustrativo entre los seis y ver qué datos convoca),
   `docs/formacion.html` (el texto vigente que se va a reemplazar).

---

## 15. Errores del asistente

| # | Error | Causa | Patrón | Resolución |
|---|---|---|---|---|
| E-01 | Las tres opciones ofrecidas en el bloque 1 (propósito) eran todas instrumentales: qué se lleva quien busca un dato. Ninguna contemplaba que el propósito fuera demostrar el método del Área | El asistente arrastró el marco de las sesiones anteriores, donde la sección era un catálogo con envoltorio | Ofrecer alternativas dentro de un marco no declarado, de modo que elegir entre ellas no cuestiona el marco | El titular formuló el propósito fuera del menú. Regla: cuando el titular responde «no sé en cuál cae», la causa probable es que el menú esté mal planteado, no que la respuesta sea ambigua |
| E-02 | En el bloque 2 se propuso reducir cuatro públicos primarios a uno («primario las otras áreas»), tratando la multiplicidad como indecisión del titular | Preferencia del asistente por cerrar rápido sobre precisión del registro | Convertir una recomendación en presión para simplificar una realidad que es legítimamente múltiple | Se registraron los cuatro y se extrajo lo común (el interés, no el nivel), que es lo que en efecto restringía la narración |
| E-03 | En el bloque 7 se recomendó un caso real como protagonista y mover el catálogo a página propia, contra lo que el titular ya había señalado sobre el valor del catálogo | Lectura parcial del bloque 5, que había concluido que el catálogo completo no es material didáctico | Tratar una conclusión intermedia como premisa cerrada sin contrastarla con el propósito declarado | El titular corrigió; la síntesis (catálogo leído desde los desafíos) resolvió la tensión sin descartar ninguna de las dos posiciones |

Ninguno de los tres costó trabajo perdido: los tres se corrigieron dentro del
mismo bloque. Se registran porque el patrón común (proponer dentro de un marco
heredado sin declararlo) es exactamente el que produjo las tres representaciones
descartadas.
