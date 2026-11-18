# YOUNOVAL — preliminary personal-data map

**Status:** draft for legal review. No account collection is enabled.

## Purposes

1. Create and maintain a user account.
2. Authenticate the account owner and recover access.
3. Save, display, update and delete the user's tool answers and detailed results.
4. Maintain account security and diagnose technical incidents.
5. Measure platform usage and prepare aggregate project statistics.

## Planned data categories

### Account
- email address;
- internal account UUID;
- password hash (never plaintext);
- account status and timestamps;
- verification and recovery state, once designed.

### Tool results
- account UUID;
- tool identifier and schema version;
- answers submitted to the tool;
- calculated result, recommendations and saved action plan;
- creation/update timestamps.

Answers may include business, financial and operational information. Forms must warn users not to submit credentials, bank-card details, government identifiers, client personal data or other third-party personal data.

### Product analytics
Only an allow-listed event name, tool identifier, account UUID and event timestamp:
- login_completed;
- tool_started;
- tool_completed;
- plan_created.

Do not put email, raw answers, free text, financial values, IP address, device fingerprint or other unnecessary identifiers in analytics events. Account-linked event data remains personal/pseudonymous data and must be handled as such. Publish aggregate counts only.

## Retention

Exact periods are intentionally not hard-coded in the database design. Before collection begins, define and disclose:
- account and result retention while the account is active;
- deletion workflow and any legally required retention exceptions;
- short-lived raw analytics-event retention;
- longer retention for genuinely aggregate daily statistics;
- security-log retention.

## Legal and operational launch gates

- Identify the operator and confirm the lawful basis for each purpose.
- Determine whether separate consent is required; keep personal-data consent separate from user terms.
- Finalize privacy notice, consent text, user terms and withdrawal/deletion process.
- Determine whether analytics requires separate opt-in and implement consent enforcement.
- Assess Article 8(10) of 149-FZ and choose an allowed authentication method if it applies.
- Select a Russian-hosted production database and verify backups, replicas, logs, support access and subprocessors.
- Complete the RKN notification before processing where required.
- Complete threat modelling, access controls, encryption, backup/restore and incident procedures.
- Do not activate registration or event collection until all gates are complete.

## Data model

See backend/db/migrations/001_initial_schema.sql. The schema separates accounts, consents, individual tool results, short-lived account-linked analytics events and aggregate daily rollups.
