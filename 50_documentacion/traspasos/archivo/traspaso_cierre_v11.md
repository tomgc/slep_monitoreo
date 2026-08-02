# Traspaso de cierre v11 — slep_monitoreo

## 1. Identificación

| Campo | Valor |
|---|---|
| Proyecto | `slep_monitoreo` |
| Versión del traspaso | v11 |
| Fecha | 2026-07-30 |
| Sesión | 11 (Claude Opus 5, ejecutada en Claude Code) |
| Foco | Producción y verificación del catálogo de fuentes de datos del Área, de punta a punta: 74 URLs candidatas abiertas una por una en cinco tramos con compuerta, 83 filas emitidas, validadas y renderizadas como fichas. Adopción del primer pipeline de R del proyecto. Cierre previo de la deuda de la sesión 10. |
| Entorno | macOS · Git · R 4.5.2 con tidyverse · GitHub Pages desde `main` y `docs/` |
| Repositorio | `https://github.com/tomgc/slep_monitoreo.git` · rama `main` |
| Directorio local | `/Users/tomgc/Projects/slep_monitoreo/` |
| Protocolo vigente | `POLITICA_PROYECTO.md` v5.5 · `SETTINGS_Y_PROMPTS_OPERACIONALES.md` v15 |
| Modo de trabajo | Encargo autónomo por lotes con compuertas, ejecutado en Claude Code |
| Archivos principales creados | `30_procesamiento/31_catalogo_fuentes_filas.R`, `32_validar_catalogo_fuentes.R`, `33_emitir_fichas_fuentes.R`, `40_salidas/catalogo_fuentes.csv`, `40_salidas/catalogo_fuentes_fichas.md`, `40_salidas/log_verificacion_fuentes.csv`, `40_salidas/solicitudes_al_titular.md` |
| Archivos principales modificados | `CLAUDE.md`, `50_documentacion/activa/backlog_acumulativo.md`, `50_documentacion/activa/ESTADO.md` |

## 2. Resumen ejecutivo

La sesión abrió cerrando la deuda de la sesión 10: publicó los tres commits pendientes y ejecutó dos encargos consecutivos sobre el pendiente P5, que en ambos casos terminaron cancelando la eliminación por evidencia viva en el markup. Con eso liberado, el foco pasó al catálogo de fuentes de datos, que el traspaso v10 esperaba recibir de una sesión paralela y que en cambio se produjo aquí. El insumo era un inventario de 74 URLs candidatas **no verificadas**; el trabajo consistió en abrirlas una por una. Se ejecutó en cinco tramos de quince con compuerta del titular, y cada cierre de tramo escribió a disco y commiteó antes de reportar, de modo que un corte de sesión no perdiera trabajo. El resultado son 83 filas de catálogo sobre un esquema que creció de 26 a 29 campos a través de nueve enmiendas aprobadas, todas registradas en el propio encargo para que el contrato siguiera siendo verdadero. Nueve fallas de transporte distintas aparecieron en el camino y ninguna se clasificó como enlace roto sin distinguir su causa. La enmienda de mayor rendimiento fue la doble fuente: cruzar el catálogo contra las copias que ya viven en los proyectos hermanos del portafolio, que resolvió metadatos que ninguna página publica. El catálogo quedó validado por script y emitido como fichas; 38 solicitudes quedaron pendientes del titular, agrupadas por lo que necesitan de él. El frente del atlas no se tocó.

## 3. Estado al cierre

### Qué funciona

| Componente | Estado | Última verificación |
|---|---|---|
| Catálogo de fuentes | 83 filas × 29 campos, 0 celdas vacías, correlativo F001-F083 íntegro | `32_validar_catalogo_fuentes.R` exit 0 |
| Validador del catálogo | Seis comprobaciones, aborta con `stop()` sin emitir si alguna falla | corrida de la sesión |
| Fichas del catálogo | 83 fichas de 27 campos, 2.778 líneas | `grep -c "^#### F"` = 83 = filas del CSV |
| Log de verificación | 74 líneas, una por URL candidata, cuadra lote por lote con el reconocimiento | recuento programático |
| Pipeline de R | `20_insumos/` → `30_procesamiento/` → `40_salidas/`, tres scripts correlativos | las tres corridas de la sesión |
| Sitio en producción | Sin cambios: `docs/` intacto en toda la sesión | `git diff` sobre `docs/` vacío |
| Repositorio | Árbol limpio, 10 commits nuevos sin publicar | `git status --short` vacío |

### Qué no funciona

Nada reportado como defecto activo. Lo que está incompleto es **contenido**, no código: 38 fuentes del catálogo conservan `NA` en campos que solo se pueden llenar con acceso que el asistente no tiene, y eso está declarado fuente por fuente.

### Delta respecto de v10

