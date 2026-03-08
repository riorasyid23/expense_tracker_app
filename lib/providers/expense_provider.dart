import 'package:expense_tracker/data/models/expense_category.dart';
import 'package:flutter/material.dart';
import '../data/models/expense.dart';

class ExpenseProvider extends ChangeNotifier {
  String? _selectedCategory;
  int _amount = 0;
  int get amount => _amount;
  bool get isAmountValid => _amount > 0;

  final List<Expense> _expenses = [];
  final List<ExpenseCategory> _expenseCategories = [
    ExpenseCategory(expenseType: "Food", iconActive: false, iconData: Icons.restaurant, color: Colors.orangeAccent),
    ExpenseCategory(expenseType: "Travel", iconActive: false, iconData: Icons.flight, color: Colors.blueAccent),
    ExpenseCategory(expenseType: "Shop", iconActive: false, iconData: Icons.shopping_cart, color: Colors.greenAccent),
    ExpenseCategory(expenseType: "Health", iconActive: false, iconData: Icons.local_hospital, color: Colors.redAccent),
    ExpenseCategory(expenseType: "Bills", iconActive: false, iconData: Icons.receipt, color: Colors.purpleAccent),
    ExpenseCategory(expenseType: "Other", iconActive: false, iconData: Icons.question_mark, color: Colors.grey),
  ];

  String? get selectedCategory => _selectedCategory;
  List<Expense> get expenses => _expenses;
  List<ExpenseCategory> get expenseCategories => _expenseCategories;

  void setAmount(int amount) {
    _amount = amount;
    print(_amount);
    notifyListeners();
  }

  void addExpense(Expense expense) {
    _expenses.add(expense);
    _amount = 0;
    notifyListeners();
  }

  void selectCategory(String type) {
     for(var item in _expenseCategories){
      item.iconActive = item.expenseType == type;
     }
     _selectedCategory = type;
     notifyListeners();
  }


}