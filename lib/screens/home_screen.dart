// import 'package:expense_tracker/data/models/expense_category.dart';
import 'package:expense_tracker/theme/app_button.dart';
import 'package:expense_tracker/theme/app_text_styles.dart';
import 'package:expense_tracker/widgets/expense_card.dart';
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
  double expenseAmount = 0;
  DateTime _selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  DateTime get combinedDateTime => DateTime(
    _selectedDate.year,
    _selectedDate.month,
    _selectedDate.day,
    selectedTime.hour,
    selectedTime.minute,
  );
  bool isAmountValid = false;
  final amountInputController = TextEditingController();

  // Date Picker FUnction
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2023, 1, 1),
      lastDate: DateTime.now(),
      helpText: "Select Expense Date",
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: Colors.blueAccent,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Color(0xFF101922),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      final TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        helpText: "Select Expense Time",
        builder: (context, child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: Colors.blueAccent,
                onPrimary: Colors.white,
                surface: Colors.white,
                onSurface: Colors.black,
              ),
              dialogBackgroundColor: Color(0xFF101922),
            ),
            child: child!,
          );
        },
      );

      if (time != null) {
        DateTime combinedDateTime = DateTime(
          picked.year,
          picked.month,
          picked.day,
          time.hour,
          time.minute,
        );
        setState(() {
          _selectedDate = combinedDateTime;
          selectedTime = time;
        });
        print("Selected Date & Time: ${combinedDateTime.toLocal()}");
      } 
      setState(() {
        _selectedDate = picked;
      });
      print("Selected Date: ${picked.toLocal()}");
    } else {
      print("Date selection cancelled.");
    }
  }

  // Time Picker Function
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      helpText: "Select Expense Time",
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: Colors.blueAccent,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Color(0xFF101922),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      DateTime combinedDateTime = DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        picked.hour,
        picked.minute,
      );
      setState(() {
        _selectedDate = combinedDateTime;
        selectedTime = picked;
      });
      print("Selected Date & Time: ${combinedDateTime.toLocal()}");
    } else {
      print("Time selection cancelled.");
    }
  }

  @override
  Widget build(BuildContext context) {
    final expenseProvider = context.watch<ExpenseProvider>();

    // final amountInputController = TextEditingController(text: expenseAmount > 0 ? expenseAmount.toString() : "");

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
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              spacing: 8,
                              children: [
                                // Date Button
                                Expanded(
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      alignment: Alignment(
                                        -1, 0
                                      ),
                                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        side: BorderSide(
                                          color: Colors.white,
                                          width: 0.5,
                                          style: BorderStyle.solid
                                        )
                                      )
                                    ),
                                    onPressed: () {
                                      _selectDate(context);
                                    },
                                    child: Text(
                                      formatDate(combinedDateTime),
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white54
                                      ),
                                    ),
                                  ),
                                ),
                                
                                // Time Button
                                TextButton(
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                                    // backgroundColor: Colors.white10,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      side: BorderSide(
                                        color: Colors.white,
                                        width: 0.5,
                                        style: BorderStyle.solid
                                      )
                                    )
                                  ),
                                  onPressed: () {
                                    _selectTime(context);
                                  },
                                  child: Text(
                                    formatTimeHour(combinedDateTime),
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white54
                                    ),
                                  ),
                                )
                              ],
                            )
                          ),

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                            child: TextField(
                              controller: amountInputController,
                              cursorColor: Colors.white,
                              onChanged: (value) => {
                                setState(() {
                                  expenseAmount = double.tryParse(value) ?? 0;
                                  isAmountValid = expenseAmount > 0;
                                })
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
                          ),

                          
                        ],
                      ),
                      ElevatedButton(
                        onPressed: isAmountValid ? () {
                          context.read<ExpenseProvider>().addExpense(
                            Expense(
                              id: generateSimpleId(),
                              amount: expenseAmount,
                              expenseType: expenseProvider.selectedCategory ?? "Other",
                              expenseDate: _selectedDate,
                            ),
                          );


                          showDialog(context: context, builder: (BuildContext context){
                            return AlertDialog(
                              title: Text("Success"),
                              content: Text("Expense added successfully!"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("OK"),
                                )
                              ],

                            );
                          });
                          setState(() {
                            expenseAmount = 0;
                            isAmountValid = false;
                            _selectedDate = DateTime.now();
                            selectedTime = TimeOfDay.now();
                          });

                          amountInputController.clear();

                        } : null,
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

