import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:monetra/core/utils/financial_calculator.dart';
import 'package:monetra/core/widgets/budget_progress_ring.dart';
import 'package:monetra/core/widgets/safe_spend_card.dart';

void main() {
  testWidgets('SafeSpendCard renders daily allowance and metrics', (WidgetTester tester) async {
    const metrics = FinancialMetrics(
      totalIncomeCents: 500000,
      totalExpenseCents: 150000,
      netSavingsCents: 350000,
      safeToSpendTodayCents: 7500,
      committedUpcomingBillsCents: 20000,
      remainingBudgetCents: 150000,
      budgetConsumptionRatio: 0.5,
      daysRemainingInMonth: 20,
      projectedMonthEndExpenseCents: 220000,
    );

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SafeSpendCard(
            metrics: metrics,
            currencyCode: 'USD',
          ),
        ),
      ),
    );

    expect(find.text('SAFE TO SPEND TODAY'), findsOneWidget);
    expect(find.text('\$75.00'), findsOneWidget);
    expect(find.text('20d left in cycle'), findsOneWidget);
  });

  testWidgets('BudgetProgressRing renders consumed percentage', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: BudgetProgressRing(
            spentCents: 150000,
            totalBudgetCents: 300000,
            currencyCode: 'USD',
          ),
        ),
      ),
    );

    expect(find.text('MONTHLY BUDGET'), findsOneWidget);
    expect(find.text('50% consumed'), findsOneWidget);
    expect(find.text('On Track'), findsOneWidget);
  });
}