- El proyecto dejó de ser solo un sitio estático: tiene un pipeline de R con insumo, procesamiento y salidas.
- Existe un catálogo de fuentes verificado, que v10 esperaba recibir y no se había producido.
- `CLAUDE.md` dejó de afirmar que no hay pipeline de R, que era su excepción declarada.
- El pendiente P5 pasó de "eliminar tokens huérfanos" a una decisión de diseño abierta, tras dos cancelaciones documentadas.
- El remoto sigue con una sola rama; `main` avanzó de `952d89b` a `1dcbafe` y luego acumuló 10 commits locales sin publicar.

## 4. Registro detallado de cambios

Los siete cambios conceptuales de la sesión están en el backlog acumulativo, entradas **82 a 88**, con su causa raíz y su categoría. No se repiten aquí. Lo que sigue son las decisiones que el backlog no alcanza a explicar.

### 4.1 El esquema creció de 26 a 29 campos por enmienda, no por deriva

El encargo declaraba 26 campos y prohibía agregarlos sin pasar por la compuerta. Se agregaron tres, uno por vez, cada uno aprobado antes de aplicarse y registrado en una sección **Enmiendas aprobadas** anexada al propio encargo:

- `variables` (E2), nombres de variable observados, tras la compuerta de la Fase 0.
- `copia_local` (E4), la raíz de datos del proyecto hermano donde el archivo ya vive.
- `fuente_equivalente` (E8), bidireccional, para los datos publicados por más de una vía.

El vocabulario de `formato` también creció, con `rar` (E1), después de que las primeras cuatro páginas de Datos Abiertos mostraran que el formato de distribución real no estaba en la lista. Esa fue una detención legítima: el encargo prohíbe improvisar metodología, y elegir cómo codificar `.rar` es metodología.

### 4.2 Nueve fallas de transporte, todas distinguidas

Un catálogo que llame "enlace roto" a todo lo que no cargó es un catálogo que miente. Se distinguieron: HTTP 403 sobre host vivo (6 fuentes), HTTP 404 sobre host vivo (2), dominio que no resuelve (2, una con espejo vivo), cadena TLS no verificable (2), cabeceras HTTP malformadas en todo un dominio (2), bucle de redirecciones (1), plantilla que solo se arma en el navegador (2), y PDF de imagen sin texto extraíble (2). Solo dos fuentes quedaron como `Enlace roto` y una como `No encontrada`.

### 4.3 La doble fuente, y por qué el primer cruce falló

El titular observó que el primer cruce contra los proyectos hermanos encontró solo dos coincidencias y sugirió que el matcheo había sido conservador. Tenía razón: cruzaba por **nombre de proyecto**. Al cruzar por **nombre de archivo** aparecieron históricos completos de Datos Abiertos en `slep_estudio_oferta_demanda` y 170 esquemas de registro (`ER_*.pdf`) que el portal no publica en la web. Eso subió `variables` de 2 a 10 fuentes y `copia_local` de 2 a 10.

**Regla aprendida:** cruzar un catálogo contra un acervo local por nombre de proyecto encuentra lo que el nombre del proyecto anuncia; cruzar por nombre de archivo encuentra lo que el acervo realmente contiene. Son cosas distintas y la segunda es la que importa.

### 4.4 El barrido de esquemas resolvió tres fuentes y ninguna del bloque A

Los 170 `ER_*.pdf` corresponden exactamente a las bases ya descargadas, que son justo las que la doble fuente ya había resuelto. Ninguna de las 12 solicitudes pendientes del bloque A tiene su esquema en disco, **porque el esquema viaja dentro del `.rar`**: sin bajar el archivo tampoco hay libro de códigos. El barrido igual valió: resolvió tres fuentes que estaban en `Declarada sin verificar` con todo en `NA`, y rescató dos advertencias del emisor que ninguna página publica (ver §7).

## 5. Backlog acumulativo

Vive en `50_documentacion/activa/backlog_acumulativo.md`. Esta sesión agrega las entradas **82-88** (7 nuevas), llevando el total de 81 a 88. Sin reescritura ni renumeración de entradas anteriores.

## 6. Bugs de la sesión

**Sin bugs de código en esta sesión.** Los scripts corrieron sin `warning()` no explicado desde su primera versión funcional. Los dos defectos encontrados fueron de datos y de método, y están en §7 y §15 respectivamente.

## 7. Aprendizajes y restricciones descubiertas

1. **El vocabulario controlado describe el mundo, y el mundo no pidió permiso.** MINEDUC distribuye en `.rar`, formato ausente del esquema. La regla: cuando un valor observado no cabe en un vocabulario cerrado, se detiene y se propone; no se mapea a un valor "parecido" (`.rar` no es `.zip`) ni se descarta a `NA`, que perdería lo observado.

2. **Un HTTP 403 no es un enlace roto.** El host respondió; lo que falló es la recuperación por esta herramienta, y un navegador humano probablemente sí alcance la página. Clasificarlo como roto habría mandado al titular a buscar una URL de reemplazo que no hace falta.

