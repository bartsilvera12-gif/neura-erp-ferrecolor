import { NextRequest } from "next/server";
import { getChatServiceClientForEmpresa } from "@/app/api/chat/_chat-service-client";
import { assignConversation } from "@/lib/chat/assign-conversation-service";
import { saveIncomingMessage } from "@/lib/chat/incoming-message-service";
import {
  extractDisplayName,
  extractExternalMessageId,
  extractInboundIdentifiers,
  extractMessageContent,
  extractSendTimeIso,
  parseYCloudWebhookEnvelope,
} from "@/lib/chat/webhooks/ycloud-inbound-payload";
import { resolveYCloudChannelForWebhook } from "@/lib/chat/webhooks/ycloud-resolve-channel";

export const dynamic = "force-dynamic";

const LOG = "[webhooks/ycloud]";
const LOG_IN = "[ycloud-incoming]";

export async function POST(request: NextRequest) {
  const rawBody = await request.text();
  const sigHeader =
    request.headers.get("ycloud-signature") ??
    request.headers.get("YCloud-Signature") ??
    request.headers.get("x-ycloud-signature");

  let body: unknown;
  try {
    body = JSON.parse(rawBody);
  } catch {
    console.warn(LOG, LOG_IN, "JSON inválido");
    return new Response("Bad Request", { status: 400 });
  }

  const env = parseYCloudWebhookEnvelope(body);
  const eventType = typeof env?.type === "string" ? env.type.trim() : "";

  if (eventType !== "whatsapp.inbound_message.received") {
    console.info(LOG, LOG_IN, "evento ignorado (ack)", { eventType, event_id: env?.id });
    return new Response("OK", { status: 200 });
  }

  const wim = env?.whatsappInboundMessage;
  if (!wim || typeof wim !== "object" || Array.isArray(wim)) {
    console.warn(LOG, LOG_IN, "sin whatsappInboundMessage");
    return new Response("Bad Request", { status: 400 });
  }

  const msg = wim as Record<string, unknown>;
  const ids = extractInboundIdentifiers(msg);
  if (!ids) {
    console.warn(LOG, LOG_IN, "sin from/to/waba suficiente", { keys: Object.keys(msg) });
    return new Response("Bad Request", { status: 400 });
  }

  const resolved = await resolveYCloudChannelForWebhook(rawBody, sigHeader, ids);
  if (!resolved) {
    console.warn(LOG, LOG_IN, "401 canal no resuelto o firma inválida", {
      wabaId: ids.wabaId,
      to: ids.to,
    });
    return new Response("Unauthorized", { status: 401 });
  }

  console.info(LOG, LOG_IN, "canal resuelto", {
    empresa_id: resolved.empresa_id,
    channel_id: resolved.channel_id,
    wabaId: ids.wabaId,
    from: ids.from,
  });

  const supabase = await getChatServiceClientForEmpresa(resolved.empresa_id);
  const externalId = extractExternalMessageId(msg);
  const { message_type, content } = extractMessageContent(msg);
  const createdAt = extractSendTimeIso(msg);
  const displayName = extractDisplayName(msg);

  const save = await saveIncomingMessage({
    supabase,
    channel: {
      id: resolved.channel_id,
      empresa_id: resolved.empresa_id,
      type: "whatsapp",
    },
    external_id: externalId,
    contact_data: {
      address: ids.from,
      display_name: displayName,
    },
    message_data: {
      message_type,
      content,
      raw_payload: env as unknown as Record<string, unknown>,
      created_at: createdAt,
      from_me: false,
      sender_type: "contact",
    },
  });

  if (!save.ok) {
    console.error(LOG, LOG_IN, "saveIncomingMessage", save.error);
    return new Response("Error", { status: 500 });
  }

  if (save.skipped_duplicate) {
    console.info(LOG, LOG_IN, "duplicado omitido", { externalId });
    return new Response("OK", { status: 200 });
  }

  const ar = await assignConversation(supabase, save.conversation_id);
  if (!ar.ok) {
    console.warn(LOG, LOG_IN, "assignConversation", save.conversation_id, ar.error);
  } else if (ar.assigned) {
    console.info(LOG, LOG_IN, "assignConversation ok", { conversation_id: save.conversation_id, agent_id: ar.agent_id });
  } else {
    console.info(LOG, LOG_IN, "assignConversation sin asignación", {
      conversation_id: save.conversation_id,
      reason: ar.reason,
    });
  }

  console.info(LOG, LOG_IN, "mensaje persistido", {
    conversation_id: save.conversation_id,
    message_id: save.message_id,
  });

  return new Response("OK", { status: 200 });
}
