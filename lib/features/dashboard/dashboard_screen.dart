import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/currency_formatter.dart';
import '../../core/widgets/budget_progress_ring.dart';
import '../../core/widgets/quick_add_sheet.dart';
import '../../core/widgets/safe_spend_card.dart';
import '../../core/utils/financial_calculator.dart';
import '../../core/utils/transaction_localizer.dart';
import '../../data/models/category_model.dart';
import '../../data/models/financial_insight_model.dart';
import '../../data/models/subscription_model.dart';
import '../../data/models/transaction_model.dart';
import '../../l10n/generated/app_localizations.dart';
import '../providers/finance_providers.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);
    final metrics = ref.watch(dashboardMetricsProvider);
    final currency = ref.watch(currencyProvider);
    final insights = ref.watch(financialInsightsProvider);
    final txAsync = ref.watch(transactionsProvider);
    final catAsync = ref.watch(categoriesProvider);
    final subsAsync = ref.watch(subscriptionsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/images/monetra_logo.png',
                width: 28,
                height: 28,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'MONETRA',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10n?.commitmentsUpToDate ?? 'All financial commitments are up to date!')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: metrics == null
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () async {
                ref.read(transactionsProvider.notifier).refresh();
                ref.read(budgetsProvider.notifier).refresh();
                ref.read(subscriptionsProvider.notifier).refresh();
                ref.read(savingsGoalsProvider.notifier).refresh();
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // 1. Safe To Spend Today Card
                    SafeSpendCard(
                      metrics: metrics,
                      currencyCode: currency,
                    ),
                    const SizedBox(height: 16),

                    // 2. Monthly Inflow & Outflow Metrics Grid
                    Row(
                      children: [
                        Expanded(
                          child: _buildCashflowCard(
                            label: l10n?.monthlyIncome ?? 'Monthly Income',
                            cents: metrics.totalIncomeCents,
                            currencyCode: currency,
                            icon: Icons.arrow_downward_rounded,
                            iconColor: AppColors.primaryGreen,
                            isDark: isDark,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildCashflowCard(
                            label: l10n?.monthlyExpenses ?? 'Monthly Expenses',
                            cents: metrics.totalExpenseCents,
                            currencyCode: currency,
                            icon: Icons.arrow_upward_rounded,
                            iconColor: AppColors.coral,
                            isDark: isDark,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // 3. Monthly Budget Progress Ring & Thresholds
                    BudgetProgressRing(
                      spentCents: metrics.totalExpenseCents,
                      totalBudgetCents: metrics.remainingBudgetCents + metrics.totalExpenseCents,
                      currencyCode: currency,
                    ),
                    const SizedBox(height: 16),

                    // 4. Deterministic Insights Carousel
                    if (insights.isNotEmpty) ...[
                      _buildInsightsSection(
                        insights,
                        isDark,
                        l10n,
                        currency,
                        metrics,
                        subsAsync.value ?? [],
                        catAsync.value ?? [],
                        txAsync.value ?? [],
                      ),
                      const SizedBox(height: 16),
                    ],

                    // 5. Recent Transactions Header & List
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          l10n?.recentActivityUpper ?? 'RECENT ACTIVITY',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.1,
                            color: isDark ? AppColors.darkMuted : AppColors.lightMuted,
                          ),
                        ),
                        TextButton(
                          onPressed: () => context.go('/activity'),
                          child: Text(
                            l10n?.seeAll ?? 'See All',
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    txAsync.when(
                      data: (txList) {
                        if (txList.isEmpty) {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(24),
                              child: Center(
                                child: Text(
                                  l10n?.noTransactionsYet ??
                                      'No transactions yet.\nTap "+" below to log your first expense.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: isDark ? AppColors.darkMuted : AppColors.lightMuted,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                        final recent = txList.take(5).toList();
                        final categories = catAsync.value ?? [];
                        return Card(
                          child: ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: recent.length,
                            separatorBuilder: (_, _) => const Divider(height: 1),
                            itemBuilder: (context, index) {
                              final tx = recent[index];
                              final category = categories.firstWhere(
                                (c) => c.id == tx.categoryId,
                                orElse: () => const CategoryModel(
                                  id: 'other',
                                  name: 'Other',
                                  icon: Icons.category_rounded,
                                  color: Colors.grey,
                                ),
                              );
                              return _buildTransactionTile(tx, category, currency, isDark, l10n);
                            },
                          ),
                        );
                      },
                      loading: () => const Center(child: CircularProgressIndicator()),
                      error: (e, _) => Text('Error: $e'),
                    ),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => QuickAddSheet.show(context),
        backgroundColor: AppColors.primaryGreen,
        icon: const Icon(Icons.add_rounded, color: Colors.white),
        label: Text(
          l10n?.quickLog ?? 'Quick Log',
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  Widget _buildCashflowCard({
    required String label,
    required int cents,
    required String currencyCode,
    required IconData icon,
    required Color iconColor,
    required bool isDark,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: iconColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: iconColor, size: 16),
                ),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isDark ? AppColors.darkMuted : AppColors.lightMuted,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              CurrencyFormatter.formatCents(cents, currencyCode: currencyCode),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
                color: isDark ? AppColors.darkText : AppColors.lightText,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInsightsSection(
    List<FinancialInsightModel> insights,
    bool isDark,
    AppLocalizations? l10n,
    String currencyCode,
    FinancialMetrics? metrics,
    List<SubscriptionModel> subscriptions,
    List<CategoryModel> categories,
    List<TransactionModel> transactions,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n?.smartInsights ?? 'SMART INSIGHTS',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.1,
            color: isDark ? AppColors.darkMuted : AppColors.lightMuted,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 110,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: insights.length,
            separatorBuilder: (_, _) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final insight = insights[index];
              Color accent;
              switch (insight.type) {
                case InsightType.positive:
                  accent = AppColors.primaryGreen;
                  break;
                case InsightType.warning:
                  accent = AppColors.warning;
                  break;
                case InsightType.info:
                  accent = AppColors.secondaryBlue;
                  break;
              }

              String title = insight.title;
              String message = insight.message;

              if (insight.id == 'safe_spend_good' && metrics != null) {
                title = l10n?.insightDailyTargetTitle ?? insight.title;
                message = l10n?.insightDailyTargetMsg(
                      CurrencyFormatter.formatCents(metrics.safeToSpendTodayCents, currencyCode: currencyCode),
                      metrics.daysRemainingInMonth,
                    ) ??
                    insight.message;
              } else if (insight.id == 'budget_threshold_warning') {
                title = l10n?.insightBudgetAlertTitle ?? insight.title;
                message = l10n?.insightBudgetAlertMsg ?? insight.message;
              } else if (insight.id == 'subscription_audit') {
                title = l10n?.insightRecurringTitle ?? insight.title;
                final totalSubCents = subscriptions
                    .where((s) => s.isActive)
                    .fold<int>(0, (sum, s) => sum + s.monthlyEquivalentCents);
                message = l10n?.insightRecurringMsg(
                      CurrencyFormatter.formatCents(totalSubCents, currencyCode: currencyCode),
                    ) ??
                    insight.message;
              } else if (insight.id == 'savings_positive' && metrics != null) {
                title = l10n?.insightNetSurplusTitle ?? insight.title;
                message = l10n?.insightNetSurplusMsg(
                      CurrencyFormatter.formatCents(metrics.netSavingsCents, currencyCode: currencyCode),
                    ) ??
                    insight.message;
              } else if (insight.id.startsWith('category_surge')) {
                title = l10n?.insightSurgeTitle ?? insight.title;
                final surgeCatId = insight.id.replaceFirst('category_surge_', '');
                final surgeCat = categories.firstWhere(
                  (c) => c.id == surgeCatId,
                  orElse: () => const CategoryModel(
                    id: 'other',
                    name: 'Other',
                    icon: Icons.category,
                    color: Colors.grey,
                  ),
                );
                int surgeCents = 0;
                for (final tx in transactions) {
                  if (tx.categoryId == surgeCatId && tx.type == TransactionType.expense) {
                    surgeCents += tx.amountCents;
                  }
                }
                final pct = metrics != null && metrics.totalExpenseCents > 0
                    ? ((surgeCents / metrics.totalExpenseCents) * 100).round()
                    : 35;
                message = l10n?.insightSurgeMsg(surgeCat.localizedName(l10n), pct) ?? insight.message;
              }

              return Container(
                width: 280,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkCard : AppColors.lightCard,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: accent.withValues(alpha: 0.3),
                    width: 1.2,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(insight.icon, color: accent, size: 18),
                        const SizedBox(width: 6),
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: accent,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      message,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.3,
                        color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionTile(
    TransactionModel tx,
    CategoryModel category,
    String currencyCode,
    bool isDark,
    AppLocalizations? l10n,
  ) {
    final isIncome = tx.type == TransactionType.income;
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: category.color.withValues(alpha: 0.15),
          shape: BoxShape.circle,
        ),
        child: Icon(category.icon, color: category.color, size: 22),
      ),
      title: Text(
        getLocalizedTxTitle(tx.title, l10n),
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 15,
          color: isDark ? AppColors.darkText : AppColors.lightText,
        ),
      ),
      subtitle: Text(
        '${tx.date.year}-${tx.date.month.toString().padLeft(2, '0')}-${tx.date.day.toString().padLeft(2, '0')} • ${category.localizedName(l10n)}',
        style: TextStyle(
          fontSize: 12,
          color: isDark ? AppColors.darkMuted : AppColors.lightMuted,
        ),
      ),
      trailing: Text(
        '${isIncome ? '+' : '-'}${CurrencyFormatter.formatCents(tx.amountCents, currencyCode: currencyCode)}',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 15,
          color: isIncome ? AppColors.income : (isDark ? Colors.white : AppColors.lightText),
        ),
      ),
    );
  }
}
