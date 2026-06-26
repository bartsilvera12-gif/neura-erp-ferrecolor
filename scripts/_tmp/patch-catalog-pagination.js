// Patch al public/sitio/catalogo.html para agregar paginacion server-side (25/pag),
// filtro server-side por categoria, busqueda server-side con debounce 350ms.
const fs = require('fs');
const path = 'public/sitio/catalogo.html';
let s = fs.readFileSync(path, 'utf8');
const NL = '\r\n';

// 1) Reemplazar state inicial
const oldState = `  state = {\r\n    filter: 'Todos', detail: null, search: '', filterOpen: false, catMenuOpen: false, catSearch: '',\r\n    // Datos cargados desde /api/sitio/productos y /api/sitio/categorias.\r\n    dbProducts: [], dbCategorias: [], loading: true, loadError: null\r\n  };`;
const newState = `  state = {
    filter: 'Todos', detail: null, search: '', filterOpen: false, catMenuOpen: false, catSearch: '',
    // Datos cargados desde /api/sitio/productos y /api/sitio/categorias.
    dbProducts: [], dbCategorias: [], loading: true, loadError: null,
    // Paginacion server-side (25 productos por pagina)
    page: 1, pageSize: 25, total: 0
  };`.replace(/\n/g, NL);
if (!s.includes(oldState)) throw new Error('oldState no encontrado');
s = s.replace(oldState, newState);

// 2) Reemplazar cargarDatos: ahora paginado + filtro categoria + search
const oldCarga = `  // Cargar productos + categorias del ERP. Se llama desde componentDidMount.\r\n  async cargarDatos() {\r\n    try {\r\n      const [pr, cr] = await Promise.all([\r\n        fetch('/api/sitio/productos?limit=500').then(r => r.json()),\r\n        fetch('/api/sitio/categorias').then(r => r.json())\r\n      ]);\r\n      this.setState({\r\n        dbProducts: Array.isArray(pr.productos) ? pr.productos : [],\r\n        dbCategorias: Array.isArray(cr.categorias) ? cr.categorias : [],\r\n        loading: false,\r\n        loadError: null\r\n      });\r\n    } catch (e) {\r\n      this.setState({ loading: false, loadError: String(e && e.message ? e.message : e) });\r\n    }\r\n  }`;
const newCarga = `  // Cargar productos paginados + categorias del ERP.
  // Lee filtro, busqueda y pagina del state; arma URL con offset y limit.
  async cargarDatos() {
    try {
      const st = this.state;
      const url = new URL('/api/sitio/productos', location.origin);
      url.searchParams.set('limit', String(st.pageSize));
      url.searchParams.set('offset', String((st.page - 1) * st.pageSize));
      if (st.search) url.searchParams.set('q', st.search);
      if (st.filter && st.filter !== 'Todos') {
        const cat = (st.dbCategorias || []).find(c => c.nombre === st.filter);
        if (cat) url.searchParams.set('categoria', cat.id);
      }
      // Categorias se cargan 1 vez solo; despues no se refetchean.
      const needCats = !(st.dbCategorias && st.dbCategorias.length);
      const [pr, cr] = await Promise.all([
        fetch(url.toString()).then(r => r.json()),
        needCats
          ? fetch('/api/sitio/categorias').then(r => r.json())
          : Promise.resolve({ categorias: st.dbCategorias })
      ]);
      this.setState({
        dbProducts: Array.isArray(pr.productos) ? pr.productos : [],
        dbCategorias: Array.isArray(cr.categorias) ? cr.categorias : [],
        total: Number(pr.total) || 0,
        loading: false,
        loadError: null
      });
    } catch (e) {
      this.setState({ loading: false, loadError: String(e && e.message ? e.message : e) });
    }
  }

  // Helpers de paginacion
  setPage(n) {
    const max = Math.max(1, Math.ceil(this.state.total / this.state.pageSize));
    const safe = Math.max(1, Math.min(max, n));
    if (safe === this.state.page) return;
    this.setState({ page: safe, loading: true }, () => {
      this.cargarDatos();
      // Scroll al inicio del grid
      const el = document.querySelector('[data-grid]');
      if (el) window.scrollTo({ top: el.getBoundingClientRect().top + window.scrollY - 80, behavior: 'smooth' });
    });
  }
  nextPage() { this.setPage(this.state.page + 1); }
  prevPage() { this.setPage(this.state.page - 1); }

  // Llamado cuando cambia el filtro de categoria: reset a pagina 1 + refetch
  onFilterChange(f) {
    if (f === this.state.filter) return;
    this.setState({ filter: f, page: 1, loading: true }, () => this.cargarDatos());
  }
  // Debounce simple para search (350ms)
  onSearchInput(e) {
    const v = e.target.value;
    this.setState({ search: v });
    clearTimeout(this._searchT);
    this._searchT = setTimeout(() => {
      this.setState({ page: 1, loading: true }, () => this.cargarDatos());
    }, 350);
  }
  clearSearchAndReload() {
    clearTimeout(this._searchT);
    this.setState({ search: '', page: 1, loading: true }, () => this.cargarDatos());
  }`.replace(/\n/g, NL);
if (!s.includes(oldCarga)) throw new Error('oldCarga no encontrado');
s = s.replace(oldCarga, newCarga);

// 3) En pickCat, usar onFilterChange en vez de setState filter directo
const oldPick = `  pickCat(c) {\r\n    this.setState({ filter: c, catMenuOpen: false, catSearch: '' });\r\n    setTimeout(() => {\r\n      const el = document.querySelector('[data-grid]');\r\n      if (el) window.scrollTo({ top: el.getBoundingClientRect().top + window.scrollY - 80, behavior: 'smooth' });\r\n    }, 60);\r\n  }`;
const newPick = `  pickCat(c) {
    this.setState({ catMenuOpen: false, catSearch: '' });
    this.onFilterChange(c);
    setTimeout(() => {
      const el = document.querySelector('[data-grid]');
      if (el) window.scrollTo({ top: el.getBoundingClientRect().top + window.scrollY - 80, behavior: 'smooth' });
    }, 60);
  }`.replace(/\n/g, NL);
if (!s.includes(oldPick)) throw new Error('oldPick no encontrado');
s = s.replace(oldPick, newPick);

fs.writeFileSync(path, s);
console.log('Patch 1 aplicado (state, cargarDatos, pickCat). Length:', s.length);
