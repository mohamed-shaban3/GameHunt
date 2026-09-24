import 'package:flutter/material.dart';
import 'package:gamehunt/core/constants/app_strings.dart';
import 'package:gamehunt/core/routes/app_routes.dart';
import 'package:gamehunt/core/theme/colors.dart';
import 'package:gamehunt/core/theme/styles.dart';

class DontHaveAccountText extends StatelessWidget {
  const DontHaveAccountText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppStrings.dontHaveAccount,
          style: TextStyles.font14GreyRegular,
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.register);
          },
          child: Text(
            AppStrings.createAccount,
            style: TextStyles.font16WhiteSemiBold.copyWith(
              color: ColorsManager.mainBlue,
            ),
          ),
        ),
      ],
    );
  }
}