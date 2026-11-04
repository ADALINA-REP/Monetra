import 'package:flutter/material.dart';
import '../../l10n/generated/app_localizations.dart';
import '../theme/app_colors.dart';
import '../utils/currency_formatter.dart';
import '../utils/financial_calculator.dart';

class SafeSpendCard extends StatelessWidget {
  final FinancialMetrics metrics;
  final String currencyCode;

  const SafeSpendCard({
    super.key,
    required this.metrics,
    required this.currencyCode,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);
    final isExceeded = metrics.safeToSpendTodayCents <= 0 && metrics.budgetConsumptionRatio >= 1.0;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [
                  const Color(0xFF1B382B),
                  const Color(0xFF18283B),
                ]
              : [
                  const Color(0xFFE8F8F0),
                  Colors.white,
                ],
        ),
        boxShadow: [
          BoxShadow(
            color: (isDark ? Colors.black : AppColors.primaryGreen).withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(
          color: isDark
              ? (isExceeded ? AppColors.coral.withValues(alpha: 0.4) : AppColors.primaryGreen.withValues(alpha: 0.3))
              : (isExceeded ? AppColors.coral.withValues(alpha: 0.3) : AppColors.primaryGreen.withValues(alpha: 0.2)),
          width: 1.5,
        ),
      ),
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isExceeded
                          ? AppColors.coral.withValues(alpha: 0.15)
                          : AppColors.primaryGreen.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isExceeded ? Icons.warning_amber_rounded : Icons.shield_rounded,
                      color: isExceeded ? AppColors.coral : AppColors.primaryGreen,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    l10n?.safeToSpendToday.toUpperCase() ?? 'SAFE TO SPEND TODAY',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                      color: isExceeded
                          ? AppColors.coral
                          : (isDark ? AppColors.mint : AppColors.primaryGreenDark),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkCardAlt : AppColors.lightCardAlt,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                  ),
                ),
                child: Text(
                  l10n?.daysLeftInCycle(metrics.daysRemainingInMonth) ?? '${metrics.daysRemainingInMonth}d left in cycle',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                CurrencyFormatter.formatCents(metrics.safeToSpendTodayCents, currencyCode: currencyCode),
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -1.0,
                  color: isExceeded
                      ? AppColors.coral
                      : (isDark ? Colors.white : AppColors.lightText),
                ),
              ),
              const SizedBox(width: 6),
              Text(
                l10n?.perDay ?? '/ today',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isDark ? AppColors.darkMuted : AppColors.lightMuted,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            isExceeded
                ? (l10n?.safeSpendExceededDescription ??
                    'Budget limit reached. Reserve remaining funds for committed bills.')
                : (l10n?.safeSpendDescription ??
                    'Spend up to this amount today without impacting your bills or savings goals.'),
            style: TextStyle(
              fontSize: 13,
              height: 1.4,
              color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
            ),
          ),
          const SizedBox(height: 18),
          const Divider(height: 1),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildMiniMetric(
                label: l10n?.remainingBudget ?? 'Remaining Budget',
                value: CurrencyFormatter.formatCents(
                  metrics.remainingBudgetCents,
                  currencyCode: currencyCode,
                  compact: true,
                ),
                isDark: isDark,
              ),
              _buildMiniMetric(
                label: l10n?.committedBills ?? 'Committed Bills',
                value: CurrencyFormatter.formatCents(
                  metrics.committedUpcomingBillsCents,
                  currencyCode: currencyCode,
                  compact: true,
                ),
                isDark: isDark,
              ),
              _buildMiniMetric(
                label: l10n?.projectedEnd ?? 'Projected End',
                value: CurrencyFormatter.formatCents(
                  metrics.projectedMonthEndExpenseCents,
                  currencyCode: currencyCode,
                  compact: true,
                ),
                isDark: isDark,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMiniMetric({
    required String label,
    required String value,
    required bool isDark,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: isDark ? AppColors.darkText : AppColors.lightText,
          ),
        ),
      ],
    );
  }
}
