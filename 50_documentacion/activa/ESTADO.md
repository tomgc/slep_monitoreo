---
slug: slep_monitoreo
nombre_real: Sitio del Área de Monitoreo — SLEP Costa Central
categoria: activo
semaforo: activo
sesion_actual: v11
ultima_actividad: 2026-07-30
maneja_sensibles: false
tipo_pendiente: documentacion
---
## En que vamos

El proyecto dejó de ser solo un sitio estático: tiene un pipeline de R que produjo el catálogo de fuentes de datos del Área, con 83 fuentes verificadas una por una contra la página de su emisor, validadas por script y emitidas como fichas. El catálogo nace del CSV, nunca de las fichas, que se regeneran. El frente del atlas quedó intacto y es la siguiente decisión del titular.

## Proximo paso

Publicar los 10 commits de la sesión 11 y luego resolver las 38 solicitudes del catálogo, agrupadas por bloque en `40_salidas/solicitudes_al_titular.md`.

## Bloqueantes

Ninguno para desarrollar. Uno para completar el catálogo: 38 de sus 83 fuentes conservan campos en `NA` que solo se llenan con acceso del titular (12 exigen descargar un archivo, 23 abrirlo desde navegador, 3 credenciales institucionales). El sitio sigue sin difundirse hasta que el titular revise el contenido del catálogo del atlas, que no se tocó.
