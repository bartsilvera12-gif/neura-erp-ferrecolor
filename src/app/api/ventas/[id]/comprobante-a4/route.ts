/**
 * Comprobante A4 imprimible (formato "hoja tradicional" para Ferrecolor).
 * Reemplaza el ticket termico (el cliente no tiene ticketera).
 *
 * Layout:
 *   - Ciudad + fecha en letras al tope
 *   - Razon social / direccion / contacto del cliente a la izquierda
 *   - Condicion de venta / RUC / Nota de remision a la derecha
 *   - Tabla: CANTIDAD | DESCRIPCION | P.UNITARIO | EXENTA | IVA 5% | IVA 10%
 *   - Sub totales, totales, "SON GUARANIES" en letras, liquidacion del IVA
 *
 * GET /api/ventas/[id]/comprobante-a4
 */
import { NextRequest, NextResponse } from "next/server";
import { getTenantSupabaseFromAuth } from "@/lib/supabase/tenant-api";

function escapeHtml(s: string): string {
  return String(s ?? "")
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/"/g, "&quot;")
    .replace(/'/g, "&#39;");
}

function fmtGs(v: number): string {
  return Math.round(v).toLocaleString("es-PY");
}

/** Fecha larga tipo "HERNANDARIAS, 20 DE JULIO DEL 2026". Forzada a UTC-3 (Paraguay). */
function fechaLarga(iso: string, ciudad = "HERNANDARIAS"): string {
  try {
    const d = new Date(iso);
    const py = new Date(d.getTime() - 3 * 60 * 60 * 1000);
    const dia = py.getUTCDate();
    const meses = ["ENERO","FEBRERO","MARZO","ABRIL","MAYO","JUNIO","JULIO","AGOSTO","SEPTIEMBRE","OCTUBRE","NOVIEMBRE","DICIEMBRE"];
    const mes = meses[py.getUTCMonth()];
    const anio = py.getUTCFullYear();
    return `${ciudad}, ${dia} DE ${mes} DEL ${anio}`;
  } catch {
    return ciudad;
  }
}

/** Numero entero a letras (guaranies). Soporta hasta miles de millones. */
function numeroALetras(n: number): string {
  const num = Math.round(Math.max(0, Number.isFinite(n) ? n : 0));
  if (num === 0) return "CERO";
  const unidades = ["", "UN", "DOS", "TRES", "CUATRO", "CINCO", "SEIS", "SIETE", "OCHO", "NUEVE"];
  const especiales = ["DIEZ", "ONCE", "DOCE", "TRECE", "CATORCE", "QUINCE", "DIECISEIS", "DIECISIETE", "DIECIOCHO", "DIECINUEVE"];
  const decenas = ["", "", "VEINTI", "TREINTA", "CUARENTA", "CINCUENTA", "SESENTA", "SETENTA", "OCHENTA", "NOVENTA"];
  const centenas = ["", "CIENTO", "DOSCIENTOS", "TRESCIENTOS", "CUATROCIENTOS", "QUINIENTOS", "SEISCIENTOS", "SETECIENTOS", "OCHOCIENTOS", "NOVECIENTOS"];

  function menores1000(n: number): string {
    if (n === 0) return "";
    if (n === 100) return "CIEN";
    let out = "";
    const c = Math.floor(n / 100);
    const resto = n % 100;
    if (c > 0) out += centenas[c] + " ";
    if (resto < 10) {
      out += unidades[resto];
    } else if (resto < 20) {
      out += especiales[resto - 10];
    } else {
      const d = Math.floor(resto / 10);
      const u = resto % 10;
      if (d === 2 && u > 0) {
        out += "VEINTI" + unidades[u].toLowerCase();
      } else if (u === 0) {
        out += decenas[d];
      } else {
        out += decenas[d] + " Y " + unidades[u];
      }
    }
    return out.trim().toUpperCase();
  }

  function grupo(n: number, singular: string, plural: string): string {
    if (n === 0) return "";
    if (n === 1) return singular;
    const t = menores1000(n);
    return `${t} ${plural}`;
  }

  const millones = Math.floor(num / 1_000_000);
  const restoMillones = num % 1_000_000;
  const miles = Math.floor(restoMillones / 1000);
  const unidadesFinal = restoMillones % 1000;

  const partes: string[] = [];
  if (millones > 0) partes.push(grupo(millones, "UN MILLON", "MILLONES"));
  if (miles > 0) partes.push(miles === 1 ? "MIL" : `${menores1000(miles)} MIL`);
  if (unidadesFinal > 0) partes.push(menores1000(unidadesFinal));

  return partes.join(" ").replace(/\s+/g, " ").trim();
}

export async function GET(
  request: NextRequest,
  ctxParams: { params: Promise<{ id: string }> }
) {
  try {
    const { id: ventaId } = await ctxParams.params;
    const ctx = await getTenantSupabaseFromAuth(request);
    if (!ctx) return new NextResponse("Unauthorized", { status: 401 });
    const sb = ctx.supabase;
    const empresaId = ctx.auth.empresa_id;

    // 1) Venta
    const { data: venta } = await sb
      .from("ventas")
      .select("id, numero_control, fecha, subtotal, monto_iva, total, tipo_venta, plazo_dias, metodo_pago, cliente_id, nota_remision_numero, genera_nota_remision, observaciones, estado")
      .eq("id", ventaId)
      .eq("empresa_id", empresaId)
      .maybeSingle();
    if (!venta) return new NextResponse("Venta no encontrada", { status: 404 });

    // 2) Items
    const { data: items } = await sb
      .from("ventas_items")
      .select("producto_nombre, sku, cantidad, precio_venta, tipo_iva, subtotal, monto_iva, total_linea")
      .eq("venta_id", ventaId)
      .eq("empresa_id", empresaId);

    // 3) Cliente (opcional)
    let cliente: { nombre?: string; ruc?: string; direccion?: string; telefono?: string } | null = null;
    if ((venta as { cliente_id?: string | null }).cliente_id) {
      const { data: c } = await sb
        .from("clientes")
        .select("empresa, nombre_contacto, nombre, ruc, documento, direccion, telefono")
        .eq("empresa_id", empresaId)
        .eq("id", (venta as { cliente_id: string }).cliente_id)
        .maybeSingle();
      if (c) {
        const cc = c as Record<string, string | null>;
        cliente = {
          nombre: cc.empresa || cc.nombre_contacto || cc.nombre || "",
          ruc: cc.ruc || cc.documento || "",
          direccion: cc.direccion || "",
          telefono: cc.telefono || "",
        };
      }
    }

    // 4) Empresa (para ciudad si la tuvieramos; hoy solo hardcoded HERNANDARIAS)
    // Podria leerse de ferrecolor.empresas si se completa el campo 'ciudad'.

    const filas = (items ?? []).map((it: Record<string, unknown>) => {
      const cant = Number(it.cantidad ?? 0);
      const pu = Number(it.precio_venta ?? 0);
      const total = Number(it.total_linea ?? 0);
      const ivaTipo = String(it.tipo_iva ?? "10%");
      const exenta = ivaTipo === "EXENTA" ? total : 0;
      const iva5 = ivaTipo === "5%" ? total : 0;
      const iva10 = ivaTipo === "10%" ? total : 0;
      return {
        cant,
        nombre: String(it.producto_nombre ?? ""),
        pu,
        exenta,
        iva5,
        iva10,
      };
    });

    const totExenta = filas.reduce((s, f) => s + f.exenta, 0);
    const totIva5 = filas.reduce((s, f) => s + f.iva5, 0);
    const totIva10 = filas.reduce((s, f) => s + f.iva10, 0);
    const total = totExenta + totIva5 + totIva10;
    // Liquidacion del IVA: monto de IVA incluido en la parte 5% y 10%
    const iva5Liq = Math.round((totIva5 / 1.05) * 0.05);
    const iva10Liq = Math.round((totIva10 / 1.1) * 0.1);
    const ivaTotal = iva5Liq + iva10Liq;

    const v = venta as Record<string, unknown>;
    const numeroControl = String(v.numero_control ?? "");
    const notaRem = v.genera_nota_remision === true && v.nota_remision_numero
      ? String(v.nota_remision_numero)
      : "";
    const condicion = v.tipo_venta === "CREDITO"
      ? `CREDITO${v.plazo_dias ? ` ${v.plazo_dias}d` : ""}`
      : "CONTADO";

    const filasHtml = filas
      .map(
        (f) => `<tr>
          <td class="c cant">${f.cant}</td>
          <td class="c desc">${escapeHtml(f.nombre)}</td>
          <td class="c num">${fmtGs(f.pu)}</td>
          <td class="c num">${f.exenta > 0 ? fmtGs(f.exenta) : "0"}</td>
          <td class="c num">${f.iva5 > 0 ? fmtGs(f.iva5) : "0"}</td>
          <td class="c num">${f.iva10 > 0 ? fmtGs(f.iva10) : "0"}</td>
        </tr>`
      )
      .join("");

    // Filas vacias para completar la hoja (min 12 filas para look homogeneo)
    const MIN_FILAS = 12;
    const vacias = Math.max(0, MIN_FILAS - filas.length);
    const filasVaciasHtml = Array.from({ length: vacias })
      .map(
        () => `<tr class="empty">
          <td class="c cant">&nbsp;</td>
          <td class="c desc">&nbsp;</td>
          <td class="c num">&nbsp;</td>
          <td class="c num">&nbsp;</td>
          <td class="c num">&nbsp;</td>
          <td class="c num">&nbsp;</td>
        </tr>`
      )
      .join("");

    const html = `<!doctype html>
<html lang="es"><head><meta charset="utf-8" />
<title>Comprobante ${escapeHtml(numeroControl)} — Ferrecolor</title>
<style>
  * { box-sizing: border-box; }
  @page { size: A4 landscape; margin: 12mm; }
  html, body { margin: 0; padding: 0; background: #f1f1f1; color: #111; font-family: 'Courier New', ui-monospace, monospace; font-size: 12px; }
  .hoja {
    background: #fff;
    width: 297mm; min-height: 210mm; margin: 20px auto;
    padding: 14mm 16mm; box-shadow: 0 1px 6px rgba(0,0,0,.12);
  }
  .top {
    display: flex; justify-content: space-between; align-items: flex-start;
    border-bottom: 2px solid #111; padding-bottom: 8px; margin-bottom: 12px;
  }
  .empresa { font-size: 22px; font-weight: 800; letter-spacing: 3px; }
  .ciudad-fecha { font-size: 13px; font-weight: 700; text-align: right; }
  .info { display: grid; grid-template-columns: 1fr 1fr; gap: 24px; margin-bottom: 8px; }
  .info .col div { padding: 3px 0; border-bottom: 1px dotted #333; font-size: 13px; }
  .info .col strong { display: inline-block; min-width: 130px; }
  table.items { width: 100%; border-collapse: collapse; margin-top: 8px; }
  table.items th, table.items td {
    border: 1px solid #111; padding: 4px 6px; font-size: 12px; vertical-align: top;
  }
  table.items th { background: #eee; font-weight: 700; text-align: center; letter-spacing: 1px; font-size: 11px; }
  td.c { }
  td.cant { text-align: center; width: 60px; }
  td.desc { text-align: left; }
  td.num { text-align: right; width: 90px; font-variant-numeric: tabular-nums; }
  tr.empty td { color: #fff; }
  .totales-row { font-weight: 700; background: #fafafa; }
  .footer { margin-top: 6px; border: 1px solid #111; border-top: 0; padding: 6px 8px; font-size: 12px; }
  .footer .linea { padding: 3px 0; border-bottom: 1px dotted #333; }
  .footer .linea:last-child { border-bottom: 0; }
  .footer strong { display: inline-block; min-width: 170px; letter-spacing: 1px; }
  .print-btn {
    position: fixed; top: 12px; right: 12px; background: #4FAEB2; color: #fff;
    border: 0; padding: 8px 14px; border-radius: 8px; font-family: inherit; font-size: 13px;
    font-weight: 700; cursor: pointer; box-shadow: 0 2px 8px rgba(0,0,0,.2);
  }
  .print-btn:hover { background: #3F8E91; }
  @media print {
    body { background: #fff; }
    .hoja { box-shadow: none; margin: 0; width: auto; min-height: auto; padding: 8mm 12mm; }
    .print-btn { display: none; }
  }
</style></head>
<body>
  <button class="print-btn" onclick="window.print()">Imprimir</button>
  <div class="hoja">
    <div class="top">
      <div class="empresa">FERRECOLOR</div>
      <div class="ciudad-fecha">${escapeHtml(fechaLarga(String(v.fecha ?? "")))}</div>
    </div>

    <div class="info">
      <div class="col">
        <div><strong>RAZON SOCIAL:</strong> ${escapeHtml(cliente?.nombre ?? "")}</div>
        <div><strong>DIRECCION:</strong> ${escapeHtml(cliente?.direccion ?? "")}</div>
        <div><strong>CONTACTO:</strong> ${escapeHtml(cliente?.telefono ?? "")}</div>
      </div>
      <div class="col">
        <div><strong>CONDICION DE VENTA:</strong> ${escapeHtml(condicion)}</div>
        <div><strong>R.U.C./C.I.:</strong> ${escapeHtml(cliente?.ruc ?? "")}</div>
        <div><strong>NOTA DE REMISION:</strong> ${escapeHtml(notaRem)}</div>
      </div>
    </div>

    <table class="items">
      <thead>
        <tr>
          <th style="width:60px;">CANTIDAD</th>
          <th>DESCRIPCION</th>
          <th style="width:90px;">P.UNITARIO</th>
          <th style="width:90px;">EXENTA</th>
          <th style="width:90px;">IVA 5%</th>
          <th style="width:90px;">IVA 10%</th>
        </tr>
      </thead>
      <tbody>
        ${filasHtml}
        ${filasVaciasHtml}
        <tr class="totales-row">
          <td class="c" colspan="3" style="text-align:right;"><strong>SUB TOTALES</strong></td>
          <td class="c num">${fmtGs(totExenta)}</td>
          <td class="c num">${fmtGs(totIva5)}</td>
          <td class="c num">${fmtGs(totIva10)}</td>
        </tr>
        <tr class="totales-row">
          <td class="c" colspan="3" style="text-align:right;"><strong>TOTALES</strong></td>
          <td class="c num">${fmtGs(totExenta)}</td>
          <td class="c num">${fmtGs(totIva5)}</td>
          <td class="c num">${fmtGs(totIva10)}</td>
        </tr>
      </tbody>
    </table>

    <div class="footer">
      <div class="linea"><strong>SON GUARANIES:</strong> ${escapeHtml(numeroALetras(total))}</div>
      <div class="linea">
        <strong>LIQUIDACION DEL IVA:</strong>
        &nbsp;(5%): ${fmtGs(iva5Liq)}
        &nbsp;&nbsp;(10%): ${fmtGs(iva10Liq)}
        &nbsp;&nbsp;<strong>TOTAL IVA:</strong> ${fmtGs(ivaTotal)}
      </div>
      <div class="linea" style="text-align:right;"><strong>TOTAL:</strong> Gs. ${fmtGs(total)}</div>
    </div>
  </div>
  <script>
    // Auto-open print dialog al abrir (comentar si molesta).
    // setTimeout(function(){ window.print(); }, 400);
  </script>
</body></html>`;

    return new NextResponse(html, {
      status: 200,
      headers: { "Content-Type": "text/html; charset=utf-8", "Cache-Control": "no-store" },
    });
  } catch (err) {
    console.error(
      "[/api/ventas/[id]/comprobante-a4]",
      err instanceof Error ? err.message : err
    );
    return new NextResponse("Error interno", { status: 500 });
  }
}