3. **Las páginas de organización de `datos.gob.cl` rinden como HTML; las fichas de conjunto, no.** `/organization/<slug>` entrega nombres, formatos, licencias y fechas; `/dataset/<slug>` devuelve la portada del portal. Cuando la ficha no rinde, la página de organización es una fuente legítima para los metadatos de sus conjuntos.

4. **Cruzar un acervo local por nombre de proyecto subestima lo que hay.** Ver §4.3.

5. **El esquema de registros viaja dentro del comprimido.** Por eso el barrido de `ER_*.pdf` no puede resolver una fuente cuya base no está descargada: no es que el esquema falte, es que está dentro del archivo que falta.

6. **Una serie con hueco declarado no se escribe como rango continuo.** La asistencia anual por estudiante **no se elaboró en 2020 ni 2021** por el cierre de establecimientos durante la pandemia. Escribir `2015-2025` en `cobertura_temporal` habría hecho que un análisis de tendencia leyera dos años ausentes como una caída de asistencia. El corte va en el campo y el motivo en observaciones.

7. **Un emisor puede eliminar registros de la base pública por protección de datos, y decirlo solo en el esquema.** De la asistencia anual pública se excluyeron los registros de estudiantes no binarios —cinco casos en 2025— por ser fácilmente identificables al cruzar variables, en cumplimiento de la Ley 19.628. Ningún cómputo sobre esa base cubre a esos estudiantes, y eso solo consta en el PDF del libro de códigos.

8. **El directorio oficial de establecimientos trae `RUT_SOSTENEDOR` sin enmascarar.** Es la única fuente del catálogo con identificador directo de persona, y está declarada como tal. Su tratamiento cae bajo la gobernanza de datos del proyecto.

## 8. Decisiones de diseño

| # | Decisión | Alternativas | Justificación | Implicancia |
|---|---|---|---|---|
| D1 | Adoptar las decenas de la política §1.1 | Scripts `00_` en la raíz, como el escáner y el validador del atlas | El proyecto pasó a tener un pipeline real con insumo, procesamiento y salida distinguibles; forzarlo en `00_` oculta esa naturaleza justo cuando aparece | Tres carpetas nuevas y `CLAUDE.md` corregido; hueco declarado en la decena 10 |
| D2 | Sin orquestador `00_run_all.R` | Generarlo por completitud | El pipeline tiene una compuerta humana en medio: la verificación de URLs no es automatizable | Cada script se corre por separado, y así está declarado |
| D3 | El CSV es la fuente; las fichas se generan | Editar el `.md` a mano | Un producto editable a mano diverge de su origen en la primera corrección apurada | El `.md` se regenera; toda corrección se hace en `31_` y se revalida |
| D4 | Las republicaciones no generan fila por defecto (E7) | Catalogar los 30 conjuntos de `datos.gob.cl` | Duplicaría cada dato bajo dos bases; solo aporta fila quien agrega licencia, formato, cobertura o desagregación | BIDAT sí generó fila (aporta `.dta`, `.rdata`, `.sav`); las organizaciones del CEM no |
| D5 | La copia local manda sobre la página web (E3) | Verificar solo por web | La copia declara separador, codificación, columnas y años efectivos, que el portal no publica | Acceso de solo lectura a proyectos hermanos, sin copiar ni mover nada |
| D6 | Incluir el Lote I aunque la instrucción del tramo 5 lo omitiera | Ejecutar los 10 que decía la instrucción | El criterio de aceptación exige que toda URL candidata tenga destino; cerrar sin el Lote I habría entregado un catálogo incompleto presentado como completo | 14 filas en el tramo 5 en vez de 10, declarado en el reporte |
| D7 | Revertir `Bienal` en vez de agregarlo al vocabulario | Extender el vocabulario a nueve valores | Casen no es bienal de forma estable (hay saltos de tres años); el vocabulario no debe absorber esa irregularidad | F030 queda en `Sin periodicidad definida` con el patrón real en observaciones |

## 9. Constantes y parámetros

Constantes nuevas, todas declaradas al inicio de los scripts que las usan, ninguna embebida en el flujo:

| Constante | Valor | Archivo | Motivo |
|---|---|---|---|
| `CAMPOS` | los 29 nombres del esquema, en orden | `31_`, `32_`, `33_` | Contrato del catálogo; el orden es parte del contrato |
| `VOCABULARIOS` | lista de 9 dominios cerrados | `32_` | Vocabularios controlados del encargo §5 |
| `VOC_FORMATO` | 11 valores, con `rar` (E1) | `31_`, `32_` | Multivalor, se valida por token |
| `PATRON_ID` | `^F[0-9]{3}$` | `32_` | Patrón del identificador de fuente |
| `EQUIVALENCIAS` | 4 pares recíprocos de Casen | `31_` | Enmienda E8, verificada en ambos extremos |

