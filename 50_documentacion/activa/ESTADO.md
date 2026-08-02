---
proyecto: slep_monitoreo
estado: activo
sesion_actual: v15
ultima_actividad: 2026-08-02
maneja_sensibles: no
tipo_pendiente: deuda_tecnica
---

## En que vamos

La seccion Formacion paso de tener fundamento a tener texto: los elementos 1, 2
y 4 quedaron escritos y el elemento 3 se redacto con el caso del reporte de
aprendizaje en educacion parvularia, desafio elegido por el titular. Todo vive
en `50_documentacion/activa/50_contenido_seccion_formacion.md`, en texto plano
y sin maqueta todavia. En lo tecnico se cerro el renombre `ambito` → `desafio`
en los cuatro artefactos del atlas (validador en `exit=0`, conteos identicos y
verificacion en navegador) y se refuto la premisa del traspaso v14 sobre
`docs/atlas.*`: `main` nunca tuvo el tablero experimental y
`wip/atlas_tablero_v3` es su unica copia. La memoria del proyecto (14 traspasos
y 5 logs) quedo versionada en local.

## Proximo paso

Aprobacion de los cuatro textos y maqueta desechable del elemento 2, que es el
camino critico de la etapa 1: el fundamento §9 exige maqueta antes de codigo de
produccion. Dos intentos por elemento; si se descarta, nombrar el criterio
incumplido. Despues, la redaccion del elemento 7 (cierre hacia portafolio y
contacto), unico elemento de la etapa 1 sin texto.

## Bloqueantes

Ninguno. Sin bugs activos.

## Deuda abierta

Cuatro decisiones pendientes del titular: el destino del tablero en
`wip/atlas_tablero_v3` (🔒 no borrar la rama sin decision explicita, es la unica
copia), el estado de los cuatro archivos de `50_documentacion/estructura/` hoy
trackeados (publican un snapshot congelado que nunca coincide con el arbol), las
38 fuentes pendientes del catalogo (bloquean la difusion segun el fundamento §8)
y la autorizacion del push: `main` esta 29 commits por delante de `origin/main`,
de modo que el sitio publicado no refleja el trabajo de tres sesiones.

## Condiciones permanentes

El repositorio es publico por diseno. Desde el 2026-08-02 los traspasos de
cierre (`50_documentacion/traspasos/`) y los logs de encargos ejecutados
(`50_documentacion/andamios/logs/`) se versionan, de modo que son contenido
publicado: quedan legibles en `github.com/tomgc/slep_monitoreo` aunque Pages
sirva solo `main` `/docs`. Se redactan bajo esa condicion, sin nombres de
establecimientos, RBD, RUT, correos ni rutas locales. Los encargos y maquetas
de `50_documentacion/andamios/` siguen ignorados: son instrumentos de un turno
y caducan al ejecutarse.
