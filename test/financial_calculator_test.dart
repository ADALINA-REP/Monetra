import 'package:flutter_test/flutter_test.dart';
import 'package:monetra/core/utils/currency_formatter.dart';
import 'package:monetra/core/utils/financial_calculator.dart';
import 'package:monetra/data/models/budget_model.dart';
import 'package:monetra/data/models/category_model.dart';
import 'package:monetra/data/models/subscription_model.dart';
import 'package:monetra/data/models/transaction_model.dart';

void main() {
  group('FinancialCalculator Deterministic Tests', () {
    test('Safe to Spend Today calculates exact daily discretionary allowance', () {
      final now = DateTime(2026, 10, 15); // October has 31 days. Day 15 -> 17 days remaining (15..31)
      final transactions = [
        TransactionModel(
          id: '1',
          amountCents: 500000, // $5,000.00
          type: TransactionType.income,
          categoryId: 'salary',
          title: 'Salary',
          date: DateTime(2026, 10, 1),
        ),
        TransactionModel(
          id: '2',
          amountCents: 150000, // $1,500.00
          type: TransactionType.expense,
          categoryId: 'housing',
          title: 'Rent',
          date: DateTime(2026, 10, 2),
        ),
      ];

      final budget = BudgetModel(
        id: 'b1',
        name: 'Total Budget',
        limitCents: 320000, // $3,200.00 limit -> remaining = 3200 - 1500 = 1700 ($1,700.00)
        periodMonth: '2026-10',
      );

      final subscriptions = [
        SubscriptionModel(
          id: 's1',
          name: 'Internet',
          amountCents: 8500, // $85.00 due on Oct 25
          billingCycle: BillingCycle.monthly,
          nextBillingDate: DateTime(2026, 10, 25),
          categoryId: 'bills',
          iconCode: 0,
          colorHex: 0,
        ),
      ];

      final metrics = FinancialCalculator.calculateDashboardMetrics(
        transactions: transactions,
        overallBudget: budget,
        subscriptions: subscriptions,
        referenceDate: now,
      );

      expect(metrics.totalIncomeCents, 500000);
      expect(metrics.totalExpenseCents, 150000);
      expect(metrics.remainingBudgetCents, 170000);
      expect(metrics.committedUpcomingBillsCents, 8500);

      // Remaining discretionary = 170000 - 8500 = 161500 cents ($1,615.00)
      // Days remaining = 31 - 15 + 1 = 17 days
      // 161500 / 17 = 9500 cents ($95.00 / day)
      expect(metrics.daysRemainingInMonth, 17);
      expect(metrics.safeToSpendTodayCents, 9500);
      expect(metrics.safeToSpendToday, 95.0);
    });

    test('Zero remaining budget produces safe-to-spend 0 without crashing', () {
      final now = DateTime(2026, 10, 20);
      final transactions = [
        TransactionModel(
          id: '1',
          amountCents: 400000,
          type: TransactionType.expense,
          categoryId: 'shopping',
          title: 'Big Expense',
          date: DateTime(2026, 10, 5),
        ),
      ];

      final budget = BudgetModel(
        id: 'b1',
        name: 'Budget',
        limitCents: 200000, // $2,000 limit, spent $4,000
        periodMonth: '2026-10',
      );

      final metrics = FinancialCalculator.calculateDashboardMetrics(
        transactions: transactions,
        overallBudget: budget,
        subscriptions: [],
        referenceDate: now,
      );

      expect(metrics.safeToSpendTodayCents, 0);
      expect(metrics.budgetConsumptionRatio >= 1.0, true);
    });
  });

  group('Currency Formatter Tests', () {
    test('Formats USD, EUR, GBP correctly from minor cents', () {
      expect(CurrencyFormatter.formatCents(1050, currencyCode: 'USD'), '\$10.50');
      expect(CurrencyFormatter.formatCents(250000, currencyCode: 'USD'), '\$2,500.00');
      expect(CurrencyFormatter.formatCents(100, currencyCode: 'EUR').contains('1.00'), true);
      expect(CurrencyFormatter.formatCents(999, currencyCode: 'GBP').contains('9.99'), true);
    });

    test('Supports compact formatting for high amounts', () {
      final formatted = CurrencyFormatter.formatCents(5000000, currencyCode: 'USD', compact: true);
      expect(formatted.contains('50K'), true);
    });
  });

  group('Subscription Calculations', () {
    test('Monthly equivalent normalization works across cycles', () {
      final weeklySub = SubscriptionModel(
        id: '1',
        name: 'Trainer',
        amountCents: 2500, // $25/wk
        billingCycle: BillingCycle.weekly,
        nextBillingDate: DateTime.now(),
        categoryId: 'health',
        iconCode: 0,
        colorHex: 0,
      );
      // 2500 * 52 / 12 = 10833 cents ($108.33/mo)
      expect(weeklySub.monthlyEquivalentCents, 10833);

      final yearlySub = SubscriptionModel(
        id: '2',
        name: 'Annual Software',
        amountCents: 12000, // $120/yr
        billingCycle: BillingCycle.yearly,
        nextBillingDate: DateTime.now(),
        categoryId: 'subs',
        iconCode: 0,
        colorHex: 0,
      );
      expect(yearlySub.monthlyEquivalentCents, 1000); // $10/mo
    });
  });

  group('Insights Engine Tests', () {
    test('Detects category surge when spending exceeds 35% of total outflow', () {
      const metrics = FinancialMetrics(
        totalIncomeCents: 500000,
        totalExpenseCents: 100000,
        netSavingsCents: 400000,
        safeToSpendTodayCents: 5000,
        committedUpcomingBillsCents: 0,
        remainingBudgetCents: 200000,
        budgetConsumptionRatio: 0.33,
        daysRemainingInMonth: 15,
        projectedMonthEndExpenseCents: 200000,
      );

      final transactions = [
        TransactionModel(
          id: '1',
          amountCents: 45000, // 45% on shopping
          type: TransactionType.expense,
          categoryId: 'shopping',
          title: 'Mall',
          date: DateTime.now(),
        ),
      ];

      final insights = FinancialCalculator.generateInsights(
        metrics: metrics,
        transactions: transactions,
        subscriptions: [],
        categories: CategoryModel.defaultExpenseCategories,
      );

      expect(insights.any((i) => i.id.startsWith('category_surge_shopping')), true);
    });
  });
}
