#!/usr/bin/env node
/**
 * new-paper.js — genera una entrada nueva en papers/data/papers.js
 *
 * Uso:
 *   node papers/new-paper.js "Título del paper"
 *   node papers/new-paper.js "Título del paper" "Autor Apellido" "Categoría" "Subcategoría"
 *
 * El script inserta la plantilla al inicio del array PAPERS (primer posición)
 * y abre el archivo para que lo completes.
 */

const fs   = require('fs');
const path = require('path');

/* ---- Argumentos ---- */
const title     = process.argv[2] || 'Nuevo paper';
const author    = process.argv[3] || '';
const category  = process.argv[4] || '';
const subcat    = process.argv[5] || '';

/* ---- Slug ---- */
const today = new Date().toISOString().slice(0, 10);

const slugify = str =>
    str.toLowerCase()
       .normalize('NFD').replace(/[\u0300-\u036f]/g, '')
       .replace(/[^a-z0-9\s-]/g, '')
       .trim()
       .split(/\s+/).slice(0, 4).join('-');

const slug = `${today}-${slugify(title)}`;

/* ---- Plantilla ---- */
const entry = `  {
    slug: "${slug}",
    title: "${title.replace(/"/g, '\\"')}",
    authors: [${author ? `"${author}"` : '""'}],
    year: ${new Date().getFullYear()},
    read_date: "${today}",
    category: "${category}",
    subcategory: "${subcat}",
    tags: [],
    journal: "",
    source: "",
    doi: "",
    references: [],
    body: \`## TL;DR

## Idea central

## Argumentos principales

## Por qué importa

## Notas

## Cita destacada
> *(pendiente)*
\`
  },`;

/* ---- Insertar en papers.js ---- */
const papersFile = path.join(__dirname, 'data', 'papers.js');

if (!fs.existsSync(papersFile)) {
    console.error('Error: no se encontró papers/data/papers.js');
    process.exit(1);
}

let content = fs.readFileSync(papersFile, 'utf-8');

// Insertar justo después de "window.PAPERS = ["
const marker = 'window.PAPERS = [';
const insertAt = content.indexOf(marker);

if (insertAt === -1) {
    console.error('Error: no se encontró el array PAPERS en papers.js');
    process.exit(1);
}

const afterMarker = insertAt + marker.length;
const newContent =
    content.slice(0, afterMarker) +
    '\n' + entry + '\n' +
    content.slice(afterMarker);

fs.writeFileSync(papersFile, newContent, 'utf-8');

console.log(`
Entrada creada:
  slug      : ${slug}
  título    : ${title}
  fecha     : ${today}

Edita papers/data/papers.js para completar los campos y escribe tu síntesis.
`);
