# YOUNOVAL — privacy-first analytics plan

**Status: the event adapter supports all eight tools, but analytics is disabled. No provider or account backend is currently connected.**

## Research questions

1. How many page views does the public site receive?
2. Which of the eight tools are opened and completed most often?
3. How does aggregate tool usage change after an improvement?
4. After account functionality is implemented, how many registrations and returning active accounts are recorded?

These metrics describe platform usage. They do not prove that a user is a unique person, that a tool improved a business, or that the YBRM model predicts business survival.

## Tool event schema

Only two tool events are planned:

| Event | When | Fixed tool ID |
|---|---|---|
| tool_started | A visitor opens a tool | health, finance, marketing, market, risk, operations, adapt, plan |
| tool_completed | A visitor successfully completes a tool | health, finance, marketing, market, risk, operations, adapt, plan |

No answers or custom payloads are sent with these events. Tool answers, financial inputs, calculated values, result text, free text, phone numbers and email addresses must never be included in analytics events.

Registration and active-account metrics require the future Russian-hosted account backend. They are not currently measured.

Completion counts are aggregate events, not a person-level funnel unless a lawful, minimized account-level event design is implemented on the Russian backend.

## Current implementation

- `analytics.js` supports the two fixed event names and all eight fixed tool IDs.
- It remains disabled unless `window.YN_ANALYTICS_ENDPOINT` is set.
- No provider script is requested when the endpoint is empty.
- The application does not send answers, inputs or calculated results to analytics.
- The current app still stores the latest result in the visitor's browser local storage.
- No registration, central result storage, account analytics or owner dashboard is connected.

## Russian data-location requirement

YOUNOVAL is operated from Russia and is intended for Russian users. Before collecting phone numbers or storing account-linked answers/results, choose infrastructure with the relevant databases physically located in Russia and review the operator's obligations under 152-FZ, including the current localization rule in Article 18(5). Do not connect a foreign-hosted analytics provider or database to personal data before legal review.

The existing GoatCounter integration code is only an optional adapter pattern; its hosted service is not selected or activated. Keep the endpoint empty.

## Future account and results architecture

The planned Russian-hosted backend should keep separate records for:
- accounts: internal user ID, normalized phone number, verification status, timestamps;
- verification challenges: hashed one-time code, expiry, attempt limit, resend limit;
- tool runs: account ID, tool ID, version, created/updated timestamps;
- tool answers and calculated outputs: structured JSON per tool, with access restricted to the owning account;
- minimal aggregate analytics: registrations, active accounts, tool starts and completions.

Do not store raw SMS codes. Do not expose database credentials or SMS API keys in frontend code. All database and SMS operations must run server-side. Use authorization checks on every read/write so one account cannot access another account's records.

## Privacy and access controls

- Keep personal data and account-linked tool results in Russian infrastructure.
- Collect only fields necessary for authentication, saved results and stated analytics.
- Keep the analytics dashboard owner-only; never expose admin metrics or API secrets in public frontend code.
- Publish a complete privacy notice and obtain the required consents before enabling collection.
- Provide a way to request access, correction and deletion where required.
- Avoid collecting customer/employee personal data inside free-text tool notes.

## Provider decision

No Russian database/hosting provider or SMS provider has been selected yet. A free managed database and free SMS delivery must not be assumed. Confirm provider pricing, region, contract terms, data-processing terms and availability before activation.

## Activation checklist

1. Select Russian hosting and database, confirm the physical data region, and configure a server-side API.
2. Select an SMS provider and obtain API credentials; keep them in server-side environment variables.
3. Implement phone verification with short-lived hashed codes, attempt limits, resend limits and rate limiting.
4. Implement account-scoped storage and retrieval for all eight tools.
5. Add consent, privacy notice, retention and deletion flows.
6. Add owner-only aggregate analytics on the Russian backend.
7. Keep third-party analytics disabled unless separately reviewed and approved.
8. Test account isolation, authentication abuse limits, backups and restore before public launch.
