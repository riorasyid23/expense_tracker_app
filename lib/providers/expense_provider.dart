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
  double _monthlyGrowth = 0;
  double get monthlyGrowth => _monthlyGrowth;

  // final List<Expense> _expenses = generateMockExpenseData();
  final List<Expense> _expenses = [];
  final List<Expense> _filteredExpenses = [];
  final List<ExpenseTopCategories> _topCategories = [];
  final List<ExpenseWeeklyPerfomance> _expenseWeeklyPerfomance = [];
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
  List<Expense> get filteredExpenses => _filteredExpenses;
  List<ExpenseWeeklyPerfomance> get expenseWeeklyPerfomance => _expenseWeeklyPerfomance; 
  List<ExpenseCategory> get expenseCategories => _expenseCategories;
  List<ExpenseTopCategories> get topCategories => _topCategories;

  void setAmount(int amount) {
    _amount = amount;
    debugPrint(_amount.toString());
    notifyListeners();
  }

  void addExpense(Expense expense) {
    _expenses.add(
      Expense(
        id: expense.id,
        amount: expense.amount,
        expenseType: expense.expenseType,
        expenseDate: expense.expenseDate,
      )
    );
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
    return total;
  }

  double getMonthlyExpense(int currentMonth){
    double total = 0;

    if(currentMonth != 0) {
      final List<Expense> currMo = expenses.where((expense) => expense.expenseDate.month == currentMonth).toList();
      for(var expense in currMo){
        total += expense.amount;
      }

      return total;
    }

    return 0;
  }

  List<PieChartSectionData> getSections(int touchedIndex, int month) {
    // Filter expenses by month
    List<Expense> expenses = _expenses.where((e) => e.expenseDate.month == month).toList();
    _filteredExpenses.clear();
    _filteredExpenses.addAll(expenses);

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

  List<ExpenseTopCategories> getTopThreeExpenses() {
    final totalExpenses = getTotalExpenses();
    List<Expense> sortedExpenses = List.from(_expenses);
    List<ExpenseTopCategories> topCategories = [];

    // Sum up total amount per category
    final Map<String, double> categoryTotals = {};
    for (var expense in sortedExpenses) {
      categoryTotals.update(expense.expenseType, (v) => v + expense.amount, ifAbsent: () => expense.amount);
    }

    var sortedEntries = categoryTotals.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    for (var entry in sortedEntries.take(3)) {
      topCategories.add(ExpenseTopCategories(
        id: entry.key,
        expenseType: entry.key,
        totalAmount: entry.value,
        percentage: totalExpenses > 0 ? (entry.value / totalExpenses) : 0
      ));
    }

    return topCategories;
  }

  List<ExpenseWeeklyPerfomance> getWeeklyPerformance(int monthNumber) {
    final int currentYear = DateTime.now().year;
    

    // 1. Initialize a map for exactly 4 weeks with 0.0 amount
    Map<int, double> weeklyMap = {1: 0.0, 2: 0.0, 3: 0.0, 4: 0.0};

    // 2. Filter expenses for the specific month/year and aggregate
    for (var expense in expenses) {
      if (expense.expenseDate.month == monthNumber && 
          expense.expenseDate.year == currentYear) {
        
        // Calculate week (1-4) based on day of month
        int week = ((expense.expenseDate.day - 1) ~/ 7) + 1;
        if (week > 4) week = 4; // Ensure days 29-31 stay in week 4

        weeklyMap[week] = (weeklyMap[week] ?? 0.0) + expense.amount;
      }
    }

    return weeklyMap.entries
        .map((entry) => ExpenseWeeklyPerfomance(
              weekNumber: entry.key,
              weeklyAmount: entry.value,
            ))
        .toList();

  }

  double getMonthlyGrowth(int selectedMonth){
    final double currrentMonthExpense = getMonthlyExpense(selectedMonth);
    final double lastMonthExpense = getMonthlyExpense(selectedMonth == 1 ? 12 : selectedMonth - 1);
    double expenseGrowth = 0;

    if(lastMonthExpense != 0){
      expenseGrowth = ((currrentMonthExpense - lastMonthExpense) / lastMonthExpense) * 100;

      return (expenseGrowth * 100).truncateToDouble() / 100;
    }


    return 0;
  }
}