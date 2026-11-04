import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/currency_formatter.dart';
import '../../core/widgets/budget_progress_ring.dart';
import '../../data/models/category_model.dart';
import '../../l10n/generated/app_localizations.dart';
import '../providers/finance_providers.dart';

class BudgetsScreen extends ConsumerStatefulWidget {
  const BudgetsScreen({super.key});

  @override
  ConsumerState<BudgetsScreen> createState() => _BudgetsScreenState();
}

class _BudgetsScreenState extends ConsumerState<BudgetsScreen> {
  void _showAddBudgetDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final catAsync = ref.read(categoriesProvider);
    final categories = (catAsync.value ?? [])
        .where((c) => c.type == TransactionType.expense)
        .toList();

    String? selectedCategoryId = categories.isNotEmpty ? categories.first.id : null;
    final limitController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogCtx) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            title: Text(l10n?.createCategoryBudget ?? 'Create Category Budget'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n?.selectCategory ?? 'Select Category', style: const TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    initialValue: selectedCategoryId,
                    items: categories.map((cat) {
                      return DropdownMenuItem<String>(
                        value: cat.id,
                        child: Row(
                          children: [
                            Icon(cat.icon, size: 18, color: cat.color),
                            const SizedBox(width: 8),
                            Text(cat.localizedName(l10n)),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setDialogState(() => selectedCategoryId = val);
                    },
                  ),
                  const SizedBox(height: 16),
                  Text(l10n?.monthlyLimit ?? 'Monthly Limit', style: const TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: limitController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      hintText: l10n?.limitPlaceholder ?? 'e.g. 500.00',
                      prefixIcon: const Icon(Icons.attach_money_rounded),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogCtx),
                child: Text(l10n?.cancel ?? 'Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  final limit = double.tryParse(limitController.text.replaceAll(',', '.'));
                  if (limit == null || limit <= 0) return;
                  final category = categories.firstWhere((c) => c.id == selectedCategoryId);

                  ref.read(budgetsProvider.notifier).setBudget(
                    categoryId: category.id,
                    name: '${category.localizedName(l10n)} ${l10n?.navBudgets ?? 'Budget'}',
                    limitCents: (limit * 100).round(),
                  );
                  Navigator.pop(dialogCtx);
                },
                child: Text(l10n?.setBudget ?? 'Set Budget'),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);
    final budgetsAsync = ref.watch(budgetsProvider);
    final txAsync = ref.watch(transactionsProvider);
    final catAsync = ref.watch(categoriesProvider);
    final currency = ref.watch(currencyProvider);
    final metrics = ref.watch(dashboardMetricsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n?.navBudgets ?? 'Budgets'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Master Monthly Budget Ring
            if (metrics != null)
              BudgetProgressRing(
                spentCents: metrics.totalExpenseCents,
                totalBudgetCents: metrics.remainingBudgetCents + metrics.totalExpenseCents,
                currencyCode: currency,
              ),
            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n?.categoryBudgets.toUpperCase() ?? 'CATEGORY BUDGETS',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.1,
                    color: isDark ? AppColors.darkMuted : AppColors.lightMuted,
                  ),
                ),
                TextButton.icon(
                  onPressed: () => _showAddBudgetDialog(context),
                  icon: const Icon(Icons.add_rounded, size: 18),
                  label: Text(l10n?.setBudget ?? 'Add Budget'),
                ),
              ],
            ),
            const SizedBox(height: 8),

            budgetsAsync.when(
              data: (budgets) {
                final categoryBudgets = budgets.where((b) => b.categoryId != null).toList();
                final transactions = txAsync.value ?? [];
                final categories = catAsync.value ?? [];

                if (categoryBudgets.isEmpty) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Center(
                        child: Column(
                          children: [
                            Icon(Icons.pie_chart_outline_rounded,
                                size: 48,
                                color: isDark ? AppColors.darkMuted : AppColors.lightMuted),
                            const SizedBox(height: 12),
                            Text(
                              l10n?.noCategoryBudgets ?? 'No category budgets set yet.',
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

                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: categoryBudgets.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final budget = categoryBudgets[index];
                    final category = categories.firstWhere(
                      (c) => c.id == budget.categoryId,
                      orElse: () => CategoryModel(
                        id: 'other',
                        name: 'Category',
                        icon: Icons.category_rounded,
                        color: Colors.blue,
                      ),
                    );

                    // Compute spent cents in this category for the current month
                    int spentCents = 0;
                    final now = DateTime.now();
                    for (final tx in transactions) {
                      if (tx.categoryId == budget.categoryId &&
                          tx.type == TransactionType.expense &&
                          tx.date.month == now.month &&
                          tx.date.year == now.year) {
                        spentCents += tx.amountCents;
                      }
                    }

                    final ratio = budget.limitCents > 0
                        ? (spentCents / budget.limitCents).clamp(0.0, 1.5)
                        : 0.0;
                    final percentage = (ratio * 100).round();

                    Color statusColor;
                    if (percentage < 75) {
                      statusColor = AppColors.primaryGreen;
                    } else if (percentage <= 90) {
                      statusColor = AppColors.warning;
                    } else {
                      statusColor = AppColors.coral;
                    }

                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
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
                                        color: category.color.withValues(alpha: 0.15),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(category.icon, color: category.color, size: 20),
                                    ),
                                    const SizedBox(width: 12),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          category.localizedName(l10n),
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15,
                                            color: isDark ? AppColors.darkText : AppColors.lightText,
                                          ),
                                        ),
                                        Text(
                                          '${CurrencyFormatter.formatCents(spentCents, currencyCode: currency)} / ${CurrencyFormatter.formatCents(budget.limitCents, currencyCode: currency)}',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: isDark ? AppColors.darkMuted : AppColors.lightMuted,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete_outline_rounded, size: 20),
                                  color: AppColors.coral,
                                  onPressed: () {
                                    ref.read(budgetsProvider.notifier).deleteBudget(budget.id);
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: LinearProgressIndicator(
                                value: (ratio > 1.0 ? 1.0 : ratio).toDouble(),
                                minHeight: 8,
                                backgroundColor:
                                    isDark ? AppColors.darkCardAlt : AppColors.lightCardAlt,
                                valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  l10n?.consumedPercent(percentage) ?? '$percentage% consumed',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: statusColor,
                                  ),
                                ),
                                Text(
                                  budget.limitCents > spentCents
                                      ? (l10n?.amountRemaining(CurrencyFormatter.formatCents(budget.limitCents - spentCents, currencyCode: currency)) ??
                                          '${CurrencyFormatter.formatCents(budget.limitCents - spentCents, currencyCode: currency)} remaining')
                                      : (l10n?.amountOverLimit(CurrencyFormatter.formatCents(spentCents - budget.limitCents, currencyCode: currency)) ??
                                          '${CurrencyFormatter.formatCents(spentCents - budget.limitCents, currencyCode: currency)} over limit'),
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: budget.limitCents > spentCents
                                        ? (isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary)
                                        : AppColors.coral,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Text('Error: $e'),
            ),
          ],
        ),
      ),
    );
  }
}
