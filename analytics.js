/*
 * YOUNOVAL privacy-first analytics adapter.
 *
 * Disabled by default. Do not set an analytics endpoint until the provider,
 * processing locations and applicable Russian privacy requirements have
 * been reviewed. No external analytics provider is currently connected.
 *
 * Only allow-listed event names and fixed tool IDs may be sent. Never send
 * answers, calculated values, free text, phone/email, IP, or device identifiers.
 */
(() => {
  const endpoint = window.YN_ANALYTICS_ENDPOINT || "";
  const allowedEvents = new Set(["tool_started", "tool_completed"]);
  const allowedTools = new Set([
    "health", "finance", "marketing", "market",
    "risk", "operations", "adapt", "plan"
  ]);
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
