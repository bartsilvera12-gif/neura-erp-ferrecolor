import { normalizeWaPhone } from "@/lib/chat/wa-phone";
import type { SupabaseAdmin } from "@/lib/chat/types";

/**
 * Contexto mínimo para enviar WhatsApp desde servidor (webhook, APIs) sin instanciar el flow engine.
 */
export async function getConversationWhatsAppSendContext(
  supabase: SupabaseAdmin,
  conversationId: string
): Promise<{
  toDigits: string;
  phoneNumberId: string;
  token: string;
}> {
  const { data: conv, error: convErr } = await supabase
    .from("chat_conversations")
    .select("contact_id, channel_id")
    .eq("id", conversationId)
    .maybeSingle();
  if (convErr || !conv) throw new Error(convErr?.message ?? "Conversación no encontrada");

  const { data: contact, error: cErr } = await supabase
    .from("chat_contacts")
    .select("phone_number")
    .eq("id", (conv as { contact_id: string }).contact_id)
    .maybeSingle();
  if (cErr) throw new Error(cErr.message);

  const { data: channel, error: chErr } = await supabase
    .from("chat_channels")
    .select("meta_phone_number_id, whatsapp_access_token, activo")
    .eq("id", (conv as { channel_id: string }).channel_id)
    .maybeSingle();
  if (chErr) throw new Error(chErr.message);

  const toDigits = normalizeWaPhone((contact?.phone_number as string) ?? "");
  const phoneNumberId =
    (channel as { meta_phone_number_id?: string } | null)?.meta_phone_number_id ??
    process.env.WHATSAPP_PHONE_NUMBER_ID?.trim();
  const tokenInChannel =
    typeof (channel as { whatsapp_access_token?: string } | null)?.whatsapp_access_token === "string"
      ? (channel as { whatsapp_access_token: string }).whatsapp_access_token.trim()
      : "";
  const token = tokenInChannel || process.env.WHATSAPP_TOKEN?.trim() || "";

  if (!toDigits || !phoneNumberId || !token) {
    throw new Error("Faltan datos de envío (teléfono, phone_number_id o token)");
  }
  return { toDigits, phoneNumberId, token };
}