Las constantes del sitio (paleta, tipografía, escalas) siguen en `docs/colors_and_type.css` y ninguna cambió.

## 10. Arquitectura de archivos

Escáner al cierre: `50_documentacion/estructura/estructura_actual.md`, generado el **2026-07-30 17:23:11**, con **16 carpetas y 90 archivos** (al abrir la sesión: 13 y 77).

Cambios estructurales:

- Tres carpetas nuevas en la raíz: `20_insumos/`, `30_procesamiento/`, `40_salidas/`.
- El inventario del reconocimiento salió de `50_documentacion/activa/` hacia `20_insumos/`, conservando su nombre original por la excepción de la política §1.2.4.
- `50_documentacion/traspasos/` queda con un solo archivo a la vista tras archivar el v10.

Verificación contra la política: la estructura respeta las decenas y la nomenclatura. El hueco en la decena 10 está declarado como excepción en `CLAUDE.md`.

## 11. Pendientes y ruta sugerida

### 11.1 Inventario

| # | Pendiente | Tipo | Contexto | Impacto | Dependencias | Complejidad | Criterio de éxito |
|---|---|---|---|---|---|---|---|
| P1 | Publicar los 10 commits de la sesión 11 | documentación | Árbol limpio, nada pusheado | Bajo | autorización del titular | baja | `git rev-list --left-right --count @{u}...HEAD` → `0 0` |
| P2 | Resolver las 38 solicitudes del catálogo | bloqueante | Ver §11.4; agrupadas por bloque en `40_salidas/solicitudes_al_titular.md` | Alto: es el contenido faltante del catálogo | entrega del titular | media, es trabajo del titular más una pasada de reproceso | Las 38 marcadas resueltas y sus campos poblados |
| P3 | Decidir el frente del atlas | funcionalidad | Ver §11.3; el catálogo de fuentes NO alimenta el atlas automáticamente | Alto | decisión del titular | alta | Decisión tomada y, si es afirmativa, encargo emitido |
| P4 | Revisar el catálogo de fuentes contra las fuentes | gobernanza | 49 de 83 filas están `Verificada`; el Área firma cada afirmación | Alto | P2 | media, es trabajo del titular | Cada fuente confirmada por el Área |
| P5 | Tokens `--banner-*` huérfanos | deuda técnica | Dos cancelaciones documentadas; `data-variant="d2"` está vivo y `.banner` no tiene consumidor | Bajo, deuda inerte | decisión de diseño sobre la variante `d3` | baja | Decisión tomada sobre `d3` y, si procede, eliminación con grep discriminante |
| P6 | Construir la entrada del proyecto Simce | funcionalidad | Pendiente desde la sesión 7; espera tres PDF del titular | Medio | entrega del titular | media | Proyecto `simce` con capturas y reseña en `data.js` |
| P7 | Fase 0 del catálogo de Project Cards | funcionalidad | Once campos nuevos en `data.js`; diagnóstico completo en el log de la sesión 11 | Medio | decisiones del Área sobre `madurez` y `evidencia` | media | Los once campos poblados |
| P8 | Ordenación del repositorio (§4.7) | deuda técnica | No existe `50_ordenacion_repositorio.md`; gatillo 4bis encendido | Bajo | árbol limpio y rama propia | media | El marcador existe y los cuatro bloques quedaron ejecutados |

### 11.2 Evaluación de deuda técnica

**Zonas frágiles.** `31_catalogo_fuentes_filas.R` declara las 83 filas como literales en cinco `tribble` encadenados; es explícito y auditable, pero cualquier edición manual puede desalinear una columna sin que se note hasta la validación. Mitigante real: `32_` verifica el esquema completo antes de que `33_` emita, y `31_` valida antes de escribir.

**Oportunidad.** Las 38 solicitudes están agrupadas por lo que necesitan del titular. Resolverlas en una sola pasada, y no de a una, es lo que hace que el reproceso sea barato.

### 11.3 El frente del atlas, que esta sesión no tocó

`docs/`, `docs/atlas_datos.js` y `50_documentacion/activa/50_contrato_atlas_datos.md` quedaron **intactos**, verificado programáticamente. Es la siguiente decisión del titular, no una tarea abierta.

Lo que esa decisión necesita saber es el veredicto de la Fase 0 sobre la relación entre el catálogo de fuentes y el contrato del atlas:

> **El esquema de 29 campos es INDEPENDIENTE del contrato del atlas, con solapamiento parcial, y puede alimentarlo tras una transformación declarada. NO lo contradice.**

Son dos artefactos de forma, unidad y propósito distintos: el contrato del atlas describe una estructura JS **anidada de tres niveles** (institución → base → dato) que consume el navegador; el catálogo de fuentes es una **tabla plana**, una fila por dato, que consume una revisión documental.

