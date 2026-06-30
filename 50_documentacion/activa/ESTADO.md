---
slug: slep_monitoreo
nombre_real: Sitio institucional del Área de Monitoreo del SLEP Costa Central (portafolio web estático)
categoria: activo
semaforo: activo
sesion_actual: v06
ultima_actividad: 2026-06-26
maneja_sensibles: false
tipo_pendiente: nuevo
---
## En que vamos
La sesión 6 pobló las capturas reales de producto de los 9 proyectos vigentes (26 PNG en `assets/proyectos/`, campo `imgs` en `data.js`) y corrigió un defecto visual del lightbox que recortaba las capturas (de `aspect-ratio: 16/9` + `cover` a altura fija con `contain`). El portafolio está completo y desplegado en producción para los 9 proyectos vigentes; los 2 en desarrollo mantienen su placeholder por diseño. Solo quedan pendientes diferidos, ninguno bloqueante.

## Proximo paso
Construir el nuevo proyecto "Minuta Simce" en `data.js` (objetivo, síntesis, orden, id sugerido `simce_cc` y luego sus capturas) a partir de los 3 PDF que aportará el usuario.

## Bloqueantes
ninguno
