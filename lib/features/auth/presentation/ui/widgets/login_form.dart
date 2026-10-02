import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamehunt/core/constants/app_strings.dart';
import 'package:gamehunt/core/theme/colors.dart';
import 'package:gamehunt/core/utils/app_validators.dart';
import 'package:gamehunt/core/widgets/app_button.dart';
import 'package:gamehunt/core/widgets/app_text_form_field.dart';
import 'package:gamehunt/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:gamehunt/features/auth/presentation/cubit/auth_cubit_state.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordObscure = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Email Field
          AppTextFormField(
            hintText: AppStrings.email,
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            validator: (value) => AppValidators.validateEmail(value),
          ),
          const SizedBox(height: 16),

          // Password Field
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
                buttonText: AppStrings.login,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<AuthCubit>().login(
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