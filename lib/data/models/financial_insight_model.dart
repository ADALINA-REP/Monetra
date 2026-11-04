import 'package:flutter/material.dart';

enum InsightType { positive, warning, info }

class FinancialInsightModel {
  final String id;
  final String title;
  final String message;
  final InsightType type;
  final IconData icon;
  final String? actionLabel;

  const FinancialInsightModel({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.icon,
    this.actionLabel,
  });
}
