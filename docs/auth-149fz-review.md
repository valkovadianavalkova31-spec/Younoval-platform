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

Email + password is not listed as a standalone fifth route. It might be part of a qualifying alternative authorization system, but a custom login form is not automatically compliant. Ownership and technical/legal conformity of the authentication system must be established before launch.

The obligation is tied to the location of the user being authorized (Russia), not simply to the user's citizenship. The owner's citizenship and where the owner conducts internet activity are separate scope conditions and must be assessed on the actual facts.

## YOUNOVAL facts still to confirm

- Confirm the owner's citizenship and whether the owner has any other citizenship.
- Confirm where the owner actually conducts the platform activity and whether the activity is carried out in Russia.
- Confirm whether users in Russia will have any information or functionality gated behind login.
- Confirm which of the four methods can realistically be implemented and who owns the identity/authentication system.
- Obtain a qualified Russian-law review of the fourth method before relying on it.

## Implementation decision

Until the above is resolved:
- do not launch account registration for users in Russia;
- do not deploy email/password as the only login method;
- keep the public static site and local-only tools available;
- build database schema and non-collecting API scaffolding only;
- do not send Russian users' personal data to the current Render infrastructure.

## Sources

- Article 8(10), Federal Law 149-FZ, current text: https://ivo.garant.ru/document/redirect/12148555/149
- Article 16, Federal Law 149-FZ: https://www.consultant.ru/document/cons_doc_LAW_61798/0e9ec16b786dcbdaaa7f44abfc4a15e601d5be22/
- Article 13.55, Code of Administrative Offences (added by Federal Law 199-FZ of 26 June 2026): https://www.consultant.ru/document/cons_doc_LAW_34661/eecaf3bcdcd8f21011f025127298179a3bfd8877/

This note is an engineering/legal checklist, not a substitute for advice from a Russian lawyer.
