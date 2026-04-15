"use client";

import Link from "next/link";
import { useEffect, useState } from "react";
import { saveYCloudWhatsappChannel, type ChatChannelRow } from "@/lib/chat/actions";

type Props = {
  mode: "create" | "edit";
  channelId?: string;
  initialRow?: ChatChannelRow | null;
  cancelHref?: string;
  onSaved?: (channelId: string) => void;
};

function rowToState(row: ChatChannelRow) {
  const cfg = row.config ?? {};
  return {
    nombre: row.nombre ?? "WhatsApp (YCloud)",
    activo: row.activo,
    ycloud_api_key: "",
    ycloud_webhook_secret: typeof cfg.ycloud_webhook_secret === "string" ? cfg.ycloud_webhook_secret : "",
    ycloud_sender_id: typeof cfg.ycloud_sender_id === "string" ? cfg.ycloud_sender_id : "",
    ycloud_channel_id: typeof cfg.ycloud_channel_id === "string" ? cfg.ycloud_channel_id : "",
  };
}

export function YCloudWhatsAppChannelForm({
  mode,
  channelId,
  initialRow,
  cancelHref = "/configuracion/canales",
  onSaved,
}: Props) {
  const [form, setForm] = useState(() =>
    mode === "edit" && initialRow ? rowToState(initialRow) : {
        nombre: "WhatsApp (YCloud)",
        activo: true,
        ycloud_api_key: "",
        ycloud_webhook_secret: "",
        ycloud_sender_id: "",
        ycloud_channel_id: "",
      }
  );
  const [saving, setSaving] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [success, setSuccess] = useState<string | null>(null);

  useEffect(() => {
    if (mode === "edit" && initialRow) setForm(rowToState(initialRow));
  }, [mode, initialRow]);

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault();
    setSaving(true);
    setError(null);
    setSuccess(null);
    try {
      const id = await saveYCloudWhatsappChannel({
        id: mode === "edit" ? channelId : undefined,
        nombre: form.nombre,
        activo: form.activo,
        ycloud_api_key: form.ycloud_api_key || undefined,
        ycloud_webhook_secret: form.ycloud_webhook_secret,
        ycloud_sender_id: form.ycloud_sender_id,
        ycloud_channel_id: form.ycloud_channel_id,
      });
      setSuccess("Guardado.");
      onSaved?.(id);
    } catch (err) {
      setError(err instanceof Error ? err.message : "Error al guardar");
    } finally {
      setSaving(false);
    }
  }

  return (
    <form onSubmit={handleSubmit} className="space-y-5">
      {error ? (
        <div className="bg-red-50 border border-red-200 text-red-800 text-sm rounded-lg px-4 py-2">{error}</div>
      ) : null}
      {success ? (
        <div className="bg-emerald-50 border border-emerald-200 text-emerald-800 text-sm rounded-lg px-4 py-2">
          {success}
        </div>
      ) : null}

      <div>
        <label className="block text-xs font-semibold text-slate-500 uppercase mb-1">Nombre en el ERP</label>
        <input
          className="w-full border border-slate-200 rounded-lg px-3 py-2 text-sm bg-white"
          value={form.nombre}
          onChange={(e) => setForm((p) => ({ ...p, nombre: e.target.value }))}
        />
      </div>
      <div>
        <label className="block text-xs font-semibold text-slate-500 uppercase mb-1">
          API key / secret YCloud {mode === "create" ? "*" : "(vacío = no cambiar)"}
        </label>
        <input
          type="password"
          autoComplete="off"
          className="w-full border border-slate-200 rounded-lg px-3 py-2 text-sm font-mono bg-white"
          value={form.ycloud_api_key}
          onChange={(e) => setForm((p) => ({ ...p, ycloud_api_key: e.target.value }))}
          placeholder={mode === "edit" ? "Dejar vacío para conservar la clave guardada" : ""}
        />
      </div>
      <div>
        <label className="block text-xs font-semibold text-slate-500 uppercase mb-1">Webhook secret</label>
        <input
          type="password"
          autoComplete="off"
          className="w-full border border-slate-200 rounded-lg px-3 py-2 text-sm font-mono bg-white"
          value={form.ycloud_webhook_secret}
          onChange={(e) => setForm((p) => ({ ...p, ycloud_webhook_secret: e.target.value }))}
        />
      </div>
      <div className="grid gap-4 sm:grid-cols-2">
        <div>
          <label className="block text-xs font-semibold text-slate-500 uppercase mb-1">Sender / external ID</label>
          <input
            className="w-full border border-slate-200 rounded-lg px-3 py-2 text-sm font-mono bg-white"
            value={form.ycloud_sender_id}
            onChange={(e) => setForm((p) => ({ ...p, ycloud_sender_id: e.target.value }))}
          />
        </div>
        <div>
          <label className="block text-xs font-semibold text-slate-500 uppercase mb-1">Channel ID YCloud</label>
          <input
            className="w-full border border-slate-200 rounded-lg px-3 py-2 text-sm font-mono bg-white"
            value={form.ycloud_channel_id}
            onChange={(e) => setForm((p) => ({ ...p, ycloud_channel_id: e.target.value }))}
          />
        </div>
      </div>
      <label className="flex items-center gap-2 text-sm text-slate-700">
        <input
          type="checkbox"
          checked={form.activo}
          onChange={(e) => setForm((p) => ({ ...p, activo: e.target.checked }))}
        />
        Canal activo
      </label>
      <p className="text-xs text-slate-500">
        La recepción vía YCloud se implementará en Etapa 2; acá queda persistido el modelo de credenciales y el modo{" "}
        <strong>coexistencia</strong>.
      </p>

      <div className="flex flex-wrap gap-2 pt-2 border-t border-slate-200">
        <button
          type="submit"
          disabled={saving}
          className="bg-[#0EA5E9] hover:bg-[#0284C7] disabled:opacity-50 text-white px-5 py-2.5 rounded-lg text-sm font-medium"
        >
          {saving ? "Guardando…" : mode === "edit" ? "Guardar" : "Crear canal"}
        </button>
        <Link
          href={cancelHref}
          className="inline-flex items-center border border-slate-200 text-slate-700 hover:bg-slate-50 px-5 py-2.5 rounded-lg text-sm font-medium"
        >
          Volver
        </Link>
      </div>
    </form>
  );
}
