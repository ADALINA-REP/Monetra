import 'category_model.dart';

class TransactionModel {
  final String id;
  final int amountCents; // Stored in minor currency units (cents) to guarantee decimal safety
  final TransactionType type;
  final String categoryId;
  final String title;
  final DateTime date;
  final String? notes;
  final bool isRecurring;
  final String? recurringId;

  const TransactionModel({
    required this.id,
    required this.amountCents,
    required this.type,
    required this.categoryId,
    required this.title,
    required this.date,
    this.notes,
    this.isRecurring = false,
    this.recurringId,
  });

  double get amount => amountCents / 100.0;

  static int toCents(double value) {
    return (value * 100).round();
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount_cents': amountCents,
      'type': type.name,
      'category_id': categoryId,
      'title': title,
      'date': date.toIso8601String(),
      'notes': notes,
      'is_recurring': isRecurring ? 1 : 0,
      'recurring_id': recurringId,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'] as String,
      amountCents: map['amount_cents'] as int,
      type: (map['type'] as String) == 'income'
          ? TransactionType.income
          : TransactionType.expense,
      categoryId: map['category_id'] as String,
      title: map['title'] as String,
      date: DateTime.parse(map['date'] as String),
      notes: map['notes'] as String?,
      isRecurring: (map['is_recurring'] as int?) == 1,
      recurringId: map['recurring_id'] as String?,
    );
  }

  TransactionModel copyWith({
    String? id,
    int? amountCents,
    TransactionType? type,
    String? categoryId,
    String? title,
    DateTime? date,
    String? notes,
    bool? isRecurring,
    String? recurringId,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      amountCents: amountCents ?? this.amountCents,
      type: type ?? this.type,
      categoryId: categoryId ?? this.categoryId,
      title: title ?? this.title,
      date: date ?? this.date,
      notes: notes ?? this.notes,
      isRecurring: isRecurring ?? this.isRecurring,
      recurringId: recurringId ?? this.recurringId,
    );
  }
}
