import 'package:flutter/material.dart';
import '../../l10n/generated/app_localizations.dart';

enum TransactionType { expense, income }

class CategoryModel {
  final String id;
  final String name;
  final IconData icon;
  final Color color;
  final TransactionType type;
  final bool isDefault;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    this.type = TransactionType.expense,
    this.isDefault = true,
  });

  String localizedName(AppLocalizations? l10n) {
    if (l10n == null) return name;
    switch (id) {
      case 'housing':
        return l10n.catHousing;
      case 'food':
        return l10n.catFood;
      case 'transport':
        return l10n.catTransport;
      case 'shopping':
        return l10n.catShopping;
      case 'entertainment':
        return l10n.catEntertainment;
      case 'health':
        return l10n.catHealth;
      case 'education':
        return l10n.catEducation;
      case 'travel':
        return l10n.catTravel;
      case 'bills':
        return l10n.catBills;
      case 'subscriptions':
        return l10n.catSubscriptions;
      case 'personal_care':
        return l10n.catPersonalCare;
      case 'savings_transfers':
        return l10n.catSavingsTransfers;
      case 'other_expense':
        return l10n.catOtherExpense;
      case 'salary':
        return l10n.catSalary;
      case 'freelance':
        return l10n.catFreelance;
      case 'investments':
        return l10n.catInvestments;
      case 'gifts':
        return l10n.catGifts;
      case 'other_income':
        return l10n.catOtherIncome;
      default:
        return name;
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'icon_code': icon.codePoint,
      'color_hex': color.toARGB32(),
      'type': type.name,
      'is_default': isDefault ? 1 : 0,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] as String,
      name: map['name'] as String,
      icon: IconData(map['icon_code'] as int, fontFamily: 'MaterialIcons'),
      color: Color(map['color_hex'] as int),
      type: (map['type'] as String) == 'income'
          ? TransactionType.income
          : TransactionType.expense,
      isDefault: (map['is_default'] as int) == 1,
    );
  }

  static List<CategoryModel> get defaultExpenseCategories => const [
    CategoryModel(
      id: 'housing',
      name: 'Housing & Rent',
      icon: Icons.home_rounded,
      color: Color(0xFF5478E8),
    ),
    CategoryModel(
      id: 'food',
      name: 'Food & Groceries',
      icon: Icons.restaurant_rounded,
      color: Color(0xFF16A36A),
    ),
    CategoryModel(
      id: 'transport',
      name: 'Transportation',
      icon: Icons.directions_car_rounded,
      color: Color(0xFFF59E0B),
    ),
    CategoryModel(
      id: 'shopping',
      name: 'Shopping',
      icon: Icons.shopping_bag_rounded,
      color: Color(0xFFEC4899),
    ),
    CategoryModel(
      id: 'entertainment',
      name: 'Entertainment',
      icon: Icons.movie_filter_rounded,
      color: Color(0xFF8B5CF6),
    ),
    CategoryModel(
      id: 'health',
      name: 'Health & Medical',
      icon: Icons.medical_services_rounded,
      color: Color(0xFFEF4444),
    ),
    CategoryModel(
      id: 'education',
      name: 'Education',
      icon: Icons.school_rounded,
      color: Color(0xFF3B82F6),
    ),
    CategoryModel(
      id: 'travel',
      name: 'Travel & Vacations',
      icon: Icons.flight_takeoff_rounded,
      color: Color(0xFF06B6D4),
    ),
    CategoryModel(
      id: 'bills',
      name: 'Bills & Utilities',
      icon: Icons.receipt_long_rounded,
      color: Color(0xFF64748B),
    ),
    CategoryModel(
      id: 'subscriptions',
      name: 'Subscriptions',
      icon: Icons.subscriptions_rounded,
      color: Color(0xFF6366F1),
    ),
    CategoryModel(
      id: 'personal_care',
      name: 'Personal Care',
      icon: Icons.spa_rounded,
      color: Color(0xFF14B8A6),
    ),
    CategoryModel(
      id: 'savings_transfers',
      name: 'Savings & Investments',
      icon: Icons.account_balance_wallet_rounded,
      color: Color(0xFF10B981),
    ),
    CategoryModel(
      id: 'other_expense',
      name: 'Other Expenses',
      icon: Icons.more_horiz_rounded,
      color: Color(0xFF94A3B8),
    ),
  ];

  static List<CategoryModel> get defaultIncomeCategories => const [
    CategoryModel(
      id: 'salary',
      name: 'Salary & Wages',
      icon: Icons.payments_rounded,
      color: Color(0xFF16A36A),
      type: TransactionType.income,
    ),
    CategoryModel(
      id: 'freelance',
      name: 'Freelance & Business',
      icon: Icons.laptop_mac_rounded,
      color: Color(0xFF3B82F6),
      type: TransactionType.income,
    ),
    CategoryModel(
      id: 'investments',
      name: 'Investments & Dividends',
      icon: Icons.trending_up_rounded,
      color: Color(0xFF8B5CF6),
      type: TransactionType.income,
    ),
    CategoryModel(
      id: 'gifts',
      name: 'Gifts & Reimbursements',
      icon: Icons.card_giftcard_rounded,
      color: Color(0xFFEC4899),
      type: TransactionType.income,
    ),
    CategoryModel(
      id: 'other_income',
      name: 'Other Income',
      icon: Icons.account_balance_wallet_rounded,
      color: Color(0xFF14B8A6),
      type: TransactionType.income,
    ),
  ];
}
