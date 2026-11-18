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
- Eight functional browser-based tools.
- Local browser storage for language preference and latest result per tool.
- Supabase aggregate counters for page loads, tool starts and completions; no visitor-level records or personal tool data.

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

No registration, phone numbers, accounts or central storage of user results. Tool answers, inputs, notes and calculated outputs are processed in the browser and saved locally on the visitor's device. They are not sent to YOUNOVAL's application database and are not visible to the project owner.

The Supabase database stores aggregate counts only: page loads, tool opens and completions by UTC date and fixed tool ID. It does not store user IDs, sessions, answers, financial inputs, notes or individual result histories. The static-site host and Supabase may process technical connection data in infrastructure/security logs; the operator must verify provider practices and applicable privacy requirements.

## Run locally

Open index.html in a modern browser, or serve this folder with any static web server. No build step is required.

## Deployment

The public project is deployed as a static site. Supabase is used only for aggregate usage counters; no application accounts or user-results backend is required.

## Research integrity

YOUNOVAL distinguishes published findings and official statistics from working hypotheses, author-proposed categories and user-entered calculations. It does not rank causes of business failure by prevalence without reliable comparable evidence. Self-assessment scores are prompts for reflection, not proof of risk or causation.

## Roadmap

- [x] Bilingual responsive website
- [x] Eight functional browser-based tools
- [x] Local storage for latest results per tool
- [x] Supabase aggregate counter for page views, tool starts and completions
- [x] Private aggregate statistics notebook in Supabase
- [ ] Review hosting/provider logging and finalize privacy notice
- [ ] Exportable personal report generated locally in the visitor's browser

The YOUNOVAL name is provisional; trademark and domain availability have not been cleared.
