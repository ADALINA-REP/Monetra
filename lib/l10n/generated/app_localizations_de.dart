// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appName => 'Monetra';

  @override
  String get appTagline => 'Dein Geld. Deine Vision.';

  @override
  String get appAlternativeTagline => 'Sieh dein Geld mit anderen Augen.';

  @override
  String get navDashboard => 'Übersicht';

  @override
  String get navTransactions => 'Buchungen';

  @override
  String get navBudgets => 'Budgets';

  @override
  String get navAnalytics => 'Analysen';

  @override
  String get navGoals => 'Ziele';

  @override
  String get safeToSpendToday => 'Heute verfügbar';

  @override
  String get dailyAllowanceSubtitle => 'Berechneter täglicher Freibetrag';

  @override
  String daysLeftInCycle(int count) {
    return 'noch $count Tage im Zyklus';
  }

  @override
  String get perDay => '/ Tag';

  @override
  String get safeSpendDescription =>
      'Geben Sie diesen Betrag heute bedenkenlos aus, ohne Rechnungen oder Sparziele zu gefährden.';

  @override
  String get safeSpendExceededDescription =>
      'Budgetlimit erreicht. Bitte verbleibende Mittel für Fixkosten reservieren.';

  @override
  String get remainingBudget => 'Verbleibendes Budget';

  @override
  String get committedBills => 'Feste Ausgaben';

  @override
  String get projectedEnd => 'Prognose Monatsende';

  @override
  String get monthlyIncome => 'Monatliche Einnahmen';

  @override
  String get monthlyExpenses => 'Monatliche Ausgaben';

  @override
  String get monthlyBudget => 'Monatsbudget';

  @override
  String get monthlyBudgetUpper => 'MONATSBUDGET';

  @override
  String get onTrack => 'Im Plan';

  @override
  String get attention => 'Achtung';

  @override
  String get limitExceeded => 'Limit überschritten';

  @override
  String consumedPercent(int percent) {
    return '$percent% verbraucht';
  }

  @override
  String amountRemaining(String amount) {
    return 'noch $amount';
  }

  @override
  String amountOverLimit(String amount) {
    return '$amount über Limit';
  }

  @override
  String get smartInsights => 'SMARTE ANALYSEN';

  @override
  String get insightDailyTargetTitle => 'Tägliches Ausgabenziel';

  @override
  String insightDailyTargetMsg(String amount, int days) {
    return 'Mit maximal $amount heute bleibt Ihr Monatsbudget für die verbleibenden $days Tage voll im Plan.';
  }

  @override
  String get insightBudgetAlertTitle => 'Budget-Warnung';

  @override
  String get insightBudgetAlertMsg =>
      'Sie haben über 90% Ihres Monatsbudgets verbraucht. Bitte nicht notwendige Ausgaben pausieren.';

  @override
  String get insightRecurringTitle => 'Laufende Abonnements';

  @override
  String insightRecurringMsg(String amount) {
    return 'Sie haben aktive Abos in Höhe von $amount/Monat. Das Kündigen ungenutzter Dienste spart bares Geld.';
  }

  @override
  String get insightNetSurplusTitle => 'Positiver Überschuss';

  @override
  String insightNetSurplusMsg(String amount) {
    return 'Sie sparen diesen Monat aktuell $amount. Erwägen Sie, diesen Betrag Ihren Sparzielen zuzuführen.';
  }

  @override
  String get insightSurgeTitle => 'Ausgabensprung';

  @override
  String insightSurgeMsg(String category, int percent) {
    return 'Auf $category entfallen $percent% Ihrer monatlichen Gesamtausgaben.';
  }

  @override
  String get recentActivityUpper => 'LETZTE AKTIVITÄTEN';

  @override
  String get seeAll => 'Alle anzeigen';

  @override
  String get quickLog => 'Schnellbuchung';

  @override
  String get noTransactionsYet =>
      'Noch keine Buchungen vorhanden.\nTippen Sie auf „+“, um die erste Ausgabe zu erfassen.';

  @override
  String get newTransaction => 'Neue Buchung';

  @override
  String get addExpense => 'Ausgabe';

  @override
  String get addIncome => 'Einnahme';

  @override
  String get amount => 'Betrag';

  @override
  String get category => 'Kategorie';

  @override
  String get selectCategory => 'Kategorie wählen';

  @override
  String get date => 'Datum';

  @override
  String get note => 'Notiz (optional)';

  @override
  String get descriptionPayee => 'Beschreibung / Empfänger';

  @override
  String get changeDate => 'Ändern';

  @override
  String get saveExpense => 'Ausgabe speichern';

  @override
  String get saveIncome => 'Einnahme speichern';

  @override
  String get saveTransaction => 'Speichern';

  @override
  String get enterValidAmount => 'Bitte einen gültigen Betrag eingeben';

  @override
  String get activityHistory => 'Buchungsverlauf';

  @override
  String get searchPlaceholder => 'Nach Titel, Notiz oder Empfänger suchen...';

  @override
  String get filterAll => 'Alle';

  @override
  String get filterExpenses => 'Ausgaben';

  @override
  String get filterIncome => 'Einnahmen';

  @override
  String get allCategories => 'Alle Kategorien';

  @override
  String get noTransactionsFound => 'Keine Buchungen gefunden';

  @override
  String get noTransactionsToExport =>
      'Keine Buchungen zum Exportieren vorhanden';

  @override
  String get deleteTransaction => 'Buchung löschen?';

  @override
  String confirmDeleteTransaction(String title) {
    return 'Möchten Sie „$title“ wirklich löschen? Dies kann nicht rückgängig gemacht werden.';
  }

  @override
  String get cancel => 'Abbrechen';

  @override
  String get delete => 'Löschen';

  @override
  String get transactionDeleted => 'Buchung erfolgreich gelöscht';

  @override
  String get exportCsv => 'CSV exportieren';

  @override
  String get csvExportSuccess => 'CSV erfolgreich exportiert';

  @override
  String get budgetOverview => 'Monatsbudget';

  @override
  String get createCategoryBudget => 'Kategorie-Budget erstellen';

  @override
  String get monthlyLimit => 'Monatslimit';

  @override
  String get limitPlaceholder => 'z.B. 500.00';

  @override
  String get spentOf => 'ausgegeben von';

  @override
  String get remaining => 'Verbleibend';

  @override
  String get overBudget => 'Budget überzogen';

  @override
  String get setMonthlyLimit => 'Monatslimit festlegen';

  @override
  String get setBudget => 'Budget festlegen';

  @override
  String get categoryBudgets => 'Kategorie-Budgets';

  @override
  String get noCategoryBudgets => 'Noch keine Kategorie-Budgets angelegt.';

  @override
  String get spendingBreakdown => 'Ausgabenverteilung';

  @override
  String get weeklySpendingVelocity => 'Wöchentliche Ausgabengeschwindigkeit';

  @override
  String get noSpendingData => 'Keine Ausgaben in diesem Zeitraum';

  @override
  String get highestCategory => 'Größte Kategorie';

  @override
  String get financialAnalytics => 'Finanzanalysen';

  @override
  String get savingsGoals => 'Sparziele';

  @override
  String get newGoal => 'Neues Sparziel';

  @override
  String get targetAmount => 'Zielbetrag';

  @override
  String get currentSavings => 'Bisher gespart';

  @override
  String get recurringSubscriptions => 'Laufende Abonnements';

  @override
  String get newSubscription => 'Abo hinzufügen';

  @override
  String get monthlyBurnRate => 'Monatliche Fixkosten';

  @override
  String get annualBurnRate => 'Jährliche Fixkosten';

  @override
  String get activeSubscriptions => 'Aktive Abos';

  @override
  String renewsOn(int day) {
    return 'Verlängert sich am $day. des Monats';
  }

  @override
  String get settings => 'Einstellungen & Privatsphäre';

  @override
  String get preferences => 'EINSTELLUNGEN';

  @override
  String get language => 'Sprache';

  @override
  String get languageSubtitle => 'Wählen Sie Ihre bevorzugte Sprache';

  @override
  String get systemDefault => 'Systemstandard';

  @override
  String get currency => 'Hauptwährung';

  @override
  String get currencySubtitle => 'Anzeigewährung für alle Beträge';

  @override
  String get appearance => 'Design & Darstellung';

  @override
  String get theme => 'Design';

  @override
  String get themeLight => 'Modernes Hell';

  @override
  String get themeDark => 'Mitternachtsdunkel';

  @override
  String get themeOled => 'Reines OLED-Schwarz';

  @override
  String get dataPortability => 'DATENEXPORT & SICHERUNG';

  @override
  String get backupData => 'Datenbank-Backup (JSON)';

  @override
  String get backupSubtitle => 'Vollständiges Offline-Backup exportieren';

  @override
  String get restoreData => 'Datenbank wiederherstellen (JSON)';

  @override
  String get restoreSubtitle => 'Backup-Datei importieren';

  @override
  String get seedSampleData => 'Beispieldaten laden';

  @override
  String get seedSampleSubtitle =>
      'Erzeugt Einnahmen, Fixkosten und Sparziele zum Ausprobieren';

  @override
  String get sampleDataLoaded => 'Beispieldaten erfolgreich geladen!';

  @override
  String get security => 'SICHERHEIT & DATENSCHUTZ';

  @override
  String get biometricLock => 'Biometrische Sperre';

  @override
  String get biometricSubtitle =>
      'Monetra mit Fingerabdruck oder Face ID entsperren';

  @override
  String get biometricPrompt => 'Bitte authentifizieren, um Monetra zu öffnen';

  @override
  String get dataSovereignty => '100% Offline & Privat';

  @override
  String get dataSovereigntySubtitle =>
      'Ihre Finanzdaten verbleiben ausschließlich auf Ihrem Gerät.';

  @override
  String get version => 'Version';

  @override
  String get catHousing => 'Wohnen & Miete';

  @override
  String get catFood => 'Lebensmittel & Einkäufe';

  @override
  String get catTransport => 'Transport & Mobilität';

  @override
  String get catShopping => 'Shopping & Kleidung';

  @override
  String get catEntertainment => 'Freizeit & Unterhaltung';

  @override
  String get catHealth => 'Gesundheit & Medizin';

  @override
  String get catEducation => 'Bildung & Kurse';

  @override
  String get catTravel => 'Reisen & Urlaub';

  @override
  String get catBills => 'Rechnungen & Fixkosten';

  @override
  String get catSubscriptions => 'Abonnements';

  @override
  String get catPersonalCare => 'Körperpflege & Wellness';

  @override
  String get catSavingsTransfers => 'Sparen & Überweisungen';

  @override
  String get catOtherExpense => 'Sonstige Ausgaben';

  @override
  String get catSalary => 'Gehalt & Lohn';

  @override
  String get catFreelance => 'Freiberuflich & Business';

  @override
  String get catInvestments => 'Investitionen & Renditen';

  @override
  String get catGifts => 'Geschenke & Erstattungen';

  @override
  String get catOtherIncome => 'Sonstige Einnahmen';

  @override
  String get catOther => 'Sonstiges';

  @override
  String get welcomeTitle => 'Sieh dein Geld mit anderen Augen';

  @override
  String get welcomeSubtitle =>
      'Visuelle, intelligente und 100% private Finanzverwaltung.';

  @override
  String get getStarted => 'Jetzt starten';

  @override
  String get slide1Title => 'Heute verfügbar';

  @override
  String get slide1Desc =>
      'Nie wieder zweifeln, ob das Essen im Budget liegt. Ein dynamischer Tagesfreibetrag, der Fixkosten schützt.';

  @override
  String get slide2Title => 'Klare Sicht ohne Tabellen-Chaos';

  @override
  String get slide2Desc =>
      'Fortschrittsringe, Donut-Diagramme und Trendanalysen auf einen Blick.';

  @override
  String get slide3Title => '100% Offline & Datensouveränität';

  @override
  String get slide3Desc =>
      'Keine Bank-Logins nötig. Ihre Finanzdaten liegen verschlüsselt nur auf Ihrem Smartphone.';

  @override
  String get selectCurrencyTitle => 'Wählen Sie Ihre Hauptwährung';

  @override
  String get startExploring => 'Monetra öffnen';

  @override
  String get period7Days => '7 Tage';

  @override
  String get period30Days => '30 Tage';

  @override
  String get period3Months => '3 Monate';

  @override
  String get periodAllTime => 'Gesamtzeit';

  @override
  String get period7DaysTitle => '7-Tage-Ausgabengeschwindigkeit';

  @override
  String get period30DaysTitle => '30-Tage-Ausgabentrend';

  @override
  String get period3MonthsTitle => '3-Monats-Ausgabenvergleich';

  @override
  String get periodAllTimeTitle => 'Monatliche Ausgabenentwicklung';

  @override
  String get incomeVsExpenses => 'Einnahmen vs. Ausgaben';

  @override
  String get inflow => 'Einnahmen';

  @override
  String get outflow => 'Ausgaben';

  @override
  String get netBalance => 'Netto-Saldo';

  @override
  String get spendingDistribution => 'Ausgabenverteilung';

  @override
  String get categoryBreakdown => 'Kategorie-Übersicht';

  @override
  String get noTransactionsTimeframe =>
      'Keine Transaktionen in diesem Zeitraum.';

  @override
  String pctOfTotalSpending(String percent) {
    return '$percent% der Gesamtausgaben';
  }

  @override
  String activeTargetsCount(int count) {
    return 'Aktive Sparziele ($count)';
  }

  @override
  String get noSavingsGoals =>
      'Noch keine Sparziele. Erstelle eines, um motiviert zu bleiben!';

  @override
  String targetLabel(String amount) {
    return 'Ziel: $amount';
  }

  @override
  String savedLabel(String amount) {
    return 'Gespart: $amount';
  }

  @override
  String get addFunds => 'Einzahlen';

  @override
  String contributeTo(String name) {
    return 'Einzahlen in „$name“';
  }

  @override
  String get contributionAmount => 'Einzahlungsbetrag';

  @override
  String depositedSuccess(String amount, String name) {
    return '$amount erfolgreich eingezahlt in $name!';
  }

  @override
  String get createSavingsGoal => 'Neues Sparziel erstellen';

  @override
  String get goalNameLabel => 'Name des Ziels (z. B. Neuer Laptop)';

  @override
  String get targetAmountLabel => 'Zielbetrag';

  @override
  String get targetDateLabel => 'Zieldatum';

  @override
  String get createGoal => 'Ziel speichern';

  @override
  String get monthlyCommitment => 'Monatliche Fixkosten';

  @override
  String get annualProjection => 'Jahresprognose';

  @override
  String subscriptionsAndBillsCount(int count) {
    return 'Abos & Fixkosten ($count)';
  }

  @override
  String get addBill => 'Fixkosten hinzufügen';

  @override
  String get noSubscriptionsYet => 'Noch keine wiederkehrenden Abos erfasst.';

  @override
  String get chooseAppearance => 'Erscheinungsbild wählen';

  @override
  String get restoreBackupTitle => 'Backup wiederherstellen?';

  @override
  String get restoreBackupConfirm =>
      'Das Wiederherstellen ersetzt vorhandene Buchungen, Budgets und Sparziele. Fortfahren?';

  @override
  String get restoreDataBtn => 'Daten wiederherstellen';

  @override
  String backupExportError(String error) {
    return 'Export-Fehler: $error';
  }

  @override
  String get backupInvalidFormat => 'Ungültiges Monetra-Backup-Format.';

  @override
  String restoreBackupError(String error) {
    return 'Fehler beim Wiederherstellen: $error';
  }

  @override
  String get biometricsNotAvailable =>
      'Biometrie auf diesem Gerät nicht verfügbar';

  @override
  String biometricsFailed(String error) {
    return 'Biometrische Authentifizierung fehlgeschlagen: $error';
  }

  @override
  String get commitmentsUpToDate =>
      'Alle finanziellen Verpflichtungen sind aktuell!';

  @override
  String get addSubscriptionTitle => 'Abo / Dauerauftrag hinzufügen';

  @override
  String get serviceNameLabel =>
      'Name des Dienstes (z. B. Netflix, Fitnessstudio)';

  @override
  String get amountPerCycleLabel => 'Betrag pro Abrechnungszyklus';

  @override
  String get billingFrequencyLabel => 'Abrechnungsintervall';

  @override
  String get billingMonthly => 'Monatlich';

  @override
  String get billingWeekly => 'Wöchentlich';

  @override
  String get billingQuarterly => 'Vierteljährlich';

  @override
  String get billingYearly => 'Jährlich';

  @override
  String get saveSubscription => 'Abo speichern';

  @override
  String get skip => 'Überspringen';

  @override
  String get next => 'Weiter';

  @override
  String get txSampleSalary => 'Monatliches Gehalt';

  @override
  String get txSampleRent => 'Wohnungsmiete';

  @override
  String get txSampleGroceries => 'Wocheneinkauf Supermarkt';

  @override
  String get txSampleTransport => 'Monatsticket & Kraftstoff';

  @override
  String get txSampleEntertainment => 'Kino & Restaurant am Wochenende';
}
