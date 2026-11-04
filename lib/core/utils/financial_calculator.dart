import '../../data/models/budget_model.dart';
import '../../data/models/category_model.dart';
import '../../data/models/financial_insight_model.dart';
import '../../data/models/subscription_model.dart';
import '../../data/models/transaction_model.dart';
import 'package:flutter/material.dart';

class FinancialMetrics {
  final int totalIncomeCents;
  final int totalExpenseCents;
  final int netSavingsCents;
  final int safeToSpendTodayCents;
  final int committedUpcomingBillsCents;
  final int remainingBudgetCents;
  final double budgetConsumptionRatio;
  final int daysRemainingInMonth;
  final int projectedMonthEndExpenseCents;

  const FinancialMetrics({
    required this.totalIncomeCents,
    required this.totalExpenseCents,
    required this.netSavingsCents,
    required this.safeToSpendTodayCents,
    required this.committedUpcomingBillsCents,
    required this.remainingBudgetCents,
    required this.budgetConsumptionRatio,
    required this.daysRemainingInMonth,
    required this.projectedMonthEndExpenseCents,
  });

  double get totalIncome => totalIncomeCents / 100.0;
  double get totalExpense => totalExpenseCents / 100.0;
  double get netSavings => netSavingsCents / 100.0;
  double get safeToSpendToday => safeToSpendTodayCents / 100.0;
  double get remainingBudget => remainingBudgetCents / 100.0;
  double get projectedMonthEndExpense => projectedMonthEndExpenseCents / 100.0;
}

class FinancialCalculator {
  /// Calculates all core dashboard financial metrics deterministically.
  static FinancialMetrics calculateDashboardMetrics({
    required List<TransactionModel> transactions,
    required BudgetModel? overallBudget,
    required List<SubscriptionModel> subscriptions,
    DateTime? referenceDate,
  }) {
    final now = referenceDate ?? DateTime.now();
    final firstDayOfMonth = DateTime(now.year, now.month, 1);
    final lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
    final totalDaysInMonth = lastDayOfMonth.day;
    final currentDay = now.day;
    final daysRemaining = (totalDaysInMonth - currentDay + 1).clamp(1, 31);

    int incomeCents = 0;
    int expenseCents = 0;

    for (final tx in transactions) {
      if (tx.date.isAfter(firstDayOfMonth.subtract(const Duration(seconds: 1))) &&
          tx.date.isBefore(lastDayOfMonth.add(const Duration(days: 1)))) {
        if (tx.type == TransactionType.income) {
          incomeCents += tx.amountCents;
        } else {
          expenseCents += tx.amountCents;
        }
      }
    }

    // Calculate upcoming scheduled bills/subscriptions in this cycle
    int committedUpcomingBillsCents = 0;
    for (final sub in subscriptions) {
      if (sub.isActive) {
        // If the next billing date falls in this month and after today
        if (sub.nextBillingDate.month == now.month &&
            sub.nextBillingDate.year == now.year &&
            sub.nextBillingDate.day >= now.day) {
          committedUpcomingBillsCents += sub.amountCents;
        }
      }
    }

    final budgetLimitCents = overallBudget?.limitCents ?? (incomeCents > 0 ? (incomeCents * 0.8).round() : 200000);
    final remainingBudgetCents = budgetLimitCents - expenseCents;

    // Discretionary pool available for the remaining days
    final availableDiscretionaryCents = (remainingBudgetCents - committedUpcomingBillsCents);
    final safeToSpendTodayCents = availableDiscretionaryCents > 0
        ? (availableDiscretionaryCents / daysRemaining).floor()
        : 0;

    final budgetRatio = budgetLimitCents > 0
        ? (expenseCents / budgetLimitCents).clamp(0.0, 2.0)
        : 0.0;

    // Projected end of month expense based on daily velocity
    final dailyVelocity = currentDay > 0 ? (expenseCents / currentDay) : 0.0;
    final projectedMonthEndExpenseCents = (dailyVelocity * totalDaysInMonth).round();

    return FinancialMetrics(
      totalIncomeCents: incomeCents,
      totalExpenseCents: expenseCents,
      netSavingsCents: incomeCents - expenseCents,
      safeToSpendTodayCents: safeToSpendTodayCents,
      committedUpcomingBillsCents: committedUpcomingBillsCents,
      remainingBudgetCents: remainingBudgetCents,
      budgetConsumptionRatio: budgetRatio,
      daysRemainingInMonth: daysRemaining,
      projectedMonthEndExpenseCents: projectedMonthEndExpenseCents,
    );
  }

