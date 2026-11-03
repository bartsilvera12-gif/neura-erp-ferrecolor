import { NextRequest, NextResponse } from "next/server";
import { getTenantSupabaseFromAuth } from "@/lib/supabase/tenant-api";
import { fetchDataSchemaForEmpresaId } from "@/lib/supabase/empresa-data-schema";
import { buildXlsxBufferSheets, sheetFromRows, xlsxResponseHeaders, nowStamp } from "@/lib/excel/export";
import { getReportePagosProveedores } from "@/lib/compras/server/pagos-proveedores-pg";

const METODO: Record<string, string> = {
  efectivo: "Efectivo", transferencia: "Transferencia",
  tarjeta: "Tarjeta", cheque: "Cheque", otro: "Otro",
};

/** GET /api/reportes/pagos-proveedores/export?desde=&hasta= — Excel de 3 hojas. */
export async function GET(request: NextRequest) {
  const ctx = await getTenantSupabaseFromAuth(request);
  if (!ctx) return new NextResponse("Unauthorized", { status: 401 });

  const sp = request.nextUrl.searchParams;
  const desde = sp.get("desde") || "";
  const hasta = sp.get("hasta") || "";
  if (!/^\d{4}-\d{2}-\d{2}$/.test(desde) || !/^\d{4}-\d{2}-\d{2}$/.test(hasta)) {
    return new NextResponse("Faltan desde/hasta (YYYY-MM-DD)", { status: 400 });
  }

  try {
    const schema = await fetchDataSchemaForEmpresaId(ctx.auth.empresa_id);
    const d = await getReportePagosProveedores(schema, ctx.auth.empresa_id, desde, hasta);

    const buf = buildXlsxBufferSheets([
      sheetFromRows("Pagos", d.pagos, [
        { header: "Fecha de pago", value: (p) => new Date(p.fecha_pago), width: 14 },
        { header: "Proveedor", value: (p) => p.proveedor_nombre ?? "—", width: 28 },
        { header: "Compra", value: (p) => p.numero_control, width: 16 },
        { header: "Fecha de compra", value: (p) => (p.fecha_compra ? new Date(p.fecha_compra) : ""), width: 15 },
        { header: "Total de la compra", value: (p) => p.total_compra, width: 18 },
        { header: "Monto pagado", value: (p) => p.monto, width: 16 },
        { header: "Saldo tras el pago", value: (p) => p.saldo_restante, width: 17 },
        { header: "Pago", value: (p) => (p.saldo_restante > 0 ? "Parcial" : "Cancela la compra"), width: 18 },
        { header: "De mes anterior", value: (p) => (p.de_mes_anterior ? "Sí" : "No"), width: 15 },
        { header: "Medio", value: (p) => METODO[p.metodo_pago] ?? p.metodo_pago, width: 14 },
        { header: "Salió de caja", value: (p) => (p.salio_de_caja ? "Sí" : "No"), width: 13 },
        { header: "Referencia", value: (p) => p.referencia ?? "", width: 20 },
        { header: "Registró", value: (p) => p.usuario_nombre ?? "", width: 22 },
      ]),
      sheetFromRows("Por proveedor", d.por_proveedor, [
        { header: "Proveedor", value: (r) => r.proveedor_nombre, width: 32 },
        { header: "Pagos", value: (r) => r.pagos, width: 10 },
        { header: "Total pagado", value: (r) => r.total, width: 18 },
      ]),
      sheetFromRows("Por medio de pago", d.por_metodo, [
        { header: "Medio", value: (r) => METODO[r.metodo_pago] ?? r.metodo_pago, width: 18 },
        { header: "Pagos", value: (r) => r.pagos, width: 10 },
        { header: "Total pagado", value: (r) => r.total, width: 18 },
      ]),
    ]);

    return new NextResponse(new Uint8Array(buf), {
      headers: xlsxResponseHeaders(`pagos-proveedores_${desde}_a_${hasta}_${nowStamp()}.xlsx`),
    });
  } catch (err) {
    const d = err instanceof Error ? err.message : String(err);
    console.error("[/api/reportes/pagos-proveedores/export]", d);
    return new NextResponse(`No se pudo exportar: ${d}`, { status: 500 });
  }
}
