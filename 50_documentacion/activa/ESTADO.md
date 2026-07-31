---
slug: slep_monitoreo
nombre_real: Sitio institucional del Area de Monitoreo, SLEP Costa Central
categoria: activo
semaforo: activo
sesion_actual: v12
ultima_actividad: 2026-07-31
maneja_sensibles: false
tipo_pendiente: bloqueante
---
## En que vamos

El catalogo de fuentes quedo verificado por la sesion paralela y el sitio ya
tiene su segunda pagina con tabla filtrable. El atlas se construyo dos veces
sobre una representacion orbital y las dos fueron descartadas por el titular:
funciona, pero la metafora no se sostiene sin el fondo oscuro y los ambitos de
indagacion quedaban como menu en vez de ser una dimension del dato. La direccion
acordada es un tablero de dos mitades enfrentadas, fuentes a la izquierda y
ambitos a la derecha, con destacado reciproco al hacer clic.

## Proximo paso

Correr `node 00_validar_atlas.js docs/atlas_datos.js` y versionar los cuatro
archivos de `docs/` que quedaron sin commitear, antes de empezar el tablero.

## Bloqueantes

- El validador del atlas no se ejecuto tras el retiro de UNESCO y OECD: toda
  cifra del catalogo declarada en v12 proviene del transformador y no de la
  fuente canonica.
- Cuatro archivos de `docs/` sin commitear (`atlas.js`, `atlas.css`,
  `atlas_datos.js`, `formacion.html`).
- La difusion del sitio sigue bloqueada por la revision de contenido del
  catalogo: 38 solicitudes al titular sin resolver.
