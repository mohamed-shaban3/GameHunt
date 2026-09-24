import 'package:flutter/material.dart';
import 'colors.dart';

class TextStyles {
  static TextStyle font24WhiteBold = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: ColorsManager.textWhite,
  );

  static TextStyle font14GreyRegular = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: ColorsManager.textGrey,
  );

  static TextStyle font16WhiteSemiBold = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: ColorsManager.textWhite,
  );

  static const TextStyle font24BoldWhite = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w900,
    color: ColorsManager.textPrimary,
    letterSpacing: 1.5,
  );

  static const TextStyle font12Grey = TextStyle(
    fontSize: 12,
    color: ColorsManager.textSecondary,
  );

  static const TextStyle font18BoldWhite = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: ColorsManager.textPrimary,
  );

  static const TextStyle font13NeonBold = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.bold,
    color: ColorsManager.accentNeon,
  );

  static const TextStyle font12WhiteBold = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: ColorsManager.textPrimary,
  );
}