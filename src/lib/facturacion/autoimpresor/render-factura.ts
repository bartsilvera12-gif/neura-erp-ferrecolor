/**
 * Render HTML de una factura autoimpresor (formato legal paraguayo, hoja A4).
 *
 * Soporta dos modos:
 *  - Emitida (real): muestra el número fiscal correlativo y NO lleva marca de agua.
 *  - Borrador: cuando el autoimpresor aún no está activo/configurado. Muestra el
 *    layout con una marca de agua "SIN VALIDEZ FISCAL" y numeración de ejemplo,
 *    sin consumir la secuencia real. Sirve para previsualizar el formato.
 *
 * Solo presentación. La numeración/persistencia vive en emitir-factura.ts.
 */
import type { LiquidacionIva } from "./emitir-factura";

export interface FacturaRenderData {
  borrador: boolean;
  motivoBorrador?: string | null;
  emisor: {
    razon_social: string;
    ruc: string;
    direccion: string;
    telefono: string;
    actividad?: string | null;
  };
  timbrado: {
    numero: string;
    inicio: string | null;
    fin: string | null;
    establecimiento: string;
    punto_expedicion: string;
  };
  numeroCompleto: string;
  fechaEmision: string;
  condicion: "contado" | "credito";
  cliente: { nombre: string; ruc: string | null } | null;
  ventaNumeroControl: string;
  items: Array<{
    cantidad: number;
    descripcion: string;
    precioUnitario: number;
    totalLinea: number;
    tipo_iva: string;
  }>;
  liq: LiquidacionIva;
  autoPrint: boolean;
}

