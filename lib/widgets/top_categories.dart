import 'package:expense_tracker/data/models/expense.dart';
import 'package:expense_tracker/data/models/expense_category.dart';
import 'package:expense_tracker/providers/expense_provider.dart';
import 'package:expense_tracker/widgets/expense_card.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/theme/app_colors.dart';
import 'package:expense_tracker/theme/app_text_styles.dart';
import 'package:provider/provider.dart';

class TopCategories extends StatelessWidget {
  final ExpenseTopCategories expense;
  final List<ExpenseCategory> expenseCategories;
  

  const TopCategories({
    super.key,
    required this.expense,
    required this.expenseCategories
  });

  

  @override
  Widget build(BuildContext context) {
    final expenseProvider = context.watch<ExpenseProvider>();

    double calculatePercentages(ExpenseTopCategories topCategories) {
      final totalAmount = expenseProvider.getTotalExpenses();

      return totalAmount > 0 ? expense.totalAmount / totalAmount : 0;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        spacing: 6,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              iconCategoryBuilder(expense.expenseType, expenseCategories, forTopCategories: true),
              Expanded(
                child: Text(
                  expense.expenseType,
                  style: AppTextStyles.txtSm,
                ),
              ),
              Text(
                formatMoney(expense.totalAmount, showSymbol: true),
                style: AppTextStyles.txtXs,
              )
            ],
          ),

          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(40)),
            child: LinearProgressIndicator(
              backgroundColor: AppColors.surface,
              value: calculatePercentages(expense),
              // value: 0.76,
              minHeight: 6,
            ),
          )
        ],
      ),
      );
  }
}