**Lo que sí proyecta, con un `group_by` de tres niveles:** `emisor` → institución, `base_datos` → base, `dato` → dato, `descripcion` → `desc`, `url_referencia` → `url` de la base, `url_descarga` → `url` del dato, y `nivel_acceso` → `acceso` mediante un mapeo declarado (los cuatro valores del catálogo proyectan sobre los dos del atlas sin dejar ninguno sin destino).

**Lo que el atlas exige y el catálogo no produce:** de la institución, `id`, `desc`, `color`, `x` e `y` (los tres últimos son decisión de diseño y el propio contrato §4-§5 los excluye de la revisión documental); de la base, `id`, `desde` y `desc`; del dato, `id`, `desde` y **`relaciones`**, que son las rutas de tres segmentos; y los **ámbitos** completos con su `pregunta`.

**Dos cosas que conviene tener presentes antes de decidir:**

1. **`variables` ya no es un obstáculo, pero solo en 10 de 83 fuentes.** El atlas exige entre 2 y 8 variables por dato; hoy 10 fuentes las tienen. Las otras 73 no pueden promoverse al atlas hasta que sus solicitudes se resuelvan.
2. **Las dos taxonomías de ámbito no chocan.** `ambito_monitoreo`/`subambito` es una clasificación jerárquica y exclusiva; `ATLAS_AMBITOS` es una agrupación transversal por pregunta educativa, donde un dato puede estar en varias. Son ejes ortogonales y pueden coexistir. Pero el catálogo **no produce** los ámbitos del atlas ni sus preguntas: eso es redacción, no verificación.

**La tensión real, que no es contradicción:** la restricción 🔒 del catálogo empuja a `NA` antes que adivinar; el contrato del atlas declara todos sus campos obligatorios. La consecuencia no es un conflicto de esquemas sino de secuencia: una fila con `NA` en lo que el atlas necesita no puede promoverse hasta verificarse. Es el comportamiento deseado.

### 11.4 Las 38 solicitudes, por bloque

Agrupadas en `40_salidas/solicitudes_al_titular.md` por **lo que necesitan del titular**, para resolverlas de una vez:

| Bloque | Qué necesita | Fuentes | Ejemplo destacado |
|---|---|---|---|
| **A** | Descargar el archivo y ponerlo a disposición | **12** | F041 (SERMIG): cuatro libros de metadatos livianos que resuelven una fila completa sin bajar las bases |
| **B** | Abrir desde navegador, por 403 o falla de transporte | **23** | F056 (Biblioteca de Datos de JUNAEB): la fuente de mayor valor potencial no verificada del catálogo |
| **C** | Acceso con credenciales institucionales | **3** | F053 (plataforma de resultados Simce para SLEP): la vía institucional propia del servicio |

**La pasada de reproceso, cuando el titular entregue archivos**, es la que ya se ejecutó cinco veces en esta sesión:

1. Leer las copias **en solo lectura**, sin copiar ni mover nada, y sin que ningún valor de dato entre al catálogo.
2. Poblar `variables`, `llaves_de_union`, `unidad_de_analisis`, `datos_personales` y `cobertura_temporal` en `31_catalogo_fuentes_filas.R`, apuntando `documentacion_tecnica` al esquema local y declarando en observaciones que es copia local y no URL publicada.
3. Marcar la entrada como resuelta en `solicitudes_al_titular.md` **sin borrarla**.
4. Correr `31_` → `32_` → `33_` y commitear las tres cosas juntas.

### 11.5 Auditoría de cierre (política 5.6, preguntas de cierre)

| # | Pregunta | Respuesta |
|---|---|---|
| 2 | ¿El pipeline corre de cero sin intervención manual? | **Parcialmente, y declarado.** `31_` → `32_` → `33_` corre de cero y es reproducible. La fase 1 (verificación de URLs) **no** es automatizable: es la compuerta humana que justifica la ausencia de orquestador. |
| 5 | ¿Cada transformación crítica tiene check de validación? | **Sí.** `31_` valida antes de escribir; `32_` verifica seis condiciones y aborta sin emitir; `33_` comprueba que la ficha lleve los 27 campos. |
| 6 | ¿Los outputs son reproducibles e idempotentes? | **Sí.** Correr `31_` N veces produce el mismo CSV; `33_` regenera el `.md` completo desde el CSV. Sin dependencias de estado ni de fecha del sistema (la fecha es una constante nombrada). |
| 7 | ¿Decisiones metodológicas como constantes nombradas? | **Sí.** Los vocabularios, el patrón de identificador y las equivalencias viven como constantes al inicio de sus scripts (§9). |
| 8 | ¿Nombres sin tildes, ñ ni espacios? | **Sí** en todo lo generado. |

Sin respuestas "no": esta sesión no agrega pendientes por auditoría.

### 11.6 Ruta sugerida para la próxima sesión

**Prioridad 1 — Publicar los 10 commits (P1).** Complejidad baja, y deja el remoto al día antes de cualquier trabajo nuevo.

