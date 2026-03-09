import 'package:expense_tracker/data/models/expense.dart';
import 'package:expense_tracker/data/models/expense_category.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/theme/app_colors.dart';
import 'package:expense_tracker/theme/app_text_styles.dart';
import 'package:intl/intl.dart';

class ExpenseCard extends StatelessWidget {

  final Expense expense;
  final List<ExpenseCategory> expenseCategories;

  const ExpenseCard({
    super.key,
    required this.expense,
    required this.expenseCategories
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.card,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: AppColors.textPrimary.withOpacity(0.1),
          width: 0.5
        )

      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        leading: iconCategoryBuilder(expense.expenseType, expenseCategories),
        title: Text(
          
          formatMoney(expense.amount),
          style: AppTextStyles.txtSm.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: Text(
          formatTimeHour(expense.expenseDate),
          style: AppTextStyles.txtXs.copyWith(
            color: Colors.white54,
            fontWeight: FontWeight.w300
          ),
        ),

      ),
    );
  }

}

// function to format money (50000.00 => 50,000)
String formatMoney(double amount, { bool showSymbol = true }) {
  final formatter = NumberFormat.currency(locale: 'id_ID', symbol: showSymbol ? 'Rp. ' : '', decimalDigits: 0);
  return formatter.format(amount);
}

String formatDate(DateTime date) {
  return DateFormat.yMMMMd().format(date);
}

String formatTimeHour(DateTime date) {
  return DateFormat.jm().format(date);
}

Widget iconCategoryBuilder(String expenseType, List<ExpenseCategory> category) {

  Map<String, ExpenseCategory> categoryMap = {
    for (var cat in category) cat.expenseType: cat
  };

  final item = categoryMap[expenseType];

  return Container(
    width: 32,
    height: 32,
    decoration: BoxDecoration(
      color: item?.color.withOpacity(0.1),
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(8)
    ),
    child: Icon(
      item?.iconData,
      color: item?.color,
      size: 14,
    ),
  );
}