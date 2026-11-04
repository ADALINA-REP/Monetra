import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';
import 'package:share_plus/share_plus.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/currency_formatter.dart';
import '../../l10n/generated/app_localizations.dart';
import '../providers/finance_providers.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  String _getLocaleDisplayName(Locale? locale) {
    if (locale == null) return '🌐 System Default';
    switch (locale.languageCode) {
      case 'fr':
        return '🇫🇷 Français (French)';
      case 'de':
        return '🇩🇪 Deutsch (German)';
      case 'es':
        return '🇪🇸 Español (Spanish)';
      case 'pt':
        return '🇧🇷 Português (Portuguese)';
      case 'ar':
        return '🇲🇦 العربية (Arabic)';
      case 'en':
      default:
        return '🇬🇧 English';
    }
  }

  void _showLanguagePicker(BuildContext context, WidgetRef ref, Locale? current) {
    final l10n = AppLocalizations.of(context);
    final languages = [
      {'code': null, 'flag': '🌐', 'name': 'System Default', 'native': 'Automatic'},
      {'code': 'en', 'flag': '🇬🇧', 'name': 'English', 'native': 'English'},
      {'code': 'fr', 'flag': '🇫🇷', 'name': 'French', 'native': 'Français'},
      {'code': 'de', 'flag': '🇩🇪', 'name': 'German', 'native': 'Deutsch'},
      {'code': 'es', 'flag': '🇪🇸', 'name': 'Spanish', 'native': 'Español'},
      {'code': 'pt', 'flag': '🇧🇷', 'name': 'Portuguese', 'native': 'Português'},
      {'code': 'ar', 'flag': '🇲🇦', 'name': 'Arabic', 'native': 'العربية (RTL)'},
    ];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.75,
            ),
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        l10n?.language ?? 'Language',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close_rounded),
                        onPressed: () => Navigator.pop(ctx),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),
                Expanded(
                  child: ListView.builder(
                    itemCount: languages.length,
                    itemBuilder: (context, index) {
                      final lang = languages[index];
                      final code = lang['code'];
                      final isSelected = current?.languageCode == code;
                      return ListTile(
                        leading: Container(
                          width: 44,
                          height: 44,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primaryGreen.withValues(alpha: 0.15)
                                : Colors.grey.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            lang['flag']!,
                            style: const TextStyle(fontSize: 24),
                          ),
                        ),
                        title: Text(
                          lang['native']!,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: isSelected ? AppColors.primaryGreen : null,
                          ),
                        ),
                        subtitle: Text(lang['name']!),
                        trailing: isSelected
                            ? const Icon(Icons.check_circle_rounded, color: AppColors.primaryGreen)
                            : null,
                        onTap: () {
                          ref.read(localeProvider.notifier).setLocale(code != null ? Locale(code) : null);
                          Navigator.pop(ctx);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showCurrencyPicker(BuildContext context, WidgetRef ref, String current) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Select Primary Currency',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: ListView.builder(
                    itemCount: CurrencyFormatter.supportedCurrencies.length,
                    itemBuilder: (context, index) {
                      final curr = CurrencyFormatter.supportedCurrencies[index];
                      final isSelected = curr.code == current;
                      return ListTile(
                        leading: Text(curr.flag, style: const TextStyle(fontSize: 24)),
                        title: Text('${curr.name} (${curr.code})',
                            style: const TextStyle(fontWeight: FontWeight.w600)),
                        trailing: isSelected
                            ? const Icon(Icons.check_rounded, color: AppColors.primaryGreen)
                            : null,
                        onTap: () {
                          ref.read(currencyProvider.notifier).setCurrency(curr.code);
                          Navigator.pop(ctx);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showThemePicker(BuildContext context, WidgetRef ref, ThemeMode current) {
    final l10n = AppLocalizations.of(context);
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n?.chooseAppearance ?? 'Choose Appearance', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                const SizedBox(height: 16),
                ListTile(
                  leading: const Icon(Icons.settings_brightness_rounded),
                  title: Text(l10n?.systemDefault ?? 'System Default'),
                  trailing: current == ThemeMode.system
                      ? const Icon(Icons.check_rounded, color: AppColors.primaryGreen)
                      : null,
                  onTap: () {
                    ref.read(themeModeProvider.notifier).setThemeMode(ThemeMode.system);
                    Navigator.pop(ctx);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.light_mode_rounded),
                  title: Text(l10n?.themeLight ?? 'Modern Light'),
                  trailing: current == ThemeMode.light
                      ? const Icon(Icons.check_rounded, color: AppColors.primaryGreen)
                      : null,
                  onTap: () {
                    ref.read(themeModeProvider.notifier).setThemeMode(ThemeMode.light);
                    Navigator.pop(ctx);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.dark_mode_rounded),
                  title: Text(l10n?.themeDark ?? 'Midnight Dark'),
                  trailing: current == ThemeMode.dark
                      ? const Icon(Icons.check_rounded, color: AppColors.primaryGreen)
                      : null,
                  onTap: () {
                    ref.read(themeModeProvider.notifier).setThemeMode(ThemeMode.dark);
                    Navigator.pop(ctx);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _exportBackupJson(BuildContext context, WidgetRef ref) async {
    try {
      final repo = ref.read(financeRepositoryProvider);
      final data = await repo.exportData();
      final jsonStr = const JsonEncoder.withIndent('  ').convert(data);
      await SharePlus.instance.share(
        ShareParams(
          text: jsonStr,
          subject: 'Monetra_Encrypted_Backup.json',
        ),
      );
    } catch (e) {
      if (context.mounted) {
        final l10n = AppLocalizations.of(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n?.backupExportError(e.toString()) ?? 'Backup export error: $e')),
        );
      }
    }
  }

  Future<void> _restoreBackupJson(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    try {
      final files = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
      );

      if (files.isEmpty) return;
      final file = files.first;
      final content = await file.xFile.readAsString();

      final data = jsonDecode(content) as Map<String, dynamic>;
      if (!data.containsKey('transactions') && !data.containsKey('categories')) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n?.backupInvalidFormat ?? 'Invalid Monetra backup format.')),
          );
        }
        return;
      }

      if (context.mounted) {
        final confirmed = await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text(l10n?.restoreBackupTitle ?? 'Restore Backup?'),
            content: Text(
              l10n?.restoreBackupConfirm ??
                  'Restoring this backup will replace current transactions, budgets, and savings goals with the saved data. Proceed?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: Text(l10n?.cancel ?? 'Cancel'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(ctx, true),
                child: Text(l10n?.restoreDataBtn ?? 'Restore Data'),
              ),
            ],
          ),
        );

        if (confirmed != true) return;
      }

      final repo = ref.read(financeRepositoryProvider);
      await repo.restoreData(data);

      ref.read(transactionsProvider.notifier).refresh();
      ref.read(budgetsProvider.notifier).refresh();
      ref.read(savingsGoalsProvider.notifier).refresh();
      ref.read(subscriptionsProvider.notifier).refresh();

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n?.sampleDataLoaded ?? 'Backup restored successfully!'),
            backgroundColor: AppColors.primaryGreen,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n?.restoreBackupError(e.toString()) ?? 'Error restoring backup: $e')),
        );
      }
    }
  }

  Future<void> _toggleBiometrics(BuildContext context, WidgetRef ref, bool currentVal) async {
    final l10n = AppLocalizations.of(context);
    final localAuth = LocalAuthentication();
    final canCheck = await localAuth.canCheckBiometrics || await localAuth.isDeviceSupported();

    if (!canCheck) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n?.biometricsNotAvailable ?? 'Biometrics not available on this device')),
        );
      }
      return;
    }

    try {
      final authenticated = await localAuth.authenticate(
        localizedReason: l10n?.biometricPrompt ?? 'Please authenticate to configure biometric lock',
      );

      if (authenticated) {
        ref.read(biometricLockProvider.notifier).setEnabled(!currentVal);
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n?.biometricsFailed(e.toString()) ?? 'Biometric authentication failed: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);
    final currency = ref.watch(currencyProvider);
    final themeMode = ref.watch(themeModeProvider);
    final biometricEnabled = ref.watch(biometricLockProvider);
    final currentLocale = ref.watch(localeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n?.settings ?? 'Settings & Privacy'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          _buildSectionHeader(l10n?.preferences.toUpperCase() ?? 'PREFERENCES', isDark),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.language_rounded),
                  title: Text(l10n?.language ?? 'Language'),
                  subtitle: Text(_getLocaleDisplayName(currentLocale)),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () => _showLanguagePicker(context, ref, currentLocale),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.currency_exchange_rounded),
                  title: Text(l10n?.currency ?? 'Primary Currency'),
                  subtitle: Text(
                      '${CurrencyFormatter.getCurrency(currency).name} (${CurrencyFormatter.getCurrency(currency).symbol})'),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () => _showCurrencyPicker(context, ref, currency),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.palette_outlined),
                  title: Text(l10n?.appearance ?? 'Theme & Appearance'),
                  subtitle: Text(_getThemeDisplayName(themeMode, l10n)),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () => _showThemePicker(context, ref, themeMode),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          _buildSectionHeader(l10n?.dataPortability ?? 'DATA PORTABILITY & BACKUP', isDark),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.backup_rounded),
                  title: Text(l10n?.backupData ?? 'Export Complete Backup (JSON)'),
                  subtitle: Text(l10n?.backupSubtitle ?? 'Export all transactions, goals, and budgets'),
                  trailing: const Icon(Icons.file_upload_outlined),
                  onTap: () => _exportBackupJson(context, ref),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.restore_page_rounded),
                  title: Text(l10n?.restoreData ?? 'Restore from Backup (JSON)'),
                  subtitle: Text(l10n?.restoreSubtitle ?? 'Restore data from a saved Monetra JSON file'),
                  trailing: const Icon(Icons.file_download_outlined),
                  onTap: () => _restoreBackupJson(context, ref),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.replay_rounded),
                  title: Text(l10n?.seedSampleData ?? 'Seed Sample FinTech Data'),
                  subtitle: Text(l10n?.seedSampleSubtitle ?? 'Populates sample income, bills, and goals'),
                  trailing: const Icon(Icons.arrow_forward_rounded),
                  onTap: () async {
                    await ref.read(financeRepositoryProvider).seedInitialData(force: true);
                    ref.read(transactionsProvider.notifier).refresh();
                    ref.read(budgetsProvider.notifier).refresh();
                    ref.read(savingsGoalsProvider.notifier).refresh();
                    ref.read(subscriptionsProvider.notifier).refresh();
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(l10n?.sampleDataLoaded ?? 'Sample data loaded successfully!'),
                          backgroundColor: AppColors.primaryGreen,
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          _buildSectionHeader(l10n?.security ?? 'SECURITY & PRIVACY', isDark),
          Card(
            child: Column(
              children: [
                SwitchListTile(
                  secondary: const Icon(Icons.fingerprint_rounded),
                  title: Text(l10n?.biometricLock ?? 'Require Biometric Lock'),
                  subtitle: Text(l10n?.biometricSubtitle ?? 'Face ID, Fingerprint, or Device Passcode'),
                  value: biometricEnabled,
                  activeThumbColor: AppColors.primaryGreen,
                  onChanged: (_) => _toggleBiometrics(context, ref, biometricEnabled),
                ),
                const Divider(height: 1),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.primaryGreen.withValues(alpha: 0.12),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.lock_outline_rounded,
                                color: AppColors.primaryGreen, size: 20),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            l10n?.dataSovereignty ?? '100% Local-First & Private',
                            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        l10n?.dataSovereigntySubtitle ??
                            'Your financial numbers never leave your device. Monetra does not transmit bank balances, payees, or transaction details to remote telemetry servers.',
                        style: TextStyle(
                          fontSize: 13,
                          height: 1.4,
                          color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          Center(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/images/monetra_logo.png',
                    width: 44,
                    height: 44,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Monetra v1.0.0 • ${l10n?.appTagline ?? 'Your money. Your vision.'}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isDark ? AppColors.darkMuted : AppColors.lightMuted,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  String _getThemeDisplayName(ThemeMode mode, AppLocalizations? l10n) {
    switch (mode) {
      case ThemeMode.light:
        return l10n?.themeLight ?? 'Clean Light';
      case ThemeMode.dark:
        return l10n?.themeDark ?? 'Midnight Dark';
      case ThemeMode.system:
        return l10n?.systemDefault ?? 'System Default';
    }
  }

  Widget _buildSectionHeader(String title, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.1,
          color: isDark ? AppColors.darkMuted : AppColors.lightMuted,
        ),
      ),
    );
  }
}
