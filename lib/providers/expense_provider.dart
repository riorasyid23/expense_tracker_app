// import 'package:expense_tracker/data/mocks/mock_categories.dart';
import 'package:expense_tracker/data/models/expense_category.dart';
import 'package:expense_tracker/widgets/expense_card.dart';
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

    final Map<String, double> totals = {};
    for (var e in expenses) {
      totals.update(e.expenseType, (v) => v + e.amount, ifAbsent: () => e.amount);
    }

    var sortedEntries = totals.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    

    List<Color> colors = [Colors.orangeAccent, Colors.blueAccent, Colors.greenAccent, Colors.redAccent, Colors.purpleAccent, Colors.grey];
    
    List<PieChartSectionData> sections = sortedEntries.asMap().entries.map((entry) {
      int idx = entry.key;
      var data = entry.value;
      final isTouched = entry.key == touchedIndex;
      final double fontSize = isTouched ? 12 : 8;
      final double radius = isTouched ? 50 : 40;
      return PieChartSectionData(
        // titlePositionPercentageOffset: 12,
        titleStyle: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.white),
        title: isTouched ? formatMoney(data.value) : "",
        value: data.value,
        color: colors[idx],
        radius: radius,
        badgeWidget: Badge(
          isLabelVisible: false,
          alignment: Alignment(
            BorderSide.strokeAlignCenter,
            BorderSide.strokeAlignCenter
          ),
          child: Text(
            data.key,
            style: TextStyle(fontSize: 10, color: Colors.white),
          ),
        ),
        badgePositionPercentageOffset: radius/30,
        
      );
    }).toList();

    return sections;
  }


}