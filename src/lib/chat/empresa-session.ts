import { createSupabaseServerClient } from "@/lib/supabase/server";

export type EmpresaUsuarioSession = {
  supabase: Awaited<ReturnType<typeof createSupabaseServerClient>>;
  empresa_id: string;
  usuario_id: string;
};

/**
 * Usuario autenticado (auth) alineado a `public.usuarios` de su empresa.
 */
export async function requireEmpresaUsuarioSession(): Promise<EmpresaUsuarioSession> {
  const supabase = await createSupabaseServerClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user?.email) {
    throw new Error("Usuario no autenticado o sin empresa");
  }
  const { data, error } = await supabase
    .from("usuarios")
    .select("id, empresa_id")
    .eq("email", user.email)
    .single();
  if (error) throw new Error(error.message);
  const empresa_id = data?.empresa_id;
  const usuario_id = data?.id;
  if (!empresa_id || typeof empresa_id !== "string" || !usuario_id || typeof usuario_id !== "string") {
    throw new Error("Usuario no autenticado o sin empresa");
  }
  return { supabase, empresa_id, usuario_id };
}
