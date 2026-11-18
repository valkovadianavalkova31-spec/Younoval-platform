# YOUNOVAL — Free Youth Business Resilience Toolkit

A bilingual (Russian / English), research-informed educational project focused on strengthening youth entrepreneurship in Russia.

**All eight tools are free.** The current public version does not yet have phone authentication or a central account database. Tool calculations run in the browser and the latest result for each tool is stored locally on the visitor's device.

## Research purpose

RU: «Повышение устойчивости молодёжного предпринимательства в России: факторы успеха, причины закрытия бизнеса и разработка практической модели развития»

EN: *Youth Business Resilience: Strengthening Young Entrepreneurship in Russia Through Business Resilience Strategies.*

## Preliminary YBRM framework

The Youth Business Resilience Model (YBRM) is a preliminary author-designed framework with six dimensions:

1. Customer Resilience
2. Financial Resilience
3. Marketing Resilience
4. Operational Resilience
5. Adaptive Resilience
6. Digital & Learning Resilience

The Business Health Check uses a 0–3 practice-adoption scale. Its score describes the practices selected by a user. It is **not a validated predictive model**, does not estimate the probability of business closure, and must not be interpreted as a measure of survival likelihood. No empirical validation or causal effect is claimed.

## Current website and tools

- Responsive bilingual landing page (RU / EN).
- Business Health Check across six resilience dimensions.
- Financial Stability Planner: net monthly cash flow, cash runway and break-even units.
- Marketing Performance Calculator: CAC, conversion rate, average order value and ROAS.
- Market Validation Check.
- Risk Priority Matrix.
- Operational Resilience Check.
- Business Adaptability Check.
- 90-Day Action Plan.
- Browser local storage for language preference and latest result per tool.
- Optional privacy-first analytics adapter supports all eight fixed tool IDs, but remains disabled until a provider and legal basis are reviewed.

## Calculation notes

- Net monthly cash flow = cash inflows − cash outflows.
- Cash runway = current cash / absolute monthly net cash outflow, only when net cash flow is negative and current cash is positive. When cash flow is non-negative, no infinite or negative runway is displayed.
- Break-even units = fixed costs / (selling price per unit − variable cost per unit), rounded up. Not calculated if contribution margin is zero or negative.
- CAC = advertising spend / new customers acquired.
- Conversion rate = orders / visitors or leads × 100.
- Average order value = attributed revenue / orders.
- ROAS = attributed revenue / advertising spend.

These are simplified educational indicators, not accounting, tax, legal, investment or professional advice. ROAS is not profit or ROI.

## Privacy and technology

The current public version is a static HTML, CSS and JavaScript project. It does not currently provide phone authentication, a central account database, or central storage of tool answers/results. Language choice and latest results use browser local storage. Clearing browser site data removes those values. Calculator inputs are processed in the browser and are not intentionally sent to a YOUNOVAL application backend.

The future account system is planned around a Russian-hosted backend and database. Do not collect phone numbers or account-linked results until hosting location, provider terms, privacy documentation, required consents and security controls have been reviewed. The analytics adapter is disabled by default.

## Run locally

Open index.html in a modern browser, or serve this folder with any static web server. No build step is required.

## Deployment

The current static project is deployed as a static site. The future account backend must be deployed separately on infrastructure selected for Russian data localization requirements; do not put database credentials or SMS API keys in frontend code.

## Research integrity

YOUNOVAL distinguishes published findings and official statistics from working hypotheses, author-proposed categories and user-entered calculations. It does not rank causes of business failure by prevalence without reliable comparable evidence. Self-assessment scores are prompts for reflection, not proof of risk or causation.

## Roadmap

- [x] Bilingual responsive website
- [x] Eight functional browser-based tools
- [x] Local storage for latest results per tool
- [x] Analytics adapter allowlist for all eight tools (provider disabled)
- [ ] Russian-hosted backend and database
- [ ] Phone-number authentication with one-time verification codes
- [ ] Account-linked saving and retrieval of answers/results for all eight tools
- [ ] Owner-only aggregate dashboard for registrations, active accounts and tool popularity
- [ ] Exportable personal report

The YOUNOVAL name is provisional; trademark and domain availability have not been cleared.
