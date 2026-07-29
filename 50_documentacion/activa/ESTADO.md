---
slug: slep_monitoreo
nombre_real: Sitio institucional del Área de Monitoreo del SLEP Costa Central (portafolio web estático)
categoria: activo
semaforo: activo
sesion_actual: v07
ultima_actividad: 2026-07-27
maneja_sensibles: false
tipo_pendiente: nuevo
---
## En que vamos
La sesión 7 agregó un visor de imagen a resolución completa sobre el lightbox (con navegación por flechas y teclado, y cierre por X, fondo y Esc) y reorganizó el lightbox a dos columnas en desktop (captura 60% / reseña 40%) para dar protagonismo al texto, con reversión a columna apilada en móvil. En paralelo cerró tres pendientes diferidos de v06: sección Trayectoria oculta de forma reversible, campo `thumb` obsoleto eliminado de `data.js`, y peso 400 de Museo Sans mapeado explícitamente al `.otf` 500. Siete commits desplegados y verificados en producción; solo quedan pendientes diferidos, ninguno bloqueante.

## Proximo paso
Construir el nuevo proyecto "Minuta Simce" en `data.js` (objetivo, síntesis, orden, id sugerido `simce_cc` y luego sus capturas) a partir de los 3 PDF que aportará el usuario.

## Bloqueantes
ninguno
