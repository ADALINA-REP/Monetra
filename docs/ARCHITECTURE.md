# MONETRA — Software Architecture & Engineering Blueprint
**Version:** 1.0.0  
**Stack:** Flutter Stable (Dart 3.11+) • Riverpod 2.6+ • GoRouter 17.5+ • SQLite (Drift/FFI) • fl_chart  

---

## 1. Architectural Philosophy: Visual-First & Local-First

Monetra is engineered around three foundational pillars:
1. **5-Second Cognitive Clarity:** Data flow is optimized so the hero metrics (Safe to Spend Today, Cashflow Net, Budget Burn) compute deterministically and update instantaneously without background network spinners.
2. **100% Local-First Resilience:** The app operates seamlessly offline with zero latency. All write operations commit directly to SQLite, immediately notifying reactive Riverpod providers.
3. **Decimal-Safe Financial Arithmetic:** To avoid catastrophic binary IEEE-754 floating-point rounding errors common in junior finance apps (e.g., `0.1 + 0.2 = 0.30000000000000004`), Monetra stores all currency units internally as 64-bit integer minor units (cents/satoshis), strictly converting only at the visual formatting layer via `CurrencyFormatter`.

---

## 2. Layered Clean Architecture

```
┌──────────────────────────────────────────────────────────┐
│                   PRESENTATION LAYER                     │
│  • Screens (Dashboard, Activity, Budgets, Analytics,     │
│             Goals & Subscriptions, Settings, Onboarding) │
│  • Reusable Core Widgets (SafeSpendCard, QuickAddSheet,  │
│                           BudgetProgressRing)            │
│  • Visual Design System & Themes (Light & Midnight Dark) │
└────────────────────────────┬─────────────────────────────┘
                             │ Watches / Dispatches
┌────────────────────────────▼─────────────────────────────┐
│                 APPLICATION & STATE LAYER                │
│  • Riverpod Notifiers (TransactionsNotifier,             │
│                        BudgetsNotifier, CurrencyNotifier)│
│  • Deterministic Engines (FinancialCalculator,           │
│                           InsightsGenerator)             │
│  • GoRouter Shell Route & Deep Linking                   │
└────────────────────────────┬─────────────────────────────┘
                             │ Invocations
┌────────────────────────────▼─────────────────────────────┐
│                    DATA & REPOSITORY LAYER               │
│  • FinanceRepository (Abstracted single point of truth)  │
│  • AppDatabase (SQLite with FFI desktop & mobile driver) │
│  • Serialization & Portability (JSON & CSV engines)      │
└──────────────────────────────────────────────────────────┘
```

---

## 3. Directory Layout

```
lib/
├── app/
│   ├── app.dart                   # MaterialApp.router configuration
│   └── router/app_router.dart     # GoRouter StatefulShellRoute & navigation tabs
├── core/
│   ├── theme/
│   │   ├── app_colors.dart        # FinTech curated palette
│   │   └── app_theme.dart         # Material 3 Light & Midnight Dark tokens
│   ├── utils/
│   │   ├── currency_formatter.dart# ISO 4217 minor unit formatter
│   │   └── financial_calculator.dart # Deterministic Safe-to-Spend & Insights
│   └── widgets/
│       ├── safe_spend_card.dart   # Hero daily spending guidance widget
│       ├── budget_progress_ring.dart # Budget burn gauge & threshold alerts
│       └── quick_add_sheet.dart   # 3-Second rapid transaction logger
├── data/
│   ├── database/app_database.dart # Local SQLite persistence & migrations
│   ├── models/
│   │   ├── category_model.dart    # Categories & default presets
│   │   ├── transaction_model.dart # Decimal-safe minor unit transactions
│   │   ├── budget_model.dart      # Overall and category monthly budgets
│   │   ├── savings_goal_model.dart# Visual targets with milestone math
│   │   ├── subscription_model.dart# Recurring bill normalization engine
│   │   └── financial_insight_model.dart # Contextual insight entities
│   └── repositories/
│       └── finance_repository.dart# Repository implementation & seeding
└── features/
    ├── onboarding/                # First-run currency, budget & theme wizard
    ├── dashboard/                 # Command center with Safe-to-Spend & burn ring
    ├── transactions/              # Search, multi-facet filtering & CSV export
    ├── budgets/                   # Master & category budget limits
    ├── analytics/                 # fl_chart interactive donut & cashflow trends
    ├── goals/                     # Savings milestones & subscription audit
    ├── settings/                  # Currency switcher, backup & privacy
    └── providers/
        └── finance_providers.dart # Riverpod reactive state graph
```

---

## 4. Key Engineering Highlights
- **State Preservation:** Uses `StatefulShellRoute.indexedStack` to preserve scroll offsets, search filters, and tab state between screen transitions.
- **Fast Input Cycle:** QuickAddSheet opens in a bottom sheet with numeric autofocus, type toggle, and instant chip selection, enabling sub-3-second transaction entry.
- **Zero-Telemetry Security:** No bank balances, transaction amounts, or personal descriptions are broadcast to third-party servers.
