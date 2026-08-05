---
slug: slep_monitoreo
nombre_real: Sitio institucional del Área de Monitoreo — SLEP Costa Central
categoria: activo
semaforo: activo
sesion_actual: v17
ultima_actividad: 2026-08-05
maneja_sensibles: false
tipo_pendiente: nuevo
---

## En que vamos

El elemento 2 (el recorrido de seis pasos y tres decisiones) quedó integrado en
`docs/formacion.html`, con sus estilos en `formacion.css` y su lógica en
`formacion.js`, y el titular lo verificó en navegador. La colisión de `pintar()`
no llegó a producirse: cada unidad vive en su propio IIFE. En la misma tanda
salieron los restos de la metáfora celeste: la sección `#atlas` y sus
dependencias `atlas.css` y `atlas.js` ya no están en el marcado;
`atlas_datos.js` sigue cargándose porque alimenta la tabla.

El elemento 7, el cierre de la sección, tiene texto aprobado por el titular:
con él, los cinco elementos de la etapa 1 tienen redacción (**P4 cerrado**).

`atlas.js` y `atlas.css` dejaron además de publicarse: se archivaron en
`_archivo/20260805_atlas_muerto/`, fuera del árbol versionado, tras comprobar
que sus 84 menciones en el repositorio son todas de documentación y ninguna es
una referencia viva. Con ellos salieron las dos reglas huérfanas
`.fm-atlas-espera` y `.fm-atlas-foot`, heredadas de la sesión 12 (**P13
cerrado**). La página se verificó en navegador después de archivar: sin
peticiones rotas ni errores de consola. Las dos verificaciones quedaron
registradas en `50_documentacion/andamios/logs/`, en
`20260804_integracion_elemento2_log.md` y
`20260805_higiene_repositorio_log.md`.

Existe un diagnóstico de ordenación del repositorio en
`50_documentacion/activa/50_diagnostico_ordenacion_repositorio.md`: 4
incumplimientos, 4 casos dudosos y 9 movimientos propuestos por riesgo, de los
cuales 7 requieren decisión del titular. Ninguno se ejecutó (**P10 avanzado, no
cerrado**). El marcador `50_ordenacion_repositorio.md` no se creó, de modo que
la ordenación se seguirá proponiendo en cada apertura.

## Proximo paso

Abordar los elementos 3, 4 y 6 de la sección Formación. En paralelo, decidir
sobre los movimientos del diagnóstico de ordenación.

## Bloqueantes

Ninguno activo. La memoria del repositorio es pública, de modo que nada de lo que
entra a `50_documentacion/` puede contener nombres de establecimientos ni
identificadores. Hay 52 commits locales sin pushear, a la espera de que la etapa 1
de la sección esté completa; el push requiere autorización explícita del titular.
