import 'package:flutter/material.dart';
import 'package:gamehunt/core/constants/app_strings.dart';
import 'package:gamehunt/core/theme/colors.dart';
import 'package:gamehunt/core/theme/styles.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  static Future<bool?> show(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => const LogoutDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorsManager.cardDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: ColorsManager.borderDark),
      ),
      title: const Text(
        AppStrings.logout,
        style: TextStyles.font18BoldWhite,
      ),
      content: const Text(
        AppStrings.logoutConfirmationMessage,
        style: TextStyles.font14GreyRegular,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text(
            AppStrings.cancel,
            style: TextStyle(color: ColorsManager.textGrey),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text(
            AppStrings.logout,
            style: TextStyle(color: ColorsManager.redError),
          ),
        ),
      ],
    );
  }
}