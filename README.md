# YOUNOVAL — Free Youth Business Resilience Toolkit

A bilingual (Russian / English), research-informed educational project focused on strengthening youth entrepreneurship in Russia.

**All eight tools are free and available without registration.** Tool calculations run in the visitor's browser. The latest result for each tool is saved locally in that browser; YOUNOVAL does not receive or centrally store individual answers or results.

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
- Local browser storage for language preference and latest result per tool.
- Optional aggregate analytics adapter supports all eight tools but remains disabled until a suitable provider is reviewed.

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

No registration, phone numbers, accounts or central storage of user results. Tool answers, inputs, notes and calculated outputs are processed in the browser and saved locally on the visitor's device. They are not sent to a YOUNOVAL application backend and are not visible to the project owner.

The planned owner statistics are aggregate counts only: visits, tool opens and completions by tool and period. They must not include answers, financial inputs, notes, user IDs or visitor-level histories. The analytics adapter is disabled by default. Website hosting may process technical connection data in its logs; the operator must verify actual provider practices before making absolute no-data-collection claims.

## Run locally

Open index.html in a modern browser, or serve this folder with any static web server. No build step is required.

## Deployment

The project is deployed as a static site. No application backend or database is required for the tools to work.

## Research integrity

YOUNOVAL distinguishes published findings and official statistics from working hypotheses, author-proposed categories and user-entered calculations. It does not rank causes of business failure by prevalence without reliable comparable evidence. Self-assessment scores are prompts for reflection, not proof of risk or causation.

## Roadmap

- [x] Bilingual responsive website
- [x] Eight functional browser-based tools
- [x] Local storage for latest results per tool
- [x] Analytics adapter allowlist for all eight tools (provider disabled)
- [ ] Privacy-reviewed aggregate counter and private owner-only statistics view
- [ ] Exportable personal report generated locally in the visitor's browser

The YOUNOVAL name is provisional; trademark and domain availability have not been cleared.
