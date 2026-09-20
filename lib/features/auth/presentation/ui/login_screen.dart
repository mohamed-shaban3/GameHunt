import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamehunt/core/routes/app_routes.dart';
import 'package:gamehunt/core/theme/colors.dart';
import 'package:gamehunt/core/theme/styles.dart';
import 'package:gamehunt/core/utils/app_snack_bar.dart';
import 'package:gamehunt/core/utils/app_validators.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_form_field.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state.status == AuthStatus.error) {
                AppSnackBar.showError(context, state.message ?? AppStrings.somethingWentWrong);
              } else if (state.status == AuthStatus.success) {
                // استخدام AppSnackBar للنجاح[cite: 32]
                AppSnackBar.showSuccess(context, state.message ?? AppStrings.loggedInSuccessfully);
                Navigator.pushReplacementNamed(context, AppRoutes.gamesScreen);
              }
            },
            builder: (context, state) {
              return Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    Text(
                      AppStrings.login,
                      style: TextStyles.font24WhiteBold, 
                    ),
                    const SizedBox(height: 8),
                    Text(
                      AppStrings.welcomeBack,
                      style: TextStyles.font14GreyRegular,
                    ),
                    const SizedBox(height: 36),

                    // Email
                    AppTextFormField(
                      hintText: AppStrings.email,
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      // استخدام AppValidators الجاهز[cite: 33]
                      validator: (value) => AppValidators.validateEmail(value ?? ''), 
                    ),
                    const SizedBox(height: 16),

                    // Password
                    AppTextFormField(
                      hintText: AppStrings.password,
                      controller: _passwordController,
                      isObscureText: _isPasswordObscure,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordObscure
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: ColorsManager.textGrey, 
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordObscure = !_isPasswordObscure;
                          });
                        },
                      ),
                      // استخدام AppValidators الجاهز[cite: 33]
                      validator: (value) => AppValidators.validatePassword(value ?? ''),
                    ),
                    const SizedBox(height: 28),

                    // Login Button / Loading Indicator
                    state.status == AuthStatus.loading
                        ? const Center(child: CircularProgressIndicator(color: ColorsManager.mainBlue)) //[cite: 29]
                        : AppButton(
                            buttonText: AppStrings.login,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<AuthCubit>().login(
                                      email: _emailController.text.trim(),
                                      password: _passwordController.text,
                                    );
                              }
                            },
                          ),
                    const SizedBox(height: 24),

                    // Sign up navigation
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(AppStrings.dontHaveAccount, style: TextStyles.font14GreyRegular), //[cite: 30]
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, AppRoutes.register);
                          },
                          child: Text(
                            AppStrings.createAccount,
                            style: TextStyles.font16WhiteSemiBold.copyWith(color: ColorsManager.mainBlue), //[cite: 29, 30]
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}