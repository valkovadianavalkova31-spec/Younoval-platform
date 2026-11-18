# YOUNOVAL — privacy-first analytics plan

**Status: prepared in code, disabled by default. No analytics provider is currently connected.**

## Research questions the analytics should answer

1. How many page views does the public site receive?
2. Which available tools are opened most often?
3. How often is each tool completed after it is opened?
4. Does usage change after a tool or explanation is improved?

These metrics describe platform usage. They do not prove that a user is a unique person, that the tool improved a business, or that the YBRM model predicts business survival.

## Minimal event schema

Only these events are planned:

| Event | When | Allowed properties |
|---|---|---|
| Page view | GoatCounter page-view counter | Standard page path |
| tool_started | A visitor opens one of the available tools | Fixed tool ID: health, finance, marketing |
| tool_completed | A visitor successfully calculates a result | Fixed tool ID: health, finance, marketing |

No custom payloads are sent. Tool answers, financial inputs, calculated values, result text, free text, phone numbers, email addresses, IP addresses and device fingerprints are never included in custom events.

Completion rate is calculated from aggregate event counts: completions divided by starts for the same tool and period. Because no visitor/session identifier is retained in our event names, this is an aggregate ratio, not a person-level funnel. Repeated use can make the ratio exceed or differ from a true per-person completion rate.

## Free provider candidate

GoatCounter offers a hosted service free for reasonable public usage and supports custom events. Its documentation says it stores aggregate statistics by hour/day and does not persist IP addresses or full User-Agent headers in its normal aggregate mode. It does process IP + User-Agent transiently in memory (up to eight hours) to estimate repeat visits; derived country/browser/screen/language statistics can be stored unless disabled. Its hosted service is operated from Ireland and stores data on Hetzner servers in Finland and Germany. An owner email is required for the GoatCounter account.

Official documentation:
- https://www.goatcounter.com/help/events
- https://www.goatcounter.com/help/privacy
- https://www.goatcounter.com/help/terms

**Important:** this provider is only a candidate. It is not connected. External processing and the provider's data locations must be reviewed against the project's legal obligations and intended Russian audience before activation. Do not describe the project as collecting absolutely no data while a third-party analytics provider is enabled.

## Current implementation

- `analytics.js` is a small optional adapter.
- It is disabled unless `window.YN_ANALYTICS_ENDPOINT` is set before the adapter loads.
- No provider script is requested when the endpoint is empty.
- The adapter accepts only two event names and three fixed tool IDs.
- The application never sends tool answers, inputs or calculated results to analytics.
- Tool results continue to be stored locally in the visitor's browser under the existing local-storage implementation.

## Dashboard access — owner only

The analytics dashboard must remain private:

- Set GoatCounter **Dashboard viewable by** to **logged in users only** (not public and not secret-token access).
- Use only the project owner's individual account; do not invite other users.
- Do not embed the dashboard in YOUNOVAL, add a public statistics page, publish a dashboard link, or place an API token in frontend code.
- If a private dashboard is later built into a separate owner-only area, it must use a server-side secret and real authentication; never expose a read-statistics token in browser JavaScript.

The current public website contains no analytics dashboard. Visitors cannot view the owner's statistics.

## Activation checklist

1. Create the project owner's GoatCounter site and review its current terms/privacy settings. Keep dashboard visibility set to **logged in users only** and do not add other accounts.
2. Disable individual pageview storage and any unnecessary dimensions (location, browser/system, screen width and language) where the dashboard permits.
3. Confirm whether the provider's transient processing and Finland/Germany storage are acceptable for the project's actual operator, audience and applicable law. If not, leave analytics disabled and use a Russian-hosted solution only after legal review.
4. Add the site's `/count` endpoint to `window.YN_ANALYTICS_ENDPOINT`.
5. Test page views and the two event types using non-real test traffic.
6. Publish a concise analytics/privacy notice before enabling collection.
7. Periodically export aggregate reports for the research log; never publish raw event logs.

## What can be measured before activation

The website can be used and tool results can be saved locally without any central analytics. Without a connected analytics provider, the owner cannot see cross-visitor totals. Browser-local counters would only describe activity on that one device and must not be presented as total site usage.
