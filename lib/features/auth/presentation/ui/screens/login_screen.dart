import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamehunt/core/constants/app_strings.dart';
import 'package:gamehunt/core/routes/app_routes.dart';
import 'package:gamehunt/core/utils/app_snack_bar.dart';
import 'package:gamehunt/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:gamehunt/features/auth/presentation/cubit/auth_cubit_state.dart';
import '../widgets/auth_header.dart';
import '../widgets/dont_have_account_text.dart';
import '../widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: BlocListener<AuthCubit, AuthCubitState>(
            listener: (context, state) {
              if (state.status == AuthStatus.error) {
                AppSnackBar.showError(
                  context,
                  state.message ?? AppStrings.somethingWentWrong,
                );
              } else if (state.status == AuthStatus.success) {
                AppSnackBar.showSuccess(
                  context,
                  state.message ?? AppStrings.loggedInSuccessfully,
                );
                Navigator.pushReplacementNamed(context, AppRoutes.gamesScreen);
              }
            },
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40),
                AuthHeader(
                  title: AppStrings.login,
                  subtitle: AppStrings.welcomeBack,
                ),
                SizedBox(height: 36),
                LoginForm(),
                SizedBox(height: 24),
                DontHaveAccountText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}