  /// Generates real-time, deterministic financial insights based on actual user data.
  static List<FinancialInsightModel> generateInsights({
    required FinancialMetrics metrics,
    required List<TransactionModel> transactions,
    required List<SubscriptionModel> subscriptions,
    required List<CategoryModel> categories,
  }) {
    final insights = <FinancialInsightModel>[];

    // 1. Safe to spend insight
    if (metrics.safeToSpendTodayCents > 0) {
      final formattedDaily = (metrics.safeToSpendTodayCents / 100.0).toStringAsFixed(2);
      insights.add(
        FinancialInsightModel(
          id: 'safe_spend_good',
          title: 'Daily Spending Target',
          message: 'Staying within \$$formattedDaily today keeps your monthly budget safely on track for the remaining ${metrics.daysRemainingInMonth} days.',
          type: InsightType.positive,
          icon: Icons.verified_rounded,
        ),
      );
    } else if (metrics.budgetConsumptionRatio >= 0.9) {
      insights.add(
        const FinancialInsightModel(
          id: 'budget_threshold_warning',
          title: 'Budget Alert',
          message: 'You have consumed over 90% of your monthly budget. Discretionary spending should be paused to protect essentials.',
          type: InsightType.warning,
          icon: Icons.warning_amber_rounded,
        ),
      );
    }

    // 2. Subscription overhead insight
    int totalMonthlySubCents = 0;
    for (final s in subscriptions) {
      if (s.isActive) totalMonthlySubCents += s.monthlyEquivalentCents;
    }
    if (totalMonthlySubCents > 0) {
      final formattedSub = (totalMonthlySubCents / 100.0).toStringAsFixed(2);
      insights.add(
        FinancialInsightModel(
          id: 'subscription_audit',
          title: 'Recurring Commitments',
          message: 'You have active subscriptions totaling \$$formattedSub/month. Auditing unused services could save you money.',
          type: InsightType.info,
          icon: Icons.repeat_rounded,
        ),
      );
    }

    // 3. Savings velocity insight
    if (metrics.netSavingsCents > 0) {
      final formattedSavings = (metrics.netSavingsCents / 100.0).toStringAsFixed(2);
      insights.add(
        FinancialInsightModel(
          id: 'savings_positive',
          title: 'Net Surplus',
          message: 'You are currently saving \$$formattedSavings this month. Consider transferring excess funds into your savings goals.',
          type: InsightType.positive,
          icon: Icons.trending_up_rounded,
        ),
      );
    }

    // 4. Category surge detection (excluding fixed housing)
    if (metrics.totalExpenseCents > 0) {
      final categoryTotals = <String, int>{};
      for (final tx in transactions) {
        if (tx.type == TransactionType.expense) {
          categoryTotals[tx.categoryId] = (categoryTotals[tx.categoryId] ?? 0) + tx.amountCents;
        }
      }

      for (final entry in categoryTotals.entries) {
        final ratio = entry.value / metrics.totalExpenseCents;
        if (ratio >= 0.35 && entry.key != 'housing') {
          final cat = categories.firstWhere(
            (c) => c.id == entry.key,
            orElse: () => const CategoryModel(
              id: 'other',
              name: 'Other',
              icon: Icons.category,
              color: Colors.grey,
            ),
          );
          final pct = (ratio * 100).round();
          insights.add(
            FinancialInsightModel(
              id: 'category_surge_${entry.key}',
              title: '${cat.name} Alert',
              message: '${cat.name} accounts for $pct% of your total spending this cycle. Consider reviewing your discretionary expenses.',
              type: InsightType.warning,
              icon: Icons.trending_up_rounded,
            ),
          );
          break;
        }
      }
    }

    return insights;
  }
}