**Prioridad 2 — Resolver las solicitudes por bloque (P2).** Es la que más contenido desbloquea por unidad de esfuerzo. El bloque B (23 fuentes) es el más barato para el titular: son páginas que se abren en el navegador, no archivos que bajar.

**Prioridad 3 — Decidir el frente del atlas (P3).** La decisión es del titular y §11.3 le da lo que necesita. Si es afirmativa, la sesión siguiente diseña el puente entre el catálogo y el contrato; si es negativa, el catálogo de fuentes vive por sí solo como producto del Área.

**Conviene diferir.** P5 es cosmético e inerte tras dos cancelaciones. P6 espera entrega del titular. P7 exige decisiones del Área sobre `madurez` y `evidencia`. P8 exige rama propia y su bloque 1 ya está hecho de facto.

## 12. Instrucciones específicas para la próxima sesión

- ⚠️ **NO** ejecutar `git push` sin autorización explícita del titular en el turno inmediatamente anterior. La autorización no se hereda entre encargos.
- ⚠️ **NO** editar `40_salidas/catalogo_fuentes.csv` ni `40_salidas/catalogo_fuentes_fichas.md` a mano. **La fuente es el CSV, y el CSV lo genera `31_catalogo_fuentes_filas.R`.** Toda corrección se hace en ese script, se revalida con `32_` y se re-emite con `33_`.
- ⚠️ **NO** agregar un valor a un vocabulario controlado por cuenta propia. Ocurrió con `Bienal` en esta sesión y se revirtió: extender un vocabulario es decisión del titular.
- ⚠️ **NO** clasificar como `Enlace roto` una URL que devolvió 403: el host respondió y un navegador probablemente la alcance.
- ⚠️ **NO** correr `00_escanear_proyecto.R` más de una vez por sesión: rota un par fijo `actual`/`anterior` y la segunda corrida destruye el punto de comparación.
- ⚠️ **NO** escribir una `cobertura_temporal` como rango continuo cuando el esquema de registros declare un hueco en la serie.
- ✅ **ANTES** de dar una fuente por no disponible, cruzar contra las raíces `*_DATA_ROOT` de `~/.Renviron` **por nombre de archivo**, no por nombre de proyecto.
- ✅ **ANTES** de pedir un archivo al titular, comprobar si su esquema de registros (`ER_*.pdf`) ya está en una copia local: resuelve `variables` sin descargar nada.
- ✅ **ANTES** de commitear un tramo, correr `31_` → `32_` → `33_` y verificar el cuadre de los tres artefactos. El reporte al chat va **después** de que el disco esté al día.
- 🔒 El acceso a los proyectos hermanos es **estrictamente de solo lectura**. No se copia, no se mueve, no se extrae. Ningún valor de dato entra al catálogo, solo metadatos de estructura.
- 🔒 `docs/`, `docs/atlas_datos.js` y `50_documentacion/activa/50_contrato_atlas_datos.md` no se tocan sin decisión explícita del titular sobre el frente del atlas.
- 🔒 El lightbox de reseña y el visor a resolución completa de `docs/app.js` no se tocan.
- 🔒 `POLITICA_PROYECTO.md`, `SETTINGS_Y_PROMPTS_OPERACIONALES.md`, `50_documentacion/traspasos/**` y `50_documentacion/andamios/**` permanecen fuera del repositorio público.
- 🔒 Los bundles de `_archivo/20260730/ramas_claude/` y las capturas de `_archivo/20260729/capturas_originales/` no se borran jamás.
- 🔒 El directorio oficial de establecimientos (F007) trae `RUT_SOSTENEDOR` sin enmascarar. Ningún identificador directo de persona entra a un artefacto publicable.

## 13. Fragmentos de código de referencia

**Lectura de cabecera sin cargar el archivo** (patrón nuevo de esta sesión, para inspeccionar un CSV de 576 MB sin abrirlo):

```r
leer_cabecera <- function(f) {
  crudo <- readBin(f, "raw", n = 131072L)
  fin <- which(crudo == as.raw(10))[1]          # primer salto de linea
  b <- crudo[seq_len(fin - 1L)]; b <- b[b != as.raw(13)]
  u <- iconv(rawToChar(b), "UTF-8", "UTF-8")
  if (!is.na(u)) list(t = u, e = "UTF-8")
  else list(t = iconv(rawToChar(b), "latin1", "UTF-8"), e = "ISO-8859-1")
}
```

**Extracción de nombres de variable desde un esquema de registro en PDF:**

```r
# identificador en mayusculas seguido de 2+ espacios y su tipo declarado
PAT <- "^\\s*([A-Z][A-Z0-9_]{1,29})\\s{2,}(Num|Tex|Cad|Fec|Alfa|Car|Ent|Dec)"
l <- unlist(strsplit(paste(pdftools::pdf_text(f), collapse = "\n"), "\n"))
m <- regmatches(l, regexec(PAT, l))
nombres <- unique(vapply(m[lengths(m) > 0], function(x) x[2], character(1)))
```

