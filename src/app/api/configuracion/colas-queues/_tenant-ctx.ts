import type { NextRequest } from "next/server";
import { getTenantSupabaseFromAuth } from "@/lib/supabase/tenant-api";
import { createServiceRoleClient } from "@/lib/supabase/service-admin";
import type { QueueAdminTenantContext } from "@/lib/chat/queue-admin-repo";

export async function resolveQueueAdminTenantContext(
  request: NextRequest
): Promise<{ ctx: QueueAdminTenantContext } | null> {
  const t = await getTenantSupabaseFromAuth(request);
  if (!t?.auth.empresa_id) return null;
  const ctx: QueueAdminTenantContext = {
    supabase: t.supabase,
    catalogSr: createServiceRoleClient(),
    empresa_id: t.auth.empresa_id,
  };
  return { ctx };
}
