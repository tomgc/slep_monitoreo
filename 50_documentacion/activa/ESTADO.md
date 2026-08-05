---
slug: slep_monitoreo
nombre_real: Sitio institucional del Área de Monitoreo — SLEP Costa Central
categoria: activo
semaforo: activo
sesion_actual: v17
ultima_actividad: 2026-08-05
maneja_sensibles: false
tipo_pendiente: deuda_tecnica
---

## En que vamos

La sesión 17 llevó el elemento 2 de la sección Formación a producción en
`docs/formacion.html`, con el traslado literal de la lógica de la maqueta a una
segunda IIFE que resolvió de raíz las colisiones de `pintar()` y `fila`, y con
la corrección del globo del recorrido que la revisión visual del titular
detectó y que ningún control estático podía ver. Publicado el elemento 2, la
sesión ejecutó el resto de la ruta acordada: el texto del elemento 7 —con lo
que la etapa 1 tiene sus cinco elementos redactados—, el archivado de
`atlas.js` y `atlas.css` fuera del sitio publicado, el diagnóstico de
ordenación del repositorio sin ejecutar un solo movimiento, y el push de los 53
commits acumulados durante cuatro sesiones, con lo que el sitio en internet
volvió a reflejar el repositorio. Quedan abiertos la redacción de los elementos
3, 4 y 6, la decisión sobre los nueve movimientos del diagnóstico, y un desfase
de versiones de la gobernanza descubierto al cierre.

## Proximo paso

Sincronizar la gobernanza en disco (P3, prioridad 1 de la §11.4 del traspaso
v17). Las copias de `POLITICA_PROYECTO.md` y `SETTINGS_Y_PROMPTS_OPERACIONALES.md`
en `50_documentacion/activa/` declaran v5.5 y v15, mientras la knowledge base va
en v5.6 y v16. Es de complejidad baja y condición para lo demás: todo encargo
que lea la copia en disco opera contra una versión anterior, y el diagnóstico de
ordenación ya lo hizo. Criterio de éxito: los encabezados en disco declaran v5.6
y v16.

## Bloqueantes

Ninguno activo. La memoria del repositorio es pública, de modo que nada de lo que
entra a `50_documentacion/` puede contener nombres de establecimientos ni
identificadores. Hay 2 commits locales sin pushear; el push requiere autorización
explícita del titular.
