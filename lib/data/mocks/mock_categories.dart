import 'package:flutter/material.dart';
import 'dart:math';
import '../models/expense_category.dart';
import '../models/expense.dart';


class ExpenseMockEngine{
  Expense? createdExpense;
  String? _selectedCategory;

  // final List<Expense> _expenses = generateMockExpenseData();
  final List<Expense> _expenses = [];

  final List<ExpenseCategory> _mockCategories = [
    ExpenseCategory(expenseType: "Food", iconActive: false, iconData: Icons.restaurant, color: Colors.orangeAccent),
    ExpenseCategory(expenseType: "Travel", iconActive: false, iconData: Icons.flight, color: Colors.blueAccent),
    ExpenseCategory(expenseType: "Shop", iconActive: false, iconData: Icons.shopping_cart, color: Colors.greenAccent),
    ExpenseCategory(expenseType: "Health", iconActive: false, iconData: Icons.local_hospital, color: Colors.redAccent),
    ExpenseCategory(expenseType: "Bills", iconActive: false, iconData: Icons.receipt, color: Colors.purpleAccent),
    ExpenseCategory(expenseType: "Other", iconActive: false, iconData: Icons.question_mark, color: Colors.grey),
  ];

  String? get selectedCategory => _selectedCategory;
  List<Expense> get expenses => _expenses;
  List<ExpenseCategory> get mockCategories => _mockCategories;


  void selectCategory(String type){
     for(var item in _mockCategories){
      item.iconActive = item.expenseType == type;
     }
     _selectedCategory = type;
  }
}

DateTime getRandomDate() {
  final start = DateTime(2026, 2, 1);
  final end = DateTime(2026, 3, 7);
  final random = Random();
  final differenceInDays = end.difference(start).inDays;
  final randomDays = random.nextInt(differenceInDays + 1);
  return start.add(Duration(days: randomDays));
}

String generateSimpleId(){
  String chars = 'abcdefghijklmnopqrstuvwxyz1234567890';
  var random = Random();


  List<String> finalId = [];
  for(int i = 0; i<=8; i++){
    int randomInt= random.nextInt(chars.length);
    String randomChar = chars[randomInt];
    finalId.add(randomChar);
  }

  return finalId.join('');
}

List<Expense> generateMockExpenseData(){
  List<String> expenseCategories = ["Food", "Travel", "Shop", "Health", "Bills", "Other"];
  List<double> expenseAmounts = [50000, 55000, 60000, 65000, 70000, 75000, 80000, 85000, 90000, 95000, 100000];
  var random = Random();

  return List.generate(20, (exp) => Expense(
      id: generateSimpleId(),
      amount: expenseAmounts[random.nextInt(expenseAmounts.length)],
      expenseType: expenseCategories[random.nextInt(expenseCategories.length)],
      expenseDate: getRandomDate()
    )
  );
}