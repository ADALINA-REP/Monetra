import 'package:intl/intl.dart';

class CurrencyInfo {
  final String code;
  final String symbol;
  final String name;
  final String flag;

  const CurrencyInfo({
    required this.code,
    required this.symbol,
    required this.name,
    required this.flag,
  });
}

class CurrencyFormatter {
  static const List<CurrencyInfo> supportedCurrencies = [
    CurrencyInfo(code: 'USD', symbol: '\$', name: 'US Dollar', flag: '🇺🇸'),
    CurrencyInfo(code: 'EUR', symbol: '€', name: 'Euro', flag: '🇪🇺'),
    CurrencyInfo(code: 'GBP', symbol: '£', name: 'British Pound', flag: '🇬🇧'),
    CurrencyInfo(code: 'CAD', symbol: 'CA\$', name: 'Canadian Dollar', flag: '🇨🇦'),
    CurrencyInfo(code: 'AUD', symbol: 'AU\$', name: 'Australian Dollar', flag: '🇦🇺'),
    CurrencyInfo(code: 'CHF', symbol: 'CHF', name: 'Swiss Franc', flag: '🇨🇭'),
    CurrencyInfo(code: 'AED', symbol: 'AED', name: 'UAE Dirham', flag: '🇦🇪'),
    CurrencyInfo(code: 'MAD', symbol: 'MAD', name: 'Moroccan Dirham', flag: '🇲🇦'),
  ];

  static CurrencyInfo getCurrency(String code) {
    return supportedCurrencies.firstWhere(
      (c) => c.code.toUpperCase() == code.toUpperCase(),
      orElse: () => supportedCurrencies.first,
    );
  }

  /// Formats minor currency units (cents) into a clean string.
  /// e.g. 1050 cents with USD -> "$10.50"
  static String formatCents(int cents, {String currencyCode = 'USD', bool compact = false}) {
    final currency = getCurrency(currencyCode);
    final amount = cents / 100.0;

    if (compact && amount.abs() >= 10000) {
      final formatter = NumberFormat.compact();
      return '${currency.symbol}${formatter.format(amount)}';
    }

    final formatter = NumberFormat.currency(
      symbol: currency.symbol,
      decimalDigits: 2,
    );
    return formatter.format(amount);
  }

  /// Formats double amount into a currency string
  static String formatAmount(double amount, {String currencyCode = 'USD'}) {
    return formatCents((amount * 100).round(), currencyCode: currencyCode);
  }
}
