import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamehunt/core/constants/app_strings.dart';
import 'package:gamehunt/core/routes/app_routes.dart';
import 'package:gamehunt/core/utils/app_snack_bar.dart';
import 'package:gamehunt/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:gamehunt/features/auth/presentation/cubit/auth_cubit_state.dart';
import '../widgets/already_have_account_text.dart';
import '../widgets/auth_header.dart';
import '../widgets/register_form.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
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
                  state.message ?? AppStrings.accountCreatedSuccessfully,
                );
                final email = state.user?.email ?? '';
                Navigator.pushReplacementNamed(
                  context,
                  AppRoutes.otpVerification,
                  arguments: email,
                );
              }
            },
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AuthHeader(
                  title: AppStrings.createAccount,
                  subtitle: AppStrings.enterDetailsToCreateAccount,
                ),
                SizedBox(height: 32),
                RegisterForm(),
                SizedBox(height: 24),
                AlreadyHaveAccountText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
