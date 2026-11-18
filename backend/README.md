# YOUNOVAL API foundation

This folder contains the first backend layer for accounts, saved tool results and aggregate product analytics.

## Current state

- PostgreSQL schema for accounts, consent records, complete tool answers/results, analytics events and aggregate views.
- Node/Express health endpoint.
- Analytics query helper for a private operator dashboard.
- Registration, login, result APIs and event ingestion are intentionally not enabled.

## Why collection is disabled

YOUNOVAL is still a static public site. Before any personal data is collected, the project must finish its Russian legal and technical setup: confirm the operator and processing purposes, assess Article 8(10) of 149-FZ, select a compliant authentication route if applicable, choose Russian-hosted primary storage, complete the required RKN notice and user-facing documents, and implement security and deletion controls.

The current public website is hosted as a Render static site. Do not connect Russian users' account data to that service or provision the production database in Render's available regions.

## Local development

1. Install Node.js 22 or newer.
2. Run npm install in this directory.
3. Create a local PostgreSQL database for development only.
4. Apply migrations in order from db/migrations.
5. Copy .env.example to a private .env and set DATABASE_URL.
6. Run npm run check, then npm start.
7. Open /healthz to verify the database connection.

Never use real user information in local development or test fixtures. Do not commit .env files, passwords, API keys or database connection strings.

## Data model

- accounts: email and password hash; no plaintext passwords.
- consent_records: versioned records for each separate document/consent.
- tool_results: full answers and detailed result JSON, scoped to one account.
- analytics_events: allow-listed account-linked events only; no emails, free text, financial values, IPs or answer payloads.
- analytics views: aggregate registration, active-account and tool popularity statistics.

The analytics event table is still pseudonymous personal data because events are linked to an account. Keep it in the approved Russian environment, restrict access and set a disclosed retention period before collection.
