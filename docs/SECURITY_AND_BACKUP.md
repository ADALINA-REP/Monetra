# MONETRA — Security, Privacy & Data Recovery Strategy
**Version:** 1.0.0  
**Classification:** Confidential FinTech Operations  

---

## 1. Local-First Security Architecture

Financial data is inherently sensitive. Traditional finance apps leak balances, merchant names, and geolocation to third-party ad networks and aggregators. Monetra implements an uncompromising **Local-First & Privacy-By-Design** posture:

1. **Zero-Telemetry Financial Records:**
   - Transaction amounts, payees, category balances, and bank notes are never dispatched to analytics SDKs or remote log aggregators.
   - Any crash-reporting or product analytics tracked (e.g. `onboarding_completed`, `quick_log_opened`) contain purely structural metadata, never financial figures.
2. **On-Device Storage Isolation:**
   - The primary SQLite database is housed within the private sandbox directory provided by the operating system (`getDatabasesPath()` on Android/iOS, and protected user application directories on desktop).
3. **Biometric Session Protection:**
   - Local authentication hooks (Face ID, Touch ID, Android BiometricPrompt) ensure unauthorized users cannot inspect financial totals if the phone is unlocked in public.

---

## 2. Backup & Disaster Recovery Architecture

```
┌────────────────────────────────────────────────────────┐
│                   MONETRA DEVICE                       │
│  [ Local SQLite Database (monetra_app.db) ]            │
└───────────────┬────────────────────────┬───────────────┘
                │                        │
       Export Complete JSON       Export Filtered CSV
                │                        │
┌───────────────▼────────┐      ┌────────▼───────────────┐
│ Encrypted JSON Backup  │      │ Standard CSV File      │
│ (All tables, goals,    │      │ (Spreadsheet / Tax     │
│  budgets, categories)  │      │  Audit Portability)    │
└────────────────────────┘      └────────────────────────┘
```

### 2.1 Complete JSON Backup & Restore
- **Export:** Serializes all database tables into a clean, portable JSON format.
- **Restore:** Uses an atomic SQLite transaction to wipe and re-seed tables, rolling back immediately if file validation or JSON parsing fails.

### 2.2 CSV Portability
- Generates an RFC 4180 compliant CSV export containing Date, Type, Category, Title, Amount, and Notes for seamless import into Excel, Google Sheets, or accountant software.
