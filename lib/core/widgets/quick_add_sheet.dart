import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/category_model.dart';
import '../../l10n/generated/app_localizations.dart';
import '../theme/app_colors.dart';
import '../utils/currency_formatter.dart';
import '../../features/providers/finance_providers.dart';

class QuickAddSheet extends ConsumerStatefulWidget {
  const QuickAddSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const QuickAddSheet(),
    );
  }

  @override
  ConsumerState<QuickAddSheet> createState() => _QuickAddSheetState();
}

class _QuickAddSheetState extends ConsumerState<QuickAddSheet> {
  TransactionType _type = TransactionType.expense;
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  String? _selectedCategoryId;
  DateTime _selectedDate = DateTime.now();

  @override
  void dispose() {
    _amountController.dispose();
    _titleController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _onCategorySelected(CategoryModel cat, AppLocalizations? l10n) {
    setState(() {
      _selectedCategoryId = cat.id;
      if (_titleController.text.trim().isEmpty) {
        _titleController.text = cat.localizedName(l10n);
      }
    });
  }

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context);
    final amountText = _amountController.text.replaceAll(',', '.').trim();
    final amount = double.tryParse(amountText);

    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n?.enterValidAmount ?? 'Please enter a valid amount')),
      );
      return;
    }

    final categories = ref.read(categoriesProvider).value ?? [];
    final activeCategories = categories.where((c) => c.type == _type).toList();
    final categoryId = _selectedCategoryId ??
        (activeCategories.isNotEmpty ? activeCategories.first.id : 'other_expense');

    final title = _titleController.text.trim().isEmpty
        ? (_type == TransactionType.expense ? (l10n?.addExpense ?? 'Expense') : (l10n?.addIncome ?? 'Income'))
        : _titleController.text.trim();

    final cents = (amount * 100).round();

    await ref.read(transactionsProvider.notifier).addTransaction(
      amountCents: cents,
      type: _type,
      categoryId: categoryId,
      title: title,
      date: _selectedDate,
      notes: _notesController.text.trim().isNotEmpty ? _notesController.text.trim() : null,
    );

    if (mounted) {
      HapticFeedback.mediumImpact();
      Navigator.pop(context);
      final curr = ref.read(currencyProvider);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('✓ ${CurrencyFormatter.formatCents(cents, currencyCode: curr)} ($title)'),
          backgroundColor: AppColors.primaryGreen,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);
    final currency = ref.watch(currencyProvider);
    final currencyInfo = CurrencyFormatter.getCurrency(currency);
    final categoriesAsync = ref.watch(categoriesProvider);

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.lightCard,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Segmented Type Selector
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() {
                      _type = TransactionType.expense;
                      _selectedCategoryId = null;
                    }),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: _type == TransactionType.expense
                            ? AppColors.coral
                            : (isDark ? AppColors.darkCardAlt : AppColors.lightCardAlt),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        l10n?.addExpense ?? 'Expense',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: _type == TransactionType.expense
                              ? Colors.white
                              : (isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() {
                      _type = TransactionType.income;
                      _selectedCategoryId = null;
                    }),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: _type == TransactionType.income
                            ? AppColors.primaryGreen
                            : (isDark ? AppColors.darkCardAlt : AppColors.lightCardAlt),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        l10n?.addIncome ?? 'Income',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: _type == TransactionType.income
                              ? Colors.white
                              : (isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Prominent Amount Input
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  currencyInfo.symbol,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                  ),
                ),
                const SizedBox(width: 8),
                IntrinsicWidth(
                  child: TextField(
                    controller: _amountController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    autofocus: true,
                    style: TextStyle(
                      fontSize: 44,
                      fontWeight: FontWeight.w800,
                      color: _type == TransactionType.expense
                          ? (isDark ? Colors.white : AppColors.lightText)
                          : AppColors.primaryGreen,
                    ),
                    decoration: const InputDecoration(
                      hintText: '0.00',
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      filled: false,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Category Selection Carousel
            Text(
              l10n?.category.toUpperCase() ?? 'CATEGORY',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.1,
                color: isDark ? AppColors.darkMuted : AppColors.lightMuted,
              ),
            ),
            const SizedBox(height: 10),
            categoriesAsync.when(
              data: (categories) {
                final filtered = categories.where((c) => c.type == _type).toList();
                if (_selectedCategoryId == null && filtered.isNotEmpty) {
                  _selectedCategoryId = filtered.first.id;
                }
                return SizedBox(
                  height: 82,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: filtered.length,
                    separatorBuilder: (_, _) => const SizedBox(width: 10),
                    itemBuilder: (context, index) {
                      final cat = filtered[index];
                      final isSelected = cat.id == _selectedCategoryId;
                      return GestureDetector(
                        onTap: () => _onCategorySelected(cat, l10n),
                        child: Column(
                          children: [
                            Container(
                              width: 52,
                              height: 52,
                              decoration: BoxDecoration(
                                color: isSelected ? cat.color : cat.color.withValues(alpha: 0.15),
                                shape: BoxShape.circle,
                                border: isSelected
                                    ? Border.all(color: Colors.white, width: 2)
                                    : null,
                              ),
                              child: Icon(
                                cat.icon,
                                color: isSelected ? Colors.white : cat.color,
                                size: 24,
                              ),
                            ),
                            const SizedBox(height: 4),
                            SizedBox(
                              width: 68,
                              child: Text(
                                cat.localizedName(l10n),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                                  color: isDark ? AppColors.darkText : AppColors.lightText,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
              loading: () => const LinearProgressIndicator(),
              error: (e, _) => Text('Failed to load categories: $e'),
            ),
            const SizedBox(height: 16),
            // Title Input
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: l10n?.descriptionPayee ?? 'Description / Payee',
                prefixIcon: const Icon(Icons.edit_note_rounded),
              ),
            ),
            const SizedBox(height: 12),
            // Date Picker Row
            InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2030),
                );
                if (picked != null) {
                  setState(() => _selectedDate = picked);
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkCardAlt : AppColors.lightCardAlt,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.calendar_today_rounded,
                        size: 20,
                        color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary),
                    const SizedBox(width: 12),
                    Text(
                      '${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isDark ? AppColors.darkText : AppColors.lightText,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      l10n?.changeDate ?? 'Change',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryGreen,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Submit Button
            ElevatedButton(
              onPressed: _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: _type == TransactionType.expense
                    ? AppColors.coral
                    : AppColors.primaryGreen,
                padding: const EdgeInsets.symmetric(vertical: 18),
              ),
              child: Text(
                _type == TransactionType.expense
                    ? (l10n?.saveExpense ?? 'Save Expense')
                    : (l10n?.saveIncome ?? 'Save Income'),
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
