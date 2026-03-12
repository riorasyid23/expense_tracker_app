import 'package:expense_tracker/data/models/expense.dart';
import 'package:expense_tracker/data/models/expense_category.dart';
import 'package:expense_tracker/theme/app_colors.dart';
import 'package:expense_tracker/widgets/expense_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker/theme/app_text_styles.dart';
import 'package:provider/provider.dart';
import '../widgets/custom_bottom_navbar.dart';
import '../widgets/custom_appbar.dart';
import '../data/mocks/mock_categories.dart';
import '../providers/expense_provider.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final ExpenseMockEngine expenseMockEngine = ExpenseMockEngine();
  // late List<Expense> expenses;
  late List<ExpenseCategory> expenseCategories;
  // late Map<String, List<Expense>> groupedExpenses;
  // final sortedKeys = groupedExpense.
  // late List<String> sortedKeys;
  

  @override
  void initState(){
    super.initState();
    // expenses = expenseMockEngine.expenses;
    expenseCategories = expenseMockEngine.mockCategories;
    // groupedExpenses = groupExpensesByDate(expenses);
    // sortedKeys = groupedExpenses.keys.toList()..sort((a, b) => b.compareTo(a));
  }

  @override
  Widget build(BuildContext context) {
    // final expenseProvider = Provider.of<ExpenseProvider>(context);
    final expenses = context.watch<ExpenseProvider>().expenses;

    final groupedExpenses = groupExpensesByDate(expenses);

    final sortedKeys = groupedExpenses.keys.toList()
      ..sort((a, b) => b.compareTo(a));
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomQuickExpenseAppBar(
        pageRoute: "/history",
        title: "Expense History",
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Visibility(
          visible: expenses.isNotEmpty,
          replacement: Center(
            // child: Text(
            //   "No expenses recorded yet.",
            //   style: AppTextStyles.txtSm.copyWith(
            //     color: Colors.white54,
            //     fontWeight: FontWeight.w300
            //   ),
            // ),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.textPrimary.withOpacity(0.1),
                  width: 0.5
                )
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.history,
                    size: 48,
                    color: Colors.white54,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "No expenses recorded yet.",
                    style: AppTextStyles.txtSm.copyWith(
                      color: Colors.white54,
                      fontWeight: FontWeight.w300
                    ),
                  ),
                ],
              ),
            ),
          ),
          child: ListView.builder(
            itemCount: groupedExpenses.keys.length,
            itemBuilder: (context, index) {
              final dateKey = sortedKeys[index];
              final expensesForDate = groupedExpenses[dateKey]!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text(
                      formatInteractiveDate(dateKey),
                      style: AppTextStyles.txtXs.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Colors.white54,
                      ),
                    ),
                  ),
                  ...expensesForDate.map((expense) => ExpenseCard(expense: expense, expenseCategories: expenseCategories)),
                ],
              );
            },
          ),
        )
      ),
      bottomNavigationBar: const CustomBottomNavbar(pageRoute: "/history"),
    );
  }
}

// Function to group expenses by date
Map<String, List<Expense>> groupExpensesByDate(List<Expense> expenses) {
  Map<String, List<Expense>> groupedExpenses = {};
  for (var expense in expenses) {
    String dateKey = DateFormat('yyyy-MM-dd').format(expense.expenseDate);
    if (!groupedExpenses.containsKey(dateKey)) {
      groupedExpenses[dateKey] = [];
    }
    groupedExpenses[dateKey]!.add(expense);
  }

  return groupedExpenses;
}

// Function to format interactive date (TODAY, YESTERDAY, JAN 1)
String formatInteractiveDate(String formattedDate) {
  final DateTime date = DateTime.parse(formattedDate);
  final DateTime now = DateTime.now();
  final DateTime today = DateTime(now.year, now.month, now.day);
  final DateTime checkDate = DateTime(date.year, date.month, date.day);
  final DateTime yesterday = today.subtract(const Duration(days: 1));

  // final bool isToday = 
  if(checkDate == today){
    return 'TODAY';
  }

  if(checkDate == yesterday){
    return 'YESTERDAY';
  }

  return DateFormat.MMMMd().format(date).toUpperCase();
}
  