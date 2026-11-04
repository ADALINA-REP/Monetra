# MONETRA — Database Schema & Data Persistence Specification
**Engine:** SQLite via Sqflite / Sqflite Common FFI  
**Version:** 1.0.0  

---

## 1. Schema Definitions

### Table 1: `categories`
Stores preset and custom user transaction categories.
```sql
CREATE TABLE categories (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  icon_code INTEGER NOT NULL,
  color_hex INTEGER NOT NULL,
  type TEXT NOT NULL, -- 'expense' | 'income'
  is_default INTEGER NOT NULL DEFAULT 1
);
```

### Table 2: `transactions`
Stores all inflow and outflow records. `amount_cents` is strictly an integer minor currency unit.
```sql
CREATE TABLE transactions (
  id TEXT PRIMARY KEY,
  amount_cents INTEGER NOT NULL, -- minor unit (e.g. $10.50 -> 1050)
  type TEXT NOT NULL,           -- 'expense' | 'income'
  category_id TEXT NOT NULL,
  title TEXT NOT NULL,
  date TEXT NOT NULL,           -- ISO 8601 string: YYYY-MM-DDTHH:MM:SS
  notes TEXT,
  is_recurring INTEGER NOT NULL DEFAULT 0,
  recurring_id TEXT,
  FOREIGN KEY (category_id) REFERENCES categories (id)
);
CREATE INDEX idx_transactions_date ON transactions (date DESC);
CREATE INDEX idx_transactions_category ON transactions (category_id);
```

### Table 3: `budgets`
Tracks overall and category-specific spending limits per billing cycle.
```sql
CREATE TABLE budgets (
  id TEXT PRIMARY KEY,
  category_id TEXT,             -- NULL for master monthly budget
  name TEXT NOT NULL,
  limit_cents INTEGER NOT NULL,
  period_month TEXT NOT NULL,   -- 'YYYY-MM'
  carry_over INTEGER NOT NULL DEFAULT 0
);
CREATE INDEX idx_budgets_period ON budgets (period_month);
```

### Table 4: `savings_goals`
Tracks target goals, milestones, and contributions.
```sql
CREATE TABLE savings_goals (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  target_amount_cents INTEGER NOT NULL,
  current_amount_cents INTEGER NOT NULL,
  target_date TEXT NOT NULL,
  icon_code INTEGER NOT NULL,
  color_hex INTEGER NOT NULL,
  notes TEXT
);
```

### Table 5: `subscriptions`
Manages fixed recurring commitments and subscriptions.
```sql
CREATE TABLE subscriptions (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  amount_cents INTEGER NOT NULL,
  billing_cycle TEXT NOT NULL,  -- 'weekly' | 'monthly' | 'quarterly' | 'yearly'
  next_billing_date TEXT NOT NULL,
  category_id TEXT NOT NULL,
  icon_code INTEGER NOT NULL,
  color_hex INTEGER NOT NULL,
  is_active INTEGER NOT NULL DEFAULT 1
);
```

### Table 6: `app_settings`
Key-value store for preferences, primary currency, and onboarding flags.
```sql
CREATE TABLE app_settings (
  key TEXT PRIMARY KEY,
  value TEXT NOT NULL
);
```

---

## 2. Data Loss Prevention & Migration Strategy
1. **Atomic Transactions:** All batch operations, migrations, and restores run inside SQLite transactions (`txn.transaction(...)`) to guarantee all-or-nothing execution.
2. **Crash Resilience:** SQLite write-ahead logging (WAL) prevents database corruption during sudden OS process terminations.
3. **Data Portability:** Users can generate an unencrypted or encrypted JSON snapshot anytime via Settings -> Export Complete Backup.
