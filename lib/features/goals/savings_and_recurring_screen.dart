import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/currency_formatter.dart';
import '../../data/models/savings_goal_model.dart';
import '../../data/models/subscription_model.dart';
import '../../l10n/generated/app_localizations.dart';
import '../providers/finance_providers.dart';

class SavingsAndRecurringScreen extends ConsumerStatefulWidget {
  const SavingsAndRecurringScreen({super.key});

  @override
  ConsumerState<SavingsAndRecurringScreen> createState() => _SavingsAndRecurringScreenState();
}

class _SavingsAndRecurringScreenState extends ConsumerState<SavingsAndRecurringScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showAddGoalDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final nameCtrl = TextEditingController();
    final targetCtrl = TextEditingController();
    DateTime targetDate = DateTime.now().add(const Duration(days: 180));

    showDialog(
      context: context,
      builder: (dialogCtx) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            title: Text(l10n?.createSavingsGoal ?? 'Create Savings Goal'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameCtrl,
                    decoration: InputDecoration(labelText: l10n?.goalNameLabel ?? 'Goal Name (e.g. New Laptop)'),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: targetCtrl,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(labelText: l10n?.targetAmountLabel ?? 'Target Amount'),
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(l10n?.targetDateLabel ?? 'Target Date', style: const TextStyle(fontSize: 14)),
                    subtitle: Text(
                      '${targetDate.year}-${targetDate.month.toString().padLeft(2, '0')}-${targetDate.day.toString().padLeft(2, '0')}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: const Icon(Icons.calendar_today_rounded, size: 20),
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: targetDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2035),
                      );
                      if (picked != null) {
                        setDialogState(() => targetDate = picked);
                      }
                    },
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(dialogCtx), child: Text(l10n?.cancel ?? 'Cancel')),
              ElevatedButton(
                onPressed: () {
                  final target = double.tryParse(targetCtrl.text.replaceAll(',', '.'));
                  if (nameCtrl.text.trim().isEmpty || target == null || target <= 0) return;

                  ref.read(savingsGoalsProvider.notifier).addGoal(
                    name: nameCtrl.text.trim(),
                    targetAmountCents: (target * 100).round(),
                    targetDate: targetDate,
                    iconCode: Icons.flag_rounded.codePoint,
                    colorHex: 0xFF16A36A,
                  );
                  Navigator.pop(dialogCtx);
                },
                child: Text(l10n?.createGoal ?? 'Create Goal'),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showContributeDialog(BuildContext context, SavingsGoalModel goal) {
    final l10n = AppLocalizations.of(context);
    final amountCtrl = TextEditingController();
    showDialog(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        title: Text(l10n?.contributeTo(goal.name) ?? 'Contribute to "${goal.name}"'),
        content: TextField(
          controller: amountCtrl,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          autofocus: true,
          decoration: InputDecoration(
            labelText: l10n?.contributionAmount ?? 'Contribution Amount',
            prefixIcon: const Icon(Icons.add_circle_outline_rounded),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogCtx), child: Text(l10n?.cancel ?? 'Cancel')),
          ElevatedButton(
            onPressed: () {
              final amt = double.tryParse(amountCtrl.text.replaceAll(',', '.'));
              if (amt == null || amt <= 0) return;
              ref.read(savingsGoalsProvider.notifier).contribute(goal.id, (amt * 100).round());
              Navigator.pop(dialogCtx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(l10n?.depositedSuccess(CurrencyFormatter.formatAmount(amt), goal.name) ??
                      'Deposited ${CurrencyFormatter.formatAmount(amt)} to ${goal.name}!'),
                  backgroundColor: AppColors.primaryGreen,
                ),
              );
            },
            child: Text(l10n?.addFunds ?? 'Add Funds'),
          ),
        ],
      ),
    );
  }

  void _showAddSubscriptionDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final nameCtrl = TextEditingController();
    final amountCtrl = TextEditingController();
    BillingCycle cycle = BillingCycle.monthly;
    DateTime nextDate = DateTime.now().add(const Duration(days: 14));

    showDialog(
      context: context,
      builder: (dialogCtx) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            title: Text(l10n?.addSubscriptionTitle ?? 'Add Recurring Bill / Subscription'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameCtrl,
                    decoration: InputDecoration(
                      labelText: l10n?.serviceNameLabel ?? 'Service Name (e.g. Netflix, Gym)',
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: amountCtrl,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: l10n?.amountPerCycleLabel ?? 'Amount per Cycle',
                    ),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<BillingCycle>(
                    initialValue: cycle,
                    decoration: InputDecoration(
                      labelText: l10n?.billingFrequencyLabel ?? 'Billing Frequency',
                    ),
                    items: BillingCycle.values.map((c) {
                      String label;
                      switch (c) {
                        case BillingCycle.monthly:
                          label = l10n?.billingMonthly ?? 'Monthly';
                          break;
                        case BillingCycle.weekly:
                          label = l10n?.billingWeekly ?? 'Weekly';
                          break;
                        case BillingCycle.quarterly:
                          label = l10n?.billingQuarterly ?? 'Quarterly';
                          break;
                        case BillingCycle.yearly:
                          label = l10n?.billingYearly ?? 'Yearly';
                          break;
                      }
                      return DropdownMenuItem(
                        value: c,
                        child: Text(label),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) setDialogState(() => cycle = val);
                    },
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(dialogCtx), child: Text(l10n?.cancel ?? 'Cancel')),
              ElevatedButton(
                onPressed: () {
                  final amt = double.tryParse(amountCtrl.text.replaceAll(',', '.'));
                  if (nameCtrl.text.trim().isEmpty || amt == null || amt <= 0) return;

                  ref.read(subscriptionsProvider.notifier).addSubscription(
                    name: nameCtrl.text.trim(),
                    amountCents: (amt * 100).round(),
                    billingCycle: cycle,
                    nextBillingDate: nextDate,
                    categoryId: 'subscriptions',
                    iconCode: 0xe62e,
                    colorHex: 0xFF6366F1,
                  );
                  Navigator.pop(dialogCtx);
                },
                child: Text(l10n?.saveSubscription ?? 'Save Subscription'),
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
    final currency = ref.watch(currencyProvider);
    final goalsAsync = ref.watch(savingsGoalsProvider);
    final subsAsync = ref.watch(subscriptionsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n?.savingsGoals ?? 'Goals & Subscriptions'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.primaryGreen,
          labelColor: AppColors.primaryGreen,
          unselectedLabelColor: isDark ? AppColors.darkMuted : AppColors.lightMuted,
          tabs: [
            Tab(text: l10n?.savingsGoals ?? 'Savings Goals', icon: const Icon(Icons.flag_rounded)),
            Tab(text: l10n?.recurringSubscriptions ?? 'Subscriptions', icon: const Icon(Icons.repeat_rounded)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // TAB 1: SAVINGS GOALS
          goalsAsync.when(
            data: (goals) {
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          l10n?.activeTargetsCount(goals.length).toUpperCase() ?? 'ACTIVE TARGETS (${goals.length})',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.1,
                            color: isDark ? AppColors.darkMuted : AppColors.lightMuted,
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () => _showAddGoalDialog(context),
                          icon: const Icon(Icons.add_rounded, size: 18),
                          label: Text(l10n?.newGoal ?? 'New Goal'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    if (goals.isEmpty)
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(32),
                          child: Center(
                            child: Column(
                              children: [
                                Icon(Icons.flag_outlined,
                                    size: 56,
                                    color: isDark ? AppColors.darkMuted : AppColors.lightMuted),
                                const SizedBox(height: 12),
                                Text(l10n?.noSavingsGoals ?? 'No savings goals yet. Create one to stay motivated!'),
                              ],
                            ),
                          ),
                        ),
                      )
                    else
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: goals.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final goal = goals[index];
                          final isCompleted = goal.currentAmountCents >= goal.targetAmountCents;

                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(18),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: goal.color.withValues(alpha: 0.15),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(goal.icon, color: goal.color, size: 24),
                                      ),
                                      const SizedBox(width: 14),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              goal.name,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                color: isDark
                                                    ? AppColors.darkText
                                                    : AppColors.lightText,
                                              ),
                                            ),
                                            Text(
                                              l10n?.targetLabel(CurrencyFormatter.formatCents(goal.targetAmountCents, currencyCode: currency)) ??
                                                  'Target: ${CurrencyFormatter.formatCents(goal.targetAmountCents, currencyCode: currency)}',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: isDark
                                                    ? AppColors.darkMuted
                                                    : AppColors.lightMuted,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        '${goal.progressPercentage}%',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800,
                                          color: isCompleted
                                              ? AppColors.primaryGreen
                                              : (isDark ? Colors.white : AppColors.lightText),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(6),
                                    child: LinearProgressIndicator(
                                      value: goal.progressRatio,
                                      minHeight: 10,
                                      backgroundColor: isDark
                                          ? AppColors.darkCardAlt
                                          : AppColors.lightCardAlt,
                                      valueColor:
                                          AlwaysStoppedAnimation<Color>(goal.color),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        l10n?.savedLabel(CurrencyFormatter.formatCents(goal.currentAmountCents, currencyCode: currency)) ??
                                            'Saved: ${CurrencyFormatter.formatCents(goal.currentAmountCents, currencyCode: currency)}',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: isDark
                                              ? AppColors.darkTextSecondary
                                              : AppColors.lightTextSecondary,
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () => _showContributeDialog(context, goal),
                                        style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 8),
                                        ),
                                        child: Text(l10n?.addFunds ?? 'Add Funds',
                                            style: const TextStyle(fontSize: 12)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                  ],
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Error: $e')),
          ),

          // TAB 2: RECURRING SUBSCRIPTIONS & CALENDAR
          subsAsync.when(
            data: (subs) {
              int totalMonthlyBurnCents = 0;
              int totalYearlyBurnCents = 0;
              for (final s in subs) {
                if (s.isActive) {
                  totalMonthlyBurnCents += s.monthlyEquivalentCents;
                  totalYearlyBurnCents += s.yearlyEquivalentCents;
                }
              }

              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  children: [
                    // Summary Overhead Card
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text(
                                  l10n?.monthlyCommitment ?? 'Monthly Commitment',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isDark ? AppColors.darkMuted : AppColors.lightMuted,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  CurrencyFormatter.formatCents(totalMonthlyBurnCents,
                                      currencyCode: currency),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.coral,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: 1,
                              height: 36,
                              color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                            ),
                            Column(
                              children: [
                                Text(
                                  l10n?.annualProjection ?? 'Annual Projection',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isDark ? AppColors.darkMuted : AppColors.lightMuted,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  CurrencyFormatter.formatCents(totalYearlyBurnCents,
                                      currencyCode: currency),
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                    color: isDark ? AppColors.darkText : AppColors.lightText,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          l10n?.subscriptionsAndBillsCount(subs.length).toUpperCase() ?? 'SUBSCRIPTIONS & BILLS (${subs.length})',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.1,
                            color: isDark ? AppColors.darkMuted : AppColors.lightMuted,
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () => _showAddSubscriptionDialog(context),
                          icon: const Icon(Icons.add_rounded, size: 18),
                          label: Text(l10n?.addBill ?? 'Add Bill'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    if (subs.isEmpty)
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(32),
                          child: Center(
                            child: Column(
                              children: [
                                Icon(Icons.repeat_rounded,
                                    size: 56,
                                    color: isDark ? AppColors.darkMuted : AppColors.lightMuted),
                                const SizedBox(height: 12),
                                Text(l10n?.noSubscriptionsYet ?? 'No recurring subscriptions added yet.'),
                              ],
                            ),
                          ),
                        ),
                      )
                    else
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: subs.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          final sub = subs[index];
                          return Card(
                            child: ListTile(
                              leading: Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: sub.color.withValues(alpha: 0.15),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(sub.icon, color: sub.color, size: 22),
                              ),
                              title: Text(
                                sub.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: isDark ? AppColors.darkText : AppColors.lightText,
                                ),
                              ),
                              subtitle: Text(
                                'Renews ${sub.nextBillingDate.month}/${sub.nextBillingDate.day} • ${sub.billingCycle.name}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isDark ? AppColors.darkMuted : AppColors.lightMuted,
                                ),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    CurrencyFormatter.formatCents(sub.amountCents,
                                        currencyCode: currency),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 15,
                                      color: isDark ? Colors.white : AppColors.lightText,
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete_outline_rounded, size: 20),
                                    color: AppColors.coral,
                                    onPressed: () {
                                      ref
                                          .read(subscriptionsProvider.notifier)
                                          .deleteSubscription(sub.id);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                  ],
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Error: $e')),
          ),
        ],
      ),
    );
  }
}
