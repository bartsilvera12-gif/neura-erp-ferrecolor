import { NextRequest, NextResponse } from "next/server";
import { getTenantSupabaseFromAuthWithRol } from "@/lib/supabase/tenant-api";
import { errorResponse } from "@/lib/api/response";
import { API_ERRORS } from "@/lib/api/errors";
import { downloadSifenObject } from "@/lib/sifen/sifen-storage";
import { buildKudePdfBuffer, type KudeBranding } from "@/lib/sifen/kude-pdf";
import { kudeFallbackQrUrl, parseKudeFromSignedRdeXml } from "@/lib/sifen/parse-kude-from-signed-xml";
import type { SifenConsultaLoteUltimaPersistida } from "@/lib/sifen/types";
import type { AppSupabaseClient } from "@/lib/supabase/schema";

const TIPO_DOC_LABEL_NC = "Nota de crédito electrónica";

function dProtAutDesdeConsulta(
  cdc: string,
  consulta: SifenConsultaLoteUltimaPersistida | Record<string, unknown> | null | undefined
): string | null {
  if (!consulta || typeof consulta !== "object") return null;
  const o = consulta as Record<string, unknown>;
  const raw = o.detallePorCdc ?? o.detalle_por_cdc;
  if (!Array.isArray(raw)) return null;
  const hit = (raw as { cdc?: string; dProtAut?: string | null }[]).find((d) => d.cdc === cdc);
  const v = hit?.dProtAut;
  return v != null && String(v).trim() !== "" ? String(v).trim() : null;
}

function nombreArchivoKudeNc(numeroFactura: string, cdc: string): string {
  const safe = numeroFactura.replace(/[^\w.-]+/g, "_").slice(0, 40);
  return `KuDE-NC-${safe || "nota-credito"}-${cdc.slice(-8)}.pdf`;
}

/** Mismo branding por empresa que el KuDE de factura; solo afecta apariencia. */
async function loadKudeBranding(
  supabase: AppSupabaseClient,
  empresaId: string
): Promise<KudeBranding | null> {
  const { data, error } = await supabase
    .from("empresa_sifen_config")
    .select("kude_logo_path, kude_color_primario, kude_color_primario_fill")
    .eq("empresa_id", empresaId)
    .maybeSingle();

  if (error || !data) return null;

  const row = data as {
    kude_logo_path: string | null;
    kude_color_primario: string | null;
    kude_color_primario_fill: string | null;
  };

  const colorPrimario =
    row.kude_color_primario == null || String(row.kude_color_primario).trim() === ""
      ? null
      : String(row.kude_color_primario).trim();
  const colorPrimarioFill =
    row.kude_color_primario_fill == null || String(row.kude_color_primario_fill).trim() === ""
      ? null
      : String(row.kude_color_primario_fill).trim();

  const logoPath =
    row.kude_logo_path == null || String(row.kude_logo_path).trim() === ""
      ? null
      : String(row.kude_logo_path).trim();

  let logoBytes: Uint8Array | null = null;
  if (logoPath) {
    const dl = await downloadSifenObject(supabase, logoPath);
    if (dl.ok) logoBytes = new Uint8Array(dl.data);
  }

  return { logoBytes, colorPrimario, colorPrimarioFill };
}

/**
 * GET /api/notas-credito/[id]/sifen/kude
 * PDF KuDE de la nota de crédito desde su XML firmado. Solo con `estado_sifen` = aprobado.
 * Query: `download=1` → Content-Disposition attachment.
 */
