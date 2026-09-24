import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamehunt/core/constants/app_strings.dart';
import 'package:gamehunt/core/theme/colors.dart';
import 'package:gamehunt/core/utils/app_validators.dart';
import 'package:gamehunt/core/widgets/app_button.dart';
import 'package:gamehunt/core/widgets/app_text_form_field.dart';
import 'package:gamehunt/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:gamehunt/features/auth/presentation/cubit/auth_cubit_state.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isPasswordObscure = true;
  bool _isConfirmPasswordObscure = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Email
          AppTextFormField(
            hintText: AppStrings.email,
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            validator: (value) => AppValidators.validateEmail(value),
          ),
          const SizedBox(height: 16),

          // Password
          AppTextFormField(
            hintText: AppStrings.password,
            controller: _passwordController,
            isObscureText: _isPasswordObscure,
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordObscure ? Icons.visibility_off : Icons.visibility,
                color: ColorsManager.textGrey,
              ),
              onPressed: () {
                setState(() {
                  _isPasswordObscure = !_isPasswordObscure;
                });
              },
            ),
            validator: (value) => AppValidators.validatePassword(value),
          ),
          const SizedBox(height: 16),

          // Confirm Password
          AppTextFormField(
            hintText: AppStrings.confirmPassword,
            controller: _confirmPasswordController,
            isObscureText: _isConfirmPasswordObscure,
            suffixIcon: IconButton(
              icon: Icon(
                _isConfirmPasswordObscure ? Icons.visibility_off : Icons.visibility,
                color: ColorsManager.textGrey,
              ),
              onPressed: () {
                setState(() {
                  _isConfirmPasswordObscure = !_isConfirmPasswordObscure;
                });
              },
            ),
            validator: (value) => AppValidators.validateConfirmPassword(
              value,
              _passwordController.text,
            ),
          ),
          const SizedBox(height: 28),

          // Submit Button
          BlocBuilder<AuthCubit, AuthCubitState>(
            builder: (context, state) {
              if (state.status == AuthStatus.loading) {
                return const Center(
                  child: CircularProgressIndicator(color: ColorsManager.mainBlue),
                );
              }
              return AppButton(
                buttonText: AppStrings.register,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<AuthCubit>().register(
                          email: _emailController.text.trim(),
                          password: _passwordController.text,
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