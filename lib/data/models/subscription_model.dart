import 'package:flutter/material.dart';

enum BillingCycle { weekly, monthly, quarterly, yearly }

class SubscriptionModel {
  final String id;
  final String name;
  final int amountCents;
  final BillingCycle billingCycle;
  final DateTime nextBillingDate;
  final String categoryId;
  final int iconCode;
  final int colorHex;
  final bool isActive;

  const SubscriptionModel({
    required this.id,
    required this.name,
    required this.amountCents,
    required this.billingCycle,
    required this.nextBillingDate,
    required this.categoryId,
    required this.iconCode,
    required this.colorHex,
    this.isActive = true,
  });

  double get amount => amountCents / 100.0;

  // Normalized monthly cost in minor units (cents)
  int get monthlyEquivalentCents {
    switch (billingCycle) {
      case BillingCycle.weekly:
        return (amountCents * 52 / 12).round();
      case BillingCycle.monthly:
        return amountCents;
      case BillingCycle.quarterly:
        return (amountCents / 3).round();
      case BillingCycle.yearly:
        return (amountCents / 12).round();
    }
  }

  // Normalized yearly cost in minor units (cents)
  int get yearlyEquivalentCents {
    switch (billingCycle) {
      case BillingCycle.weekly:
        return amountCents * 52;
      case BillingCycle.monthly:
        return amountCents * 12;
      case BillingCycle.quarterly:
        return amountCents * 4;
      case BillingCycle.yearly:
        return amountCents;
    }
  }

  IconData get icon => IconData(iconCode, fontFamily: 'MaterialIcons');
  Color get color => Color(colorHex);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'amount_cents': amountCents,
      'billing_cycle': billingCycle.name,
      'next_billing_date': nextBillingDate.toIso8601String(),
      'category_id': categoryId,
      'icon_code': iconCode,
      'color_hex': colorHex,
      'is_active': isActive ? 1 : 0,
    };
  }

  factory SubscriptionModel.fromMap(Map<String, dynamic> map) {
    return SubscriptionModel(
      id: map['id'] as String,
      name: map['name'] as String,
      amountCents: map['amount_cents'] as int,
      billingCycle: BillingCycle.values.firstWhere(
        (e) => e.name == map['billing_cycle'],
        orElse: () => BillingCycle.monthly,
      ),
      nextBillingDate: DateTime.parse(map['next_billing_date'] as String),
      categoryId: map['category_id'] as String,
      iconCode: map['icon_code'] as int,
      colorHex: map['color_hex'] as int,
      isActive: (map['is_active'] as int?) == 1,
    );
  }

  SubscriptionModel copyWith({
    String? id,
    String? name,
    int? amountCents,
    BillingCycle? billingCycle,
    DateTime? nextBillingDate,
    String? categoryId,
    int? iconCode,
    int? colorHex,
    bool? isActive,
  }) {
    return SubscriptionModel(
      id: id ?? this.id,
      name: name ?? this.name,
      amountCents: amountCents ?? this.amountCents,
      billingCycle: billingCycle ?? this.billingCycle,
      nextBillingDate: nextBillingDate ?? this.nextBillingDate,
      categoryId: categoryId ?? this.categoryId,
      iconCode: iconCode ?? this.iconCode,
      colorHex: colorHex ?? this.colorHex,
      isActive: isActive ?? this.isActive,
    );
  }
}
