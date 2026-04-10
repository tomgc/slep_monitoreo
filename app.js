/* ============================================================
   Mi colección de películas y documentales
   Lógica del frontend: carga, filtros, búsqueda, orden, modal.
   ============================================================ */

(() => {
    "use strict";

    // ---------- Estado ----------
    const state = {
        movies: [],
        filters: {
            type: new Set(),
            genre: new Set(),
            decade: new Set(),
            country: new Set(),
        },
        search: "",
        sort: "added_desc",
    };

    // ---------- Utilidades ----------
    const $ = (sel) => document.querySelector(sel);
    const $$ = (sel) => Array.from(document.querySelectorAll(sel));

    const debounce = (fn, ms = 150) => {
        let t;
        return (...args) => {
            clearTimeout(t);
            t = setTimeout(() => fn(...args), ms);
        };
    };

    const normalize = (s) =>
        (s || "")
            .toString()
            .toLowerCase()
            .normalize("NFD")
            .replace(/[\u0300-\u036f]/g, "");

    const decadeOf = (year) => {
        if (!year) return null;
        const d = Math.floor(year / 10) * 10;
        return `${d}s`;
    };

    const rottenTomatoesUrl = (title) => {
        const q = encodeURIComponent(title || "");
        return `https://www.rottentomatoes.com/search?search=${q}`;
    };

    const imdbUrl = (imdbId) =>
        imdbId ? `https://www.imdb.com/title/${imdbId}/` : null;

    const tmdbUrl = (tmdbId, type) =>
        tmdbId
            ? `https://www.themoviedb.org/${type === "documentary" ? "movie" : "movie"}/${tmdbId}`
            : null;

    // ---------- Carga ----------
    async function loadMovies() {
        try {
            const res = await fetch("data/movies.json", { cache: "no-cache" });
            if (!res.ok) throw new Error(`HTTP ${res.status}`);
            const data = await res.json();
            state.movies = Array.isArray(data) ? data : [];
        } catch (err) {
            console.error("No se pudo cargar data/movies.json:", err);
            state.movies = [];
        }
    }

    // ---------- Filtros disponibles ----------
    function buildFacets() {
        const facets = {
            type: new Map(),
            genre: new Map(),
            decade: new Map(),
            country: new Map(),
        };

        for (const m of state.movies) {
            // tipo
            const type = m.type || "movie";
            facets.type.set(type, (facets.type.get(type) || 0) + 1);

            // géneros (todos)
            (m.genres || []).forEach((g) => {
                if (!g) return;
                facets.genre.set(g, (facets.genre.get(g) || 0) + 1);
            });

            // década
            const dec = decadeOf(m.year);
            if (dec) facets.decade.set(dec, (facets.decade.get(dec) || 0) + 1);

            // países
            (m.countries || []).forEach((c) => {
                if (!c) return;
                facets.country.set(c, (facets.country.get(c) || 0) + 1);
            });
        }
        return facets;
    }

    // ---------- Render de filtros ----------
    function renderFilters() {
        const facets = buildFacets();

        const typeLabels = { movie: "Película", documentary: "Documental" };

        const renderChips = (containerId, entries, key, labelMap) => {
            const container = $("#" + containerId);
            container.innerHTML = "";
            // ordenar por count desc, luego alfabético
            const sorted = entries.sort((a, b) => {
                if (b[1] !== a[1]) return b[1] - a[1];
                return a[0].localeCompare(b[0]);
            });
            for (const [val, count] of sorted) {
                const label = labelMap ? labelMap[val] || val : val;
                const btn = document.createElement("button");
                btn.className = "chip";
                btn.type = "button";
                btn.dataset.value = val;
                btn.innerHTML = `${label}<span class="count">${count}</span>`;
                if (state.filters[key].has(val)) btn.classList.add("active");
                btn.addEventListener("click", () => {
                    if (state.filters[key].has(val)) state.filters[key].delete(val);
                    else state.filters[key].add(val);
                    btn.classList.toggle("active");
                    apply();
                });
                container.appendChild(btn);
            }
            if (sorted.length === 0) {
                const empty = document.createElement("span");
                empty.className = "muted";
                empty.style.fontSize = "0.78rem";
                empty.style.color = "var(--text-muted)";
                empty.textContent = "—";
                container.appendChild(empty);
            }
        };

        renderChips("filter-type", Array.from(facets.type.entries()), "type", typeLabels);
        renderChips("filter-genre", Array.from(facets.genre.entries()), "genre");
        // décadas: ordenar cronológicamente desc
        const decadeEntries = Array.from(facets.decade.entries()).sort((a, b) => {
            const ay = parseInt(a[0]);
            const by = parseInt(b[0]);
            return by - ay;
        });
        const decadeContainer = $("#filter-decade");
        decadeContainer.innerHTML = "";
        for (const [val, count] of decadeEntries) {
            const btn = document.createElement("button");
            btn.className = "chip";
            btn.type = "button";
            btn.dataset.value = val;
            btn.innerHTML = `${val}<span class="count">${count}</span>`;
            if (state.filters.decade.has(val)) btn.classList.add("active");
            btn.addEventListener("click", () => {
                if (state.filters.decade.has(val)) state.filters.decade.delete(val);
                else state.filters.decade.add(val);
                btn.classList.toggle("active");
                apply();
            });
            decadeContainer.appendChild(btn);
        }
        if (decadeEntries.length === 0) {
            const empty = document.createElement("span");
            empty.style.fontSize = "0.78rem";
            empty.style.color = "var(--text-muted)";
            empty.textContent = "—";
            decadeContainer.appendChild(empty);
        }

        renderChips("filter-country", Array.from(facets.country.entries()), "country");
    }

    // ---------- Filtrado ----------
    function matches(movie) {
        // tipo (OR dentro del grupo, AND con otros)
        if (state.filters.type.size > 0 && !state.filters.type.has(movie.type || "movie"))
            return false;

        // géneros: el film debe contener al menos uno de los seleccionados
        if (state.filters.genre.size > 0) {
            const gset = new Set(movie.genres || []);
            let ok = false;
            for (const g of state.filters.genre) if (gset.has(g)) { ok = true; break; }
            if (!ok) return false;
        }

        // década
        if (state.filters.decade.size > 0) {
            const d = decadeOf(movie.year);
            if (!d || !state.filters.decade.has(d)) return false;
        }

        // país
        if (state.filters.country.size > 0) {
            const cset = new Set(movie.countries || []);
            let ok = false;
            for (const c of state.filters.country) if (cset.has(c)) { ok = true; break; }
            if (!ok) return false;
        }

        // búsqueda de texto
        if (state.search) {
            const q = normalize(state.search);
            const haystack = normalize(
                [
                    movie.title,
                    movie.original_title,
                    (movie.directors || []).join(" "),
                    (movie.writers || []).join(" "),
                    (movie.cast || []).join(" "),
                    (movie.genres || []).join(" "),
                    (movie.keywords || []).join(" "),
                ].join(" ")
            );
            if (!haystack.includes(q)) return false;
        }

        return true;
    }

    function sortMovies(list) {
        const arr = list.slice();
        switch (state.sort) {
            case "title_asc":
                arr.sort((a, b) => normalize(a.title).localeCompare(normalize(b.title)));
                break;
            case "title_desc":
                arr.sort((a, b) => normalize(b.title).localeCompare(normalize(a.title)));
                break;
            case "year_asc":
                arr.sort((a, b) => (a.year || 0) - (b.year || 0));
                break;
            case "year_desc":
                arr.sort((a, b) => (b.year || 0) - (a.year || 0));
                break;
            case "rating_desc":
                arr.sort((a, b) => (b.tmdb_rating || 0) - (a.tmdb_rating || 0));
                break;
            case "added_desc":
            default:
                arr.sort((a, b) => {
                    const da = a.added_date || "";
                    const db = b.added_date || "";
                    return db.localeCompare(da);
                });
                break;
        }
        return arr;
    }

    // ---------- Render de cards ----------
    function renderGrid(list) {
        const grid = $("#grid");
        grid.innerHTML = "";

        if (state.movies.length === 0) {
            $("#empty-state").hidden = false;
            $("#no-results").hidden = true;
            $("#results-count").textContent = "0 títulos";
            return;
        }
        $("#empty-state").hidden = true;

        if (list.length === 0) {
            $("#no-results").hidden = false;
            $("#results-count").textContent = "0 resultados";
            return;
        }
        $("#no-results").hidden = true;

        const frag = document.createDocumentFragment();
        for (const m of list) {
            const card = document.createElement("button");
            card.className = "card";
            card.type = "button";
            card.setAttribute("role", "listitem");
            card.addEventListener("click", () => openModal(m));

            const poster = document.createElement("div");
            poster.className = "poster";

            if (m.poster_path) {
                const img = document.createElement("img");
                img.src = m.poster_path;
                img.alt = `Portada de ${m.title}`;
                img.loading = "lazy";
                img.decoding = "async";
                poster.appendChild(img);
            } else {
                poster.textContent = m.title || "Sin portada";
            }

            if (m.type === "documentary") {
                const badge = document.createElement("span");
                badge.className = "type-badge";
                badge.textContent = "Doc";
                poster.appendChild(badge);
            }

            const title = document.createElement("div");
            title.className = "card-title";
            title.textContent = m.title || "(sin título)";

            const meta = document.createElement("div");
            meta.className = "card-meta";
            const parts = [];
            if (m.year) parts.push(m.year);
            if (m.directors && m.directors.length) parts.push(m.directors[0]);
            meta.textContent = parts.join(" · ");

            card.appendChild(poster);
            card.appendChild(title);
            card.appendChild(meta);
            frag.appendChild(card);
        }
        grid.appendChild(frag);

        $("#results-count").textContent =
            list.length === 1 ? "1 título" : `${list.length} títulos`;
    }

    function renderActiveFilters() {
        const active = [];
        for (const k of ["type", "genre", "decade", "country"]) {
            for (const v of state.filters[k]) {
                active.push(v === "movie" ? "Película" : v === "documentary" ? "Documental" : v);
            }
        }
        $("#active-filters").textContent = active.length ? `· ${active.join(", ")}` : "";
    }

    // ---------- Modal ----------
    function openModal(m) {
        const body = $("#modal-body");

        const linkImdb = imdbUrl(m.imdb_id);
        const linkRT = rottenTomatoesUrl(m.title);
        const linkTMDB = tmdbUrl(m.tmdb_id, m.type);

        const renderList = (items) =>
            (items || []).filter(Boolean).join(", ") || "—";

        const genres = m.genres || [];
        const primaryGenre = genres[0];
        const subGenres = genres.slice(1);

        const keywords = m.keywords || [];

        body.innerHTML = `
            <div class="modal-poster">
                ${
                    m.poster_path
                        ? `<img src="${m.poster_path}" alt="Portada de ${escapeHtml(m.title)}">`
                        : ""
                }
            </div>
            <div class="modal-info">
                <p class="modal-eyebrow">${m.type === "documentary" ? "Documental" : "Película"}${
                    m.year ? " · " + m.year : ""
                }${
                    typeof m.tmdb_rating === "number" && m.tmdb_rating > 0
                        ? ` · ★ ${m.tmdb_rating.toFixed(1)}`
                        : ""
                }</p>
                <h2 id="modal-title">${escapeHtml(m.title || "(sin título)")}</h2>
                ${
                    m.original_title && m.original_title !== m.title
                        ? `<p class="modal-original">${escapeHtml(m.original_title)}</p>`
                        : ""
                }

                <p class="modal-line"><strong>Dirección:</strong> ${escapeHtml(renderList(m.directors))}</p>
                <p class="modal-line"><strong>Guion:</strong> ${escapeHtml(renderList(m.writers))}</p>
                <p class="modal-line"><strong>Elenco:</strong> ${escapeHtml(renderList((m.cast || []).slice(0, 6)))}</p>
                <p class="modal-line"><strong>País:</strong> ${escapeHtml(renderList(m.countries))}</p>
                <p class="modal-line"><strong>Idioma original:</strong> ${escapeHtml(m.original_language || "—")}</p>
                <p class="modal-line"><strong>Duración:</strong> ${
                    m.runtime ? m.runtime + " min" : "—"
                }</p>

                ${
                    genres.length
                        ? `<div class="modal-section">
                            <h4>Géneros</h4>
                            <div class="tag-list">
                                ${primaryGenre ? `<span class="tag primary">${escapeHtml(primaryGenre)}</span>` : ""}
                                ${subGenres.map((g) => `<span class="tag">${escapeHtml(g)}</span>`).join("")}
                            </div>
                        </div>`
                        : ""
                }

                ${
                    keywords.length
                        ? `<div class="modal-section">
                            <h4>Etiquetas</h4>
                            <div class="tag-list">
                                ${keywords.map((k) => `<span class="tag">${escapeHtml(k)}</span>`).join("")}
                            </div>
                        </div>`
                        : ""
                }

                ${
                    m.synopsis
                        ? `<div class="modal-section">
                            <h4>Sinopsis</h4>
                            <p class="modal-synopsis">${escapeHtml(m.synopsis)}</p>
                        </div>`
                        : ""
                }

                <div class="modal-links">
                    ${linkImdb ? `<a href="${linkImdb}" target="_blank" rel="noopener">IMDb</a>` : ""}
                    <a class="secondary" href="${linkRT}" target="_blank" rel="noopener">Rotten Tomatoes</a>
                    ${linkTMDB ? `<a class="secondary" href="${linkTMDB}" target="_blank" rel="noopener">TMDB</a>` : ""}
                </div>

                ${
                    m.added_date
                        ? `<p class="modal-line" style="margin-top:22px;color:var(--text-muted);font-size:0.74rem;">Agregada el ${escapeHtml(m.added_date)}</p>`
                        : ""
                }
            </div>
        `;

        const modal = $("#modal");
        modal.hidden = false;
        modal.setAttribute("aria-hidden", "false");
        document.body.style.overflow = "hidden";
    }

    function closeModal() {
        const modal = $("#modal");
        modal.hidden = true;
        modal.setAttribute("aria-hidden", "true");
        document.body.style.overflow = "";
    }

    function escapeHtml(str) {
        return String(str ?? "")
            .replace(/&/g, "&amp;")
            .replace(/</g, "&lt;")
            .replace(/>/g, "&gt;")
            .replace(/"/g, "&quot;")
            .replace(/'/g, "&#39;");
    }

    // ---------- Pipeline ----------
    function apply() {
        const filtered = state.movies.filter(matches);
        const sorted = sortMovies(filtered);
        renderGrid(sorted);
        renderActiveFilters();
    }

    // ---------- Eventos ----------
    function bindEvents() {
        $("#search-input").addEventListener(
            "input",
            debounce((e) => {
                state.search = e.target.value.trim();
                apply();
            }, 120)
        );

        $("#sort-select").addEventListener("change", (e) => {
            state.sort = e.target.value;
            apply();
        });

        $("#clear-filters").addEventListener("click", () => {
            for (const k of ["type", "genre", "decade", "country"]) state.filters[k].clear();
            state.search = "";
            $("#search-input").value = "";
            renderFilters();
            apply();
        });

        // modal close
        $("#modal").addEventListener("click", (e) => {
            if (e.target.dataset && e.target.dataset.close !== undefined) closeModal();
        });
        document.addEventListener("keydown", (e) => {
            if (e.key === "Escape" && !$("#modal").hidden) closeModal();
        });

        // sidebar toggle (mobile)
        $("#sidebar-toggle").addEventListener("click", () => {
            $("#sidebar").classList.toggle("open");
        });
    }

    // ---------- Init ----------
    async function init() {
        bindEvents();
        await loadMovies();
        renderFilters();
        apply();
    }

    document.addEventListener("DOMContentLoaded", init);
})();
