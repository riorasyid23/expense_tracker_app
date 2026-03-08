import 'package:flutter/material.dart';

class ExpenseCategory {
  final String expenseType;
  bool iconActive;
  final IconData iconData;
  final Color color;

  ExpenseCategory({
    required this.expenseType,
    required this.iconActive,
    required this.iconData,
    required this.color,
  });

  // This helper creates an object from your JSON-like Map
  factory ExpenseCategory.fromMap(Map<String, dynamic> map) {
    return ExpenseCategory(
      expenseType: map['expenseType'] ?? '',
      iconActive: map['iconActive'] ?? false,
      iconData: map['iconData'] != null ? IconData(map['iconData'], fontFamily: 'MaterialIcons') : Icons.help_outline,
      color: map['color'] != null ? Color(map['color']) : Colors.white54,
    );
  }
}