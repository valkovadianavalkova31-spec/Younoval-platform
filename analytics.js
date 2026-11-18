/*
 * YOUNOVAL aggregate analytics.
 * Sends only fixed event names and fixed tool IDs to our Supabase Edge Function.
 * No answers, amounts, notes, user IDs, cookies or device identifiers are sent.
 * Supabase receives a network request and may process technical connection data.
 */
(() => {
  const endpoint = "https://mtnmsjftexummebtpyop.supabase.co/functions/v1/younoval-track";
  const publishableKey = "sb_publishable_Vr43cig07d8hFTKpt71S3w_OxU-Z7YS";
  // Legacy anon JWT is a public client credential; it carries no privileged access.
  const anonJwt = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im10bm1zamZ0ZXh1bW1lYnRweW9wIiwicm9sZSI6ImFub24iLCJpYXQiOjE3OTUwMzE1OTQsImV4cCI6MjExMDYwNzU5NH0.naSluubZ-hDHkKY5HlCUn1G5mp7TE8LCfTShwrAg4Xo";
  const allowedEvents = new Set(["tool_started", "tool_completed"]);
  const allowedTools = new Set([
    "health", "finance", "marketing", "market",
    "risk", "operations", "adapt", "plan"
  ]);

  const send = (event, tool = null) => {
    if (event === "page_view") {
      tool = null;
    } else if (!allowedEvents.has(event) || !allowedTools.has(tool)) {
      return;
    }

    fetch(endpoint, {
      method: "POST",
      mode: "cors",
      keepalive: true,
      headers: {
        "Content-Type": "application/json",
        "apikey": publishableKey,
        "Authorization": "Bearer " + anonJwt
      },
      body: JSON.stringify({ event: event, tool: tool })
    }).catch(() => {});
  };

  window.YNAnalytics = {
    enabled: true,
    track(event, tool) {
      send(event, tool);
    }
  };

  send("page_view");
})();
