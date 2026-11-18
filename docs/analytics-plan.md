# YOUNOVAL — privacy-first aggregate analytics

**Status: the event adapter supports all eight tools, but analytics is disabled. No analytics provider is connected.**

## Project principles

- No registration, phone numbers, accounts or user profiles.
- Tool answers, inputs, notes and calculated results stay in the visitor's own browser.
- YOUNOVAL does not receive or centrally store individual tool results.
- The project owner should see aggregate usage statistics only.

## What is stored locally

The current application uses browser local storage for:
- the selected language;
- the latest result for each tool.

These values remain in that browser on that device. They are not synchronized to another device or sent to YOUNOVAL. Clearing saved results in the interface removes the saved tool results from that browser.

## Aggregate usage metrics

The planned statistics are limited to counts:
- overall page visits;
- tool opens for each of the eight tools;
- tool completions for each of the eight tools.

Tool IDs are fixed values only: health, finance, marketing, market, risk, operations, adapt, plan.

No questionnaire answers, financial inputs, calculated values, free text, notes, phone numbers, email addresses, account IDs or user-level histories are sent as analytics events. The statistics are counts, not unique-user tracking. A tool-open count is not a count of distinct people.

## Current implementation

- `analytics.js` accepts only `tool_started` and `tool_completed` for the eight fixed tool IDs.
- The adapter is disabled unless an endpoint is explicitly configured.
- No third-party analytics script is loaded while the endpoint is empty.
- Tool results remain in local storage.
- No registration system, central user database, personal-results dashboard or user-level analytics exists.
- The current code records an open when a visitor selects a tool and a completion when they calculate or generate a result.

## Owner statistics

The future owner view should show aggregate counts only, grouped by date and tool. It must not expose visitor-level records, individual answers, financial information or free-text notes. The dashboard must be private and accessible only to the project owner.

## Technical privacy caveat

Even an aggregate counter receives a network request. Hosting and analytics providers may process technical connection metadata (for example, IP address) in server logs or transiently to deliver the service. Before enabling a provider, review its data locations, logs, retention, terms and applicable privacy requirements. Do not claim that no technical data is processed unless this has been verified.

The previous GoatCounter adapter is not activated. Keep the endpoint empty until a suitable provider and configuration have been reviewed. Prefer an aggregate counter that increments totals without cookies, account identifiers, fingerprinting or persistent visitor-level logs.

## Research integrity

Counts describe tool usage, not business outcomes. They cannot show that YOUNOVAL improved a business or that the YBRM model predicts business survival. Report them as aggregate descriptive statistics and disclose the observation period and limitations.
