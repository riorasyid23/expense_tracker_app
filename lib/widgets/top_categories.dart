import 'package:flutter/material.dart';
import 'package:expense_tracker/theme/app_colors.dart';
import 'package:expense_tracker/theme/app_text_styles.dart';

class TopCategories extends StatelessWidget {
  const TopCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 6,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                shape: BoxShape.circle
              ),
              child: Icon(
                Icons.restaurant,
                color: Colors.blue,
                size: 16,
              ),
            ),
            Expanded(
              child: Text(
                "Food",
                style: AppTextStyles.txtSm,
              ),
            ),
            Text(
              "Rp. 12000",
              style: AppTextStyles.txtXs,
            )
          ],
        ),

        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(40)),
          child: LinearProgressIndicator(
            backgroundColor: AppColors.surface,
            value: 0.76,
            minHeight: 6,
          ),
        )
      ],
    );
  }
}