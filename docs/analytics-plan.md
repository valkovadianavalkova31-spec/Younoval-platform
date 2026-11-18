# YOUNOVAL — privacy-first aggregate analytics

**Status: connected to the project's Supabase database and Edge Function.** The implementation records aggregate counters only; it does not identify visitors.

## Project principles

- No registration, phone numbers, accounts or user profiles.
- Tool answers, inputs, notes and calculated results stay in the visitor's browser.
- YOUNOVAL does not receive or centrally store individual tool results.
- The project owner sees aggregate counts only.

## Stored data

The browser stores the selected language and the latest result for each tool in local storage. These values remain on that device/browser and are not synchronized.

The Supabase table `public.younoval_daily_counts` stores only:
- UTC date;
- fixed event name: `page_view`, `tool_started`, or `tool_completed`;
- one of the eight fixed tool IDs for tool events (no tool ID for page views);
- an integer aggregate count and update timestamp.

There are no event rows per visitor, user IDs, session IDs, cookies, answers, financial inputs, calculated values, free-text notes, phone numbers or email addresses.

## Event definitions and limitations

- `page_view`: a page load of the public website.
- `tool_started`: the visitor selects a tool in the workspace.
- `tool_completed`: a tool calculates or generates a result.

Counts are not unique visitors. Repeated visits and repeated tool use increase the counters. Automated or forged requests can also inflate them, so these are indicative descriptive metrics, not an exact audience count. Completion/open ratios are aggregate indicators, not person-level conversion rates.

## Technical implementation

- `analytics.js` sends only fixed event names and tool IDs to the YOUNOVAL Supabase Edge Function.
- The Edge Function checks the allowed origin, HTTP method, event name and tool ID. The origin allowlist is a browser CORS control, not strong authentication: non-browser clients can forge an Origin header.
- The counter endpoint is intentionally public and does not use visitor IDs or IP-based rate limiting. As a result, automated traffic can inflate counts; do not interpret them as verified unique users.
- A server-side Supabase credential writes through a restricted database function.
- The counter table has RLS enabled and no access policies for public or signed-in browser roles. Direct client reads and writes are not granted.
- Tool answers and result payloads are never sent to the function.
- A private Supabase SQL notebook provides project members with aggregate reports only.

## Owner statistics

Open the private [YOUNOVAL aggregate usage notebook](https://supabase.com/dashboard/project/mtnmsjftexummebtpyop/explorer/notebook/66d6ed99-7236-40a8-a115-c39f4b5c92aa) in the Supabase project. It contains daily totals, totals by tool, and daily tool usage. Access is governed by Supabase project membership; do not make the notebook public or share it outside the project.

## Technical privacy caveat

The counter endpoint receives network requests. Supabase and the static-site host may process technical connection metadata, including IP addresses, in security and infrastructure logs. The aggregate table itself does not store IP addresses or visitor identifiers. The operator must review provider logging, retention, data locations and applicable Russian privacy/localization requirements before making legal claims.

## Research integrity

Counts describe website and tool usage, not business outcomes. They cannot show that YOUNOVAL improved a business or that the YBRM model predicts business survival. Report them as aggregate descriptive statistics with the observation period and limitations.
