# MONETRA — Quality Assurance & Production Release Checklist
**Target Release:** v1.0.0 Production  
**Platforms:** Android (AAB / APK) & iOS (IPA)  

---

## 1. Technical Quality Gates

- [x] **Flutter Compilation:** App builds cleanly without compilation failures.
- [x] **Linter & Analyzer:** `flutter analyze --no-fatal-infos` passes with 0 errors and 0 warnings.
- [x] **Unit Testing:** Deterministic financial formulas (Safe-to-Spend, budget burn, currency normalization) verified with 100% pass rate (`flutter test test/financial_calculator_test.dart`).
- [x] **Offline Reliability:** Core functionality (transactions, budgets, savings, charts) works completely offline.
- [x] **Desktop/Mobile Parity:** SQLite runs natively via FFI on desktop runners and standard SQLite on mobile devices.
- [x] **Decimal Arithmetic Safety:** All monetary quantities stored as minor integer units (cents) to avoid IEEE-754 precision loss.

---

## 2. UI/UX Acceptance Criteria

- [x] **5-Second Clarity Test:** Dashboard immediately communicates Safe-to-Spend Today and monthly budget health upon app launch.
- [x] **3-Second Logging Test:** QuickAddSheet allows logging a transaction within 3 taps.
- [x] **Theme Consistency:** Light theme and Deep Midnight Dark theme both uphold WCAG AA contrast standards.
- [x] **Visual Polish:** Interactive charts with touch tooltips, animated progress indicators, and empty state guides.
- [x] **Multi-Currency:** Dynamic currency symbol formatting across USD, EUR, GBP, CAD, AUD, CHF, AED, and MAD.

---

## 3. Data Portability & Disaster Recovery

- [x] **JSON Backup Export:** Full database snapshot exports via native share sheet.
- [x] **CSV Data Portability:** Transactions export as standard RFC 4180 CSV for external accounting.
- [x] **Sample Data Generator:** Ability to seed demo transactions for testing or user demonstration.

---

## 4. App Store & Google Play Submission

- [x] App Icon assets configured.
- [x] App Titles, Subtitles, and 80-character short descriptions finalized (`docs/ASO_AND_SEO_STRATEGY.md`).
- [x] Full App Store description and keyword bank optimized.
- [x] Privacy declarations verified (Zero remote financial telemetry).
