# Log — política de versionado de `traspasos/` y `andamios/`: **detención en fase A**

> **Encargo:** `50_documentacion/andamios/20260802_encargo_gitignore_memoria.md`
> **Proyecto:** `slep_monitoreo` · **Fecha:** 2026-08-02
> **Ejecutor:** Claude Code, modo autónomo.
> **Resultado:** detenido por la regla 2 de la sección 1. `.gitignore` sin modificar,
> índice de git sin tocar, ningún archivo incorporado.

---

## 1. Por qué se detuvo

La sección 2 del encargo justifica versionar la memoria del proyecto así: vive
«solo en el disco del titular, **sin respaldo remoto**». El encargo ordena en su
fase A detenerse si una premisa de esa sección no se sostiene.

No se sostiene, por dos hechos verificados en el repositorio:

1. **El repositorio es público.** `gh repo view` devuelve
   `"visibility":"PUBLIC"`, `"isPrivate":false`, en
   `https://github.com/tomgc/slep_monitoreo`. Versionar estos archivos no es
   respaldarlos: es publicarlos para cualquiera, de forma difícil de revertir
   (GitHub y los buscadores conservan copias e índices aunque después se borre).
2. **La exclusión era deliberada y por motivo de publicación, no un descuido de
   archivo.** El propio `.gitignore` lo dice en su línea 13: «Traspasos de
   sesión: memoria interna, **NO se publican** (Pages sirve todo el repo)». La
   sección 2 del encargo describe la exclusión como una simple falta de
   respaldo y no menciona en ningún punto que el remoto sea público.

El motivo escrito en el comentario (**«Pages sirve todo el repo»**) es
**incorrecto**: Pages sirve solo `/docs`. Pero la conclusión que ese comentario
protege es correcta y por una vía más directa: el repositorio entero es público,
de modo que todo lo versionado queda legible en github.com aunque Pages no lo
sirva.

---

## 2. Estado previo de `.gitignore` (íntegro, sin modificar)

```
     1	# macOS
     2	.DS_Store
     3	
     4	# Archivo local (snapshots pre-reorganización, no se versionan)
     5	_archivo/
     6	
     7	# Config local del editor / MCP
     8	.claude/
     9	
    10	# Insumo de traspaso entregado (referencia local, no se versiona)
    11	handoff/
    12	
    13	# Traspasos de sesión: memoria interna, NO se publican (Pages sirve todo el repo)
    14	50_documentacion/traspasos/**
    15	POLITICA_PROYECTO.md
    16	SETTINGS_Y_PROMPTS_OPERACIONALES.md
    17	
    18	# Andamios de sesión: encargos y logs de ejecución, NO se publican
    19	50_documentacion/andamios/**
```

Bloque nuevo: **no se escribió.** La fase B no se ejecutó.

---

## 3. `git check-ignore` antes (no hay «después»)

```
.gitignore:14:50_documentacion/traspasos/**	50_documentacion/traspasos/traspaso_cierre_v14.md
.gitignore:19:50_documentacion/andamios/**	50_documentacion/andamios/logs/20260802_normalizacion_y_renombre_log.md
.gitignore:15:POLITICA_PROYECTO.md	50_documentacion/activa/POLITICA_PROYECTO.md
exit=0
```

Las tres premisas de la sección 2 sobre qué está excluido se confirman. Lo que
no se confirma es el *motivo* que el encargo les atribuye.

---

## 4. Configuración de publicación verificada

```
gh repo view  → {"isPrivate":false,"visibility":"PUBLIC",
                 "url":"https://github.com/tomgc/slep_monitoreo"}

gh api repos/tomgc/slep_monitoreo/pages
              → "source":{"branch":"main","path":"/docs"},
                "public":true,
                "html_url":"https://tomgc.github.io/slep_monitoreo/"
```

Lectura: Pages publica `main:/docs`. El resto del repositorio no se sirve como
sitio, pero **sí es navegable en github.com** por ser público.

**Discrepancia adicional.** `CLAUDE.md` §3 describe la raíz de código como
«este repo (**GitHub privado**)». El repositorio real es público. Esa
discrepancia es previa a este encargo y no se corrigió aquí, pero conviene
resolverla: varias decisiones de gobernanza del proyecto se apoyan en ella.

---

## 5. Revisión de contenido de los archivos a versionar (fase C, paso 1)

Se ejecutó aunque la fase B no llegó a correr, porque determina si la regla 3
también aplicaba. **No aplica:** el contenido está limpio.

Universo: 17 archivos, 484 KB (14 traspasos, 3 logs).

| Búsqueda | Resultado |
|---|---|
| `rbd\|escuela \|liceo \|jardín \|colegio ` | 3 coincidencias, **ninguna real** |
| RUT (`\d{1,2}\.?\d{3}\.?\d{3}-[\dkK]`) | 0 |
| Correos electrónicos | 0 |
| `onedrive\|/Users/…/Library\|DATA_ROOT` | 1, sin ruta concreta |

Las tres coincidencias del primer patrón son **discusiones sobre la gobernanza,
no datos**:

- `archivo/traspaso_cierre_v09.md:285` — auditoría de cierre: «Ningún dato
  identificable entró al repositorio».
- `archivo/traspaso_cierre_v08.md:49` — nombres de archivo de las minutas
  (`Minuta_n_1`…), sin establecimientos.
