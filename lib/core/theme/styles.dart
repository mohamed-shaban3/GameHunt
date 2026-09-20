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
}