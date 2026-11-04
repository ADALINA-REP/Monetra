import 'package:flutter/material.dart';
import '../../l10n/generated/app_localizations.dart';
import '../theme/app_colors.dart';
import '../utils/currency_formatter.dart';

class BudgetProgressRing extends StatelessWidget {
  final int spentCents;
  final int totalBudgetCents;
  final String currencyCode;

  const BudgetProgressRing({
    super.key,
    required this.spentCents,
    required this.totalBudgetCents,
    required this.currencyCode,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);
    final ratio = totalBudgetCents > 0 ? (spentCents / totalBudgetCents).clamp(0.0, 1.5) : 0.0;
    final percentage = (ratio * 100).round();

    Color statusColor;
    String statusText;
    if (percentage < 75) {
      statusColor = AppColors.primaryGreen;
      statusText = l10n?.onTrack ?? 'On Track';
    } else if (percentage <= 90) {
      statusColor = AppColors.warning;
      statusText = l10n?.attention ?? 'Attention';
    } else {
      statusColor = AppColors.coral;
      statusText = l10n?.limitExceeded ?? 'Limit Exceeded';
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n?.monthlyBudgetUpper ?? 'MONTHLY BUDGET',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.1,
                        color: isDark ? AppColors.darkMuted : AppColors.lightMuted,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${CurrencyFormatter.formatCents(spentCents, currencyCode: currencyCode)} / ${CurrencyFormatter.formatCents(totalBudgetCents, currencyCode: currencyCode)}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: isDark ? AppColors.darkText : AppColors.lightText,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: statusColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        statusText,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: statusColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: (ratio > 1.0 ? 1.0 : ratio).toDouble(),
                minHeight: 12,
                backgroundColor: isDark ? AppColors.darkCardAlt : AppColors.lightCardAlt,
                valueColor: AlwaysStoppedAnimation<Color>(statusColor),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n?.consumedPercent(percentage) ?? '$percentage% consumed',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                  ),
                ),
                Text(
                  totalBudgetCents > spentCents
                      ? (l10n?.amountRemaining(CurrencyFormatter.formatCents(totalBudgetCents - spentCents, currencyCode: currencyCode)) ??
                          '${CurrencyFormatter.formatCents(totalBudgetCents - spentCents, currencyCode: currencyCode)} remaining')
                      : (l10n?.amountOverLimit(CurrencyFormatter.formatCents(spentCents - totalBudgetCents, currencyCode: currencyCode)) ??
                          '${CurrencyFormatter.formatCents(spentCents - totalBudgetCents, currencyCode: currencyCode)} over limit'),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: totalBudgetCents > spentCents ? statusColor : AppColors.coral,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
