-- YOUNOVAL initial data model.
-- Run only against an approved Russian-hosted production database after legal
-- review, RKN notification (where required), notices/consents and security setup.
BEGIN;
CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE IF NOT EXISTS accounts (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  phone_e164 TEXT NOT NULL,
  phone_verified_at TIMESTAMPTZ,
  email TEXT,
  status TEXT NOT NULL DEFAULT 'pending'
    CHECK (status IN ('pending', 'active', 'suspended', 'deletion_requested', 'deleted')),
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  deleted_at TIMESTAMPTZ,
  CONSTRAINT accounts_phone_format CHECK (phone_e164 ~ '^\\+[1-9][0-9]{7,14}$'),
  CONSTRAINT accounts_email_length CHECK (email IS NULL OR char_length(email) BETWEEN 3 AND 254)
);
CREATE UNIQUE INDEX IF NOT EXISTS accounts_phone_unique
  ON accounts (phone_e164) WHERE deleted_at IS NULL;
CREATE UNIQUE INDEX IF NOT EXISTS accounts_email_lower_unique
  ON accounts (lower(email)) WHERE email IS NOT NULL AND deleted_at IS NULL;

-- OTPs are never stored in plaintext. otp_hash must be a keyed HMAC generated
-- with a server-side secret; the secret itself must not be stored in this DB.
-- Sending, rate limiting and verification remain disabled until a Russian SMS
-- provider and production controls have been selected and reviewed.
CREATE TABLE IF NOT EXISTS phone_auth_challenges (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  phone_e164 TEXT NOT NULL CHECK (phone_e164 ~ '^\\+[1-9][0-9]{7,14}$'),
  otp_hash TEXT NOT NULL,
  purpose TEXT NOT NULL CHECK (purpose IN ('registration', 'login', 'phone_change', 'recovery')),
  expires_at TIMESTAMPTZ NOT NULL,
  attempts SMALLINT NOT NULL DEFAULT 0 CHECK (attempts BETWEEN 0 AND 10),
  max_attempts SMALLINT NOT NULL DEFAULT 5 CHECK (max_attempts BETWEEN 1 AND 10),
  consumed_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  CHECK (expires_at > created_at)
);
CREATE INDEX IF NOT EXISTS phone_auth_challenges_phone_created_idx
  ON phone_auth_challenges (phone_e164, created_at DESC);
CREATE INDEX IF NOT EXISTS phone_auth_challenges_expiry_idx
  ON phone_auth_challenges (expires_at) WHERE consumed_at IS NULL;

CREATE TABLE IF NOT EXISTS consent_records (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  account_id UUID NOT NULL REFERENCES accounts(id) ON DELETE CASCADE,
  document_type TEXT NOT NULL
    CHECK (document_type IN ('personal_data_consent', 'privacy_notice_ack', 'user_terms', 'analytics_consent')),
  document_version TEXT NOT NULL,
  granted_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  withdrawn_at TIMESTAMPTZ,
  capture_method TEXT NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS consent_records_account_idx
  ON consent_records (account_id, document_type, granted_at DESC);

CREATE TABLE IF NOT EXISTS tool_results (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  account_id UUID NOT NULL REFERENCES accounts(id) ON DELETE CASCADE,
  tool_key TEXT NOT NULL
    CHECK (tool_key IN ('health', 'finance', 'marketing', 'market_validation', 'risk_recovery', 'operations', 'adaptability', 'plan_90_days')),
  schema_version INTEGER NOT NULL DEFAULT 1,
  answers JSONB NOT NULL DEFAULT '{}'::jsonb CHECK (jsonb_typeof(answers) = 'object'),
  result JSONB NOT NULL DEFAULT '{}'::jsonb CHECK (jsonb_typeof(result) = 'object'),
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  archived_at TIMESTAMPTZ
);
CREATE INDEX IF NOT EXISTS tool_results_account_tool_date_idx
  ON tool_results (account_id, tool_key, created_at DESC) WHERE archived_at IS NULL;

-- Events are allow-listed. Never put phone/email, answers, free text, financial
-- values, IP addresses or device fingerprints in this table. Account linkage is
-- still personal/pseudonymous data and must remain in the Russian data environment.
CREATE TABLE IF NOT EXISTS analytics_events (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  account_id UUID NOT NULL REFERENCES accounts(id) ON DELETE CASCADE,
  event_name TEXT NOT NULL
    CHECK (event_name IN ('login_completed', 'tool_started', 'tool_completed', 'plan_created')),
  tool_key TEXT
    CHECK (tool_key IS NULL OR tool_key IN ('health', 'finance', 'marketing', 'market_validation', 'risk_recovery', 'operations', 'adaptability', 'plan_90_days')),
  occurred_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  CHECK (
    (event_name IN ('tool_started', 'tool_completed') AND tool_key IS NOT NULL)
    OR (event_name IN ('login_completed', 'plan_created'))
  )
);
CREATE INDEX IF NOT EXISTS analytics_events_date_idx ON analytics_events (occurred_at DESC);
CREATE INDEX IF NOT EXISTS analytics_events_account_date_idx ON analytics_events (account_id, occurred_at DESC);
CREATE INDEX IF NOT EXISTS analytics_events_tool_date_idx ON analytics_events (tool_key, occurred_at DESC) WHERE tool_key IS NOT NULL;

CREATE TABLE IF NOT EXISTS analytics_daily_rollups (
  day DATE NOT NULL,
  metric_key TEXT NOT NULL,
  tool_key TEXT NOT NULL DEFAULT '',
  event_count BIGINT NOT NULL DEFAULT 0 CHECK (event_count >= 0),
  unique_account_count BIGINT NOT NULL DEFAULT 0 CHECK (unique_account_count >= 0),
  calculated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (day, metric_key, tool_key)
);
COMMIT;
