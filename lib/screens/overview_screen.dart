import 'package:expense_tracker/providers/expense_provider.dart';
import 'package:expense_tracker/theme/app_colors.dart';
import 'package:expense_tracker/theme/app_text_styles.dart';
import 'package:expense_tracker/widgets/custom_appbar.dart';
import 'package:expense_tracker/widgets/expense_card.dart';
import 'package:expense_tracker/widgets/perfomance_barchart.dart';
import 'package:expense_tracker/widgets/top_categories.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/custom_bottom_navbar.dart';

class OverviewScreen extends StatefulWidget {
  const OverviewScreen({super.key});

  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  int touchedIndex = -1;
  String? _selectedMonth = (DateTime.now().month).toString();
  final List<String> _months = [
    "January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December"
  ];

  @override
  Widget build(BuildContext context) {
    final expenseProvider = context.watch<ExpenseProvider>();
    final pieChartSections = expenseProvider.getSections(touchedIndex, int.parse(_selectedMonth ?? "1"));
    final topExpenses = expenseProvider.getTopThreeExpenses();
    final expenseWeeklyPerfomance = expenseProvider.getWeeklyPerformance(int.parse(_selectedMonth ?? "1"));
    final highestWeeklyExpense = expenseWeeklyPerfomance.reduce((a, b) => 
    a.weeklyAmount > b.weeklyAmount ? a : b);
    final monthlyGrowth = expenseProvider.monthlyGrowth;

    
    return Scaffold(
      appBar: CustomQuickExpenseAppBar(pageRoute: "/overview"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Rp. ",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight(300),
                          color: Colors.white54
                        ),
                      ),
                      Text(
                        formatMoney(expenseProvider.getTotalExpenses(), showSymbol: false),
                        style: AppTextStyles.amountValue,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Total Spent in ",
                        style: AppTextStyles.amountLabel,
                      ),
                      DropdownButton<String>(
                        items: _months.map((month) => DropdownMenuItem<String>(
                          value: (_months.indexOf(month) + 1).toString(),
                          child: Text(
                            month,
                            style: AppTextStyles.amountLabel
                          ),
                        )).toList(),
                        value: _selectedMonth,
                        
                        onChanged: (value) {
                          setState(() {
                            _selectedMonth = value;
                            // debugPrint("Current month number: ${getCurrentMonthNumber()}");
                          });
                        },
                      )

                    ],
                  ),
                  
                ],
              ),

              Visibility(
                visible: expenseProvider.filteredExpenses.isNotEmpty,
                replacement: Center(
                  child: Container(
                    height: 220,
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      // border: Border.all(color: Colors.white54, width: 0.5, style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(12)
                    ),
                    margin: const EdgeInsets.only(top: 32, bottom: 32),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      spacing: 12,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.pie_chart_outline,
                          size: 48,
                          color: Colors.white54,
                        ),
                        Text(
                          "No expenses recorded in ${_months[int.parse(_selectedMonth ?? "1") - 1]}",
                          style: AppTextStyles.txtSm.copyWith(
                            color: Colors.white54,
                            fontWeight: FontWeight.w300,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: PieChart(
                    PieChartData(
                      pieTouchData: PieTouchData(
                        touchCallback: (event, response) {
                          if(event.isInterestedForInteractions && response != null && response.touchedSection != null){
                            final index = response.touchedSection!.touchedSectionIndex;
                            // debugPrint("Touched section index: $index");
                            setState(() {
                              touchedIndex = index;
                            });
                          }
                        },
                        enabled: true,
                      ),
                      sectionsSpace: 0,
                      centerSpaceRadius: 50,
                      startDegreeOffset: -90,
                      sections: pieChartSections,
                    )
                  ),
                ),
              ),
              
              Column(
                spacing: 16,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Top Categories",
                        style: AppTextStyles.txtMd,
                      ),
                      Text(
                        "View All",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.blueAccent
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: expenseProvider.expenses.isNotEmpty,
                    replacement: Center(
                      // child: Text(
                      //   "No expenses recorded",
                      //   style: AppTextStyles.txtSm.copyWith(
                      //     color: Colors.white54,
                      //     fontWeight: FontWeight.w300,
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
                              Icons.category_outlined,
                              size: 48,
                              color: Colors.white54,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              "No expenses recorded",
                              style: AppTextStyles.txtSm.copyWith(
                                color: Colors.white54,
                                fontWeight: FontWeight.w300,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: topExpenses.length,
                      itemBuilder: (context, index) {
                        final expense = topExpenses[index];
                        return TopCategories(expense: expense, expenseCategories: expenseProvider.expenseCategories, );
                      },
                    ),
                  ),
                ],
              ),

              Visibility(
                visible: expenseProvider.expenses.isNotEmpty,
                replacement: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.textPrimary.withOpacity(0.1),
                      width: 0.5
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.receipt_long_outlined,
                        size: 48,
                        color: Colors.white54,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "No transactions recorded",
                        style: AppTextStyles.txtSm.copyWith(
                          color: Colors.white54,
                          fontWeight: FontWeight.w300,
                        ),
                      )
                    ],
                  ),
                ),
                child: PerfomanceBarchart(
                  expenseWeeklyPerfomance: expenseWeeklyPerfomance,
                  highestWeeklyExpense: highestWeeklyExpense.weeklyAmount,
                  monthlyGrowth: expenseProvider.monthlyGrowth,
                )
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavbar(pageRoute: "/overview"),
    );
  }
}