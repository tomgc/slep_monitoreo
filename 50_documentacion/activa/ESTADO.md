---
slug: slep_monitoreo
nombre_real: Sitio institucional del Área de Monitoreo — SLEP Costa Central
categoria: activo
semaforo: activo
sesion_actual: v18
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
3, 4 y 6 y la decisión sobre los nueve movimientos del diagnóstico.

El desfase de versiones de la gobernanza que se descubrió al cierre de la
sesión 17 quedó resuelto (**P3 cerrado**): las copias en disco de
`POLITICA_PROYECTO.md` y `SETTINGS_Y_PROMPTS_OPERACIONALES.md` declaran v5.6 y
v16, verificado por encabezado y por longitud. No deja rastro en el historial
porque `.gitignore:21-22` mantiene esos dos documentos fuera del repositorio:
viven en la knowledge base de la cartera, y la sincronización es un reemplazo
en disco, no un commit.

## Proximo paso

Redactar el elemento 3 de la sección Formación (P1, prioridad 2 de la §11.4 del
traspaso v17, que pasa a ser la primera al cerrarse P3). Un elemento por sesión
y no los tres: el fundamento §10 concede dos intentos por elemento, y el 3 es el
que usa un caso real del Área, de modo que exige decisiones del titular sobre
qué se cuenta y cómo. Debe mantenerse en términos conceptuales, sin nombrar
establecimientos. Criterio de éxito: texto aprobado contra los siete criterios
del fundamento §9.

## Bloqueantes

Ninguno activo. La memoria del repositorio es pública, de modo que nada de lo que
entra a `50_documentacion/` puede contener nombres de establecimientos ni
identificadores. Hay 5 commits locales sin pushear; el push requiere autorización
explícita del titular.
