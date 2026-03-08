import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {

  static const txtXs = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w300,
    color: AppColors.textPrimary,
  );

  static const txtSm = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  static const txtMd = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  static const txtLg = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const amountLabel = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  static const amountValue = TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static const categoryLabel = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  static const categoryItem = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w300,
    color: AppColors.textSecondary,
  );

  static const buttonText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  // final primaryButton = ElevatedButton.styleFrom(
  //   backgroundColor: AppColors.primary,
  //   disabledBackgroundColor: Colors.lightBlue,
  //   shape: RoundedRectangleBorder(
  //     borderRadius: BorderRadius.circular(24),
  //   ),
  // );
}