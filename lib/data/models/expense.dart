class Expense {
  final String id;
  final double amount;
  final String expenseDescription;
  final String expenseType;
  final DateTime expenseDate;

  Expense({
    required this.id,
    required this.amount,
    this.expenseDescription = "",
    required this.expenseType,
    required this.expenseDate
  });
}

