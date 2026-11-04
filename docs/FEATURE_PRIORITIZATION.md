# MONETRA — Feature Prioritization & Roadmap
**Framework:** Impact vs. Effort (Value / Complexity Matrix)  
**Version:** 1.0.0  

---

## 1. Impact vs. Effort Matrix

```
       HIGH IMPACT
            ▲
            │   [QUICK WINS]                       [STRATEGIC FOUNDATIONS - MVP]
            │   • 3-Second Quick-Add Keypad        • Safe-to-Spend Daily Engine
            │   • Category Preset Icons            • Visual-First Dashboard (Rings/Donuts)
            │   • Currency Selector (USD/EUR/etc.) • Transaction Management & Filtering
            │   • Dark/Light Theme Switching       • Smart Monthly & Category Budgets
            │                                      • Local SQLite Persistence (Drift)
            │                                      • Savings Goal Progress & Milestones
            │                                      • Subscription & Bill Calendar
            │                                      • Deterministic Financial Insights
            │                                      • JSON/CSV Export & Restore
            │
────────────┼────────────────────────────────────────────────────────────────────────►
            │                                                            HIGH EFFORT
            │   [LOW-PRIORITY EXTRAS]              [DEFERRED TO POST-MVP / v2]
            │   • Custom Avatar picker             • Live Plaid/Open-Banking Sync
            │   • In-app feedback sound effects    • AI Chatbot Financial Advisor
            │   • Manual tags multi-select         • Joint / Partner Shared Budgets
            │                                      • Crypto / Investment Portfolio Tracker
            │
            ▼
        LOW IMPACT
```

---

## 2. Release Milestones & Phase Allocation

### Phase 1: MVP Core (Current Release)
1. **Foundation & Architecture:** Flutter + Riverpod + GoRouter + Drift (SQLite) Clean Architecture.
2. **Design System:** Light & Deep Midnight Dark palettes, typography tokens, custom widgets, visual cards, animated progress rings.
3. **Onboarding Flow:** Welcoming 4-step wizard setting currency, income, baseline budget, and theme.
4. **Main Dashboard:** "Safe to Spend Today" card, Available Balance vs. Reserve, Monthly inflow/outflow, budget ring, recent activity, insight pills.
5. **Transactions:** Add, edit, delete, categorize, search, filter, date pickers, fast bottom sheet.
6. **Budgets & Categories:** Category allocation, warning thresholds (<75%, 75-90%, >90%), visual progress bars.
7. **Visual Analytics:** fl_chart-powered spending donut, monthly income vs expenses, trend curves, period selector.
8. **Savings Goals:** Goal creation, contribution tracking, milestone projections.
9. **Subscriptions & Recurring:** Fixed recurring expenses, monthly/yearly commitments, calendar schedule.
10. **Data Safety & Portability:** Local database, full JSON/CSV backup and restore.

### Phase 2: Monetization & Growth (Post-MVP v1.1)
- Freemium entitlement gates (advanced analytics timeframes, unlimited goals).
- RevenueCat SDK subscription integration.
- Privacy-safe consent management.

### Phase 3: Connected Intelligence (v1.2+)
- Cloud sync (encrypted Supabase / iCloud / Google Drive).
- Optional Open Banking / Plaid bank connectors for US/UK/EU markets.
- Generative AI Financial Assistant for natural language querying.
