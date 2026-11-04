import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/currency_formatter.dart';
import '../../core/utils/transaction_localizer.dart';
import '../../core/widgets/quick_add_sheet.dart';
import '../../data/models/category_model.dart';
import '../../data/models/transaction_model.dart';
import '../../l10n/generated/app_localizations.dart';
import '../providers/finance_providers.dart';

class TransactionsScreen extends ConsumerStatefulWidget {
  const TransactionsScreen({super.key});

  @override
  ConsumerState<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends ConsumerState<TransactionsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String? _selectedCategoryId;
  TransactionType? _typeFilter; // null = all

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _exportCsv(List<TransactionModel> txs) async {
    final buffer = StringBuffer();
    buffer.writeln('ID,Date,Type,Category,Title,Amount,Notes');
    for (final tx in txs) {
      buffer.writeln(
        '${tx.id},${tx.date.toIso8601String()},${tx.type.name},${tx.categoryId},"${tx.title.replaceAll('"', '""')}",${(tx.amountCents / 100.0).toStringAsFixed(2)},"${(tx.notes ?? '').replaceAll('"', '""')}"',
      );
    }
    await SharePlus.instance.share(
      ShareParams(
        text: buffer.toString(),
        subject: 'Monetra_Transactions_Export.csv',
      ),
    );
  }

  void _confirmDelete(BuildContext context, TransactionModel tx) {
    final l10n = AppLocalizations.of(context);
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n?.deleteTransaction ?? 'Delete Transaction?'),
        content: Text(
          l10n?.confirmDeleteTransaction(tx.title) ??
              'Are you sure you want to delete "${tx.title}"? This cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(l10n?.cancel ?? 'Cancel'),
          ),
          TextButton(
            onPressed: () {
              ref.read(transactionsProvider.notifier).deleteTransaction(tx.id);
              Navigator.pop(dialogContext);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10n?.transactionDeleted ?? 'Transaction deleted')),
              );
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.coral),
            child: Text(l10n?.delete ?? 'Delete'),
          ),
        ],
      ),
    );
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
        title: Text(l10n?.activityHistory ?? 'Activity & History'),
        actions: [
          IconButton(
            tooltip: l10n?.exportCsv ?? 'Export CSV',
            icon: const Icon(Icons.download_rounded),
            onPressed: () {
              final txs = txAsync.value ?? [];
              if (txs.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n?.noTransactionsToExport ?? 'No transactions to export')),
                );
              } else {
                _exportCsv(txs);
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search & Filter Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: _searchController,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText: l10n?.searchPlaceholder ?? 'Search by title, note, or payee...',
                prefixIcon: const Icon(Icons.search_rounded),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear_rounded),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {});
                        },
                      )
                    : null,
              ),
            ),
          ),

          // Type Chips (All, Expense, Income)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _buildFilterChip(l10n?.filterAll ?? 'All', _typeFilter == null, () {
                  setState(() => _typeFilter = null);
                }, isDark),
                const SizedBox(width: 8),
                _buildFilterChip(l10n?.filterExpenses ?? 'Expenses', _typeFilter == TransactionType.expense, () {
                  setState(() => _typeFilter = TransactionType.expense);
                }, isDark),
                const SizedBox(width: 8),
                _buildFilterChip(l10n?.filterIncome ?? 'Income', _typeFilter == TransactionType.income, () {
                  setState(() => _typeFilter = TransactionType.income);
                }, isDark),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Categories horizontal chip filter
          catAsync.when(
            data: (cats) {
              return SizedBox(
                height: 38,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: cats.length + 1,
                  separatorBuilder: (_, _) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return ChoiceChip(
                        label: Text(l10n?.allCategories ?? 'All Categories'),
                        selected: _selectedCategoryId == null,
                        onSelected: (val) {
                          setState(() => _selectedCategoryId = null);
                        },
                      );
                    }
                    final cat = cats[index - 1];
                    return ChoiceChip(
                      avatar: Icon(cat.icon, size: 16, color: cat.color),
                      label: Text(cat.localizedName(l10n)),
                      selected: _selectedCategoryId == cat.id,
                      onSelected: (val) {
                        setState(() => _selectedCategoryId = val ? cat.id : null);
                      },
                    );
                  },
                ),
              );
            },
            loading: () => const SizedBox(height: 38),
            error: (_, _) => const SizedBox(height: 38),
          ),
          const SizedBox(height: 12),

          // Transactions List
          Expanded(
            child: txAsync.when(
              data: (txList) {
                final query = _searchController.text.trim().toLowerCase();
                final filtered = txList.where((tx) {
                  if (_typeFilter != null && tx.type != _typeFilter) return false;
                  if (_selectedCategoryId != null && tx.categoryId != _selectedCategoryId) return false;
                  if (query.isNotEmpty) {
                    final matchesTitle = tx.title.toLowerCase().contains(query);
                    final matchesNotes = tx.notes?.toLowerCase().contains(query) ?? false;
                    return matchesTitle || matchesNotes;
                  }
                  return true;
                }).toList();

                if (filtered.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.receipt_long_rounded,
                            size: 64, color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
                        const SizedBox(height: 16),
                        Text(
                          l10n?.noTransactionsFound ?? 'No matching transactions found.',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: isDark ? AppColors.darkMuted : AppColors.lightMuted,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                final categories = catAsync.value ?? [];

                return ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  itemCount: filtered.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final tx = filtered[index];
                    final cat = categories.firstWhere(
                      (c) => c.id == tx.categoryId,
                      orElse: () => CategoryModel(
                        id: 'other',
                        name: 'Other',
                        icon: Icons.category_rounded,
                        color: Colors.grey,
                      ),
                    );
                    final isIncome = tx.type == TransactionType.income;

                    return Card(
                      child: ListTile(
                        leading: Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: cat.color.withValues(alpha: 0.15),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(cat.icon, color: cat.color, size: 22),
                        ),
                        title: Text(
                          getLocalizedTxTitle(tx.title, l10n),
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: isDark ? AppColors.darkText : AppColors.lightText,
                          ),
                        ),
                        subtitle: Text(
                          '${tx.date.year}-${tx.date.month.toString().padLeft(2, '0')}-${tx.date.day.toString().padLeft(2, '0')} • ${cat.localizedName(l10n)}${tx.notes != null ? ' • "${tx.notes}"' : ''}',
                          style: TextStyle(
                            fontSize: 12,
                            color: isDark ? AppColors.darkMuted : AppColors.lightMuted,
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${isIncome ? '+' : '-'}${CurrencyFormatter.formatCents(tx.amountCents, currencyCode: currency)}',
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 15,
                                color: isIncome ? AppColors.income : (isDark ? Colors.white : AppColors.lightText),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete_outline_rounded, size: 20),
                              color: AppColors.coral,
                              onPressed: () => _confirmDelete(context, tx),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error loading transactions: $e')),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => QuickAddSheet.show(context),
        backgroundColor: AppColors.primaryGreen,
        child: const Icon(Icons.add_rounded, color: Colors.white),
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected, VoidCallback onTap, bool isDark) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryGreen
              : (isDark ? AppColors.darkCard : AppColors.lightCard),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? AppColors.primaryGreen
                : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            color: isSelected
                ? Colors.white
                : (isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary),
          ),
        ),
      ),
    );
  }
}
