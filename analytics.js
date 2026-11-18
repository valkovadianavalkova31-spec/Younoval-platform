/*
 * YOUNOVAL privacy-first analytics adapter.
 *
 * Disabled by default. To enable after reviewing the provider's terms and
 * applicable privacy/localization requirements, set
 * window.YN_ANALYTICS_ENDPOINT to the site's GoatCounter /count endpoint
 * before this file loads (see docs/analytics-plan.md).
 *
 * Only allow-listed event names and tool IDs are sent. Never send answers,
 * calculated values, free text, phone/email, IP, or device identifiers.
 */
(() => {
  const endpoint = window.YN_ANALYTICS_ENDPOINT || "";
  const allowedEvents = new Set(["tool_started", "tool_completed"]);
  const allowedTools = new Set(["health", "finance", "marketing"]);
  const queue = [];

  const send = (eventName, toolId) => {
    if (!allowedEvents.has(eventName) || !allowedTools.has(toolId)) return;
    const count = window.goatcounter && window.goatcounter.count;
    if (typeof count !== "function") {
      queue.push([eventName, toolId]);
      return;
    }
    count({
      path: "event-" + eventName + "-" + toolId,
      title: eventName + " " + toolId,
      event: true,
      no_session: true
    });
  };

  window.YNAnalytics = {
    enabled: Boolean(endpoint),
    track(eventName, toolId) {
      if (endpoint) send(eventName, toolId);
    }
  };

  if (!endpoint) return;

  const script = document.createElement("script");
  script.async = true;
  script.src = "https://gc.zgo.at/count.js";
  script.dataset.goatcounter = endpoint;
  script.onload = () => {
    while (queue.length) {
      const [eventName, toolId] = queue.shift();
      send(eventName, toolId);
    }
  };
  document.head.appendChild(script);
})();
