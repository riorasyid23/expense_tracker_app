import 'package:expense_tracker/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomQuickExpenseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String pageRoute;

  const CustomQuickExpenseAppBar({
    super.key, 
    this.title = "Quick Expense",
    required this.pageRoute,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
      ),
      child: SafeArea( // Protects content from the status bar
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.settings, color: Colors.blueGrey, size: 16),
              onPressed: () {},
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.calendar_today, color: Colors.blueGrey, size: 16),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  @override
  // This defines the height of your AppBar
  Size get preferredSize => const Size.fromHeight(70);
}