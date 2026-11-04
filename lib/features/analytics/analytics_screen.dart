import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/currency_formatter.dart';
import '../../data/models/category_model.dart';
import '../../data/models/transaction_model.dart';
import '../../l10n/generated/app_localizations.dart';
import '../providers/finance_providers.dart';

enum AnalyticsPeriod { week7d, days30, months3, allTime }

class AnalyticsScreen extends ConsumerStatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  ConsumerState<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _PeriodBarData {
  final String label;
  final String tooltipTitle;
  final double amount;

  const _PeriodBarData({
    required this.label,
    required this.tooltipTitle,
    required this.amount,
  });
}

class _AnalyticsScreenState extends ConsumerState<AnalyticsScreen> {
  AnalyticsPeriod _selectedPeriod = AnalyticsPeriod.days30;
  int _touchedDonutIndex = -1;

  String _getChartTitle(AppLocalizations? l10n) {
    switch (_selectedPeriod) {
      case AnalyticsPeriod.week7d:
        return l10n?.period7DaysTitle.toUpperCase() ?? '7-DAY SPENDING VELOCITY';
      case AnalyticsPeriod.days30:
        return l10n?.period30DaysTitle.toUpperCase() ?? '30-DAY SPENDING TREND';
      case AnalyticsPeriod.months3:
        return l10n?.period3MonthsTitle.toUpperCase() ?? '3-MONTH SPENDING COMPARISON';
      case AnalyticsPeriod.allTime:
        return l10n?.periodAllTimeTitle.toUpperCase() ?? 'MONTHLY SPENDING EVOLUTION';
    }
  }

