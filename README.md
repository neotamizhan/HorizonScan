# HorizonScan

Daily intelligence briefing on the Iran conflict and its impact on Kuwait — prepared for Technology Risk Management.

**Live site:** `https://<your-username>.github.io/HorizonScan/`

---

## Setup (one-time)

1. Push this repo to GitHub
2. Go to **Settings → Pages**
3. Set Source to **Deploy from a branch**, branch `main`, folder `/` (root)
4. GitHub Pages will be live within a minute

---

## Adding a new daily report

1. Create `reports/YYYY-MM-DD.json` following the schema below
2. Commit and push to `main`
3. The GitHub Actions workflow automatically updates `reports/index.json`
4. The site immediately reflects the new report

That's it — no other files need to be touched.

---

## Report JSON schema

```json
{
  "date": "2026-03-21",
  "headline": "21 March 2026",
  "subtitle": "Day 19 of Operation Epic Fury",
  "coverage": "20 March 2026 07:00 UTC+3 – 21 March 2026 07:00 UTC+3",
  "sections": [
    {
      "id": "alerts",
      "number": 1,
      "title": "Alerts & Sirens",
      "color": "#dc2626",
      "items": [
        {
          "bold_heading": "Optional bold heading",
          "text": "Main body text of the item.",
          "sources": ["Source A", "Source B"]
        }
      ]
    },
    {
      "id": "bigpicture",
      "number": 6,
      "title": "Big Picture Reading",
      "color": "#7c3aed",
      "articles": [
        {
          "title": "Article title",
          "author": "Author name",
          "publication": "Publication name",
          "pub_date": "21 March 2026",
          "summary": "One-paragraph summary."
        }
      ]
    }
  ],
  "footer": "Report compiled 21 March 2026 at 07:30 UTC+3. Sources: ..."
}
```

### Section IDs

| `id`         | Section                                |
|--------------|----------------------------------------|
| `alerts`     | Alerts & Sirens                        |
| `targets`    | Targets & Incidents                    |
| `local`      | Kuwait Local Situation                 |
| `regional`   | Regional Context                       |
| `risk`       | Risk Signal for Financial Institutions |
| `bigpicture` | Big Picture Reading (`articles` array) |
| `cyber`      | Cyber & Threat Intelligence            |

- All sections except `bigpicture` use an `items` array
- `bold_heading` is optional — omit for plain bullet points
- `sources` can be an empty array `[]`
- `footer` is optional

---

## File structure

```
/
├── index.html                  # Single-page app (no build step needed)
├── reports/
│   ├── index.json              # Auto-generated — do not edit manually
│   ├── 2026-03-21.json
│   ├── 2026-03-19.json
│   └── 2026-03-18.json
└── .github/
    └── workflows/
        └── update-index.yml    # Auto-updates index.json on every push
```
