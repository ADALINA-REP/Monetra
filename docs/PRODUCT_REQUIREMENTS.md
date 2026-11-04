# MONETRA — Product Requirements Document (PRD)
**Version:** 1.0.0  
**Status:** Approved  
**Platform:** Flutter (iOS & Android)  

---

## 1. Product Overview

Monetra is a visual-first mobile personal finance application enabling users to achieve complete financial awareness in under 5 seconds. Monetra delivers actionable clarity on daily spending, automated budget tracking, savings goal management, subscription audits, and privacy-preserving analytics.

---

## 2. Personas & Core User Journeys

### Persona A: Alex, The Young Professional (Age 27, Freelance/Tech)
- **Goal:** Wants to know how much they can spend going out tonight without risking upcoming rent.
- **Pain point:** Spreadsheets are tedious; banking apps just show a raw balance that is misleading because bills haven't cleared yet.
- **Monetra Journey:** Opens app -> glances at "Safe to Spend Today" ($42.50) -> taps "+" -> logs $4.20 coffee in 3 seconds -> returns to work with confidence.

### Persona B: Maya, The Goal-Driven Saver (Age 32, Household Budget)
- **Goal:** Saving $8,000 for a down payment on a car while tracking household expenses across categories.
- **Pain point:** Traditional apps yell when an envelope is exceeded by $10 and don't provide a visual milestone celebration.
- **Monetra Journey:** Reviews circular savings progress bar -> deposits $250 contribution -> watches progress indicator animate to 65% -> reviews category breakdown donut to trim entertainment spending.

---

## 3. Detailed Functional Requirements

### 3.1 Onboarding Experience
- **FR-ONB-01:** Welcome carousel highlighting 3 key benefits: Instant clarity, Safe Daily Spending, and Goal Tracking.
- **FR-ONB-02:** Currency selector supporting USD ($), EUR (€), GBP (£), CAD (C$), AUD (A$), CHF (Fr), AED (د.إ), MAD (DH), and extensible ISO 4217 list.
- **FR-ONB-03:** Baseline monthly income & primary budget setup with sensible defaults.
- **FR-ONB-04:** Theme preference selection: System Default, Modern Light, Deep Midnight Dark.
- **FR-ONB-05:** Fast completion with instant transition to Dashboard (skipping optional questions allowed).

### 3.2 Main Dashboard ("Command Center")
- **FR-DSH-01:** **Available Balance Card:** Clear distinction between Total Balance, Committed Reserve (upcoming bills/goals), and True Discretionary Balance.
- **FR-DSH-02:** **Safe-to-Spend Today Widget:** Deterministic calculation:
  $$\text{SafeToSpend} = \frac{\text{Remaining Monthly Discretionary Budget} - \text{Committed Bills in Cycle}}{\text{Days Remaining in Cycle}}$$
- **FR-DSH-03:** **Monthly Cashflow Summary:** Total Inflow, Total Outflow, Net Burn/Surplus with period indicator.
- **FR-DSH-04:** **Visual Budget Progress Ring:** Animated circular gauge showing overall budget consumption percentage with health color coding (Green < 75%, Amber 75-90%, Coral > 90%).
- **FR-DSH-05:** **Category Spend Distribution:** Dynamic fl_chart interactive donut chart displaying top spending categories.
- **FR-DSH-06:** **Recent Transactions Feed:** Chronological list of last 5 transactions with quick navigation to full transaction list.
- **FR-DSH-07:** **Savings Snapshot:** Active goals with progress rings and milestone projections.
- **FR-DSH-08:** **Deterministic Insights Pill:** Real-time data-driven insights (e.g. "You're spending 12% less on Food this week").

### 3.3 Transaction Management
- **FR-TX-01:** Add Income & Expense with type toggle.
- **FR-TX-02:** Optimized Quick-Entry keypad with real-time decimal precision.
- **FR-TX-03:** Category assignment from 13 pre-seeded categories (Housing, Food & Groceries, Transportation, Shopping, Entertainment, Health, Education, Travel, Bills & Utilities, Subscriptions, Personal Care, Savings, Other) + custom user categories.
- **FR-TX-04:** Transaction Date selection (default today), description, notes, and recurring frequency flag (None, Daily, Weekly, Monthly, Yearly).
- **FR-TX-05:** Transaction search by title/notes, with multi-facet filtering (Category, Date Range, Type).
- **FR-TX-06:** Edit, update, and soft/hard delete with confirmation prompt.
- **FR-TX-07:** CSV Import and CSV Export for user data portability.

### 3.4 Visual Analytics
- **FR-ANA-01:** Period filters: 7 Days, 30 Days, 3 Months, 6 Months, Year-to-Date, All.
- **FR-ANA-02:** Monthly Income vs Expense comparison bar chart.
- **FR-ANA-03:** Spending Category distribution donut chart with interactive touch tooltips.
- **FR-ANA-04:** Daily/Weekly spending trend curve with average baseline indicator.
- **FR-ANA-05:** Category-by-category drill-down report.

### 3.5 Smart Budgets
- **FR-BDG-01:** Overall monthly budget + individual category budgets.
- **FR-BDG-02:** Real-time budget burn rate tracking with percentage consumed.
- **FR-BDG-03:** Visual alert thresholds: Normal (Green), Warning (Amber), Exceeded (Coral).
- **FR-BDG-04:** Budget rollover option toggle.

### 3.6 Savings Goals
- **FR-SAV-01:** Goal creation: Name, Target Amount, Target Date, Category Icon, Color.
- **FR-SAV-02:** Contribution logging: Add funds or withdraw funds with automatic balance recalculation.
- **FR-SAV-03:** Visual animated progress bar and estimated completion date based on savings velocity.

### 3.7 Recurring Payments & Subscriptions
- **FR-SUB-01:** Manage recurring commitments: Rent, Internet, Streaming, Utilities, Gym.
- **FR-SUB-02:** Next due date calculation, recurring frequency (weekly, monthly, quarterly, annual).
- **FR-SUB-03:** Total monthly subscription burn and annual projection metrics.
- **FR-SUB-04:** Interactive visual recurring calendar showing upcoming payment timeline.

### 3.8 Financial Insights (Deterministic Engine)
- **FR-INS-01:** Rule-based comparison between current cycle and prior cycle.
- **FR-INS-02:** Category anomaly detection (>20% surge above 30-day baseline).
- **FR-INS-03:** Positive habit reinforcement (e.g., 3 consecutive days under daily spending target).

### 3.9 Security, Data Portability & Settings
- **FR-SET-01:** Local-first encrypted SQLite database via Drift.
- **FR-SET-02:** Complete data export to JSON & CSV.
- **FR-SET-03:** Full data restore from backup file.
- **FR-SET-04:** Currency switcher with real-time recalculation.
- **FR-SET-05:** Biometric authentication lock (LocalAuth) for privacy.
- **FR-SET-06:** Zero telemetry on financial numbers.

---

## 4. Non-Functional Requirements
- **Performance:** Cold start to interactive UI under 600ms on modern devices; frame rendering locked at 60/120fps.
- **Offline Reliability:** 100% of core features (transactions, charts, budgets, goals) work without network connectivity.
- **Accessibility:** Minimum WCAG 2.1 AA contrast ratio across both Light and Dark themes. Dynamic font size support.
- **Data Integrity:** Accurate decimal arithmetic (never binary floating-point rounding errors for currency amounts).
