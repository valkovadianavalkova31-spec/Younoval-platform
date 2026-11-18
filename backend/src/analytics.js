// Query helpers for the private project analytics dashboard.
// Do not expose these queries to unauthenticated public endpoints.
async function getOverview(pool) {
  const [registrations, activity, tools] = await Promise.all([
    pool.query(`
      SELECT
        COUNT(*) FILTER (WHERE deleted_at IS NULL)::int AS total_accounts,
        COUNT(*) FILTER (
          WHERE deleted_at IS NULL AND created_at >= now() - interval '30 days'
        )::int AS registrations_30d
      FROM accounts
    `),
    pool.query(`
      SELECT
        COUNT(DISTINCT account_id) FILTER (
          WHERE occurred_at >= now() - interval '7 days'
        )::int AS active_accounts_7d,
        COUNT(DISTINCT account_id) FILTER (
          WHERE occurred_at >= now() - interval '30 days'
        )::int AS active_accounts_30d
      FROM analytics_events
    `),
    pool.query(`
      SELECT tool_key, starts, completions, unique_accounts, completion_rate_percent
      FROM analytics_tool_popularity
      ORDER BY completions DESC, starts DESC, tool_key ASC
    `)
  ]);

  return {
    registrations: registrations.rows[0],
    activity: activity.rows[0],
    tools: tools.rows
  };
}

module.exports = { getOverview };
