import { serializeUnknownError } from "@/lib/errors/serialize-unknown-error";
import { supabase } from "@/lib/supabase";

async function resolveAccessToken(): Promise<string | null> {
  let {
    data: { session },
  } = await supabase.auth.getSession();
  if (session?.access_token) return session.access_token;
  const { data: gu, error } = await supabase.auth.getUser();
  if (error || !gu.user) return null;
  ({
    data: { session },
  } = await supabase.auth.getSession());
  return session?.access_token ?? null;
}

/** fetch a rutas propias enviando el JWT de la sesión actual (localStorage); fallback cookies con credentials. */
export async function fetchWithSupabaseSession(
  input: RequestInfo | URL,
  init?: RequestInit
): Promise<Response> {
  try {
    const pedir = async (token: string | null) => {
      const headers = new Headers(init?.headers);
      if (token) headers.set("Authorization", `Bearer ${token}`);
      return fetch(input, { ...init, headers, credentials: init?.credentials ?? "include" });
    };

    let res = await pedir(await resolveAccessToken());

    // Sesión vencida: el server responde 401 y antes eso llegaba a la pantalla
    // como un "No autenticado" suelto (p. ej. dentro del modal de crear cliente).
    // Se intenta UNA renovación y se repite el pedido; si sigue 401, la sesión
    // esta realmente muerta y se manda al login con aviso.
    if (res.status === 401) {
      let renovado: string | null = null;
      try {
        const { data, error } = await supabase.auth.refreshSession();
        if (!error) renovado = data.session?.access_token ?? null;
      } catch { /* sin sesión renovable */ }

      if (renovado) res = await pedir(renovado);

      if (res.status === 401 && typeof window !== "undefined") {
        const yaEnLogin = window.location.pathname.startsWith("/login");
        if (!yaEnLogin) {
          const volverA = window.location.pathname + window.location.search;
          window.location.href = `/login?expirada=1&next=${encodeURIComponent(volverA)}`;
        }
      }
    }

    return res;
  } catch (e) {
    // Preservar AbortError tal cual para que el caller pueda hacer
    //   catch (err) { if (err instanceof DOMException && err.name === "AbortError") return; }
    // Sin esto, el wrapper Error lo enmascaraba y el caller no podia distinguir
    // un abort intencional (componente desmontado) de un fallo de red real.
    if (e instanceof DOMException && e.name === "AbortError") throw e;
    throw new Error(`fetchWithSupabaseSession: ${serializeUnknownError(e)}`);
  }
}

/**
 * Helper: true si el error proviene de un AbortController.
 * Sirve para llamadas que pueden venir del wrapper o de fetch nativo.
 */
export function isAbortError(err: unknown): boolean {
  if (err instanceof DOMException && err.name === "AbortError") return true;
  if (err instanceof Error && err.name === "AbortError") return true;
  return false;
}

/** Alias: todas las llamadas a `/api/*` autenticadas desde el browser deben usar esto (JWT localStorage). */
export const apiFetch = fetchWithSupabaseSession;
