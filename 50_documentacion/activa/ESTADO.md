---
proyecto: slep_monitoreo
estado: activo
sesion_actual: v14
ultima_actividad: 2026-08-02
maneja_sensibles: no
tipo_pendiente: nuevo
---

## En que vamos

La seccion Formacion del sitio quedo con su documento de fundamento cerrado
(`50_documentacion/activa/50_fundamento_seccion_formacion.md`): proposito,
audiencia, alcance, linea editorial, orden de los siete elementos, etapas de
publicacion, siete criterios de aceptacion y regla de descarte. La sesion 14 no
escribio codigo: fue una entrevista de diez bloques al titular. El tablero
descartado quedo aislado en la rama local `wip/atlas_tablero_v3`.

## Proximo paso

Sesion 1 de la ruta de implementacion: redaccion de contenido en texto plano,
sin HTML ni CSS. Texto de los elementos 1, 2 y 4, y eleccion del desafio
educativo del elemento 3 con su caso real del Area en terminos conceptuales.
Antes, en un turno: verificar el estado real de `docs/atlas.js` y
`docs/atlas.css` en `main` (discrepancia de tamanos entre escaneres, §6 del
traspaso v14).

## Bloqueantes

Ninguno.

## Condiciones permanentes

El repositorio es publico por diseno. Desde el 2026-08-02 los traspasos de
cierre (`50_documentacion/traspasos/`) y los logs de encargos ejecutados
(`50_documentacion/andamios/logs/`) se versionan, de modo que son contenido
publicado: quedan legibles en `github.com/tomgc/slep_monitoreo` aunque Pages
sirva solo `main` `/docs`. Se redactan bajo esa condicion, sin nombres de
establecimientos, RBD, RUT, correos ni rutas locales. Los encargos y maquetas
de `50_documentacion/andamios/` siguen ignorados: son instrumentos de un turno
y caducan al ejecutarse.
