import 'package:expense_tracker/providers/expense_provider.dart';
import 'package:expense_tracker/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/screens/home_screen.dart';
import 'package:expense_tracker/screens/history_screen.dart';
import 'package:expense_tracker/screens/overview_screen.dart';
// import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

void main() {
  // debugPaintSizeEnabled = true;
  runApp(
    ChangeNotifierProvider(
      create: (_) => ExpenseProvider(),
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      theme: AppTheme.darkTheme,
      routes: {
        "/": (context) => const HomeScreen(),
        "/history": (context) => const HistoryScreen(),
        "/overview": (context) => const OverviewScreen(),
      },
    );
  }
}

