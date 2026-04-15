import { createServiceRoleClient } from "@/lib/supabase/service-admin";
import { createServiceRoleClientForEmpresa } from "@/lib/supabase/empresa-data-schema";
import { normalizeWaPhone } from "@/lib/chat/wa-phone";
import type { SupabaseAdmin } from "@/lib/chat/types";
import { verifyYCloudWebhookSignature } from "@/lib/chat/webhooks/ycloud-signature";

export type YCloudInboundIdentifiers = {
  wabaId: string;
  to: string;
  from: string;
};

function normPhone(s: string): string {
  return normalizeWaPhone(s || "");
}

function cfgStr(cfg: Record<string, unknown>, key: string): string {
  const v = cfg[key];
  return typeof v === "string" ? v.trim() : "";
}

/** Coincidencia heurística canal ERP ↔ payload YCloud (sin validar firma aún). */
export function channelMatchesYCloudInbound(
  row: {
    provider_channel_id: string | null;
    config: unknown;
  },
  ids: YCloudInboundIdentifiers
): boolean {
  const cfg =
    row.config && typeof row.config === "object" && !Array.isArray(row.config)
      ? (row.config as Record<string, unknown>)
      : {};

  const waba = ids.wabaId.trim();
  const ycCh = cfgStr(cfg, "ycloud_channel_id");
  const ycSend = cfgStr(cfg, "ycloud_sender_id");
  const prov = (row.provider_channel_id ?? "").trim();
  const toN = normPhone(ids.to);

  if (waba && ycCh && waba === ycCh) return true;
  if (waba && prov && waba === prov) return true;
  if (toN && ycSend && normPhone(ycSend) === toN) return true;
  if (toN && prov && normPhone(prov) === toN) return true;
  return false;
}

export type ResolvedYCloudChannel = {
  empresa_id: string;
  channel_id: string;
  webhook_secret: string;
};

/**
 * Busca canales WhatsApp YCloud que casen con el payload y cuya firma del body sea válida.
 */
export async function resolveYCloudChannelForWebhook(
  rawBody: string,
  signatureHeader: string | null,
  ids: YCloudInboundIdentifiers
): Promise<ResolvedYCloudChannel | null> {
  const catalog = createServiceRoleClient();
  const single = process.env.YCLOUD_WEBHOOK_EMPRESA_ID?.trim();

  let empresaIds: string[] = [];
  if (single) {
    empresaIds = [single];
  } else {
    const { data: emps, error } = await catalog.from("empresas").select("id");
    if (error) {
      console.warn("[webhooks/ycloud] list empresas", error.message);
      return null;
    }
    empresaIds = (emps ?? []).map((r) => (r as { id: string }).id).filter(Boolean);
  }

  const candidates: ResolvedYCloudChannel[] = [];

  for (const empresaId of empresaIds) {
    let supabase: SupabaseAdmin;
    try {
      supabase = (await createServiceRoleClientForEmpresa(empresaId)) as SupabaseAdmin;
    } catch {
      continue;
    }

    const { data: rows, error: chErr } = await supabase
      .from("chat_channels")
      .select("id, empresa_id, provider, type, config, provider_channel_id, activo")
      .eq("empresa_id", empresaId)
      .eq("type", "whatsapp")
      .eq("provider", "ycloud")
      .eq("activo", true);

    if (chErr) {
      console.warn("[webhooks/ycloud] chat_channels", empresaId, chErr.message);
      continue;
    }

    for (const row of rows ?? []) {
      const r = row as {
        id: string;
        empresa_id: string;
        provider: string;
        config: unknown;
        provider_channel_id: string | null;
      };
      if (!channelMatchesYCloudInbound(r, ids)) continue;

      const cfg =
        r.config && typeof r.config === "object" && !Array.isArray(r.config)
          ? (r.config as Record<string, unknown>)
          : {};
      const secret = cfgStr(cfg, "ycloud_webhook_secret");
      if (!secret) continue;

      if (!verifyYCloudWebhookSignature(rawBody, signatureHeader, secret)) continue;

      candidates.push({
        empresa_id: r.empresa_id,
        channel_id: r.id,
        webhook_secret: secret,
      });
    }
  }

  if (candidates.length === 0) return null;
  if (candidates.length > 1) {
    console.warn("[webhooks/ycloud] múltiples canales coinciden; se usa el primero", {
      count: candidates.length,
      channel_ids: candidates.map((c) => c.channel_id),
    });
  }
  return candidates[0] ?? null;
}
