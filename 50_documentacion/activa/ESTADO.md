---
slug: slep_monitoreo
nombre_real: Sitio institucional del Área de Monitoreo — SLEP Costa Central
categoria: activo
semaforo: activo
sesion_actual: v16
ultima_actividad: 2026-08-04
maneja_sensibles: false
tipo_pendiente: nuevo
---

## En que vamos

La sección Formación tiene sus cuatro primeros textos aprobados y el elemento 2
(el recorrido de seis pasos y tres decisiones) cuenta por fin con una maqueta
desechable aprobada en navegador, tras dos descartes propios y un cambio de
método: el prototipo de Claude Design se trasladó mecánicamente a vanilla y se
cotejó contra un inventario de estilos extraído de su propio código, en lugar de
reinterpretarse desde una descripción en prosa. El plan de integración a
producción está emitido. En gobernanza, la salida del escáner salió del árbol
versionado y los dos paquetes de handoff de diseño se reubicaron a
`50_documentacion/handoffs/`, fuera del espacio de trabajo de sesión. `docs/` no
se tocó en toda la sesión: el sitio publicado sigue igual que en v15.

## Proximo paso

Integrar el elemento 2 a `docs/formacion.html` siguiendo
`20260803_plan_integracion_elemento2.md`, y retirar en la misma tanda los restos
de la metáfora celeste que quedan en esa página (la sección «Atlas», su bajada y
la etiqueta «Ámbito de indagación» del filtro). El riesgo conocido es la colisión
de la función `pintar()` que ya existe en `formacion.js`.

## Bloqueantes

Ninguno activo. La memoria del repositorio es pública, de modo que nada de lo que
entra a `50_documentacion/` puede contener nombres de establecimientos ni
identificadores. Hay 37 commits locales sin pushear, a la espera de que la etapa 1
de la sección esté completa; el push requiere autorización explícita del titular.