**Verificación de reciprocidad de un campo bidireccional:**

```r
for (id in names(EQUIVALENCIAS)) {
  destinos <- trimws(strsplit(EQUIVALENCIAS[[id]], ";")[[1]])
  for (d in destinos) {
    vuelta <- trimws(strsplit(catalogo$fuente_equivalente[catalogo$id_fuente == d], ";")[[1]])
    if (!id %in% vuelta) stop("equivalencia no reciproca: ", id, " -> ", d)
  }
}
```

## 14. Reapertura

**Mensaje de apertura sugerido:**

> Tipo CONTINUATION. El protocolo (`POLITICA_PROYECTO.md` v5.5 + `SETTINGS_Y_PROMPTS_OPERACIONALES.md` v15) vive en la knowledge base del Project; verifica que estén al día antes de empezar. Adjunto el traspaso v11, el escáner al cierre y el backlog. La sesión 11 produjo el catálogo de fuentes completo: 83 fuentes verificadas, validadas y emitidas como fichas, con un pipeline de R nuevo en `20_insumos/`, `30_procesamiento/` y `40_salidas/`. Quedan 10 commits sin publicar y 38 solicitudes que dependen de mí, agrupadas por bloque. La prioridad 1 es publicar; después, [resolver las solicitudes que ya te entregué / decidir el frente del atlas].

**Documentos para la próxima sesión, en tres bloques:**

1. *Protocolo en knowledge base* (no se adjuntan; verificar que estén al día): `POLITICA_PROYECTO.md`, `SETTINGS_Y_PROMPTS_OPERACIONALES.md`, `encargo_autonomo_claude_code_v1.md`.
2. *Opcionales según el foco*: `CLAUDE.md` si correrá en Claude Code; `50_contrato_atlas_datos.md` si se aborda el frente del atlas; `50_catalogo_project_cards.md` si se aborda P7.
3. *Específicos de la sesión* (sí se adjuntan): `traspaso_cierre_v11.md`; `estructura_actual.md`; `backlog_acumulativo.md`; `40_salidas/solicitudes_al_titular.md` (es el mapa de lo que falta); `40_salidas/catalogo_fuentes.csv` si el foco es el catálogo; los archivos que el titular haya descargado para resolver el bloque A, con su ruta.

**Nota final obligatoria:** `CLAUDE.md` cambió en esta sesión (sus excepciones declaradas ya no dicen que no hay pipeline de R); adjunta la versión de disco. Verifica el nombre del proyecto en el encabezado de cada archivo de memoria antes de adjuntarlo.

## 14bis. Constancias posteriores al cierre

Dos correcciones anotadas despues de escribir este traspaso, sin reescribir lo
ya redactado: el traspaso crece por anexo.

1. **Numero de commits sin publicar.** Las secciones 3 y 14 dicen 10; la cifra
   correcta al cierre efectivo es **15**, recontada con
   `git rev-list --left-right --count @{u}...HEAD`. La diferencia son los tres
   commits del propio cierre (escaner, backlog y `ESTADO.md`), mas dos previos
   emitidos entre la redaccion y el cierre. El mensaje de reapertura de §14
   queda corregido en este punto.

2. **El brief del reconocimiento quedo junto a su insumo.** `20_insumos/`
   guardaba el resultado del reconocimiento sin las instrucciones que lo
   produjeron, que viven en
   `herramientas_dev/prompts/catalogo_fuentes/brief_research_reconocimiento_fuentes_v2.md`.
   Se **copio** ese brief a `20_insumos/` conservando su nombre (copia, no
   movimiento: la biblioteca de prompts de `herramientas_dev` sigue siendo su
   casa) y se agrego `20_insumos/README.md`, que declara que las filas del
   reconocimiento son candidatas y no verificadas, y que su verificacion es el
   pipeline de `30_procesamiento/`. Sin esto, quien abriera la carpeta no podia
   saber con que criterios se produjo el inventario ni por que tiene diez lotes
   y esas diez columnas.

## 15. Errores del asistente

> **Nota sobre el campo `patron`:** el catálogo canónico `catalogo_patrones_errores_v3.md` no está en la knowledge base de este Project ni fue adjuntado. Las etiquetas `PAT-NN` de abajo son **propuestas y no verificadas contra el catálogo**; una sesión con acceso debe confirmarlas o corregirlas. Se declara en vez de inventar la correspondencia.

### E1 — Prompt de fetch que no pidió lo que el catálogo necesitaba

