// import 'package:expense_tracker/data/models/expense_category.dart';
import 'package:expense_tracker/theme/app_button.dart';
import 'package:expense_tracker/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/custom_appbar.dart';
import 'package:expense_tracker/widgets/custom_bottom_navbar.dart';
import 'package:expense_tracker/data/mocks/mock_categories.dart';
import 'package:provider/provider.dart';
import '../data/models/expense.dart';
import '../providers/expense_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ExpenseMockEngine expensesEngine = ExpenseMockEngine();

  @override
  Widget build(BuildContext context) {
    final expenseProvider = context.watch<ExpenseProvider>();
    int expenseAmount = expenseProvider.amount;
    bool isAmountValid = expenseProvider.isAmountValid;

    // final amountInputController = TextEditingController(text: expenseAmount > 0 ? expenseAmount.toString() : "");
    final amountInputController = TextEditingController(text: expenseAmount > 0 ? expenseAmount.toString() : "");

    return Scaffold(
      backgroundColor: Color(0xFF101922),
      appBar: CustomQuickExpenseAppBar(
        pageRoute: "/",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 32,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      "AMOUNT",
                      style: AppTextStyles.amountLabel,
                    ),
                  ),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "\$",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight(300),
                          color: Colors.white54
                        ),
                      ),
                      Text(
                        "100",
                        style: AppTextStyles.amountValue,
                      )
                    ],
                  )
                  
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                spacing: 12,
                children: [
                  
                  Text(
                    "SELECT CATEGORY",
                    style: AppTextStyles.categoryLabel,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            int column = (constraints.maxWidth / 100).floor();
                            
                            return GridView.builder(
                              shrinkWrap: true,
                              itemCount: expenseProvider.expenseCategories.length,
                              
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: column,
                                mainAxisSpacing: 4,
                                crossAxisSpacing: 4,
                              ),
                              
                              itemBuilder: (context, index) {
                                final expense = expenseProvider.expenseCategories[index];

                                return Card(
                                  color: Colors.white10,
                                  child: InkWell(
                                    onTap: () {
                                      context.read<ExpenseProvider>().selectCategory(expense.expenseType);
                                      print(expenseProvider.selectedCategory);
                                      // setState(() {
                                      //   expensesEngine.selectCategory(expense.expenseType);
                                      //   // print("${expense.expenseType} - ${expense.iconActive}");
                                      // });
                                    },
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          expense.iconData,
                                          color: expense.iconActive ? Colors.blue : Colors.white54,
                                          size: 24,
                                        ),
                                        Text(
                                          expense.expenseType,
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight(300),
                                            color: expense.iconActive ? Colors.blue : Colors.white54
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                );
                              },
                            );
                          }
                        )
                      )
                    ],
                  ),

                  Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                            child: TextField(
                              controller: amountInputController,
                              cursorColor: Colors.white,
                              onChanged: (value) => {
                                expenseAmount = int.tryParse(value) ?? 0,
                                context.read<ExpenseProvider>().setAmount(expenseAmount),
                                print("Expense Amount: $expenseAmount - Valid: ${context.read<ExpenseProvider>().isAmountValid}")
                              },
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white
                                
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 0.5,
                                    style: BorderStyle.solid
                                  ),
                                  
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 1,
                                    style: BorderStyle.solid,
                                  )
                                ),
                                hintText: "Enter expense amount",
                                
                              
                              ),
                            ),
                          )
                        ],
                      ),
                      ElevatedButton(
                        onPressed: isAmountValid ? () {
                          context.read<ExpenseProvider>().addExpense(
                            Expense(
                              id: generateSimpleId(),
                              amount: expenseAmount.toDouble(),
                              expenseType: expenseProvider.selectedCategory ?? "Other",
                              expenseDate: DateTime.now(),
                            ),
                          );

                          amountInputController.clear();

                          showDialog(context: context, builder: (BuildContext context){
                            return AlertDialog(
                              title: Text("Success"),
                              content: Text("Expense added successfully!"),

                            );
                          });

                          print("Expense Added: Amount - $expenseAmount, Category - ${expenseProvider.selectedCategory}");
                          // expenseAmount = 0;

                        } : () {print("Invalid amount");},
                        style: isAmountValid ? AppButtonStyles.primaryButton : AppButtonStyles.primaryDisabledButton,
                        child: Text(
                          "+ Add Expense",
                          style: AppTextStyles.buttonText.copyWith(
                            color: isAmountValid ? Colors.white : Colors.white54
                          ),
                          
                        ),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavbar(
        pageRoute: "/",
      ),
    );
  }
}