/**
 * Aplica un archivo .sql remoto vía conexión Postgres directa (cuando `supabase` CLI está bloqueado).
 * Uso: npx tsx scripts/apply-sql-file-pg.ts supabase/migrations/archivo.sql
 * Variables: DIRECT_URL o DATABASE_URL en .env.local
 */
import { config } from "dotenv";
import { readFileSync } from "node:fs";
import path from "node:path";
import pg from "pg";

config({ path: path.resolve(process.cwd(), ".env.local") });

const file = process.argv[2];
if (!file) {
  console.error("Uso: npx tsx scripts/apply-sql-file-pg.ts <ruta.sql>");
  process.exit(1);
}

const url =
  process.env.DIRECT_URL?.trim() ||
  process.env.DATABASE_URL?.trim() ||
  process.env.SUPABASE_DB_URL?.trim();
if (!url) {
  console.error("Falta DIRECT_URL o DATABASE_URL en .env.local");
  process.exit(1);
}

async function main() {
  const sql = readFileSync(path.resolve(process.cwd(), file), "utf8");
  const client = new pg.Client({ connectionString: url, ssl: url.includes("supabase") ? { rejectUnauthorized: false } : undefined });
  await client.connect();
  try {
    await client.query(sql);
    console.log("OK:", file);
  } finally {
    await client.end();
  }
}

main().catch((e) => {
  console.error(e);
  process.exit(1);
});
