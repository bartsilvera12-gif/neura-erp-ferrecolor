// Patch 2: rewrite renderVals filter logic + add pagination UI to HTML template.
const fs = require('fs');
const path = 'public/sitio/catalogo.html';
let s = fs.readFileSync(path, 'utf8');
const NL = '\r\n';

// ---------- A) Reemplazar bloque de filter client-side + resultLabel ----------
const oldFilter = `    const f = st.filter;\r\n    const q = this.norm(st.search).trim();\r\n    const tokens = q ? q.split(/\\s+/) : [];\r\n    const products = this.catalog().filter(p => {\r\n      const okFilter = (f === 'Todos') || (f === 'Ofertas' ? p.badge === 'Oferta' : p.cat === f);\r\n      if (!okFilter) return false;\r\n      if (!tokens.length) return true;\r\n      const hay = this.norm(p.name + ' ' + p.cat + ' ' + p.attr + ' ' + (p.desc || ''));\r\n      return tokens.every(t => hay.includes(t));\r\n    }).map(p => {\r\n      const b = (badgeMap[p.badge] || badgeMap['Stock']);\r\n      return {\r\n        id: p.id, name: p.name, cat: p.cat, attr: p.attr,\r\n        priceLabel: fmt(p.price), hasOld: !!p.old, oldLabel: p.old ? fmt(p.old) : '',\r\n        badgeBg: b.bg, badgeFg: b.fg, badgeText: b.text,\r\n        img: p.img,\r\n        open: () => this.openDetail(p.id)\r\n      };\r\n    });\r\n    const resultLabel = q || f !== 'Todos'\r\n      ? products.length + (products.length === 1 ? ' resultado' : ' resultados')\r\n      : products.length + ' productos';`;
const newFilter = `    // Productos vienen paginados/filtrados del server (no se filtra client-side).
    const products = this.catalog().map(p => {
      const b = (badgeMap[p.badge] || badgeMap['Stock']);
      return {
        id: p.id, name: p.name, cat: p.cat, attr: p.attr,
        priceLabel: fmt(p.price), hasOld: !!p.old, oldLabel: p.old ? fmt(p.old) : '',
        badgeBg: b.bg, badgeFg: b.fg, badgeText: b.text,
        img: p.img,
        open: () => this.openDetail(p.id)
      };
    });
    // Paginacion
    const total = st.total || 0;
    const pageSize = st.pageSize || 25;
    const totalPages = Math.max(1, Math.ceil(total / pageSize));
    const safePage = Math.min(Math.max(1, st.page || 1), totalPages);
    const fromIdx = total === 0 ? 0 : (safePage - 1) * pageSize + 1;
    const toIdx = Math.min(safePage * pageSize, total);
    const resultLabel = total === 0
      ? (st.loading ? 'Cargando productos...' : 'Sin productos')
      : 'Mostrando ' + fromIdx + '-' + toIdx + ' de ' + total;
    const hasPrev = safePage > 1;
    const hasNext = safePage < totalPages;
    const pageBtnStyle = (enabled) => 'display:inline-flex;align-items:center;gap:6px;height:42px;padding:0 18px;border-radius:11px;border:1.5px solid ' +
      (enabled ? '#E97932' : '#E2E7EF') + ';background:' + (enabled ? '#fff' : '#F6F7FA') +
      ';color:' + (enabled ? '#E97932' : '#A4ACBA') + ';font-weight:700;font-size:14px;cursor:' +
      (enabled ? 'pointer' : 'not-allowed') + ';font-family:Montserrat;transition:all .2s;';
    const pageInfoStyle = 'font-size:13.5px;color:#697287;font-weight:600;font-family:Montserrat;padding:0 18px;';`.replace(/\n/g, NL);
if (!s.includes(oldFilter)) throw new Error('oldFilter no encontrado');
s = s.replace(oldFilter, newFilter);

// ---------- B) Cambiar el handler de filter.set para usar onFilterChange ----------
const oldFilterSet = `      return { label, style, active, set: () => this.setState({ filter: label, filterOpen: false }) };`;
const newFilterSet = `      return { label, style, active, set: () => { this.setState({ filterOpen: false }); this.onFilterChange(label); } };`;
if (!s.includes(oldFilterSet)) throw new Error('oldFilterSet no encontrado');
s = s.replace(oldFilterSet, newFilterSet);

