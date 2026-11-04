class BudgetModel {
  final String id;
  final String? categoryId; // null indicates total overall monthly budget
  final String name;
  final int limitCents;
  final String periodMonth; // e.g. "2026-10"
  final bool carryOver;

  const BudgetModel({
    required this.id,
    this.categoryId,
    required this.name,
    required this.limitCents,
    required this.periodMonth,
    this.carryOver = false,
  });

  double get limit => limitCents / 100.0;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category_id': categoryId,
      'name': name,
      'limit_cents': limitCents,
      'period_month': periodMonth,
      'carry_over': carryOver ? 1 : 0,
    };
  }

  factory BudgetModel.fromMap(Map<String, dynamic> map) {
    return BudgetModel(
      id: map['id'] as String,
      categoryId: map['category_id'] as String?,
      name: map['name'] as String,
      limitCents: map['limit_cents'] as int,
      periodMonth: map['period_month'] as String,
      carryOver: (map['carry_over'] as int?) == 1,
    );
  }

  BudgetModel copyWith({
    String? id,
    String? categoryId,
    String? name,
    int? limitCents,
    String? periodMonth,
    bool? carryOver,
  }) {
    return BudgetModel(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      name: name ?? this.name,
      limitCents: limitCents ?? this.limitCents,
      periodMonth: periodMonth ?? this.periodMonth,
      carryOver: carryOver ?? this.carryOver,
    );
  }
}
