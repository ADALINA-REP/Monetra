import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/utils/financial_calculator.dart';
import '../../data/models/budget_model.dart';
import '../../data/models/category_model.dart';
import '../../data/models/financial_insight_model.dart';
import '../../data/models/savings_goal_model.dart';
import '../../data/models/subscription_model.dart';
import '../../data/models/transaction_model.dart';
import '../../data/repositories/finance_repository.dart';

final financeRepositoryProvider = Provider<FinanceRepository>((ref) {
  return FinanceRepository();
});

// --- Currency Provider ---
class CurrencyNotifier extends StateNotifier<String> {
  final FinanceRepository _repo;
  CurrencyNotifier(this._repo) : super('USD') {
    _load();
  }

  Future<void> _load() async {
    state = await _repo.getCurrency();
  }

  Future<void> setCurrency(String code) async {
    state = code;
    await _repo.setCurrency(code);
  }
}

final currencyProvider = StateNotifierProvider<CurrencyNotifier, String>((ref) {
  final repo = ref.watch(financeRepositoryProvider);
  return CurrencyNotifier(repo);
});

// --- Locale Provider ---
class LocaleNotifier extends StateNotifier<Locale?> {
  final FinanceRepository _repo;
  LocaleNotifier(this._repo) : super(null) {
    _load();
  }

  Future<void> _load() async {
    final code = await _repo.getLocaleCode();
    if (code != null && code.isNotEmpty) {
      state = Locale(code);
    }
  }

  Future<void> setLocale(Locale? locale) async {
    state = locale;
    await _repo.setLocaleCode(locale?.languageCode);
  }
}

final localeProvider = StateNotifierProvider<LocaleNotifier, Locale?>((ref) {
  final repo = ref.watch(financeRepositoryProvider);
  return LocaleNotifier(repo);
});

// --- Theme Mode Provider ---
class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier() : super(ThemeMode.system);

  void setThemeMode(ThemeMode mode) {
    state = mode;
  }
}

final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) {
  return ThemeModeNotifier();
});

// --- Biometric Lock Provider ---
class BiometricLockNotifier extends StateNotifier<bool> {
  final FinanceRepository _repo;
  BiometricLockNotifier(this._repo) : super(false) {
    _load();
  }

  Future<void> _load() async {
    state = await _repo.getBiometricEnabled();
  }

  Future<void> setEnabled(bool enabled) async {
    state = enabled;
    await _repo.setBiometricEnabled(enabled);
  }
}

final biometricLockProvider = StateNotifierProvider<BiometricLockNotifier, bool>((ref) {
  final repo = ref.watch(financeRepositoryProvider);
  return BiometricLockNotifier(repo);
});

// --- Categories Provider ---
final categoriesProvider = FutureProvider<List<CategoryModel>>((ref) async {
  final repo = ref.watch(financeRepositoryProvider);
  return await repo.getCategories();
});

// --- Transactions Notifier ---
class TransactionsNotifier extends StateNotifier<AsyncValue<List<TransactionModel>>> {
  final FinanceRepository _repo;
  TransactionsNotifier(this._repo) : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    try {
      final list = await _repo.getTransactions();
      state = AsyncValue.data(list);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addTransaction({
    required int amountCents,
    required TransactionType type,
    required String categoryId,
    required String title,
    required DateTime date,
    String? notes,
  }) async {
    await _repo.addTransaction(
      amountCents: amountCents,
      type: type,
      categoryId: categoryId,
      title: title,
      date: date,
      notes: notes,
    );
    await refresh();
  }

  Future<void> updateTransaction(TransactionModel tx) async {
    await _repo.updateTransaction(tx);
    await refresh();
  }

  Future<void> deleteTransaction(String id) async {
    await _repo.deleteTransaction(id);
    await refresh();
  }
}

final transactionsProvider =
    StateNotifierProvider<TransactionsNotifier, AsyncValue<List<TransactionModel>>>((ref) {
  final repo = ref.watch(financeRepositoryProvider);
  return TransactionsNotifier(repo);
});

// --- Budgets Notifier ---
class BudgetsNotifier extends StateNotifier<AsyncValue<List<BudgetModel>>> {
  final FinanceRepository _repo;
  final String _currentPeriod;

