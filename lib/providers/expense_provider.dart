// import 'package:expense_tracker/data/mocks/mock_categories.dart';
import 'package:expense_tracker/data/models/expense_category.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../data/models/expense.dart';

class ExpenseProvider extends ChangeNotifier {
  String? _selectedCategory;
  int _amount = 0;
  int get amount => _amount;
  bool get isAmountValid => _amount > 0;

  // final List<Expense> _expenses = generateMockExpenseData();
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
    debugPrint(_amount.toString());
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

  double getTotalExpenses() {
    double total = 0;
    for(var expense in _expenses){
      total += expense.amount;
    }
    // print("Total Expenses: $total");
    return total;
  }

  List<PieChartSectionData> getSections(int touchedIndex) {

    // 1. Get summed totals per category
    final Map<String, double> totals = {};
    double totalAll = 0;
    for (var e in expenses) {
      totals.update(e.expenseType, (v) => v + e.amount, ifAbsent: () => e.amount);
      totalAll += e.amount;
    }

    // 2. Sort and take Top 3
    var sortedEntries = totals.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    
    var top3 = sortedEntries.take(3).toList();
    
    // 3. Calculate "Others"
    double top3Sum = top3.fold(0, (sum, entry) => sum + entry.value);
    double othersSum = totalAll - top3Sum;

    // 4. Map to PieChartSectionData
    List<Color> colors = [Colors.blue, Colors.purple, Colors.orange, Colors.grey];
    
    List<PieChartSectionData> sections = top3.asMap().entries.map((entry) {
      int idx = entry.key;
      var data = entry.value;
      final isTouched = entry.key == touchedIndex;
      final double fontSize = isTouched ? 18 : 14;
      final double radius = isTouched ? 70 : 60;
      return PieChartSectionData(
        titleStyle: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.white),
        title: data.key,
        value: data.value,
        color: colors[idx],
        radius: radius,
      );
    }).toList();

    // Add "Others" section if it exists
    if (othersSum > 0) {
      sections.add(PieChartSectionData(
        title: "Others",
        value: othersSum,
        color: colors.last,
        radius: 60,
      ));
    }

    return sections;
  }


}