# Encargo de diseño — Portafolio del Área de Monitoreo

## Qué es el sitio

Sitio institucional estático de una sola página que presenta el portafolio de
proyectos del Área de Monitoreo y Seguimiento de Procesos y Resultados
Educativos del SLEP Costa Central (Chile). Publicado en GitHub Pages:
`https://tomgc.github.io/slep_monitoreo/`

Audiencia: directivos del Servicio, equipos de establecimientos educacionales y
contrapartes institucionales. Registro sobrio e institucional, no comercial.

## El problema a resolver

Hoy el portafolio es una lista vertical de tarjetas donde cada proyecto se
presenta con mucho texto (título más un párrafo de objetivo) y una captura
pequeña al costado. La reseña completa y la galería viven en un lightbox que se
abre al hacer click.

El resultado es que el sitio se lee como una lista de texto. Las capturas de
producto, que son lo que efectivamente muestra el trabajo del Área, quedan
subordinadas al texto y no se ven a tamaño útil sin abrir el lightbox.

**Objetivo del rediseño:** que las imágenes sean el elemento dominante del
portafolio y que los proyectos se recorran uno por uno, en vez de escanearse
como una lista.

## Dirección preferida

Un carrusel de proyectos: un proyecto a la vez ocupando el ancho disponible, con
la captura grande como elemento principal y el texto reducido a título y
objetivo al costado. Avance con flechas y con dots numerados, de modo que se
mantenga visible cuántos proyectos hay y en cuál se está.

Dos alternativas exploradas y descartadas como primera opción, por si aportan
ideas: una grilla de mosaicos de dos o tres por fila dominados por la captura
con el título sobrepuesto; y mantener la lista vertical pero invirtiendo el peso
de cada banner para que la captura domine y el texto se reduzca a una línea.

La dirección preferida no es una restricción cerrada. Si hay una propuesta mejor
para el objetivo declarado, se agradece verla.

## Datos del contenido

- 12 proyectos en total: 10 con estado `vigente` y 2 con estado `desarrollo`.
- Los proyectos en desarrollo y uno de los vigentes no tienen capturas todavía
  (arreglo `imgs` vacío). El diseño debe resolver con dignidad la tarjeta sin
  imagen, que hoy es un marcador gris con la palabra "Próximamente".
- Los proyectos con capturas tienen entre 1 y 4 cada uno; 26 capturas en total.
- Las capturas son pantallazos de informes, tableros y aplicaciones. Tienen
  proporciones variables entre sí, así que el diseño no puede asumir una
  relación de aspecto fija (el layout actual usa altura fija más
  `object-fit: contain`, es decir, letterbox).
- Cada proyecto tiene: `tipo` (etiqueta corta), `titulo`, `objetivo` (un párrafo
  largo), `sintesis` (dos a cinco párrafos) y `estado`.
- Los títulos son largos: varios superan los 90 caracteres. El diseño debe
  probarse con los títulos reales, no con títulos cortos de ejemplo.

## Restricciones técnicas no negociables

- HTML, CSS y JavaScript sin dependencias externas. Sin frameworks, sin CDN, sin
  build. El sitio se sirve tal cual desde GitHub Pages.
- Los archivos son `index.html`, `styles.css`, `colors_and_type.css`, `app.js` y
  `data.js`. El contenido vive en `data.js` y no debe mezclarse con la
  presentación.
- La identidad visual usa las tipografías institucionales gobCL y Museo Sans,
  cargadas localmente desde `fonts/`. Los colores y la tipografía viven en
  `colors_and_type.css`, que se adjunta y debe respetarse.
- Debe funcionar en móvil. El comportamiento actual apila todo en una columna
  bajo los 880 px de ancho.
- Accesibilidad: la navegación actual funciona con teclado (Enter, Espacio,
  flechas, Esc) y con etiquetas `aria-label`. Conviene conservarla.

## Qué queda fuera de este encargo

El lightbox de reseña y el visor de imagen a resolución completa se rediseñaron
hace poco y funcionan bien. No hay que tocarlos, salvo que el nuevo portafolio
los vuelva redundantes, en cuyo caso conviene decirlo antes de rehacerlos.

## Entregable esperado

Propuesta visual del portafolio rediseñado, con la maquetación de al menos: un
proyecto con varias capturas, un proyecto sin capturas y la vista móvil. Si
viene acompañada del CSS y del JavaScript necesarios, mejor.

## Archivos que se adjuntan

`index.html`, `styles.css`, `colors_and_type.css`, `app.js`, `data.js`.