- `archivo/traspaso_cierre_v08.md:116` — describe la compuerta abierta: «las
  tres minutas nombran establecimientos educacionales con RBD y comuna, y el
  sitio es público; POLITICA §6.4 recoge la condición contractual de la Agencia
  de Calidad de no identificar establecimientos por nombre en ningún output».
  Es la regla, no una lista de nombres.

La única coincidencia de la última búsqueda (`archivo/traspaso_cierre_v11.md:231`)
menciona la convención `*_DATA_ROOT` de `~/.Renviron` sin exponer ninguna ruta.

**Conclusión:** ningún archivo contiene nombres de establecimientos, RBD, RUT,
correos ni rutas del data root. La regla 3 no se activó. La detención es por la
regla 2 exclusivamente.

Lo que sí contienen los traspasos es deliberación interna: fallas de
coordinación entre sesiones, deuda técnica, compuertas de gobernanza abiertas,
condiciones contractuales con la Agencia de Calidad y planificación. Publicable
o no, es una decisión del titular, no una consecuencia mecánica del encargo.

---

## 6. Término de comparación: qué está ya versionado

`git ls-files 50_documentacion/` devuelve 13 rutas. Ya son públicas
`activa/ESTADO.md`, `activa/backlog_acumulativo.md`,
`activa/50_fundamento_seccion_formacion.md`, `activa/50_contrato_atlas_datos.md`,
`activa/50_catalogo_project_cards.md`, `activa/encargo_diseno_portafolio.md`, los
cuatro del escáner y tres `.gitkeep`.

Es decir: parte de la documentación interna **ya es pública**, lo que hace la
opción A menos disruptiva de lo que parece. Ese es el argumento más fuerte a
favor de proceder, y por eso queda registrado aquí junto al argumento en contra.

---

## 7. Auto-auditoría

| # | Pregunta | Respuesta |
|---|---|---|
| 1 | ¿Los tres archivos de gobernanza siguen ignorados? | **Sí**, sin cambios: `.gitignore` no se tocó |
| 2 | ¿Los cuatro del escáner siguen ignorados? | **Sí**, sin cambios |
| 3 | ¿Encargos y maquetas siguen ignorados? | **Sí**, sin cambios |
| 4 | ¿Entraron todos los traspasos, incluidos los de `archivo/`? | **No entró ninguno.** La fase C no se ejecutó |
| 5 | ¿Se usó `git add -A` o `git add -f`? | **No.** No se ejecutó ningún `git add` |
| 6 | ¿Algún archivo versionado expone establecimientos o datos privados? | **No.** Barrido en §5; además no se versionó nada |
| 7 | ¿Hubo push, `--force`, `reset --hard` o tag? | **No** |

---

## 8. Decisiones autónomas

1. **Detener antes de la fase B**, por la regla 2 de la sección 1 del encargo.
   Modificar `.gitignore` y hacer `git add` de los 17 archivos habría dejado la
   memoria interna a un `git push` de ser pública, y el titular hace push de
   `main` de forma rutinaria (hoy va 25 commits por delante de `origin/main`).
2. **Consultar la API de GitHub** (solo lectura) para establecer visibilidad y
   configuración de Pages, en vez de deducirlas del comentario del `.gitignore`,
   que resultó incorrecto en su motivo.
3. **Ejecutar igualmente el barrido de contenido de la fase C**, aunque su fase
   previa no corriera, para dejar establecido que la regla 3 no era la causa de
   la detención y que el contenido está limpio.
4. **No commitear este log.** Commitearlo exige la misma modificación de
   `.gitignore` que quedó en suspenso. El log queda en disco, ignorado.

---

## 9. Estado final del repositorio

Idéntico al del inicio del encargo. Nada que revertir.

```
=== git status --short ===
 M 50_documentacion/estructura/estructura_actual.md
 M 50_documentacion/estructura/estructura_actual.txt
 M 50_documentacion/estructura/estructura_anterior.md
 M 50_documentacion/estructura/estructura_anterior.txt

=== git branch -v ===
* main                 9ae92ab [ahead 25] actualiza los consumidores del atlas al identificador desafio
  wip/atlas_tablero_v3 6894986 wip: tablero del atlas sin revision visual, punto de guardado
```

Sin push, sin `--force`, sin `reset --hard`, sin tags. `.gitignore` intacto.

---

## 10. Qué necesita decidir el titular

La pregunta real no es de archivo sino de publicación: **¿la memoria interna del
proyecto (14 traspasos y 3 logs, 484 KB de deliberación) debe quedar legible
para cualquiera en un repositorio público?**

- **Si la respuesta es sí:** el encargo se ejecuta tal cual está escrito, sin
  ningún cambio. El bloque de `.gitignore` que propone su fase B es correcto y
  el contenido ya está verificado como limpio.
- **Si la respuesta es no:** la alternativa que cumple el objetivo declarado
  («que la memoria no viva solo en un disco») sin publicarla es un remoto
  privado aparte, o volver privado este repositorio y publicar el sitio por
  otra vía.
- **Independiente de lo anterior:** corregir el comentario de `.gitignore:13`,
  que atribuye la exclusión a que «Pages sirve todo el repo» cuando Pages sirve
  solo `/docs`, y alinear `CLAUDE.md` §3, que describe el repositorio como
  privado cuando es público.
