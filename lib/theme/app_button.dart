import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppButtonStyles {

  static final primaryButton = ElevatedButton.styleFrom(
    backgroundColor: AppColors.primary,
    disabledBackgroundColor: Colors.lightBlue,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
  );

  static final secondaryButton = ElevatedButton.styleFrom(
    backgroundColor: AppColors.secondary,
    disabledBackgroundColor: Colors.lightBlueAccent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
  );

  static final primaryDisabledButton = ElevatedButton.styleFrom(
    backgroundColor: AppColors.primary.withOpacity(0.5),
    disabledBackgroundColor: Colors.lightBlue,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
  );

  static final secondaryDisabledButton = ElevatedButton.styleFrom(
    backgroundColor: AppColors.secondary.withOpacity(0.5),
    disabledBackgroundColor: Colors.lightBlueAccent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
  );
}