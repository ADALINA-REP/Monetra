import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('pt'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Monetra'**
  String get appName;

  /// No description provided for @appTagline.
  ///
  /// In en, this message translates to:
  /// **'Your money. Your vision.'**
  String get appTagline;

  /// No description provided for @appAlternativeTagline.
  ///
  /// In en, this message translates to:
  /// **'See your money differently.'**
  String get appAlternativeTagline;

  /// No description provided for @navDashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get navDashboard;

  /// No description provided for @navTransactions.
  ///
  /// In en, this message translates to:
  /// **'Activity'**
  String get navTransactions;

  /// No description provided for @navBudgets.
  ///
  /// In en, this message translates to:
  /// **'Budgets'**
  String get navBudgets;

  /// No description provided for @navAnalytics.
  ///
  /// In en, this message translates to:
  /// **'Analytics'**
  String get navAnalytics;

  /// No description provided for @navGoals.
  ///
  /// In en, this message translates to:
  /// **'Goals'**
  String get navGoals;

  /// No description provided for @safeToSpendToday.
  ///
  /// In en, this message translates to:
  /// **'Safe to Spend Today'**
  String get safeToSpendToday;

  /// No description provided for @dailyAllowanceSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Calculated daily discretionary allowance'**
  String get dailyAllowanceSubtitle;

  /// No description provided for @daysLeftInCycle.
  ///
  /// In en, this message translates to:
  /// **'{count}d left in cycle'**
  String daysLeftInCycle(int count);

  /// No description provided for @perDay.
  ///
  /// In en, this message translates to:
  /// **'/ today'**
  String get perDay;

  /// No description provided for @safeSpendDescription.
  ///
  /// In en, this message translates to:
  /// **'Spend up to this amount today without impacting your bills or savings goals.'**
  String get safeSpendDescription;

  /// No description provided for @safeSpendExceededDescription.
  ///
  /// In en, this message translates to:
  /// **'Budget limit reached. Reserve remaining funds for committed bills.'**
  String get safeSpendExceededDescription;

  /// No description provided for @remainingBudget.
  ///
  /// In en, this message translates to:
  /// **'Remaining Budget'**
  String get remainingBudget;

  /// No description provided for @committedBills.
  ///
  /// In en, this message translates to:
  /// **'Committed Bills'**
  String get committedBills;

  /// No description provided for @projectedEnd.
  ///
  /// In en, this message translates to:
  /// **'Projected End'**
  String get projectedEnd;

  /// No description provided for @monthlyIncome.
  ///
  /// In en, this message translates to:
  /// **'Monthly Income'**
  String get monthlyIncome;

  /// No description provided for @monthlyExpenses.
  ///
  /// In en, this message translates to:
  /// **'Monthly Expenses'**
  String get monthlyExpenses;

  /// No description provided for @monthlyBudget.
  ///
  /// In en, this message translates to:
  /// **'Monthly Budget'**
  String get monthlyBudget;

  /// No description provided for @monthlyBudgetUpper.
  ///
  /// In en, this message translates to:
  /// **'MONTHLY BUDGET'**
  String get monthlyBudgetUpper;

  /// No description provided for @onTrack.
  ///
  /// In en, this message translates to:
  /// **'On Track'**
  String get onTrack;

  /// No description provided for @attention.
  ///
  /// In en, this message translates to:
  /// **'Attention'**
  String get attention;

  /// No description provided for @limitExceeded.
  ///
  /// In en, this message translates to:
  /// **'Limit Exceeded'**
  String get limitExceeded;

  /// No description provided for @consumedPercent.
  ///
  /// In en, this message translates to:
  /// **'{percent}% consumed'**
  String consumedPercent(int percent);

  /// No description provided for @amountRemaining.
  ///
  /// In en, this message translates to:
  /// **'{amount} remaining'**
  String amountRemaining(String amount);

  /// No description provided for @amountOverLimit.
  ///
  /// In en, this message translates to:
  /// **'{amount} over limit'**
  String amountOverLimit(String amount);

  /// No description provided for @smartInsights.
  ///
  /// In en, this message translates to:
  /// **'SMART INSIGHTS'**
  String get smartInsights;

  /// No description provided for @insightDailyTargetTitle.
  ///
  /// In en, this message translates to:
  /// **'Daily Spending Target'**
  String get insightDailyTargetTitle;

  /// No description provided for @insightDailyTargetMsg.
  ///
  /// In en, this message translates to:
  /// **'Staying within {amount} today keeps your monthly budget safely on track for the remaining {days} days.'**
  String insightDailyTargetMsg(String amount, int days);

  /// No description provided for @insightBudgetAlertTitle.
  ///
  /// In en, this message translates to:
  /// **'Budget Alert'**
  String get insightBudgetAlertTitle;

  /// No description provided for @insightBudgetAlertMsg.
  ///
  /// In en, this message translates to:
  /// **'You have consumed over 90% of your monthly budget. Discretionary spending should be paused to protect essentials.'**
  String get insightBudgetAlertMsg;

  /// No description provided for @insightRecurringTitle.
  ///
  /// In en, this message translates to:
  /// **'Recurring Commitments'**
  String get insightRecurringTitle;

  /// No description provided for @insightRecurringMsg.
  ///
  /// In en, this message translates to:
  /// **'You have active subscriptions totaling {amount}/month. Auditing unused services could save you money.'**
  String insightRecurringMsg(String amount);

  /// No description provided for @insightNetSurplusTitle.
  ///
  /// In en, this message translates to:
  /// **'Net Surplus'**
  String get insightNetSurplusTitle;

  /// No description provided for @insightNetSurplusMsg.
  ///
  /// In en, this message translates to:
  /// **'You are currently saving {amount} this month. Consider transferring excess funds into your savings goals.'**
  String insightNetSurplusMsg(String amount);

  /// No description provided for @insightSurgeTitle.
  ///
  /// In en, this message translates to:
  /// **'Spending Surge'**
  String get insightSurgeTitle;

  /// No description provided for @insightSurgeMsg.
  ///
  /// In en, this message translates to:
  /// **'{category} accounts for {percent}% of your monthly expenses.'**
  String insightSurgeMsg(String category, int percent);

  /// No description provided for @recentActivityUpper.
  ///
  /// In en, this message translates to:
  /// **'RECENT ACTIVITY'**
  String get recentActivityUpper;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See All'**
  String get seeAll;

  /// No description provided for @quickLog.
  ///
  /// In en, this message translates to:
  /// **'Quick Log'**
  String get quickLog;

  /// No description provided for @noTransactionsYet.
  ///
  /// In en, this message translates to:
  /// **'No transactions yet.\nTap \"+\" below to log your first expense.'**
  String get noTransactionsYet;

  /// No description provided for @newTransaction.
  ///
  /// In en, this message translates to:
  /// **'New Transaction'**
  String get newTransaction;

  /// No description provided for @addExpense.
  ///
  /// In en, this message translates to:
  /// **'Expense'**
  String get addExpense;

  /// No description provided for @addIncome.
  ///
  /// In en, this message translates to:
  /// **'Income'**
  String get addIncome;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @selectCategory.
  ///
  /// In en, this message translates to:
  /// **'Select Category'**
  String get selectCategory;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @note.
  ///
  /// In en, this message translates to:
  /// **'Note (optional)'**
  String get note;

  /// No description provided for @descriptionPayee.
  ///
  /// In en, this message translates to:
  /// **'Description / Payee'**
  String get descriptionPayee;

  /// No description provided for @changeDate.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get changeDate;

  /// No description provided for @saveExpense.
  ///
  /// In en, this message translates to:
  /// **'Save Expense'**
  String get saveExpense;

  /// No description provided for @saveIncome.
  ///
  /// In en, this message translates to:
  /// **'Save Income'**
  String get saveIncome;

  /// No description provided for @saveTransaction.
  ///
  /// In en, this message translates to:
  /// **'Save Transaction'**
  String get saveTransaction;

  /// No description provided for @enterValidAmount.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid amount'**
  String get enterValidAmount;

  /// No description provided for @activityHistory.
  ///
  /// In en, this message translates to:
  /// **'Activity & History'**
  String get activityHistory;

  /// No description provided for @searchPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Search by title, note, or payee...'**
  String get searchPlaceholder;

  /// No description provided for @filterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get filterAll;

  /// No description provided for @filterExpenses.
  ///
  /// In en, this message translates to:
  /// **'Expenses'**
  String get filterExpenses;

  /// No description provided for @filterIncome.
  ///
  /// In en, this message translates to:
  /// **'Income'**
  String get filterIncome;

  /// No description provided for @allCategories.
  ///
  /// In en, this message translates to:
  /// **'All Categories'**
  String get allCategories;

  /// No description provided for @noTransactionsFound.
  ///
  /// In en, this message translates to:
  /// **'No transactions found'**
  String get noTransactionsFound;

  /// No description provided for @noTransactionsToExport.
  ///
  /// In en, this message translates to:
  /// **'No transactions to export'**
  String get noTransactionsToExport;

  /// No description provided for @deleteTransaction.
  ///
  /// In en, this message translates to:
  /// **'Delete Transaction?'**
  String get deleteTransaction;

  /// No description provided for @confirmDeleteTransaction.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete \"{title}\"? This cannot be undone.'**
  String confirmDeleteTransaction(String title);

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @transactionDeleted.
  ///
  /// In en, this message translates to:
  /// **'Transaction deleted'**
  String get transactionDeleted;

  /// No description provided for @exportCsv.
  ///
  /// In en, this message translates to:
  /// **'Export CSV'**
  String get exportCsv;

  /// No description provided for @csvExportSuccess.
  ///
  /// In en, this message translates to:
  /// **'CSV exported successfully'**
  String get csvExportSuccess;

  /// No description provided for @budgetOverview.
  ///
  /// In en, this message translates to:
  /// **'Monthly Budget'**
  String get budgetOverview;

  /// No description provided for @createCategoryBudget.
  ///
  /// In en, this message translates to:
  /// **'Create Category Budget'**
  String get createCategoryBudget;

  /// No description provided for @monthlyLimit.
  ///
  /// In en, this message translates to:
  /// **'Monthly Limit'**
  String get monthlyLimit;

  /// No description provided for @limitPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'e.g. 500.00'**
  String get limitPlaceholder;

  /// No description provided for @spentOf.
  ///
  /// In en, this message translates to:
  /// **'spent of'**
  String get spentOf;

  /// No description provided for @remaining.
  ///
  /// In en, this message translates to:
  /// **'Remaining'**
  String get remaining;

  /// No description provided for @overBudget.
  ///
  /// In en, this message translates to:
  /// **'Over budget'**
  String get overBudget;

  /// No description provided for @setMonthlyLimit.
  ///
  /// In en, this message translates to:
  /// **'Set Monthly Limit'**
  String get setMonthlyLimit;

  /// No description provided for @setBudget.
  ///
  /// In en, this message translates to:
  /// **'Set Budget'**
  String get setBudget;

  /// No description provided for @categoryBudgets.
  ///
  /// In en, this message translates to:
  /// **'Category Budgets'**
  String get categoryBudgets;

  /// No description provided for @noCategoryBudgets.
  ///
  /// In en, this message translates to:
  /// **'No category budgets created yet.'**
  String get noCategoryBudgets;

  /// No description provided for @spendingBreakdown.
  ///
  /// In en, this message translates to:
  /// **'Spending Breakdown'**
  String get spendingBreakdown;

  /// No description provided for @weeklySpendingVelocity.
  ///
  /// In en, this message translates to:
  /// **'Weekly Spending Velocity'**
  String get weeklySpendingVelocity;

  /// No description provided for @noSpendingData.
  ///
  /// In en, this message translates to:
  /// **'No spending recorded this period'**
  String get noSpendingData;

  /// No description provided for @highestCategory.
  ///
  /// In en, this message translates to:
  /// **'Highest Category'**
  String get highestCategory;

  /// No description provided for @financialAnalytics.
  ///
  /// In en, this message translates to:
  /// **'Financial Analytics'**
  String get financialAnalytics;

  /// No description provided for @savingsGoals.
  ///
  /// In en, this message translates to:
  /// **'Savings Targets'**
  String get savingsGoals;

  /// No description provided for @newGoal.
  ///
  /// In en, this message translates to:
  /// **'New Goal'**
  String get newGoal;

  /// No description provided for @targetAmount.
  ///
  /// In en, this message translates to:
  /// **'Target Amount'**
  String get targetAmount;

  /// No description provided for @currentSavings.
  ///
  /// In en, this message translates to:
  /// **'Saved So Far'**
  String get currentSavings;

  /// No description provided for @recurringSubscriptions.
  ///
  /// In en, this message translates to:
  /// **'Recurring Subscriptions'**
  String get recurringSubscriptions;

  /// No description provided for @newSubscription.
  ///
  /// In en, this message translates to:
  /// **'Add Subscription'**
  String get newSubscription;

  /// No description provided for @monthlyBurnRate.
  ///
  /// In en, this message translates to:
  /// **'Monthly Burn Rate'**
  String get monthlyBurnRate;

  /// No description provided for @annualBurnRate.
  ///
  /// In en, this message translates to:
  /// **'Annual Burn Rate'**
  String get annualBurnRate;

  /// No description provided for @activeSubscriptions.
  ///
  /// In en, this message translates to:
  /// **'Active Subscriptions'**
  String get activeSubscriptions;

  /// No description provided for @renewsOn.
  ///
  /// In en, this message translates to:
  /// **'Renews on day {day}'**
  String renewsOn(int day);

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings & Privacy'**
  String get settings;

  /// No description provided for @preferences.
  ///
  /// In en, this message translates to:
  /// **'PREFERENCES'**
  String get preferences;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @languageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose your preferred language'**
  String get languageSubtitle;

  /// No description provided for @systemDefault.
  ///
  /// In en, this message translates to:
  /// **'System Default'**
  String get systemDefault;

  /// No description provided for @currency.
  ///
  /// In en, this message translates to:
  /// **'Primary Currency'**
  String get currency;

  /// No description provided for @currencySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Display currency for all figures'**
  String get currencySubtitle;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Theme & Appearance'**
  String get appearance;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Clean Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Midnight Dark'**
  String get themeDark;

  /// No description provided for @themeOled.
  ///
  /// In en, this message translates to:
  /// **'Pure OLED Black'**
  String get themeOled;

  /// No description provided for @dataPortability.
  ///
  /// In en, this message translates to:
  /// **'DATA PORTABILITY & BACKUP'**
  String get dataPortability;

  /// No description provided for @backupData.
  ///
  /// In en, this message translates to:
  /// **'Export Complete Backup (JSON)'**
  String get backupData;

  /// No description provided for @backupSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Export all transactions, goals, and budgets'**
  String get backupSubtitle;

  /// No description provided for @restoreData.
  ///
  /// In en, this message translates to:
  /// **'Restore from Backup (JSON)'**
  String get restoreData;

  /// No description provided for @restoreSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Restore data from a saved Monetra JSON file'**
  String get restoreSubtitle;

  /// No description provided for @seedSampleData.
  ///
  /// In en, this message translates to:
  /// **'Seed Sample FinTech Data'**
  String get seedSampleData;

  /// No description provided for @seedSampleSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Populates sample income, bills, and goals'**
  String get seedSampleSubtitle;

  /// No description provided for @sampleDataLoaded.
  ///
  /// In en, this message translates to:
  /// **'Sample data loaded successfully!'**
  String get sampleDataLoaded;

  /// No description provided for @security.
  ///
  /// In en, this message translates to:
  /// **'SECURITY & PRIVACY'**
  String get security;

  /// No description provided for @biometricLock.
  ///
  /// In en, this message translates to:
  /// **'Require Biometric Lock'**
  String get biometricLock;

  /// No description provided for @biometricSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Face ID, Fingerprint, or Device Passcode'**
  String get biometricSubtitle;

  /// No description provided for @biometricPrompt.
  ///
  /// In en, this message translates to:
  /// **'Please authenticate to access Monetra'**
  String get biometricPrompt;

  /// No description provided for @dataSovereignty.
  ///
  /// In en, this message translates to:
  /// **'100% Offline & Private'**
  String get dataSovereignty;

  /// No description provided for @dataSovereigntySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your financial data is stored exclusively on your device.'**
  String get dataSovereigntySubtitle;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @catHousing.
  ///
  /// In en, this message translates to:
  /// **'Housing & Rent'**
  String get catHousing;

  /// No description provided for @catFood.
  ///
  /// In en, this message translates to:
  /// **'Food & Groceries'**
  String get catFood;

  /// No description provided for @catTransport.
  ///
  /// In en, this message translates to:
  /// **'Transportation'**
  String get catTransport;

  /// No description provided for @catShopping.
  ///
  /// In en, this message translates to:
  /// **'Shopping'**
  String get catShopping;

  /// No description provided for @catEntertainment.
  ///
  /// In en, this message translates to:
  /// **'Entertainment'**
  String get catEntertainment;

  /// No description provided for @catHealth.
  ///
  /// In en, this message translates to:
  /// **'Health & Medical'**
  String get catHealth;

  /// No description provided for @catEducation.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get catEducation;

  /// No description provided for @catTravel.
  ///
  /// In en, this message translates to:
  /// **'Travel & Vacations'**
  String get catTravel;

  /// No description provided for @catBills.
  ///
  /// In en, this message translates to:
  /// **'Bills & Utilities'**
  String get catBills;

  /// No description provided for @catSubscriptions.
  ///
  /// In en, this message translates to:
  /// **'Subscriptions'**
  String get catSubscriptions;

  /// No description provided for @catPersonalCare.
  ///
  /// In en, this message translates to:
  /// **'Personal Care'**
  String get catPersonalCare;

  /// No description provided for @catSavingsTransfers.
  ///
  /// In en, this message translates to:
  /// **'Savings & Transfers'**
  String get catSavingsTransfers;

  /// No description provided for @catOtherExpense.
  ///
  /// In en, this message translates to:
  /// **'Other Expenses'**
  String get catOtherExpense;

  /// No description provided for @catSalary.
  ///
  /// In en, this message translates to:
  /// **'Salary & Wages'**
  String get catSalary;

  /// No description provided for @catFreelance.
  ///
  /// In en, this message translates to:
  /// **'Freelance & Business'**
  String get catFreelance;

  /// No description provided for @catInvestments.
  ///
  /// In en, this message translates to:
  /// **'Investments & Dividends'**
  String get catInvestments;

  /// No description provided for @catGifts.
  ///
  /// In en, this message translates to:
  /// **'Gifts & Grants'**
  String get catGifts;

  /// No description provided for @catOtherIncome.
  ///
  /// In en, this message translates to:
  /// **'Other Income'**
  String get catOtherIncome;

  /// No description provided for @catOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get catOther;

  /// No description provided for @welcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'See your money differently'**
  String get welcomeTitle;

  /// No description provided for @welcomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Visual, intelligent, and 100% private personal finance.'**
  String get welcomeSubtitle;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @slide1Title.
  ///
  /// In en, this message translates to:
  /// **'Safe to Spend Today'**
  String get slide1Title;

  /// No description provided for @slide1Desc.
  ///
  /// In en, this message translates to:
  /// **'Never wonder if you can afford lunch. Get a live daily discretionary budget that protects your bills.'**
  String get slide1Desc;

  /// No description provided for @slide2Title.
  ///
  /// In en, this message translates to:
  /// **'Zero Clutter, Pure Clarity'**
  String get slide2Title;

  /// No description provided for @slide2Desc.
  ///
  /// In en, this message translates to:
  /// **'Visual rings, category donuts, and instant spending velocity without spreadsheet chaos.'**
  String get slide2Desc;

  /// No description provided for @slide3Title.
  ///
  /// In en, this message translates to:
  /// **'100% Offline & Sovereignty'**
  String get slide3Title;

  /// No description provided for @slide3Desc.
  ///
  /// In en, this message translates to:
  /// **'No bank logins required. Your financial records live encrypted exclusively on your phone.'**
  String get slide3Desc;

  /// No description provided for @selectCurrencyTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Your Main Currency'**
  String get selectCurrencyTitle;

  /// No description provided for @startExploring.
  ///
  /// In en, this message translates to:
  /// **'Launch Monetra'**
  String get startExploring;

  /// No description provided for @period7Days.
  ///
  /// In en, this message translates to:
  /// **'7 Days'**
  String get period7Days;

  /// No description provided for @period30Days.
  ///
  /// In en, this message translates to:
  /// **'30 Days'**
  String get period30Days;

  /// No description provided for @period3Months.
  ///
  /// In en, this message translates to:
  /// **'3 Months'**
  String get period3Months;

  /// No description provided for @periodAllTime.
  ///
  /// In en, this message translates to:
  /// **'All Time'**
  String get periodAllTime;

  /// No description provided for @period7DaysTitle.
  ///
  /// In en, this message translates to:
  /// **'7-Day Spending Velocity'**
  String get period7DaysTitle;

  /// No description provided for @period30DaysTitle.
  ///
  /// In en, this message translates to:
  /// **'30-Day Spending Trend'**
  String get period30DaysTitle;

  /// No description provided for @period3MonthsTitle.
  ///
  /// In en, this message translates to:
  /// **'3-Month Spending Comparison'**
  String get period3MonthsTitle;

  /// No description provided for @periodAllTimeTitle.
  ///
  /// In en, this message translates to:
  /// **'Monthly Spending Evolution'**
  String get periodAllTimeTitle;

  /// No description provided for @incomeVsExpenses.
  ///
  /// In en, this message translates to:
  /// **'Income vs Expenses'**
  String get incomeVsExpenses;

  /// No description provided for @inflow.
  ///
  /// In en, this message translates to:
  /// **'Inflow'**
  String get inflow;

  /// No description provided for @outflow.
  ///
  /// In en, this message translates to:
  /// **'Outflow'**
  String get outflow;

  /// No description provided for @netBalance.
  ///
  /// In en, this message translates to:
  /// **'Net Balance'**
  String get netBalance;

  /// No description provided for @spendingDistribution.
  ///
  /// In en, this message translates to:
  /// **'Spending Distribution'**
  String get spendingDistribution;

  /// No description provided for @categoryBreakdown.
  ///
  /// In en, this message translates to:
  /// **'Category Breakdown'**
  String get categoryBreakdown;

  /// No description provided for @noTransactionsTimeframe.
  ///
  /// In en, this message translates to:
  /// **'No transactions in this timeframe.'**
  String get noTransactionsTimeframe;

  /// No description provided for @pctOfTotalSpending.
  ///
  /// In en, this message translates to:
  /// **'{percent}% of total spending'**
  String pctOfTotalSpending(String percent);

  /// No description provided for @activeTargetsCount.
  ///
  /// In en, this message translates to:
  /// **'Active Targets ({count})'**
  String activeTargetsCount(int count);

  /// No description provided for @noSavingsGoals.
  ///
  /// In en, this message translates to:
  /// **'No savings goals yet. Create one to stay motivated!'**
  String get noSavingsGoals;

  /// No description provided for @targetLabel.
  ///
  /// In en, this message translates to:
  /// **'Target: {amount}'**
  String targetLabel(String amount);

  /// No description provided for @savedLabel.
  ///
  /// In en, this message translates to:
  /// **'Saved: {amount}'**
  String savedLabel(String amount);

  /// No description provided for @addFunds.
  ///
  /// In en, this message translates to:
  /// **'Add Funds'**
  String get addFunds;

  /// No description provided for @contributeTo.
  ///
  /// In en, this message translates to:
  /// **'Contribute to \"{name}\"'**
  String contributeTo(String name);

  /// No description provided for @contributionAmount.
  ///
  /// In en, this message translates to:
  /// **'Contribution Amount'**
  String get contributionAmount;

  /// No description provided for @depositedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Deposited {amount} to {name}!'**
  String depositedSuccess(String amount, String name);

  /// No description provided for @createSavingsGoal.
  ///
  /// In en, this message translates to:
  /// **'Create Savings Goal'**
  String get createSavingsGoal;

  /// No description provided for @goalNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Goal Name (e.g. New Laptop)'**
  String get goalNameLabel;

  /// No description provided for @targetAmountLabel.
  ///
  /// In en, this message translates to:
  /// **'Target Amount'**
  String get targetAmountLabel;

  /// No description provided for @targetDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Target Date'**
  String get targetDateLabel;

  /// No description provided for @createGoal.
  ///
  /// In en, this message translates to:
  /// **'Create Goal'**
  String get createGoal;

  /// No description provided for @monthlyCommitment.
  ///
  /// In en, this message translates to:
  /// **'Monthly Commitment'**
  String get monthlyCommitment;

  /// No description provided for @annualProjection.
  ///
  /// In en, this message translates to:
  /// **'Annual Projection'**
  String get annualProjection;

  /// No description provided for @subscriptionsAndBillsCount.
  ///
  /// In en, this message translates to:
  /// **'Subscriptions & Bills ({count})'**
  String subscriptionsAndBillsCount(int count);

  /// No description provided for @addBill.
  ///
  /// In en, this message translates to:
  /// **'Add Bill'**
  String get addBill;

  /// No description provided for @noSubscriptionsYet.
  ///
  /// In en, this message translates to:
  /// **'No recurring subscriptions added yet.'**
  String get noSubscriptionsYet;

  /// No description provided for @chooseAppearance.
  ///
  /// In en, this message translates to:
  /// **'Choose Appearance'**
  String get chooseAppearance;

  /// No description provided for @restoreBackupTitle.
  ///
  /// In en, this message translates to:
  /// **'Restore Backup?'**
  String get restoreBackupTitle;

  /// No description provided for @restoreBackupConfirm.
  ///
  /// In en, this message translates to:
  /// **'Restoring this backup will replace current transactions, budgets, and savings goals with the saved data. Proceed?'**
  String get restoreBackupConfirm;

  /// No description provided for @restoreDataBtn.
  ///
  /// In en, this message translates to:
  /// **'Restore Data'**
  String get restoreDataBtn;

  /// No description provided for @backupExportError.
  ///
  /// In en, this message translates to:
  /// **'Backup export error: {error}'**
  String backupExportError(String error);

  /// No description provided for @backupInvalidFormat.
  ///
  /// In en, this message translates to:
  /// **'Invalid Monetra backup format.'**
  String get backupInvalidFormat;

  /// No description provided for @restoreBackupError.
  ///
  /// In en, this message translates to:
  /// **'Error restoring backup: {error}'**
  String restoreBackupError(String error);

  /// No description provided for @biometricsNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Biometrics not available on this device'**
  String get biometricsNotAvailable;

  /// No description provided for @biometricsFailed.
  ///
  /// In en, this message translates to:
  /// **'Biometric authentication failed: {error}'**
  String biometricsFailed(String error);

  /// No description provided for @commitmentsUpToDate.
  ///
  /// In en, this message translates to:
  /// **'All financial commitments are up to date!'**
  String get commitmentsUpToDate;

  /// No description provided for @addSubscriptionTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Recurring Bill / Subscription'**
  String get addSubscriptionTitle;

  /// No description provided for @serviceNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Service Name (e.g. Netflix, Gym)'**
  String get serviceNameLabel;

  /// No description provided for @amountPerCycleLabel.
  ///
  /// In en, this message translates to:
  /// **'Amount per Cycle'**
  String get amountPerCycleLabel;

  /// No description provided for @billingFrequencyLabel.
  ///
  /// In en, this message translates to:
  /// **'Billing Frequency'**
  String get billingFrequencyLabel;

  /// No description provided for @billingMonthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get billingMonthly;

  /// No description provided for @billingWeekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get billingWeekly;

  /// No description provided for @billingQuarterly.
  ///
  /// In en, this message translates to:
  /// **'Quarterly'**
  String get billingQuarterly;

  /// No description provided for @billingYearly.
  ///
  /// In en, this message translates to:
  /// **'Yearly'**
  String get billingYearly;

  /// No description provided for @saveSubscription.
  ///
  /// In en, this message translates to:
  /// **'Save Subscription'**
  String get saveSubscription;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @txSampleSalary.
  ///
  /// In en, this message translates to:
  /// **'Monthly Salary Deposit'**
  String get txSampleSalary;

  /// No description provided for @txSampleRent.
  ///
  /// In en, this message translates to:
  /// **'Apartment Rent'**
  String get txSampleRent;

  /// No description provided for @txSampleGroceries.
  ///
  /// In en, this message translates to:
  /// **'Food & Groceries Market'**
  String get txSampleGroceries;

  /// No description provided for @txSampleTransport.
  ///
  /// In en, this message translates to:
  /// **'Metro Pass & Fuel'**
  String get txSampleTransport;

  /// No description provided for @txSampleEntertainment.
  ///
  /// In en, this message translates to:
  /// **'Weekend Cinema & Dinner'**
  String get txSampleEntertainment;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'de',
    'en',
    'es',
    'fr',
    'pt',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