export async function GET(request: NextRequest, { params }: { params: Promise<{ id: string }> }) {
  try {
    const ctx = await getTenantSupabaseFromAuthWithRol(request);
    if (!ctx) {
      return NextResponse.json(errorResponse(API_ERRORS.UNAUTHORIZED), { status: 401 });
    }
    const { auth, supabase } = ctx;

    const { id } = await params;
    const nid = id?.trim();
    if (!nid) {
      return NextResponse.json(errorResponse("id de nota de crédito es obligatorio"), { status: 400 });
    }

    const download = request.nextUrl.searchParams.get("download") === "1";

    const { data: nc, error: errNc } = await supabase
      .from("nota_credito")
      .select("id, factura_id, facturas(numero_factura)")
      .eq("id", nid)
      .eq("empresa_id", auth.empresa_id)
      .maybeSingle();

    if (errNc) {
      return NextResponse.json(errorResponse(errNc.message), { status: 400 });
    }
    if (!nc) {
      return NextResponse.json(errorResponse("Nota de crédito no encontrada."), { status: 404 });
    }

    const { data: ne, error: errNe } = await supabase
      .from("nota_credito_electronica")
      .select("estado_sifen, xml_firmado_path, cdc, sifen_ultima_respuesta_consulta_lote")
      .eq("nota_credito_id", nid)
      .eq("empresa_id", auth.empresa_id)
      .maybeSingle();

    if (errNe) {
      return NextResponse.json(errorResponse(errNe.message), { status: 400 });
    }
    if (!ne) {
      return NextResponse.json(errorResponse("No hay documento electrónico para esta nota de crédito."), {
        status: 404,
      });
    }

    if (String((ne as { estado_sifen: string }).estado_sifen) !== "aprobado") {
      return NextResponse.json(
        errorResponse("El KuDE solo está disponible con la nota de crédito aprobada por SET."),
        { status: 403 }
      );
    }

    const xmlPath =
      (ne as { xml_firmado_path: string | null }).xml_firmado_path == null
        ? ""
        : String((ne as { xml_firmado_path: string | null }).xml_firmado_path).trim();
    if (!xmlPath) {
      return NextResponse.json(errorResponse("No hay XML firmado en storage."), { status: 400 });
    }

    const dl = await downloadSifenObject(supabase, xmlPath);
    if (!dl.ok) {
      return NextResponse.json(errorResponse(`No se pudo descargar el XML firmado: ${dl.message}`), {
        status: 500,
      });
    }

    let parsed;
    try {
      parsed = parseKudeFromSignedRdeXml(dl.data.toString("utf8"));
    } catch (e) {
      const m = e instanceof Error ? e.message : "Error al leer el XML";
      return NextResponse.json(errorResponse(`XML firmado inválido: ${m}`), { status: 500 });
    }

    const cdcBd = (ne as { cdc: string | null }).cdc == null ? "" : String((ne as { cdc: string | null }).cdc).trim();
    if (cdcBd && cdcBd !== parsed.cdc) {
      return NextResponse.json(
        errorResponse("Inconsistencia CDC entre la nota de crédito y su XML firmado."),
        { status: 409 }
      );
    }

    const dProtAut = dProtAutDesdeConsulta(
      parsed.cdc,
      (ne as { sifen_ultima_respuesta_consulta_lote?: Record<string, unknown> | null })
        .sifen_ultima_respuesta_consulta_lote ?? null
    );

    const branding = await loadKudeBranding(supabase, auth.empresa_id).catch((e) => {
      console.warn("[kude-nc] branding load failed, using default", {
        empresa_id: auth.empresa_id,
        error: e instanceof Error ? e.message : String(e),
      });
      return null;
    });

    const facRel = (nc as { facturas?: { numero_factura?: string } | { numero_factura?: string }[] | null }).facturas;
    const facObj = Array.isArray(facRel) ? facRel[0] : facRel;
    const numeroFactura = facObj?.numero_factura == null ? "" : String(facObj.numero_factura);

    let pdf: Buffer;
    try {
      pdf = await buildKudePdfBuffer({
        parsed,
        numeroFactura: numeroFactura ? `NC de ${numeroFactura}` : "Nota de crédito",
        dProtAut,
        qrUrl: parsed.dCarQR ?? kudeFallbackQrUrl(parsed.cdc),
        branding,
        tipoDocumentoLabel: TIPO_DOC_LABEL_NC,
      });
    } catch (e) {
      const m = e instanceof Error ? e.message : "Error al generar PDF";
      return NextResponse.json(errorResponse(m), { status: 500 });
    }

    const fname = nombreArchivoKudeNc(numeroFactura, parsed.cdc);
    return new NextResponse(new Uint8Array(pdf), {
      status: 200,
      headers: {
        "Content-Type": "application/pdf",
        "Content-Disposition": `${download ? "attachment" : "inline"}; filename="${fname}"`,
        "Cache-Control": "private, no-store",
      },
    });
  } catch (err) {
    return NextResponse.json(errorResponse(err instanceof Error ? err.message : "Error"), { status: 500 });
  }
}
