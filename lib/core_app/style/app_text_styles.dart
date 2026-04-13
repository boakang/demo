import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyles {
  const AppTextStyles._();

  static TextStyle title({Color color = AppColors.textPrimary}) {
    return TextStyle(
      color: color,
      fontSize: 18,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle subtitle({Color color = AppColors.textSecondary}) {
    return TextStyle(
      color: color,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle body({Color color = AppColors.textPrimary}) {
    return TextStyle(
      color: color,
      fontSize: 14,
      height: 1.4,
    );
  }
}