  List<TransactionModel> _getFilteredTransactions(List<TransactionModel> allTxs) {
    final now = DateTime.now();
    final todayEnd = DateTime(now.year, now.month, now.day, 23, 59, 59);

    switch (_selectedPeriod) {
      case AnalyticsPeriod.week7d:
        final start = DateTime(now.year, now.month, now.day).subtract(const Duration(days: 6));
        return allTxs.where((t) => !t.date.isBefore(start) && !t.date.isAfter(todayEnd)).toList();
      case AnalyticsPeriod.days30:
        final start = DateTime(now.year, now.month, now.day).subtract(const Duration(days: 29));
        return allTxs.where((t) => !t.date.isBefore(start) && !t.date.isAfter(todayEnd)).toList();
      case AnalyticsPeriod.months3:
        final start = DateTime(now.year, now.month - 2, 1);
        final end = DateTime(now.year, now.month + 1, 0, 23, 59, 59);
        return allTxs.where((t) => !t.date.isBefore(start) && !t.date.isAfter(end)).toList();
      case AnalyticsPeriod.allTime:
        return allTxs;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);
    final txAsync = ref.watch(transactionsProvider);
    final catAsync = ref.watch(categoriesProvider);
    final currency = ref.watch(currencyProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n?.financialAnalytics ?? 'Visual Analytics'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Period Selector
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkCard : AppColors.lightCardAlt,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                ),
              ),
              child: Row(
                children: [
                  _buildPeriodTab(l10n?.period7Days ?? '7 Days', AnalyticsPeriod.week7d, isDark),
                  _buildPeriodTab(l10n?.period30Days ?? '30 Days', AnalyticsPeriod.days30, isDark),
                  _buildPeriodTab(l10n?.period3Months ?? '3 Months', AnalyticsPeriod.months3, isDark),
                  _buildPeriodTab(l10n?.periodAllTime ?? 'All Time', AnalyticsPeriod.allTime, isDark),
                ],
              ),
            ),
            const SizedBox(height: 20),

            txAsync.when(
              data: (allTxs) {
                final txs = _getFilteredTransactions(allTxs);
                final categories = catAsync.value ?? [];

                // Separate income and expense
                int totalIncomeCents = 0;
                int totalExpenseCents = 0;
                final categorySpend = <String, int>{};

                for (final tx in txs) {
                  if (tx.type == TransactionType.income) {
                    totalIncomeCents += tx.amountCents;
                  } else {
                    totalExpenseCents += tx.amountCents;
                    categorySpend[tx.categoryId] =
                        (categorySpend[tx.categoryId] ?? 0) + tx.amountCents;
                  }
                }

                if (txs.isEmpty) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Center(
                        child: Column(
                          children: [
                            Icon(Icons.bar_chart_rounded,
                                size: 56,
                                color: isDark ? AppColors.darkMuted : AppColors.lightMuted),
                            const SizedBox(height: 12),
                            Text(
                              l10n?.noTransactionsTimeframe ?? 'No transactions in this timeframe.',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: isDark ? AppColors.darkText : AppColors.lightText,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // 1. Inflow vs Outflow Comparison Card
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n?.incomeVsExpenses.toUpperCase() ?? 'INCOME VS EXPENSES',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.1,
                                color: isDark ? AppColors.darkMuted : AppColors.lightMuted,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _buildFlowSummary(
                                  label: l10n?.inflow ?? 'Inflow',
                                  cents: totalIncomeCents,
                                  color: AppColors.income,
                                  currency: currency,
                                  isDark: isDark,
                                ),
                                Container(
                                  width: 1,
                                  height: 40,
                                  color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                                ),
                                _buildFlowSummary(
                                  label: l10n?.outflow ?? 'Outflow',
                                  cents: totalExpenseCents,
                                  color: AppColors.expense,
                                  currency: currency,
                                  isDark: isDark,
                                ),
                                Container(
                                  width: 1,
                                  height: 40,
                                  color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                                ),
                                _buildFlowSummary(
                                  label: l10n?.netBalance ?? 'Net Balance',
                                  cents: totalIncomeCents - totalExpenseCents,
                                  color: (totalIncomeCents >= totalExpenseCents)
                                      ? AppColors.primaryGreen
                                      : AppColors.coral,
                                  currency: currency,
                                  isDark: isDark,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // 2. Spending Distribution Donut Chart
                    if (totalExpenseCents > 0) ...[
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                l10n?.spendingDistribution.toUpperCase() ?? 'SPENDING DISTRIBUTION',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1.1,
                                  color: isDark ? AppColors.darkMuted : AppColors.lightMuted,
                                ),
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                height: 220,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    PieChart(
                                      PieChartData(
                                        pieTouchData: PieTouchData(
                                          touchCallback: (FlTouchEvent event, pieTouchResponse) {
                                            setState(() {
                                              if (!event.isInterestedForInteractions ||
                                                  pieTouchResponse == null ||
                                                  pieTouchResponse.touchedSection == null) {
                                                _touchedDonutIndex = -1;
                                                return;
                                              }
                                              _touchedDonutIndex = pieTouchResponse
                                                  .touchedSection!.touchedSectionIndex;
                                            });
                                          },
                                        ),
                                        borderData: FlBorderData(show: false),
                                        sectionsSpace: 2,
                                        centerSpaceRadius: 58,
                                        sections: _generatePieSections(
                                          categorySpend,
                                          categories,
                                          totalExpenseCents,
                                        ),
                                      ),
                                    ),
                                    _buildDonutCenterInfo(
                                      categorySpend,
                                      categories,
                                      totalExpenseCents,
                                      currency,
                                      isDark,
                                      l10n,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),
                              _buildSpendingLegend(
                                categorySpend,
                                categories,
                                totalExpenseCents,
                                currency,
                                isDark,
                                l10n,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],

                    // 3. Dynamic Period Spending Bar Chart
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    _getChartTitle(l10n),
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 1.1,
                                      color: isDark ? AppColors.darkMuted : AppColors.lightMuted,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: 8,
                                      height: 8,
                                      decoration: const BoxDecoration(
                                        color: AppColors.primaryGreen,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      l10n?.outflow ?? 'Expense',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: isDark ? AppColors.darkMuted : AppColors.lightMuted,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              height: 180,
                              child: _buildPeriodBarChart(
                                txs,
                                isDark,
                                currency,
                                Localizations.localeOf(context).toString(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // 4. Category Breakdown List
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n?.categoryBreakdown.toUpperCase() ?? 'CATEGORY BREAKDOWN',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.1,
                                color: isDark ? AppColors.darkMuted : AppColors.lightMuted,
                              ),
                            ),
                            const SizedBox(height: 12),
                            ...categorySpend.entries.map((entry) {
                              final cat = categories.firstWhere(
                                (c) => c.id == entry.key,
                                orElse: () => CategoryModel(
                                  id: 'other',
                                  name: 'Other',
                                  icon: Icons.category_rounded,
                                  color: Colors.grey,
                                ),
                              );
                              final pct = totalExpenseCents > 0
                                  ? (entry.value / totalExpenseCents * 100).toStringAsFixed(1)
                                  : '0';

                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 6),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 36,
                                      height: 36,
                                      decoration: BoxDecoration(
                                        color: cat.color.withValues(alpha: 0.15),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(cat.icon, color: cat.color, size: 18),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            cat.localizedName(l10n),
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: isDark ? AppColors.darkText : AppColors.lightText,
                                            ),
                                          ),
                                          Text(
                                            l10n?.pctOfTotalSpending(pct) ?? '$pct% of total spending',
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: isDark ? AppColors.darkMuted : AppColors.lightMuted,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      CurrencyFormatter.formatCents(entry.value, currencyCode: currency),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                        color: isDark ? AppColors.darkText : AppColors.lightText,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPeriodTab(String label, AnalyticsPeriod period, bool isDark) {
    final isSelected = _selectedPeriod == period;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedPeriod = period),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primaryGreen
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: isSelected
                  ? Colors.white
                  : (isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFlowSummary({
    required String label,
    required int cents,
    required Color color,
    required String currency,
    required bool isDark,
  }) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: isDark ? AppColors.darkMuted : AppColors.lightMuted,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          CurrencyFormatter.formatCents(cents, currencyCode: currency, compact: true),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: color,
          ),
        ),
      ],
    );
  }

  List<PieChartSectionData> _generatePieSections(
    Map<String, int> categorySpend,
    List<CategoryModel> categories,
    int totalExpenseCents,
  ) {
    int index = 0;
    return categorySpend.entries.map((entry) {
      final isTouched = index == _touchedDonutIndex;
      final radius = isTouched ? 42.0 : 34.0;
      final cat = categories.firstWhere(
        (c) => c.id == entry.key,
        orElse: () => CategoryModel(
          id: 'other',
          name: 'Other',
          icon: Icons.category,
          color: Colors.grey,
        ),
      );

      final double percentage = totalExpenseCents > 0
          ? (entry.value / totalExpenseCents * 100)
          : 0;

      final bool showTitle = isTouched || percentage >= 8.0;
      final String titleText = showTitle ? '${percentage.toStringAsFixed(0)}%' : '';

      index++;
      return PieChartSectionData(
        color: cat.color,
        value: entry.value.toDouble(),
        title: titleText,
        radius: radius,
        titleStyle: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: [
            Shadow(
              color: Colors.black45,
              blurRadius: 3,
            ),
          ],
        ),
      );
    }).toList();
  }

  Widget _buildDonutCenterInfo(
    Map<String, int> categorySpend,
    List<CategoryModel> categories,
    int totalExpenseCents,
    String currency,
    bool isDark,
    AppLocalizations? l10n,
  ) {
    if (_touchedDonutIndex >= 0 && _touchedDonutIndex < categorySpend.length) {
      final entry = categorySpend.entries.elementAt(_touchedDonutIndex);
      final cat = categories.firstWhere(
        (c) => c.id == entry.key,
        orElse: () => CategoryModel(
          id: 'other',
          name: 'Other',
          icon: Icons.category,
          color: Colors.grey,
        ),
      );
      final pct = totalExpenseCents > 0
          ? (entry.value / totalExpenseCents * 100).toStringAsFixed(1)
          : '0';

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(cat.icon, size: 18, color: cat.color),
          const SizedBox(height: 2),
          Text(
            cat.localizedName(l10n),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: isDark ? AppColors.darkText : AppColors.lightText,
            ),
          ),
          Text(
            CurrencyFormatter.formatCents(entry.value, currencyCode: currency, compact: true),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: cat.color,
            ),
          ),
          Text(
            '$pct%',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: isDark ? AppColors.darkMuted : AppColors.lightMuted,
            ),
          ),
        ],
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          l10n?.outflow.toUpperCase() ?? 'TOTAL',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.0,
            color: isDark ? AppColors.darkMuted : AppColors.lightMuted,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          CurrencyFormatter.formatCents(totalExpenseCents, currencyCode: currency, compact: true),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: isDark ? AppColors.darkText : AppColors.lightText,
          ),
        ),
        Text(
          '${categorySpend.length} ${categorySpend.length == 1 ? "category" : "categories"}',
          style: TextStyle(
            fontSize: 10,
            color: isDark ? AppColors.darkMuted : AppColors.lightMuted,
          ),
        ),
      ],
    );
  }

  Widget _buildSpendingLegend(
    Map<String, int> categorySpend,
    List<CategoryModel> categories,
    int totalExpenseCents,
    String currency,
    bool isDark,
    AppLocalizations? l10n,
  ) {
    final sortedEntries = categorySpend.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          height: 24,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'CATEGORIES & PROPORTIONS',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.0,
                color: isDark ? AppColors.darkMuted : AppColors.lightMuted,
              ),
            ),
            Text(
              'Tap to isolate',
              style: TextStyle(
                fontSize: 10,
                color: isDark ? AppColors.darkMuted : AppColors.lightMuted,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: sortedEntries.asMap().entries.map((mapEntry) {
            final entry = mapEntry.value;
            final originalIndex = categorySpend.keys.toList().indexOf(entry.key);
            final isSelected = _touchedDonutIndex == originalIndex;

            final cat = categories.firstWhere(
              (c) => c.id == entry.key,
              orElse: () => CategoryModel(
                id: 'other',
                name: 'Other',
                icon: Icons.category_rounded,
                color: Colors.grey,
              ),
            );

            final double percentage = totalExpenseCents > 0
                ? (entry.value / totalExpenseCents * 100)
                : 0;

            return InkWell(
              onTap: () {
                setState(() {
                  _touchedDonutIndex = isSelected ? -1 : originalIndex;
                });
              },
              borderRadius: BorderRadius.circular(10),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: isSelected
                      ? cat.color.withValues(alpha: 0.18)
                      : (isDark ? AppColors.darkCardAlt : AppColors.lightCardAlt),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: isSelected
                        ? cat.color
                        : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
                    width: isSelected ? 1.5 : 1.0,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: cat.color,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: cat.color.withValues(alpha: 0.4),
                            blurRadius: 4,
                            spreadRadius: 0.5,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 7),
                    Text(
                      cat.localizedName(l10n),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isDark ? AppColors.darkText : AppColors.lightText,
                      ),
                    ),
                    const SizedBox(width: 7),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
                      decoration: BoxDecoration(
                        color: cat.color.withValues(alpha: 0.16),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        '${percentage.toStringAsFixed(1)}%',
                        style: TextStyle(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w800,
                          color: cat.color,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      CurrencyFormatter.formatCents(entry.value, currencyCode: currency, compact: true),
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: isDark ? AppColors.darkMuted : AppColors.lightMuted,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  List<_PeriodBarData> _buildChartBars(List<TransactionModel> txs, String locale) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    switch (_selectedPeriod) {
      case AnalyticsPeriod.week7d:
        return List.generate(7, (i) {
          final date = today.subtract(Duration(days: 6 - i));
          int dailyCents = 0;
          for (final tx in txs) {
            if (tx.type == TransactionType.expense &&
                tx.date.year == date.year &&
                tx.date.month == date.month &&
                tx.date.day == date.day) {
              dailyCents += tx.amountCents;
            }
          }
          return _PeriodBarData(
            label: DateFormat('E', locale).format(date),
            tooltipTitle: DateFormat('EEEE, d MMM', locale).format(date),
            amount: dailyCents / 100.0,
          );
        });

      case AnalyticsPeriod.days30:
        final buckets = <_PeriodBarData>[];
        final intervals = [
          [29, 23],
          [22, 16],
          [15, 8],
          [7, 0],
        ];
        for (final interval in intervals) {
          final startDay = today.subtract(Duration(days: interval[0]));
          final endDay = today.subtract(Duration(days: interval[1]));
          int bucketCents = 0;
          for (final tx in txs) {
            if (tx.type == TransactionType.expense) {
              final txDay = DateTime(tx.date.year, tx.date.month, tx.date.day);
              if (!txDay.isBefore(startDay) && !txDay.isAfter(endDay)) {
                bucketCents += tx.amountCents;
              }
            }
          }
          final label = DateFormat('d/M', locale).format(startDay);
          final tooltip =
              '${DateFormat('d MMM', locale).format(startDay)} - ${DateFormat('d MMM', locale).format(endDay)}';
          buckets.add(_PeriodBarData(
            label: label,
            tooltipTitle: tooltip,
            amount: bucketCents / 100.0,
          ));
        }
        return buckets;

      case AnalyticsPeriod.months3:
        return List.generate(3, (i) {
          final offset = 2 - i;
          final target = DateTime(now.year, now.month - offset, 1);
          int monthlyCents = 0;
          for (final tx in txs) {
            if (tx.type == TransactionType.expense &&
                tx.date.year == target.year &&
                tx.date.month == target.month) {
              monthlyCents += tx.amountCents;
            }
          }
          return _PeriodBarData(
            label: DateFormat('MMM', locale).format(target),
            tooltipTitle: DateFormat('MMMM yyyy', locale).format(target),
            amount: monthlyCents / 100.0,
          );
        });

      case AnalyticsPeriod.allTime:
        final monthKeys = <DateTime>[];
        for (int i = 5; i >= 0; i--) {
          monthKeys.add(DateTime(now.year, now.month - i, 1));
        }
        for (final tx in txs) {
          final txMonth = DateTime(tx.date.year, tx.date.month, 1);
          if (!monthKeys.any((m) => m.year == txMonth.year && m.month == txMonth.month)) {
            monthKeys.add(txMonth);
          }
        }
        monthKeys.sort((a, b) => a.compareTo(b));
        final display = monthKeys.length > 6 ? monthKeys.sublist(monthKeys.length - 6) : monthKeys;

        return display.map((m) {
          int monthlyCents = 0;
          for (final tx in txs) {
            if (tx.type == TransactionType.expense &&
                tx.date.year == m.year &&
                tx.date.month == m.month) {
              monthlyCents += tx.amountCents;
            }
          }
          return _PeriodBarData(
            label: DateFormat('MMM', locale).format(m),
            tooltipTitle: DateFormat('MMMM yyyy', locale).format(m),
            amount: monthlyCents / 100.0,
          );
        }).toList();
    }
  }

  Widget _buildPeriodBarChart(
    List<TransactionModel> txs,
    bool isDark,
    String currency,
    String locale,
  ) {
    final bars = _buildChartBars(txs, locale);

    double maxY = 50.0;
    for (final b in bars) {
      if (b.amount > maxY) maxY = b.amount;
    }
    maxY = (maxY * 1.25).ceilToDouble();

    final barWidth = bars.length <= 4 ? 22.0 : (bars.length <= 6 ? 16.0 : 12.0);

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: maxY,
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              final idx = group.x.toInt();
              if (idx < 0 || idx >= bars.length) return null;
              final b = bars[idx];
              return BarTooltipItem(
                '${b.tooltipTitle}\n${CurrencyFormatter.formatAmount(rod.toY, currencyCode: currency)}',
                const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              );
            },
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (val, meta) {
                final idx = val.toInt();
                if (idx < 0 || idx >= bars.length) return const SizedBox.shrink();
                final b = bars[idx];
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    b.label,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: isDark ? AppColors.darkMuted : AppColors.lightMuted,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        barGroups: List.generate(bars.length, (idx) {
          return BarChartGroupData(
            x: idx,
            barRods: [
              BarChartRodData(
                toY: bars[idx].amount,
                color: AppColors.primaryGreen,
                width: barWidth,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
                backDrawRodData: BackgroundBarChartRodData(
                  show: true,
                  toY: maxY,
                  color: isDark ? AppColors.darkCardAlt : AppColors.lightCardAlt,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