function esc(s: string): string {
  return String(s ?? "")
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/"/g, "&quot;")
    .replace(/'/g, "&#39;");
}

function gs(v: number): string {
  return Math.round(v || 0).toLocaleString("es-PY");
}

function fecha(iso: string): string {
  try {
    const d = new Date(iso);
    const dd = String(d.getDate()).padStart(2, "0");
    const mm = String(d.getMonth() + 1).padStart(2, "0");
    return `${dd}/${mm}/${d.getFullYear()}`;
  } catch {
    return iso;
  }
}

function fechaCorta(iso: string | null): string {
  if (!iso) return "—";
  const s = String(iso).slice(0, 10);
  const m = s.match(/^(\d{4})-(\d{2})-(\d{2})$/);
  return m ? `${m[3]}/${m[2]}/${m[1]}` : s;
}

// ── Número a letras (guaraníes, enteros) ────────────────────────────────────

const UNIDADES = ["", "uno", "dos", "tres", "cuatro", "cinco", "seis", "siete", "ocho", "nueve"];
const ESPECIALES: Record<number, string> = {
  10: "diez", 11: "once", 12: "doce", 13: "trece", 14: "catorce", 15: "quince",
  16: "dieciséis", 17: "diecisiete", 18: "dieciocho", 19: "diecinueve",
  20: "veinte", 21: "veintiuno", 22: "veintidós", 23: "veintitrés", 24: "veinticuatro",
  25: "veinticinco", 26: "veintiséis", 27: "veintisiete", 28: "veintiocho", 29: "veintinueve",
};
const DECENAS = ["", "", "veinte", "treinta", "cuarenta", "cincuenta", "sesenta", "setenta", "ochenta", "noventa"];
const CENTENAS = ["", "ciento", "doscientos", "trescientos", "cuatrocientos", "quinientos", "seiscientos", "setecientos", "ochocientos", "novecientos"];

function menorMil(n: number): string {
  if (n === 0) return "";
  if (n === 100) return "cien";
  let out = "";
  const c = Math.floor(n / 100);
  const resto = n % 100;
  if (c > 0) out += CENTENAS[c] + (resto > 0 ? " " : "");
  if (resto > 0) {
    if (resto < 10) out += UNIDADES[resto];
    else if (resto <= 29) out += ESPECIALES[resto];
    else {
      const d = Math.floor(resto / 10);
      const u = resto % 10;
      out += DECENAS[d] + (u > 0 ? " y " + UNIDADES[u] : "");
    }
  }
  return out;
}

function numeroALetras(n: number): string {
  const entero = Math.round(Math.abs(n));
  if (entero === 0) return "cero";
  const millones = Math.floor(entero / 1_000_000);
  const miles = Math.floor((entero % 1_000_000) / 1000);
  const resto = entero % 1000;
  const partes: string[] = [];
  if (millones > 0) partes.push(millones === 1 ? "un millón" : `${menorMil(millones)} millones`);
  if (miles > 0) partes.push(miles === 1 ? "mil" : `${menorMil(miles)} mil`);
  if (resto > 0) partes.push(menorMil(resto));
  return partes.join(" ").replace(/\s+/g, " ").trim();
}

// ── Render ──────────────────────────────────────────────────────────────────

export function renderFacturaAutoimpresorHTML(d: FacturaRenderData): string {
  const totalIva = d.liq.iva_5 + d.liq.iva_10;
  const cond = d.condicion === "credito" ? "CRÉDITO" : "CONTADO";

  const filas = d.items
    .map((it) => {
      const t = String(it.tipo_iva).toUpperCase();
      const col10 = t === "10%" ? gs(it.totalLinea) : "";
      const col5 = t === "5%" ? gs(it.totalLinea) : "";
      const colEx = t !== "10%" && t !== "5%" ? gs(it.totalLinea) : "";
      return `<tr>
        <td class="c">${it.cantidad}</td>
        <td>${esc(it.descripcion)}</td>
        <td class="r">${gs(it.precioUnitario)}</td>
        <td class="r">${colEx}</td>
        <td class="r">${col5}</td>
        <td class="r">${col10}</td>
      </tr>`;
    })
    .join("");

  const watermark = d.borrador
    ? `<div class="watermark">SIN VALIDEZ FISCAL</div>`
    : "";
  const avisoBorrador = d.borrador
    ? `<div class="aviso">BORRADOR — vista previa del formato. ${esc(d.motivoBorrador || "El autoimpresor no está activo.")} No es una factura legal.</div>`
    : "";

  const clienteNombre = d.cliente?.nombre?.trim() || "SIN NOMBRE";
  const clienteRuc = d.cliente?.ruc?.trim() || "—";

  return `<!doctype html>
<html lang="es"><head><meta charset="utf-8" />
<title>Factura ${esc(d.numeroCompleto)} — ${esc(d.emisor.razon_social)}</title>
<style>
  * { box-sizing: border-box; }
  body { font-family: ui-sans-serif, system-ui, Arial, sans-serif; color:#111; background:#eceff1; margin:0; padding:24px; }
  .doc { position:relative; background:#fff; max-width:800px; margin:0 auto; padding:26px 30px; box-shadow:0 1px 6px rgba(0,0,0,.15); overflow:hidden; }
  .watermark { position:absolute; top:44%; left:50%; transform:translate(-50%,-50%) rotate(-24deg); font-size:56px; font-weight:900; color:rgba(220,38,38,.12); letter-spacing:3px; pointer-events:none; white-space:nowrap; }
  .aviso { background:#fef2f2; border:1px solid #fecaca; color:#b91c1c; font-size:11px; font-weight:600; padding:6px 10px; border-radius:6px; margin-bottom:14px; text-align:center; }
  .top { display:flex; justify-content:space-between; gap:20px; align-items:flex-start; }
  .emisor { flex:1; min-width:0; }
  .emisor .rs { font-size:16px; font-weight:800; color:#111; }
  .emisor .l { font-size:11px; color:#444; line-height:1.5; }
  .fiscal { flex:0 0 260px; border:2px solid #111; border-radius:8px; padding:10px 12px; font-size:12px; text-align:center; }
  .fiscal .ruc { font-weight:800; font-size:13px; }
  .fiscal .tim { font-size:11px; color:#333; margin-top:2px; }
  .fiscal .tipo { margin-top:6px; font-weight:800; letter-spacing:1px; font-size:13px; border-top:1px solid #ccc; padding-top:6px; }
  .fiscal .num { font-size:16px; font-weight:900; letter-spacing:1px; }
  .cli { display:flex; gap:20px; border:1px solid #ccc; border-radius:8px; padding:10px 12px; margin:16px 0 12px; font-size:12px; }
  .cli .campo { flex:1; }
  .cli .campo .k { font-size:10px; text-transform:uppercase; letter-spacing:.5px; color:#777; }
  .cli .campo .v { font-weight:600; }
  table.items { width:100%; border-collapse:collapse; font-size:12px; }
  table.items th, table.items td { border:1px solid #ccc; padding:5px 7px; }
  table.items th { background:#f4f4f5; font-size:10px; text-transform:uppercase; letter-spacing:.4px; }
  table.items td.c { text-align:center; width:44px; }
  table.items td.r, table.items th.r { text-align:right; white-space:nowrap; }
  .cols3 { width:88px; }
  .totrow td { border:1px solid #ccc; padding:5px 7px; font-weight:700; }
  .liq { display:flex; justify-content:space-between; gap:18px; margin-top:12px; font-size:12px; align-items:flex-start; }
  .liq .letras { flex:1; border:1px solid #ccc; border-radius:8px; padding:8px 10px; }
  .liq .letras .k { font-size:10px; text-transform:uppercase; color:#777; letter-spacing:.5px; }
  .liq .cuadro { flex:0 0 300px; border:1px solid #ccc; border-radius:8px; overflow:hidden; }
  .liq .cuadro table { width:100%; border-collapse:collapse; }
  .liq .cuadro td { padding:4px 8px; border-bottom:1px solid #eee; }
  .liq .cuadro td.k { color:#555; }
  .liq .cuadro td.v { text-align:right; font-weight:700; white-space:nowrap; }
  .liq .cuadro tr.tot td { background:#f4f4f5; font-weight:800; }
  .legal { margin-top:16px; font-size:10px; color:#666; border-top:1px dashed #bbb; padding-top:8px; text-align:center; }
  .acts { max-width:800px; margin:14px auto 0; text-align:center; }
  .acts button { padding:8px 18px; font-size:13px; border:1px solid #333; background:#fff; border-radius:6px; cursor:pointer; }
  @media print { body { background:#fff; padding:0; } .doc { box-shadow:none; max-width:none; } .acts { display:none; } @page { size:A4; margin:12mm; } }
</style></head>
<body>
<div class="doc">
  ${watermark}
  ${avisoBorrador}
  <div class="top">
    <div class="emisor">
      <div class="rs">${esc(d.emisor.razon_social)}</div>
      ${d.emisor.actividad ? `<div class="l">${esc(d.emisor.actividad)}</div>` : ""}
      <div class="l">${esc(d.emisor.direccion)}</div>
      <div class="l">Tel: ${esc(d.emisor.telefono)}</div>
    </div>
    <div class="fiscal">
      <div class="ruc">RUC: ${esc(d.emisor.ruc)}</div>
      <div class="tim">Timbrado N° ${esc(d.timbrado.numero)}</div>
      <div class="tim">Vigencia: ${esc(fechaCorta(d.timbrado.inicio))} — ${esc(fechaCorta(d.timbrado.fin))}</div>
      <div class="tipo">FACTURA</div>
      <div class="num">${esc(d.numeroCompleto)}</div>
    </div>
  </div>

  <div class="cli">
    <div class="campo"><div class="k">Fecha de emisión</div><div class="v">${esc(fecha(d.fechaEmision))}</div></div>
    <div class="campo"><div class="k">Condición de venta</div><div class="v">${cond}</div></div>
    <div class="campo"><div class="k">Nombre / Razón social</div><div class="v">${esc(clienteNombre)}</div></div>
    <div class="campo"><div class="k">RUC / CI</div><div class="v">${esc(clienteRuc)}</div></div>
  </div>

  <table class="items">
    <thead>
      <tr>
        <th class="c">Cant.</th>
        <th>Descripción</th>
        <th class="r">Precio Unit.</th>
        <th class="r cols3">Exentas</th>
        <th class="r cols3">Gravadas 5%</th>
        <th class="r cols3">Gravadas 10%</th>
      </tr>
    </thead>
    <tbody>${filas}</tbody>
    <tfoot>
      <tr class="totrow">
        <td colspan="3" style="text-align:right;">SUBTOTALES</td>
        <td class="r">${gs(d.liq.exentas)}</td>
        <td class="r">${gs(d.liq.gravado_5)}</td>
        <td class="r">${gs(d.liq.gravado_10)}</td>
      </tr>
      <tr class="totrow">
        <td colspan="5" style="text-align:right;">TOTAL A PAGAR (Gs.)</td>
        <td class="r">${gs(d.liq.total)}</td>
      </tr>
    </tfoot>
  </table>

  <div class="liq">
    <div class="letras">
      <div class="k">Total en letras</div>
      <div>${esc(numeroALetras(d.liq.total))} guaraníes.</div>
    </div>
    <div class="cuadro">
      <table>
        <tbody>
          <tr><td class="k">Liquidación IVA 5%</td><td class="v">${gs(d.liq.iva_5)}</td></tr>
          <tr><td class="k">Liquidación IVA 10%</td><td class="v">${gs(d.liq.iva_10)}</td></tr>
          <tr class="tot"><td class="k">Total IVA</td><td class="v">${gs(totalIva)}</td></tr>
        </tbody>
      </table>
    </div>
  </div>

  <div class="legal">
    Comprobante emitido por medio de autoimpresor · Venta ${esc(d.ventaNumeroControl)}
    ${d.borrador ? " · DOCUMENTO DE PRUEBA SIN VALIDEZ FISCAL" : ""}
  </div>
</div>
<div class="acts"><button type="button" onclick="window.print()">Imprimir</button></div>
<script>try{ if(new URL(location.href).searchParams.get('auto')==='1'){ setTimeout(function(){window.print();},250); } }catch(e){}</script>
</body></html>`;
}
