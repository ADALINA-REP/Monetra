import 'package:uuid/uuid.dart';
import '../database/app_database.dart';
import '../models/budget_model.dart';
import '../models/category_model.dart';
import '../models/savings_goal_model.dart';
import '../models/subscription_model.dart';
import '../models/transaction_model.dart';

class FinanceRepository {
  final AppDatabase _db = AppDatabase.instance;
  final _uuid = const Uuid();

  Future<List<TransactionModel>> getTransactions() => _db.getAllTransactions();

  Future<void> addTransaction({
    required int amountCents,
    required TransactionType type,
    required String categoryId,
    required String title,
    required DateTime date,
    String? notes,
    bool isRecurring = false,
  }) async {
    final tx = TransactionModel(
      id: _uuid.v4(),
      amountCents: amountCents,
      type: type,
      categoryId: categoryId,
      title: title,
      date: date,
      notes: notes,
      isRecurring: isRecurring,
    );
    await _db.insertTransaction(tx);
  }

  Future<void> updateTransaction(TransactionModel tx) => _db.updateTransaction(tx);

  Future<void> deleteTransaction(String id) => _db.deleteTransaction(id);

  Future<List<CategoryModel>> getCategories() => _db.getAllCategories();

  Future<List<BudgetModel>> getBudgets(String periodMonth) => _db.getBudgets(periodMonth);

  Future<void> setBudget({
    String? categoryId,
    required String name,
    required int limitCents,
    required String periodMonth,
    bool carryOver = false,
  }) async {
    final budget = BudgetModel(
      id: _uuid.v4(),
      categoryId: categoryId,
      name: name,
      limitCents: limitCents,
      periodMonth: periodMonth,
      carryOver: carryOver,
    );
    await _db.saveBudget(budget);
  }

  Future<void> deleteBudget(String id) => _db.deleteBudget(id);

  Future<List<SavingsGoalModel>> getSavingsGoals() => _db.getAllSavingsGoals();

  Future<void> addSavingsGoal({
    required String name,
    required int targetAmountCents,
    required DateTime targetDate,
    required int iconCode,
    required int colorHex,
    String? notes,
  }) async {
    final goal = SavingsGoalModel(
      id: _uuid.v4(),
      name: name,
      targetAmountCents: targetAmountCents,
      currentAmountCents: 0,
      targetDate: targetDate,
      iconCode: iconCode,
      colorHex: colorHex,
      notes: notes,
    );
    await _db.saveSavingsGoal(goal);
  }

  Future<void> contributeToGoal(String id, int amountCents) => _db.updateGoalContribution(id, amountCents);

  Future<void> deleteSavingsGoal(String id) => _db.deleteSavingsGoal(id);

  Future<List<SubscriptionModel>> getSubscriptions() => _db.getAllSubscriptions();

  Future<void> addSubscription({
    required String name,
    required int amountCents,
    required BillingCycle billingCycle,
    required DateTime nextBillingDate,
    required String categoryId,
    required int iconCode,
    required int colorHex,
  }) async {
    final sub = SubscriptionModel(
      id: _uuid.v4(),
      name: name,
      amountCents: amountCents,
      billingCycle: billingCycle,
      nextBillingDate: nextBillingDate,
      categoryId: categoryId,
      iconCode: iconCode,
      colorHex: colorHex,
    );
    await _db.saveSubscription(sub);
  }

  Future<void> deleteSubscription(String id) => _db.deleteSubscription(id);

  Future<String> getCurrency() async {
    return await _db.getSetting('currency') ?? 'USD';
  }

  Future<void> setCurrency(String code) => _db.setSetting('currency', code);

  Future<String?> getLocaleCode() async {
    final val = await _db.getSetting('app_locale');
    if (val == null || val.isEmpty) return null;
    return val;
  }

  Future<void> setLocaleCode(String? code) => _db.setSetting('app_locale', code ?? '');

  Future<bool> isOnboardingComplete() async {
    final val = await _db.getSetting('onboarding_complete');
    return val == 'true';
  }

  Future<void> setOnboardingComplete(bool complete) =>
      _db.setSetting('onboarding_complete', complete ? 'true' : 'false');

  Future<int> getMonthlyIncomeCents() async {
    final val = await _db.getSetting('monthly_income_cents');
    return int.tryParse(val ?? '450000') ?? 450000;
  }

  Future<void> setMonthlyIncomeCents(int cents) =>
      _db.setSetting('monthly_income_cents', cents.toString());

  Future<bool> getBiometricEnabled() async {
    final val = await _db.getSetting('biometric_enabled');
    return val == 'true';
  }

  Future<void> setBiometricEnabled(bool enabled) =>
      _db.setSetting('biometric_enabled', enabled ? 'true' : 'false');

  Future<Map<String, dynamic>> exportData() => _db.exportAllData();

