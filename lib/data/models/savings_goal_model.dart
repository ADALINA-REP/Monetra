import 'package:flutter/material.dart';

class SavingsGoalModel {
  final String id;
  final String name;
  final int targetAmountCents;
  final int currentAmountCents;
  final DateTime targetDate;
  final int iconCode;
  final int colorHex;
  final String? notes;

  const SavingsGoalModel({
    required this.id,
    required this.name,
    required this.targetAmountCents,
    required this.currentAmountCents,
    required this.targetDate,
    required this.iconCode,
    required this.colorHex,
    this.notes,
  });

  double get targetAmount => targetAmountCents / 100.0;
  double get currentAmount => currentAmountCents / 100.0;

  double get progressRatio {
    if (targetAmountCents <= 0) return 0.0;
    final ratio = currentAmountCents / targetAmountCents;
    return ratio.clamp(0.0, 1.0);
  }

  int get progressPercentage => (progressRatio * 100).round();

  IconData get icon => IconData(iconCode, fontFamily: 'MaterialIcons');
  Color get color => Color(colorHex);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'target_amount_cents': targetAmountCents,
      'current_amount_cents': currentAmountCents,
      'target_date': targetDate.toIso8601String(),
      'icon_code': iconCode,
      'color_hex': colorHex,
      'notes': notes,
    };
  }

  factory SavingsGoalModel.fromMap(Map<String, dynamic> map) {
    return SavingsGoalModel(
      id: map['id'] as String,
      name: map['name'] as String,
      targetAmountCents: map['target_amount_cents'] as int,
      currentAmountCents: map['current_amount_cents'] as int,
      targetDate: DateTime.parse(map['target_date'] as String),
      iconCode: map['icon_code'] as int,
      colorHex: map['color_hex'] as int,
      notes: map['notes'] as String?,
    );
  }

  SavingsGoalModel copyWith({
    String? id,
    String? name,
    int? targetAmountCents,
    int? currentAmountCents,
    DateTime? targetDate,
    int? iconCode,
    int? colorHex,
    String? notes,
  }) {
    return SavingsGoalModel(
      id: id ?? this.id,
      name: name ?? this.name,
      targetAmountCents: targetAmountCents ?? this.targetAmountCents,
      currentAmountCents: currentAmountCents ?? this.currentAmountCents,
      targetDate: targetDate ?? this.targetDate,
      iconCode: iconCode ?? this.iconCode,
      colorHex: colorHex ?? this.colorHex,
      notes: notes ?? this.notes,
    );
  }
}
