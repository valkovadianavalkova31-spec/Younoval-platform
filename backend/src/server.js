const express = require("express");
const helmet = require("helmet");
const { Pool } = require("pg");

const app = express();
app.disable("x-powered-by");
app.use(helmet());
app.use(express.json({ limit: "64kb" }));

const port = Number(process.env.PORT || 3001);
const authMode = process.env.AUTH_MODE || "disabled";

let pool = null;
if (process.env.DATABASE_URL) {
  pool = new Pool({
    connectionString: process.env.DATABASE_URL,
    ssl: process.env.DATABASE_SSL === "true" ? { rejectUnauthorized: true } : false,
    max: 5,
    idleTimeoutMillis: 10000,
    connectionTimeoutMillis: 5000
  });
}

app.get("/healthz", async (_req, res) => {
  if (!pool) return res.status(503).json({ ok: false, database: "not_configured" });
  try {
    await pool.query("SELECT 1");
    return res.json({ ok: true, database: "connected", auth: authMode });
  } catch {
    return res.status(503).json({ ok: false, database: "unavailable" });
  }
});

// Registration, login, results and analytics ingestion are intentionally not
// exposed yet. Do not enable collection until the Article 8(10) scope and
// authentication method, Russian DB location, RKN notice, user documents,
// consent enforcement and security controls have been reviewed.
// Never log request bodies, credentials, emails, answers or result payloads.

app.listen(port, () => {
  console.log(`YOUNOVAL API foundation listening on port ${port}`);
});

process.on("SIGTERM", async () => {
  if (pool) await pool.end();
  process.exit(0);
});