  Future<void> restoreData(Map<String, dynamic> data) => _db.restoreAllData(data);

  /// Seeds realistic initial sample data spanning past months and current cycle
  Future<void> seedInitialData({bool force = false}) async {
    final existing = await _db.getAllTransactions();
    final isOldBasicSeed = existing.length <= 6 &&
        existing.every((t) =>
            t.title == 'Monthly Salary Deposit' ||
            t.title == 'Apartment Rent' ||
            t.title == 'Whole Foods Market' ||
            t.title == 'Metro Pass & Fuel' ||
            t.title == 'Weekend Cinema & Dinner');

    if (existing.isNotEmpty && !force && !isOldBasicSeed) return;

    if (force || isOldBasicSeed) {
      await _db.clearSampleData();
    }

    final now = DateTime.now();

    // --- RECENT 7 DAYS (CURRENT WEEK) ---
    await addTransaction(
      amountCents: 450000,
      type: TransactionType.income,
      categoryId: 'salary',
      title: 'Monthly Salary Deposit',
      date: now.subtract(const Duration(days: 1)),
    );
    await addTransaction(
      amountCents: 140000,
      type: TransactionType.expense,
      categoryId: 'housing',
      title: 'Apartment Rent',
      date: now.subtract(const Duration(days: 1)),
    );
    await addTransaction(
      amountCents: 8550,
      type: TransactionType.expense,
      categoryId: 'food',
      title: 'Whole Foods Market',
      date: now.subtract(const Duration(days: 2)),
    );
    await addTransaction(
      amountCents: 4500,
      type: TransactionType.expense,
      categoryId: 'transport',
      title: 'Metro Pass & Fuel',
      date: now.subtract(const Duration(days: 3)),
    );
    await addTransaction(
      amountCents: 6400,
      type: TransactionType.expense,
      categoryId: 'entertainment',
      title: 'Weekend Cinema & Dinner',
      date: now.subtract(const Duration(days: 5)),
    );
    await addTransaction(
      amountCents: 3850,
      type: TransactionType.expense,
      categoryId: 'food',
      title: 'Food & Groceries Market',
      date: now.subtract(const Duration(days: 6)),
    );

    // --- PAST 30 DAYS (8 to 29 days ago) ---
    await addTransaction(
      amountCents: 95000,
      type: TransactionType.income,
      categoryId: 'freelance',
      title: 'Freelance & Business',
      date: now.subtract(const Duration(days: 11)),
    );
    await addTransaction(
      amountCents: 13500,
      type: TransactionType.expense,
      categoryId: 'food',
      title: 'Food & Groceries',
      date: now.subtract(const Duration(days: 13)),
    );
    await addTransaction(
      amountCents: 14900,
      type: TransactionType.expense,
      categoryId: 'shopping',
      title: 'Shopping',
      date: now.subtract(const Duration(days: 17)),
    );
    await addTransaction(
      amountCents: 4250,
      type: TransactionType.expense,
      categoryId: 'health',
      title: 'Health & Medical',
      date: now.subtract(const Duration(days: 21)),
    );
    await addTransaction(
      amountCents: 6500,
      type: TransactionType.expense,
      categoryId: 'bills',
      title: 'Utilities & Bills',
      date: now.subtract(const Duration(days: 25)),
    );
    await addTransaction(
      amountCents: 11000,
      type: TransactionType.expense,
      categoryId: 'shopping',
      title: 'Shopping',
      date: now.subtract(const Duration(days: 28)),
    );

    // --- PREVIOUS MONTH (31 to 60 days ago) ---
    final month1 = now.subtract(const Duration(days: 35));
    await addTransaction(
      amountCents: 450000,
      type: TransactionType.income,
      categoryId: 'salary',
      title: 'Monthly Salary Deposit',
      date: DateTime(month1.year, month1.month, 1),
    );
    await addTransaction(
      amountCents: 140000,
      type: TransactionType.expense,
      categoryId: 'housing',
      title: 'Apartment Rent',
      date: DateTime(month1.year, month1.month, 2),
    );
    await addTransaction(
      amountCents: 28000,
      type: TransactionType.expense,
      categoryId: 'food',
      title: 'Food & Groceries',
      date: DateTime(month1.year, month1.month, 8),
    );
    await addTransaction(
      amountCents: 9500,
      type: TransactionType.expense,
      categoryId: 'transport',
      title: 'Transportation',
      date: DateTime(month1.year, month1.month, 14),
    );
    await addTransaction(
      amountCents: 12000,
      type: TransactionType.expense,
      categoryId: 'entertainment',
      title: 'Entertainment',
      date: DateTime(month1.year, month1.month, 18),
    );
    await addTransaction(
      amountCents: 8500,
      type: TransactionType.expense,
      categoryId: 'bills',
      title: 'Utilities & Bills',
      date: DateTime(month1.year, month1.month, 23),
    );

    // --- TWO MONTHS AGO (61 to 90 days ago) ---
    final month2 = now.subtract(const Duration(days: 68));
    await addTransaction(
      amountCents: 450000,
      type: TransactionType.income,
      categoryId: 'salary',
      title: 'Monthly Salary Deposit',
      date: DateTime(month2.year, month2.month, 1),
    );
    await addTransaction(
      amountCents: 140000,
      type: TransactionType.expense,
      categoryId: 'housing',
      title: 'Apartment Rent',
      date: DateTime(month2.year, month2.month, 2),
    );
    await addTransaction(
      amountCents: 26500,
      type: TransactionType.expense,
      categoryId: 'food',
      title: 'Food & Groceries',
      date: DateTime(month2.year, month2.month, 7),
    );
    await addTransaction(
      amountCents: 34000,
      type: TransactionType.expense,
      categoryId: 'travel',
      title: 'Travel & Vacation',
      date: DateTime(month2.year, month2.month, 16),
    );
    await addTransaction(
      amountCents: 11500,
      type: TransactionType.expense,
      categoryId: 'health',
      title: 'Health & Medical',
      date: DateTime(month2.year, month2.month, 22),
    );
    await addTransaction(
      amountCents: 7500,
      type: TransactionType.expense,
      categoryId: 'shopping',
      title: 'Shopping',
      date: DateTime(month2.year, month2.month, 27),
    );

    // --- THREE MONTHS AGO (91 to 120 days ago, for All History) ---
    final month3 = now.subtract(const Duration(days: 98));
    await addTransaction(
      amountCents: 450000,
      type: TransactionType.income,
      categoryId: 'salary',
      title: 'Monthly Salary Deposit',
      date: DateTime(month3.year, month3.month, 1),
    );
    await addTransaction(
      amountCents: 140000,
      type: TransactionType.expense,
      categoryId: 'housing',
      title: 'Apartment Rent',
      date: DateTime(month3.year, month3.month, 2),
    );
    await addTransaction(
      amountCents: 25000,
      type: TransactionType.expense,
      categoryId: 'food',
      title: 'Food & Groceries',
      date: DateTime(month3.year, month3.month, 10),
    );
    await addTransaction(
      amountCents: 52000,
      type: TransactionType.expense,
      categoryId: 'travel',
      title: 'Travel & Vacation',
      date: DateTime(month3.year, month3.month, 18),
    );
    await addTransaction(
      amountCents: 120000,
      type: TransactionType.income,
      categoryId: 'freelance',
      title: 'Freelance & Business',
      date: DateTime(month3.year, month3.month, 24),
    );

    // Set overall budget
    final periodMonth = '${now.year}-${now.month.toString().padLeft(2, '0')}';
    await setBudget(
      name: 'Total Monthly Spending',
      limitCents: 320000,
      periodMonth: periodMonth,
    );

    // Set sample Subscriptions
    await addSubscription(
      name: 'Netflix 4K',
      amountCents: 1999,
      billingCycle: BillingCycle.monthly,
      nextBillingDate: DateTime(now.year, now.month, 18),
      categoryId: 'subscriptions',
      iconCode: 0xe62e, // Icons.movie
      colorHex: 0xFFEF4444,
    );

    await addSubscription(
      name: 'Spotify Family',
      amountCents: 1699,
      billingCycle: BillingCycle.monthly,
      nextBillingDate: DateTime(now.year, now.month, 22),
      categoryId: 'subscriptions',
      iconCode: 0xe405, // Icons.music_note
      colorHex: 0xFF10B981,
    );

    await addSubscription(
      name: 'High-Speed Fiber Internet',
      amountCents: 6500,
      billingCycle: BillingCycle.monthly,
      nextBillingDate: DateTime(now.year, now.month, 28),
      categoryId: 'bills',
      iconCode: 0xe6df, // Icons.wifi
      colorHex: 0xFF3B82F6,
    );

    // Set sample Savings Goals
    await addSavingsGoal(
      name: 'Emergency Fund',
      targetAmountCents: 1000000,
      targetDate: DateTime(now.year + 1, now.month, 1),
      iconCode: 0xe5b2, // Icons.shield_rounded
      colorHex: 0xFF16A36A,
      notes: '6 months of living expenses reserve',
    );
    final goals = await getSavingsGoals();
    if (goals.isNotEmpty) {
      await contributeToGoal(goals.first.id, 450000);
    }

    await addSavingsGoal(
      name: 'Tokyo Trip',
      targetAmountCents: 350000,
      targetDate: DateTime(now.year, now.month + 6, 15),
      iconCode: 0xe29b, // Icons.flight
      colorHex: 0xFF06B6D4,
      notes: 'Flights and accommodation for 2 weeks in Japan',
    );
    if (goals.length > 1) {
      await contributeToGoal(goals[1].id, 120000);
    }
  }
}
