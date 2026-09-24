import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamehunt/core/constants/app_strings.dart';
import 'package:gamehunt/core/routes/app_routes.dart';
import 'package:gamehunt/core/utils/app_snack_bar.dart';
import 'package:gamehunt/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:gamehunt/features/auth/presentation/cubit/auth_cubit_state.dart';
import '../widgets/auth_header.dart';
import '../widgets/otp_verification_form.dart';

class OtpVerificationScreen extends StatelessWidget {
  final String email;

  const OtpVerificationScreen({super.key, required this.email});

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
                  state.message ?? AppStrings.invalidOtpCode,
                );
              } else if (state.status == AuthStatus.success) {
                AppSnackBar.showSuccess(
                  context,
                  state.message ?? AppStrings.accountVerifiedSuccessfully,
                );
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.gamesScreen,
                  (route) => false,
                );
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AuthHeader(
                  title: AppStrings.verifyOtp,
                  subtitle: '${AppStrings.otpSentTo} $email',
                ),
                const SizedBox(height: 32),
                OtpVerificationForm(email: email),
              ],
            ),
          ),
        ),
      ),
    );
  }
}