  BudgetsNotifier(this._repo, this._currentPeriod) : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    try {
      final list = await _repo.getBudgets(_currentPeriod);
      state = AsyncValue.data(list);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> setBudget({
    String? categoryId,
    required String name,
    required int limitCents,
    bool carryOver = false,
  }) async {
    await _repo.setBudget(
      categoryId: categoryId,
      name: name,
      limitCents: limitCents,
      periodMonth: _currentPeriod,
      carryOver: carryOver,
    );
    await refresh();
  }

  Future<void> deleteBudget(String id) async {
    await _repo.deleteBudget(id);
    await refresh();
  }
}

final currentPeriodProvider = Provider<String>((ref) {
  final now = DateTime.now();
  return '${now.year}-${now.month.toString().padLeft(2, '0')}';
});

final budgetsProvider = StateNotifierProvider<BudgetsNotifier, AsyncValue<List<BudgetModel>>>((ref) {
  final repo = ref.watch(financeRepositoryProvider);
  final period = ref.watch(currentPeriodProvider);
  return BudgetsNotifier(repo, period);
});

// --- Savings Goals Notifier ---
class SavingsGoalsNotifier extends StateNotifier<AsyncValue<List<SavingsGoalModel>>> {
  final FinanceRepository _repo;
  SavingsGoalsNotifier(this._repo) : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    try {
      final list = await _repo.getSavingsGoals();
      state = AsyncValue.data(list);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addGoal({
    required String name,
    required int targetAmountCents,
    required DateTime targetDate,
    required int iconCode,
    required int colorHex,
    String? notes,
  }) async {
    await _repo.addSavingsGoal(
      name: name,
      targetAmountCents: targetAmountCents,
      targetDate: targetDate,
      iconCode: iconCode,
      colorHex: colorHex,
      notes: notes,
    );
    await refresh();
  }

  Future<void> contribute(String id, int amountCents) async {
    await _repo.contributeToGoal(id, amountCents);
    await refresh();
  }

  Future<void> deleteGoal(String id) async {
    await _repo.deleteSavingsGoal(id);
    await refresh();
  }
}

final savingsGoalsProvider =
    StateNotifierProvider<SavingsGoalsNotifier, AsyncValue<List<SavingsGoalModel>>>((ref) {
  final repo = ref.watch(financeRepositoryProvider);
  return SavingsGoalsNotifier(repo);
});

// --- Subscriptions Notifier ---
class SubscriptionsNotifier extends StateNotifier<AsyncValue<List<SubscriptionModel>>> {
  final FinanceRepository _repo;
  SubscriptionsNotifier(this._repo) : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    try {
      final list = await _repo.getSubscriptions();
      state = AsyncValue.data(list);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addSubscription({
    required String name,
    required int amountCents,
    required BillingCycle billingCycle,
    required DateTime nextBillingDate,
    required String categoryId,
    required int iconCode,
    required int colorHex,
  }) async {
    await _repo.addSubscription(
      name: name,
      amountCents: amountCents,
      billingCycle: billingCycle,
      nextBillingDate: nextBillingDate,
      categoryId: categoryId,
      iconCode: iconCode,
      colorHex: colorHex,
    );
    await refresh();
  }

  Future<void> deleteSubscription(String id) async {
    await _repo.deleteSubscription(id);
    await refresh();
  }
}

final subscriptionsProvider =
    StateNotifierProvider<SubscriptionsNotifier, AsyncValue<List<SubscriptionModel>>>((ref) {
  final repo = ref.watch(financeRepositoryProvider);
  return SubscriptionsNotifier(repo);
});

// --- Deterministic Dashboard Metrics Provider ---
final dashboardMetricsProvider = Provider<FinancialMetrics?>((ref) {
  final txAsync = ref.watch(transactionsProvider);
  final budgetAsync = ref.watch(budgetsProvider);
  final subsAsync = ref.watch(subscriptionsProvider);

  if (txAsync is! AsyncData || budgetAsync is! AsyncData || subsAsync is! AsyncData) {
    return null;
  }

  final transactions = txAsync.value ?? [];
  final budgets = budgetAsync.value ?? [];
  final subscriptions = subsAsync.value ?? [];

  final overallBudget = budgets.firstWhere(
    (b) => b.categoryId == null,
    orElse: () => BudgetModel(
      id: 'default',
      name: 'Monthly Discretionary Budget',
      limitCents: 300000,
      periodMonth: ref.read(currentPeriodProvider),
    ),
  );

  return FinancialCalculator.calculateDashboardMetrics(
    transactions: transactions,
    overallBudget: overallBudget,
    subscriptions: subscriptions,
  );
});

// --- Deterministic Financial Insights Provider ---
final financialInsightsProvider = Provider<List<FinancialInsightModel>>((ref) {
  final metrics = ref.watch(dashboardMetricsProvider);
  final txAsync = ref.watch(transactionsProvider);
  final subsAsync = ref.watch(subscriptionsProvider);
  final catAsync = ref.watch(categoriesProvider);

  if (metrics == null ||
      txAsync is! AsyncData ||
      subsAsync is! AsyncData ||
      catAsync is! AsyncData) {
    return [];
  }

  return FinancialCalculator.generateInsights(
    metrics: metrics,
    transactions: txAsync.value ?? [],
    subscriptions: subsAsync.value ?? [],
    categories: catAsync.value ?? [],
  );
});
