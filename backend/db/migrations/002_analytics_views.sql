-- Read-only aggregate views for the project dashboard.
-- Access to these views must be restricted to the operator/admin role.
BEGIN;

CREATE OR REPLACE VIEW analytics_daily_activity AS
SELECT
  occurred_at::date AS day,
  event_name,
  COALESCE(tool_key, '') AS tool_key,
  COUNT(*)::bigint AS event_count,
  COUNT(DISTINCT account_id)::bigint AS unique_accounts
FROM analytics_events
GROUP BY occurred_at::date, event_name, COALESCE(tool_key, '');

CREATE OR REPLACE VIEW analytics_tool_popularity AS
SELECT
  tool_key,
  COUNT(*) FILTER (WHERE event_name = 'tool_started')::bigint AS starts,
  COUNT(*) FILTER (WHERE event_name = 'tool_completed')::bigint AS completions,
  COUNT(DISTINCT account_id)::bigint AS unique_accounts,
  CASE
    WHEN COUNT(*) FILTER (WHERE event_name = 'tool_started') = 0 THEN 0
    ELSE ROUND(
      100.0 * COUNT(*) FILTER (WHERE event_name = 'tool_completed')
      / COUNT(*) FILTER (WHERE event_name = 'tool_started'), 2
    )
  END AS completion_rate_percent
FROM analytics_events
WHERE tool_key IS NOT NULL
GROUP BY tool_key;

CREATE OR REPLACE VIEW analytics_registration_monthly AS
SELECT
  date_trunc('month', created_at)::date AS month,
  COUNT(*)::bigint AS registrations
FROM accounts
WHERE deleted_at IS NULL
GROUP BY date_trunc('month', created_at)::date;

COMMIT;
