import 'package:expense_tracker/providers/expense_provider.dart';
import 'package:expense_tracker/theme/app_text_styles.dart';
import 'package:expense_tracker/widgets/custom_appbar.dart';
import 'package:expense_tracker/widgets/expense_card.dart';
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

  @override
  Widget build(BuildContext context) {
    final expenseProvider = context.watch<ExpenseProvider>();
    final pieChartSections = expenseProvider.getSections(touchedIndex);
    
    return Scaffold(
      appBar: CustomQuickExpenseAppBar(pageRoute: "/overview"),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
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
                Text(
                  "Total Spent in March",
                  style: AppTextStyles.amountLabel,
                ),
                Visibility(
                  visible: expenseProvider.expenses.isNotEmpty,
                  replacement: Center(
                    child: Text(
                      "No expenses recorded",
                      style: AppTextStyles.txtSm.copyWith(
                        color: Colors.white54,
                        fontWeight: FontWeight.w300,
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
                              debugPrint("Touched section index: $index");
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
                        sections: pieChartSections
                      )
                    ),
                  ),
                ),
                
                Column(
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
                        child: Text(
                          "No expenses recorded",
                          style: AppTextStyles.txtSm.copyWith(
                            color: Colors.white54,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      child: Column(
                        spacing: 12,
                        children: [
                          TopCategories(),
                          TopCategories(),
                          TopCategories()
                        ],
                      ),
                    )
                  ],
                )
              ],
            )

          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavbar(pageRoute: "/overview"),
    );
  }
}