class Expense {
  final String id;
  final double amount;
  final String expenseDescription;
  final String expenseType;
  final DateTime expenseDate;
  // final double percentage;

  Expense({
    required this.id,
    required this.amount,
    this.expenseDescription = "",
    required this.expenseType,
    required this.expenseDate,
    // this.percentage = 0
  });
}

class ExpenseTopCategories {
  final String id;
  final String expenseType;
  final double totalAmount;
  final double percentage;

  ExpenseTopCategories({
    required this.id,
    required this.expenseType,
    required this.totalAmount,
    required this.percentage
  });
}