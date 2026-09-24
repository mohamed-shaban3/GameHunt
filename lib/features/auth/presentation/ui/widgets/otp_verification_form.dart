import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamehunt/core/constants/app_strings.dart';
import 'package:gamehunt/core/theme/colors.dart';
import 'package:gamehunt/core/utils/app_validators.dart';
import 'package:gamehunt/core/widgets/app_button.dart';
import 'package:gamehunt/features/auth/presentation/ui/widgets/pin_code_input_field.dart';
import 'package:gamehunt/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:gamehunt/features/auth/presentation/cubit/auth_cubit_state.dart';

class OtpVerificationForm extends StatefulWidget {
  final String email;

  const OtpVerificationForm({super.key, required this.email});

  @override
  State<OtpVerificationForm> createState() => _OtpVerificationFormState();
}

class _OtpVerificationFormState extends State<OtpVerificationForm> {
  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Center(
            child: PinCodeInputField(
              controller: _otpController,
              length: 6,
              validator: (value) => AppValidators.validateOtp(value),
            ),
          ),
          const SizedBox(height: 28),
          BlocBuilder<AuthCubit, AuthCubitState>(
            builder: (context, state) {
              if (state.status == AuthStatus.loading) {
                return const Center(
                  child: CircularProgressIndicator(color: ColorsManager.mainBlue),
                );
              }
              return AppButton(
                buttonText: AppStrings.verifyCode,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<AuthCubit>().verifyOtp(
                          email: widget.email,
                          token: _otpController.text.trim(),
                        );
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}