// ---------- C) Reemplazar el return de renderVals para exponer paginacion + nuevos handlers ----------
const oldReturn = `    return {\r\n      products, resultLabel, filters,\r\n      hasResults: products.length > 0, noResults: products.length === 0,\r\n      search: st.search, hasSearch: !!st.search,\r\n      onSearch: (e) => this.setState({ search: e.target.value }),\r\n      clearSearch: () => this.setState({ search: '' }),\r\n      toggleFilter: () => this.setState(s => ({ filterOpen: !s.filterOpen })),\r\n      filterLabel, filterBtnStyle, filterCaretStyle, filterMenuStyle,\r\n      catMenuItems, catMenuEmpty, catCaretStyle, catMenuStyle, catSearch: st.catSearch,\r\n      onCatSearch: (e) => this.setState({ catSearch: e.target.value }),\r\n      toggleCatMenu: () => this.setState(s => ({ catMenuOpen: !s.catMenuOpen })),\r\n      goOfertas: () => this.pickCat('Ofertas'),\r\n      detail, detailOpen, detailWrapStyle, closeDetail: () => this.closeDetail(),\r\n      waContact: waBase('Hola Ferretería República! Quiero hacer una consulta.')\r\n    };`;
const newReturn = `    return {
      products, resultLabel, filters,
      hasResults: products.length > 0, noResults: products.length === 0 && !st.loading,
      search: st.search, hasSearch: !!st.search,
      onSearch: (e) => this.onSearchInput(e),
      clearSearch: () => this.clearSearchAndReload(),
      toggleFilter: () => this.setState(s => ({ filterOpen: !s.filterOpen })),
      filterLabel, filterBtnStyle, filterCaretStyle, filterMenuStyle,
      catMenuItems, catMenuEmpty, catCaretStyle, catMenuStyle, catSearch: st.catSearch,
      onCatSearch: (e) => this.setState({ catSearch: e.target.value }),
      toggleCatMenu: () => this.setState(s => ({ catMenuOpen: !s.catMenuOpen })),
      goOfertas: () => this.pickCat('Ofertas'),
      detail, detailOpen, detailWrapStyle, closeDetail: () => this.closeDetail(),
      waContact: waBase('Hola Ferretería República! Quiero hacer una consulta.'),
      // Paginacion
      hasPagination: total > pageSize,
      pageLabel: 'Página ' + safePage + ' de ' + totalPages,
      hasPrev, hasNext,
      prevStyle: pageBtnStyle(hasPrev),
      nextStyle: pageBtnStyle(hasNext),
      pageInfoStyle,
      gotoPrev: () => { if (hasPrev) this.prevPage(); },
      gotoNext: () => { if (hasNext) this.nextPage(); }
    };`.replace(/\n/g, NL);
if (!s.includes(oldReturn)) throw new Error('oldReturn no encontrado');
s = s.replace(oldReturn, newReturn);

// ---------- D) Inyectar HTML de paginacion despues del cierre de </sc-for> del grid ----------
// La estructura es:
//   <sc-for ... as="p" ...>
//     ...product card...
//   </sc-for>
// </div>     <-- cierre del grid
// </sc-if>   <-- cierre del hasResults
// Inyecto la paginacion despues del cierre </sc-if> y antes del prox elemento.
const oldGridClose = `      </sc-for>\r\n      </div>\r\n      </sc-if>`;
const newGridClose = `      </sc-for>
      </div>
      </sc-if>

      <!-- Paginacion (solo si total > pageSize) -->
      <sc-if value="{{ hasPagination }}" hint-placeholder-val="{{ false }}">
        <div style="margin-top:46px;display:flex;align-items:center;justify-content:center;gap:8px;flex-wrap:wrap;">
          <button onClick="{{ gotoPrev }}" style="{{ prevStyle }}">
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.4"><path d="M15 18l-6-6 6-6"/></svg>
            Anterior
          </button>
          <span style="{{ pageInfoStyle }}">{{ pageLabel }}</span>
          <button onClick="{{ gotoNext }}" style="{{ nextStyle }}">
            Siguiente
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.4"><path d="M9 6l6 6-6 6"/></svg>
          </button>
        </div>
      </sc-if>`.replace(/\n/g, NL);
if (!s.includes(oldGridClose)) throw new Error('oldGridClose no encontrado');
s = s.replace(oldGridClose, newGridClose);

fs.writeFileSync(path, s);
console.log('Patch 2 aplicado. Length:', s.length);
