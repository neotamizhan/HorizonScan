# Prompt: Iran War Escalation Timeline for Kuwait Bank BCP Briefing

## Instructions to Claude

You are assisting a **Technology Risk Manager at a Kuwaiti bank** who needs to brief **senior management** (CEO, COO, CRO, Board Risk Committee) on how the Iran war has escalated over time and which incidents drove the bank — and Kuwait more broadly — to invoke or tighten business continuity measures.

### Inputs

The folder `/Users/siddhu/coding/HorizonScan/reports/` contains:

- `index.json` — an array of ISO dates (newest first), one entry per daily report.
- `YYYY-MM-DD.json` — one daily situation report per date. Each report has these sections you should treat as authoritative:
  - `headline`, `subtitle`, `coverage`, `report_number`
  - `trend_tracker.metrics` — quantitative indicators (Brent/WTI, Hormuz transits, KWI airport status, AQI, cyber incident counter, etc.)
  - `sections[]` with ids: `alerts`, `targets`, `local`, `regional`, `risk`, `bigpicture`, `cyber_tactical`, `cyber_strategic`, `watchlist`
  - `source_confidence[]` — per-section sourcing strength

Read **every report in the index** before producing output. Do not sample. If a file is missing or malformed, list it explicitly in a "Data gaps" note rather than skipping silently.

### What counts as a "major escalation incident"

Include an event only if it meets **at least one** of these thresholds. Tag each event with the threshold(s) it triggered.

1. **Kinetic on Kuwait or GCC** — confirmed missile/drone strike, air-defence engagement, or kinetic attack on Kuwait or any GCC state's territory, oil/gas infrastructure, or shipping.
2. **Strait of Hormuz / oil supply** — closure, blockade extension, named-vessel interdiction, Kharg-class spill, or Brent move ≥ $5/bbl in 24h attributable to the conflict.
3. **Kuwait domestic posture change** — KWI airport status downgrade, new MOI/MOD advisory, shelter-in-place, border closure, maritime restriction tightened, FX/capital control signal, or Central Bank of Kuwait directive.
4. **Cyber against GCC financial services** — confirmed compromise, destructive wiper, ransomware, prolonged outage, or a CISA/NCSC/Unit 42-grade advisory naming GCC FS as the target sector (APT34, MuddyWater, pro-Iran hacktivist coalitions, Volt-Typhoon-successor activity).
5. **Sanctions / regulatory / AML** — new OFAC/State/Treasury designation touching GCC counterparties, FATF action on Kuwait, Central Bank of Kuwait or Ministry of Commerce AML decision, JWC listed-area change, P&I/AWRP repricing.
6. **Diplomatic inflection** — MOU acceptance/rejection, ceasefire signed/collapsed, named summit outcome, mediator entry/exit, or a US-China step that changes Iran's calculus.

**Exclude** routine status carry-forwards, single-source rumours flagged `[SINGLE SOURCE — unconfirmed]` in the underlying report (unless they later got corroborated — note the corroboration date if so), and items where `source_confidence` is "Low".

### Output

Produce a single Word document at `/Users/siddhu/coding/HorizonScan/reports/iran-war-escalation-timeline.docx` using the docx skill. Structure:

1. **Cover / header** — "Iran War Escalation Timeline — Risk Manager Briefing Pack", coverage window (earliest to latest report date), report count, date generated, classification line ("Internal — Risk & BCP use only").

2. **Executive summary (≤ 250 words, prose).** Three things only: (a) the shape of the escalation curve over the coverage window, (b) the 5–7 incidents that materially changed the bank's BCP posture, (c) the current standing posture as of the latest report.

3. **Escalation timeline (the core deliverable).** A chronological table, oldest at top. Columns:

   | Date | Incident | Category | Severity | What changed for Kuwait | BCP / risk action triggered (or that should have been) | Source confidence | Report # |

   - **Category** — one of: Kinetic-Kuwait, Kinetic-GCC, Hormuz/Oil, Kuwait-Domestic, Cyber-FS, Sanctions/Regulatory, Diplomatic.
   - **Severity** — Critical / High / Medium, justified in one phrase.
   - **BCP action** — concrete, e.g. "KWI airport partial-closure invoked branch-failover to T4/T5 staff routing", "APT34 peak window → FIDO2 enforcement & Teams federation lockdown deadline", "AWRP ~1% H&M → trade-finance underwriting repricing", "Hormuz closure → liquidity buffer extension to end-Q3".
   - Pull the action language from the report's section 5 ("Risk Signal for Financial Institutions") and 5A ("Insurance Risk Exposure") where present; otherwise infer the standard banking BCP response.
   - **Source confidence** — High / Medium / Low, lifted from `source_confidence` for the originating section. Mark single-source items.

4. **Escalation curve summary.** A short prose section (no bullets) describing 3–5 distinct phases you observed (e.g. "opening kinetic phase", "Hormuz closure & oil-export halt", "cyber escalation against GCC FS", "diplomatic stalemate", "tentative de-escalation signals"). Give each phase a date range and the defining event.

5. **Standing BCP measures currently in force (as of the latest report).** Prose paragraphs grouped by domain: airport & travel, maritime & oil exports, land borders & supply chain, cyber posture, sanctions/AML, insurance/AWRP, liquidity & FX. State which measure was triggered by which incident date so senior management can trace cause → control.

6. **Watch items the Risk Manager should flag to senior management.** Pull from the most recent 5 reports' `watchlist` sections plus any unresolved items from the timeline.

7. **Methodology & data gaps.** One paragraph: number of reports read, date range, any missing/malformed files, items excluded for being single-source, and a note that the timeline is built from the daily HorizonScan reports only.

### Style rules

- Write for a CEO/CRO audience: prose paragraphs, not bullet soup. The only bullet/table allowed is the timeline table itself and the standing-BCP grouping if it reads more clearly as a short list.
- No emojis. No marketing language. No hedging adverbs ("very", "really", "extremely").
- Every incident in the timeline must cite the report number it came from (e.g. "Report #34"). If an incident spans multiple reports (e.g. Hormuz closure persisting), cite the first report that confirmed it and the latest report that re-confirmed it.
- Currency in USD, dates in `DD MMM YYYY`, times in `UTC+3` where given.
- Quote sparingly — at most one short quoted phrase per incident, in quotation marks, attributed to the source named in the report.
- Do not invent incidents, dates, severities, or BCP actions that are not supported by the underlying reports. If you infer a BCP action that the report does not explicitly state, prefix it with "Inferred:" in the BCP column.

### Process

Work in this order and announce each step briefly:

1. Read `index.json` and list the date range and total count.
2. Read every daily report. As you go, maintain a working list of candidate incidents with date, category, severity, source confidence, and the originating report number.
3. After all reports are read, deduplicate (e.g. one Hormuz closure event, not 60) and collapse multi-day stories into a single timeline row with a "first confirmed / last reconfirmed" date pair.
4. Draft the Word document using the docx skill.
5. Save it to the path above and present it with a `computer://` link.

Begin.
