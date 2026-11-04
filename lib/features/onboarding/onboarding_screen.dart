import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/currency_formatter.dart';
import '../../l10n/generated/app_localizations.dart';
import '../providers/finance_providers.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  String _selectedCurrency = 'USD';
  final TextEditingController _incomeController = TextEditingController(text: '4500');
  final TextEditingController _budgetController = TextEditingController(text: '3200');
  ThemeMode _selectedTheme = ThemeMode.system;

  @override
  void dispose() {
    _pageController.dispose();
    _incomeController.dispose();
    _budgetController.dispose();
    super.dispose();
  }

  Future<void> _completeOnboarding() async {
    final repo = ref.read(financeRepositoryProvider);
    await repo.setCurrency(_selectedCurrency);
    ref.read(currencyProvider.notifier).setCurrency(_selectedCurrency);

    final income = double.tryParse(_incomeController.text.replaceAll(',', '.')) ?? 4500.0;
    await repo.setMonthlyIncomeCents((income * 100).round());

    final budget = double.tryParse(_budgetController.text.replaceAll(',', '.')) ?? 3200.0;
    final now = DateTime.now();
    final periodMonth = '${now.year}-${now.month.toString().padLeft(2, '0')}';
    await repo.setBudget(
      name: 'Total Monthly Spending',
      limitCents: (budget * 100).round(),
      periodMonth: periodMonth,
    );

    // Seed realistic starting demo data
    await repo.seedInitialData();
    await repo.setOnboardingComplete(true);

    ref.read(themeModeProvider.notifier).setThemeMode(_selectedTheme);
    ref.read(transactionsProvider.notifier).refresh();
    ref.read(budgetsProvider.notifier).refresh();

    if (mounted) {
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
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
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ],
                  ),
                  if (_currentPage < 3)
                    TextButton(
                      onPressed: _completeOnboarding,
                      child: Text(l10n?.skip ?? 'Skip', style: const TextStyle(fontWeight: FontWeight.w600)),
                    ),
                ],
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (i) => setState(() => _currentPage = i),
                children: [
                  _buildWelcomePage(isDark, l10n),
                  _buildCurrencyPage(isDark, l10n),
                  _buildBudgetPage(isDark, l10n),
                  _buildThemePage(isDark, l10n),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: List.generate(4, (index) {
                      final isActive = index == _currentPage;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.only(right: 6),
                        width: isActive ? 24 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: isActive
                              ? AppColors.primaryGreen
                              : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      );
                    }),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_currentPage < 3) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        _completeOnboarding();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    ),
                    child: Text(_currentPage == 3 ? (l10n?.getStarted ?? 'Get Started') : (l10n?.next ?? 'Next')),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomePage(bool isDark, AppLocalizations? l10n) {
    return Padding(
      padding: const EdgeInsets.all(28),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: Image.asset(
              'assets/images/monetra_logo.png',
              width: 84,
              height: 84,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 28),
          const Text(
            'See your money\ndifferently.',
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.w800,
              height: 1.15,
              letterSpacing: -1.0,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Understand your financial situation in under 5 seconds. Visual-first, local-first, zero confusing spreadsheets.',
            style: TextStyle(
              fontSize: 16,
              height: 1.5,
              color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrencyPage(bool isDark, AppLocalizations? l10n) {
    return Padding(
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Choose your currency',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, letterSpacing: -0.5),
          ),
          const SizedBox(height: 8),
          Text(
            'Monetra supports major international currencies with exact precision.',
            style: TextStyle(
              fontSize: 14,
              color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2.2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: CurrencyFormatter.supportedCurrencies.length,
              itemBuilder: (context, index) {
                final curr = CurrencyFormatter.supportedCurrencies[index];
                final isSelected = curr.code == _selectedCurrency;
                return GestureDetector(
                  onTap: () => setState(() => _selectedCurrency = curr.code),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primaryGreen.withValues(alpha: 0.12)
                          : (isDark ? AppColors.darkCard : AppColors.lightCard),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primaryGreen
                            : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(curr.flag, style: const TextStyle(fontSize: 22)),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              curr.code,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                                color: isDark ? AppColors.darkText : AppColors.lightText,
                              ),
                            ),
                            Text(
                              curr.symbol,
                              style: TextStyle(
                                fontSize: 12,
                                color: isDark ? AppColors.darkMuted : AppColors.lightMuted,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBudgetPage(bool isDark, AppLocalizations? l10n) {
    return Padding(
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Set your monthly baseline',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, letterSpacing: -0.5),
          ),
          const SizedBox(height: 8),
          Text(
            'This enables our "Safe to Spend Today" formula to guide your daily spending.',
            style: TextStyle(
              fontSize: 14,
              color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
            ),
          ),
          const SizedBox(height: 32),
          TextField(
            controller: _incomeController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: l10n?.monthlyIncome ?? 'Estimated Monthly Income',
              prefixIcon: const Icon(Icons.account_balance_wallet_rounded),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _budgetController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: l10n?.monthlyBudget ?? 'Monthly Spending Target',
              prefixIcon: const Icon(Icons.pie_chart_rounded),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThemePage(bool isDark, AppLocalizations? l10n) {
    return Padding(
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n?.chooseAppearance ?? 'Choose your appearance',
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w800, letterSpacing: -0.5),
          ),
          const SizedBox(height: 8),
          Text(
            'Select your preferred visual aesthetic.',
            style: TextStyle(
              fontSize: 14,
              color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
            ),
          ),
          const SizedBox(height: 32),
          _buildThemeOption(
            title: l10n?.systemDefault ?? 'System Default',
            subtitle: 'Follows your operating system schedule',
            icon: Icons.settings_brightness_rounded,
            mode: ThemeMode.system,
            isDark: isDark,
          ),
          const SizedBox(height: 12),
          _buildThemeOption(
            title: l10n?.themeLight ?? 'Modern Light',
            subtitle: 'Crisp, clean airy aesthetic',
            icon: Icons.light_mode_rounded,
            mode: ThemeMode.light,
            isDark: isDark,
          ),
          const SizedBox(height: 12),
          _buildThemeOption(
            title: l10n?.themeDark ?? 'Midnight Dark',
            subtitle: 'Deep OLED-friendly palette with mint accents',
            icon: Icons.dark_mode_rounded,
            mode: ThemeMode.dark,
            isDark: isDark,
          ),
        ],
      ),
    );
  }

  Widget _buildThemeOption({
    required String title,
    required String subtitle,
    required IconData icon,
    required ThemeMode mode,
    required bool isDark,
  }) {
    final isSelected = _selectedTheme == mode;
    return GestureDetector(
      onTap: () => setState(() => _selectedTheme = mode),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryGreen.withValues(alpha: 0.12)
              : (isDark ? AppColors.darkCard : AppColors.lightCard),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isSelected
                ? AppColors.primaryGreen
                : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? AppColors.primaryGreen : AppColors.lightMuted, size: 28),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: isDark ? AppColors.darkText : AppColors.lightText,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? AppColors.darkMuted : AppColors.lightMuted,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle_rounded, color: AppColors.primaryGreen),
          ],
        ),
      ),
    );
  }
}
