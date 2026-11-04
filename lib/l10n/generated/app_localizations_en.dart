// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Monetra';

  @override
  String get appTagline => 'Your money. Your vision.';

  @override
  String get appAlternativeTagline => 'See your money differently.';

  @override
  String get navDashboard => 'Dashboard';

  @override
  String get navTransactions => 'Activity';

  @override
  String get navBudgets => 'Budgets';

  @override
  String get navAnalytics => 'Analytics';

  @override
  String get navGoals => 'Goals';

  @override
  String get safeToSpendToday => 'Safe to Spend Today';

  @override
  String get dailyAllowanceSubtitle =>
      'Calculated daily discretionary allowance';

  @override
  String daysLeftInCycle(int count) {
    return '${count}d left in cycle';
  }

  @override
  String get perDay => '/ today';

  @override
  String get safeSpendDescription =>
      'Spend up to this amount today without impacting your bills or savings goals.';

  @override
  String get safeSpendExceededDescription =>
      'Budget limit reached. Reserve remaining funds for committed bills.';

  @override
  String get remainingBudget => 'Remaining Budget';

  @override
  String get committedBills => 'Committed Bills';

  @override
  String get projectedEnd => 'Projected End';

  @override
  String get monthlyIncome => 'Monthly Income';

  @override
  String get monthlyExpenses => 'Monthly Expenses';

  @override
  String get monthlyBudget => 'Monthly Budget';

  @override
  String get monthlyBudgetUpper => 'MONTHLY BUDGET';

  @override
  String get onTrack => 'On Track';

  @override
  String get attention => 'Attention';

  @override
  String get limitExceeded => 'Limit Exceeded';

  @override
  String consumedPercent(int percent) {
    return '$percent% consumed';
  }

  @override
  String amountRemaining(String amount) {
    return '$amount remaining';
  }

  @override
  String amountOverLimit(String amount) {
    return '$amount over limit';
  }

  @override
  String get smartInsights => 'SMART INSIGHTS';

  @override
  String get insightDailyTargetTitle => 'Daily Spending Target';

  @override
  String insightDailyTargetMsg(String amount, int days) {
    return 'Staying within $amount today keeps your monthly budget safely on track for the remaining $days days.';
  }

  @override
  String get insightBudgetAlertTitle => 'Budget Alert';

  @override
  String get insightBudgetAlertMsg =>
      'You have consumed over 90% of your monthly budget. Discretionary spending should be paused to protect essentials.';

  @override
  String get insightRecurringTitle => 'Recurring Commitments';

  @override
  String insightRecurringMsg(String amount) {
    return 'You have active subscriptions totaling $amount/month. Auditing unused services could save you money.';
  }

  @override
  String get insightNetSurplusTitle => 'Net Surplus';

  @override
  String insightNetSurplusMsg(String amount) {
    return 'You are currently saving $amount this month. Consider transferring excess funds into your savings goals.';
  }

  @override
  String get insightSurgeTitle => 'Spending Surge';

  @override
  String insightSurgeMsg(String category, int percent) {
    return '$category accounts for $percent% of your monthly expenses.';
  }

  @override
  String get recentActivityUpper => 'RECENT ACTIVITY';

  @override
  String get seeAll => 'See All';

  @override
  String get quickLog => 'Quick Log';

  @override
  String get noTransactionsYet =>
      'No transactions yet.\nTap \"+\" below to log your first expense.';

  @override
  String get newTransaction => 'New Transaction';

  @override
  String get addExpense => 'Expense';

  @override
  String get addIncome => 'Income';

  @override
  String get amount => 'Amount';

  @override
  String get category => 'Category';

  @override
  String get selectCategory => 'Select Category';

  @override
  String get date => 'Date';

  @override
  String get note => 'Note (optional)';

  @override
  String get descriptionPayee => 'Description / Payee';

  @override
  String get changeDate => 'Change';

  @override
  String get saveExpense => 'Save Expense';

  @override
  String get saveIncome => 'Save Income';

  @override
  String get saveTransaction => 'Save Transaction';

  @override
  String get enterValidAmount => 'Please enter a valid amount';

  @override
  String get activityHistory => 'Activity & History';

  @override
  String get searchPlaceholder => 'Search by title, note, or payee...';

  @override
  String get filterAll => 'All';

  @override
  String get filterExpenses => 'Expenses';

  @override
  String get filterIncome => 'Income';

  @override
  String get allCategories => 'All Categories';

  @override
  String get noTransactionsFound => 'No transactions found';

  @override
  String get noTransactionsToExport => 'No transactions to export';

  @override
  String get deleteTransaction => 'Delete Transaction?';

  @override
  String confirmDeleteTransaction(String title) {
    return 'Are you sure you want to delete \"$title\"? This cannot be undone.';
  }

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get transactionDeleted => 'Transaction deleted';

  @override
  String get exportCsv => 'Export CSV';

  @override
  String get csvExportSuccess => 'CSV exported successfully';

  @override
  String get budgetOverview => 'Monthly Budget';

  @override
  String get createCategoryBudget => 'Create Category Budget';

  @override
  String get monthlyLimit => 'Monthly Limit';

  @override
  String get limitPlaceholder => 'e.g. 500.00';

  @override
  String get spentOf => 'spent of';

  @override
  String get remaining => 'Remaining';

  @override
  String get overBudget => 'Over budget';

  @override
  String get setMonthlyLimit => 'Set Monthly Limit';

  @override
  String get setBudget => 'Set Budget';

  @override
  String get categoryBudgets => 'Category Budgets';

  @override
  String get noCategoryBudgets => 'No category budgets created yet.';

  @override
  String get spendingBreakdown => 'Spending Breakdown';

  @override
  String get weeklySpendingVelocity => 'Weekly Spending Velocity';

  @override
  String get noSpendingData => 'No spending recorded this period';

  @override
  String get highestCategory => 'Highest Category';

  @override
  String get financialAnalytics => 'Financial Analytics';

  @override
  String get savingsGoals => 'Savings Targets';

  @override
  String get newGoal => 'New Goal';

  @override
  String get targetAmount => 'Target Amount';

  @override
  String get currentSavings => 'Saved So Far';

  @override
  String get recurringSubscriptions => 'Recurring Subscriptions';

  @override
  String get newSubscription => 'Add Subscription';

  @override
  String get monthlyBurnRate => 'Monthly Burn Rate';

  @override
  String get annualBurnRate => 'Annual Burn Rate';

  @override
  String get activeSubscriptions => 'Active Subscriptions';

  @override
  String renewsOn(int day) {
    return 'Renews on day $day';
  }

  @override
  String get settings => 'Settings & Privacy';

  @override
  String get preferences => 'PREFERENCES';

  @override
  String get language => 'Language';

  @override
  String get languageSubtitle => 'Choose your preferred language';

  @override
  String get systemDefault => 'System Default';

  @override
  String get currency => 'Primary Currency';

  @override
  String get currencySubtitle => 'Display currency for all figures';

  @override
  String get appearance => 'Theme & Appearance';

  @override
  String get theme => 'Theme';

  @override
  String get themeLight => 'Clean Light';

  @override
  String get themeDark => 'Midnight Dark';

  @override
  String get themeOled => 'Pure OLED Black';

  @override
  String get dataPortability => 'DATA PORTABILITY & BACKUP';

  @override
  String get backupData => 'Export Complete Backup (JSON)';

  @override
  String get backupSubtitle => 'Export all transactions, goals, and budgets';

  @override
  String get restoreData => 'Restore from Backup (JSON)';

  @override
  String get restoreSubtitle => 'Restore data from a saved Monetra JSON file';

  @override
  String get seedSampleData => 'Seed Sample FinTech Data';

  @override
  String get seedSampleSubtitle => 'Populates sample income, bills, and goals';

  @override
  String get sampleDataLoaded => 'Sample data loaded successfully!';

  @override
  String get security => 'SECURITY & PRIVACY';

  @override
  String get biometricLock => 'Require Biometric Lock';

  @override
  String get biometricSubtitle => 'Face ID, Fingerprint, or Device Passcode';

  @override
  String get biometricPrompt => 'Please authenticate to access Monetra';

  @override
  String get dataSovereignty => '100% Offline & Private';

  @override
  String get dataSovereigntySubtitle =>
      'Your financial data is stored exclusively on your device.';

  @override
  String get version => 'Version';

  @override
  String get catHousing => 'Housing & Rent';

  @override
  String get catFood => 'Food & Groceries';

  @override
  String get catTransport => 'Transportation';

  @override
  String get catShopping => 'Shopping';

  @override
  String get catEntertainment => 'Entertainment';

  @override
  String get catHealth => 'Health & Medical';

  @override
  String get catEducation => 'Education';

  @override
  String get catTravel => 'Travel & Vacations';

  @override
  String get catBills => 'Bills & Utilities';

  @override
  String get catSubscriptions => 'Subscriptions';

  @override
  String get catPersonalCare => 'Personal Care';

  @override
  String get catSavingsTransfers => 'Savings & Transfers';

  @override
  String get catOtherExpense => 'Other Expenses';

  @override
  String get catSalary => 'Salary & Wages';

  @override
  String get catFreelance => 'Freelance & Business';

  @override
  String get catInvestments => 'Investments & Dividends';

  @override
  String get catGifts => 'Gifts & Grants';

  @override
  String get catOtherIncome => 'Other Income';

  @override
  String get catOther => 'Other';

  @override
  String get welcomeTitle => 'See your money differently';

  @override
  String get welcomeSubtitle =>
      'Visual, intelligent, and 100% private personal finance.';

  @override
  String get getStarted => 'Get Started';

  @override
  String get slide1Title => 'Safe to Spend Today';

  @override
  String get slide1Desc =>
      'Never wonder if you can afford lunch. Get a live daily discretionary budget that protects your bills.';

  @override
  String get slide2Title => 'Zero Clutter, Pure Clarity';

  @override
  String get slide2Desc =>
      'Visual rings, category donuts, and instant spending velocity without spreadsheet chaos.';

  @override
  String get slide3Title => '100% Offline & Sovereignty';

  @override
  String get slide3Desc =>
      'No bank logins required. Your financial records live encrypted exclusively on your phone.';

  @override
  String get selectCurrencyTitle => 'Select Your Main Currency';

  @override
  String get startExploring => 'Launch Monetra';

  @override
  String get period7Days => '7 Days';

  @override
  String get period30Days => '30 Days';

  @override
  String get period3Months => '3 Months';

  @override
  String get periodAllTime => 'All Time';

  @override
  String get period7DaysTitle => '7-Day Spending Velocity';

  @override
  String get period30DaysTitle => '30-Day Spending Trend';

  @override
  String get period3MonthsTitle => '3-Month Spending Comparison';

  @override
  String get periodAllTimeTitle => 'Monthly Spending Evolution';

  @override
  String get incomeVsExpenses => 'Income vs Expenses';

  @override
  String get inflow => 'Inflow';

  @override
  String get outflow => 'Outflow';

  @override
  String get netBalance => 'Net Balance';

  @override
  String get spendingDistribution => 'Spending Distribution';

  @override
  String get categoryBreakdown => 'Category Breakdown';

  @override
  String get noTransactionsTimeframe => 'No transactions in this timeframe.';

  @override
  String pctOfTotalSpending(String percent) {
    return '$percent% of total spending';
  }

  @override
  String activeTargetsCount(int count) {
    return 'Active Targets ($count)';
  }

  @override
  String get noSavingsGoals =>
      'No savings goals yet. Create one to stay motivated!';

  @override
  String targetLabel(String amount) {
    return 'Target: $amount';
  }

  @override
  String savedLabel(String amount) {
    return 'Saved: $amount';
  }

  @override
  String get addFunds => 'Add Funds';

  @override
  String contributeTo(String name) {
    return 'Contribute to \"$name\"';
  }

  @override
  String get contributionAmount => 'Contribution Amount';

  @override
  String depositedSuccess(String amount, String name) {
    return 'Deposited $amount to $name!';
  }

  @override
  String get createSavingsGoal => 'Create Savings Goal';

  @override
  String get goalNameLabel => 'Goal Name (e.g. New Laptop)';

  @override
  String get targetAmountLabel => 'Target Amount';

  @override
  String get targetDateLabel => 'Target Date';

  @override
  String get createGoal => 'Create Goal';

  @override
  String get monthlyCommitment => 'Monthly Commitment';

  @override
  String get annualProjection => 'Annual Projection';

  @override
  String subscriptionsAndBillsCount(int count) {
    return 'Subscriptions & Bills ($count)';
  }

  @override
  String get addBill => 'Add Bill';

  @override
  String get noSubscriptionsYet => 'No recurring subscriptions added yet.';

  @override
  String get chooseAppearance => 'Choose Appearance';

  @override
  String get restoreBackupTitle => 'Restore Backup?';

  @override
  String get restoreBackupConfirm =>
      'Restoring this backup will replace current transactions, budgets, and savings goals with the saved data. Proceed?';

  @override
  String get restoreDataBtn => 'Restore Data';

  @override
  String backupExportError(String error) {
    return 'Backup export error: $error';
  }

  @override
  String get backupInvalidFormat => 'Invalid Monetra backup format.';

  @override
  String restoreBackupError(String error) {
    return 'Error restoring backup: $error';
  }

  @override
  String get biometricsNotAvailable =>
      'Biometrics not available on this device';

  @override
  String biometricsFailed(String error) {
    return 'Biometric authentication failed: $error';
  }

  @override
  String get commitmentsUpToDate => 'All financial commitments are up to date!';

  @override
  String get addSubscriptionTitle => 'Add Recurring Bill / Subscription';

  @override
  String get serviceNameLabel => 'Service Name (e.g. Netflix, Gym)';

  @override
  String get amountPerCycleLabel => 'Amount per Cycle';

  @override
  String get billingFrequencyLabel => 'Billing Frequency';

  @override
  String get billingMonthly => 'Monthly';

  @override
  String get billingWeekly => 'Weekly';

  @override
  String get billingQuarterly => 'Quarterly';

  @override
  String get billingYearly => 'Yearly';

  @override
  String get saveSubscription => 'Save Subscription';

  @override
  String get skip => 'Skip';

  @override
  String get next => 'Next';

  @override
  String get txSampleSalary => 'Monthly Salary Deposit';

  @override
  String get txSampleRent => 'Apartment Rent';

  @override
  String get txSampleGroceries => 'Food & Groceries Market';

  @override
  String get txSampleTransport => 'Metro Pass & Fuel';

  @override
  String get txSampleEntertainment => 'Weekend Cinema & Dinner';
}