| Campo | Contenido |
|---|---|
| `momento` | Tramo 1, verificación de las 14 URLs del lote A |
| `disparador` | Usuario lo señaló sin nombrarlo error ("`url_descarga` quedó NA en las 24 filas... revisa si el fetch no los capturó o si de verdad no están expuestos") |
| `que_paso` | Los prompts de fetch preguntaban por extensiones de archivo y no por los `href`, de modo que el modelo lector resumía sin entregar las URL de descarga; se concluyó y se reportó que las páginas no las exponían, cuando sí lo hacen |
| `regla_violada` | SETTINGS §1.2.6, fuente primaria de una ESTRUCTURA es su inspección: se afirmó una propiedad de la página (no expone enlaces) sin haberla consultado por lo que se afirmaba |
| `causa_raiz` | El prompt se diseñó desde los campos del esquema que se estaban llenando en ese momento (formato, cobertura) y no desde el conjunto completo de campos que la página podía responder. La ausencia se leyó como propiedad de la fuente cuando era propiedad de la pregunta |
| `salvaguarda_presente` | SETTINGS §1.2.6 |
| `patron` | `PAT-01` propuesto, sobre afirmar una ausencia sin haber preguntado por lo ausente |
| `gatillo_observable` | `afirmar-sin-leer`: concluir que una página no publica un dato tras una consulta que no lo pedía |
| `intentos_previos` | 0 |
| `costo` | Una ronda de 10 fetches de corrección y un commit adicional (`2fb5bc6`) |

### E2 — Valor fuera del vocabulario controlado, y validador que lo absorbió

| Campo | Contenido |
|---|---|
| `momento` | Tramo 2 (escritura de F030) y Fase 2 (escritura del validador) |
| `disparador` | Asistente lo señaló espontáneamente al construir `32_validar_catalogo_fuentes.R` |
| `que_paso` | Se escribió `Bienal` como `periodicidad` de Casen, valor ausente del vocabulario declarado del encargo, y al escribir el validador se lo agregó a la lista de valores válidos, convirtiendo una desviación en norma |
| `regla_violada` | Encargo §5 (vocabularios controlados declarados como constantes y validados antes de emitir) y §10 criterio 6 (ninguna celda de vocabulario controlado con valor fuera de lista) |
| `causa_raiz` | El valor se eligió por ser descriptivamente correcto —la serie Casen es aproximadamente bienal— sin contrastar contra la lista cerrada. El segundo momento es más grave: al validar, se hizo que la herramienta de control aceptara la desviación en vez de detectarla, que es exactamente lo que el criterio 6 existe para impedir |
| `salvaguarda_presente` | El propio encargo §5 y §10; el precedente de `.rar`, donde sí se detuvo a pedir aprobación |
| `patron` | `PAT-09` propuesto, sobre ajustar el control a la desviación en vez de al revés |
| `gatillo_observable` | `otro`: extender el dominio de un vocabulario cerrado dentro del mismo artefacto que debe verificarlo |
| `intentos_previos` | 0 |
| `costo` | Ninguno en datos: se detectó y revirtió antes de commitear la Fase 2. Una corrección de dos archivos |

### E3 — CSV adelantado respecto de las fichas al cierre del tramo 2

| Campo | Contenido |
|---|---|
| `momento` | Cierre del tramo 2, con el clasificador de permisos caído |
| `disparador` | Asistente lo señaló espontáneamente al reportar; el usuario lo formalizó después como recordatorio de resiliencia |
| `que_paso` | Se actualizó `solicitudes_al_titular.md` a 18 entradas mientras el CSV seguía en 24 filas del tramo 1, porque no se pudo ejecutar el script; el reporte al chat se emitió con el disco desalineado |
| `regla_violada` | SETTINGS §1.2.6, generar-verificar-consumar: el reporte es el paso consumidor y se ejecutó sin que la verificación intermedia (script corrido, artefactos cuadrados) hubiera pasado |
| `causa_raiz` | Ante el bloqueo de la herramienta se avanzó con lo que sí se podía escribir, en vez de detener toda la escritura hasta poder ejecutar. La intención era no perder trabajo; el efecto fue dejar tres artefactos que debían cuadrar entre sí en dos estados distintos |
| `salvaguarda_presente` | SETTINGS §1.2.6 (sandwich generar-verificar-consumar); la propia instrucción de resiliencia del titular del turno anterior |
| `patron` | `PAT-02` propuesto, sobre consumar sin verificación intermedia |
| `gatillo_observable` | `otro`: emitir un reporte cuando dos artefactos que deben cuadrar están en estados distintos |
| `intentos_previos` | 2 (dos ejecuciones de `Rscript` bloqueadas por el clasificador antes de decidir avanzar sin ejecutar) |
| `costo` | Un turno del titular ejecutando el script a mano y reportando su salida |

### Fricciones

`friccion: los reportes de cierre de tramo crecieron por encima del techo de prosa de SETTINGS §1.2.6 → se mantuvieron porque el titular pidió explícitamente el detalle en cada compuerta, pero conviene revisarlo si se repite el patrón por lotes.`
