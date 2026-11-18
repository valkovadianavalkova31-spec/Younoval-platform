# YOUNOVAL — review of Article 8(10), Federal Law 149-FZ

**Reviewed:** 18 November 2026  
**Status:** preliminary implementation gate; not an individual legal opinion.

## Rule

Part 10 of Article 8 applies where all relevant conditions are met:
- the resource owner is a Russian legal entity or a citizen of the Russian Federation;
- the owner carries out internet activity in the territory of the Russian Federation; and
- access to information on the site/system/software is provided to users after authorization.

For users located in the Russian Federation, the provision lists four authorization routes:
1. mobile subscriber number;
2. ESIA;
3. the Unified Biometric System in the statutory procedure;
4. another information system that provides authorization, meets the information-protection requirements referenced in Article 16, and is owned by a Russian citizen who does not hold another citizenship, or by a qualifying Russian legal entity.

Email + password is not listed as a standalone fifth route. YOUNOVAL has selected mobile subscriber number as the intended primary route. SMS one-time-code verification is the planned technical flow, subject to validation with the selected provider and Russian legal counsel. The law names use of a mobile subscriber number; this note does not claim that any arbitrary SMS implementation automatically satisfies every legal requirement.

The obligation is tied to the location of the user being authorized (Russia), not simply to the user's citizenship. The owner's citizenship and where the owner conducts internet activity are separate scope conditions and must be assessed on the actual facts.

## YOUNOVAL decision

- Primary authentication: mobile subscriber number, verified by a short-lived SMS one-time code.
- Password: not planned for the first version.
- Email: optional contact/recovery channel, not a substitute for the primary phone authorization.
- OTP: never stored or logged in plaintext; store a keyed HMAC only, expire quickly, limit attempts and requests, and keep the HMAC secret outside the database.
- Session: secure HttpOnly/SameSite cookie, session rotation on login, revocation on logout and suspicious activity.
- Provider: not selected. Before selection, review its legal entity, contract, data processing role, subprocessors, data locations, logs, retention, security and cross-border access.
- Registration and OTP sending remain disabled until the infrastructure and legal launch gates are complete.

## Remaining checks

- Confirm the owner's citizenship and whether the owner has any other citizenship.
- Confirm where the owner actually conducts platform activity and whether the activity is carried out in Russia.
- Confirm which users and information will be gated behind login.
- Verify with Russian counsel and the selected SMS provider that the proposed phone-number authentication flow is appropriate under the current law.
- Select Russian-hosted production storage and review backups, replicas, logs, support access and subprocessors.
- Complete the RKN notification before processing where required, and finalize notices, consent, retention, deletion and security procedures.

## Implementation gate

Until the above is resolved:
- do not launch account registration or send SMS codes;
- keep the public static site and local-only tools available;
- build database schema and non-collecting API scaffolding only;
- do not send Russian users' personal data to the current Render infrastructure.

## Sources

- Article 8(10), Federal Law 149-FZ, current text: https://klerk.systems/docs/fz_149_2006/article/8/date20260901/
- Article 16, Federal Law 149-FZ: https://www.consultant.ru/document/cons_doc_LAW_61798/0e9ec16b786dcbdaaa7f44abfc4a15e601d5be22/
- Article 18(5), Federal Law 152-FZ: https://www.consultant.ru/document/cons_doc_LAW_61801/cbf4e15b7c330f9372e876cdf2bc928bad7950ef/

This note is an engineering/legal checklist, not a substitute for advice from a Russian lawyer.
