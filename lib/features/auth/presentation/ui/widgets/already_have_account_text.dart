import 'package:flutter/material.dart';
import 'package:gamehunt/core/constants/app_strings.dart';
import 'package:gamehunt/core/theme/colors.dart';
import 'package:gamehunt/core/theme/styles.dart';

class AlreadyHaveAccountText extends StatelessWidget {
  const AlreadyHaveAccountText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppStrings.alreadyHaveAccount,
          style: TextStyles.font14GreyRegular,
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            AppStrings.login,
            style: TextStyles.font16WhiteSemiBold.copyWith(
              color: ColorsManager.mainBlue,
            ),
          ),
        ),
      ],
    );
  }
}