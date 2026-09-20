import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamehunt/core/routes/app_routes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_form_field.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

// --- الاستدعاءات الجديدة للملفات المساعدة ---
import '../../../../core/utils/app_snack_bar.dart';
import '../../../../core/utils/app_validators.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/styles.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state.status == AuthStatus.error) {
                // استخدام AppSnackBar المجهز للخطأ[cite: 32]
                AppSnackBar.showError(context, state.message ?? AppStrings.somethingWentWrong);
              } else if (state.status == AuthStatus.success) {
                // استخدام AppSnackBar المجهز للنجاح[cite: 32]
                AppSnackBar.showSuccess(context, state.message ?? AppStrings.accountCreatedSuccessfully);
    
                // الانتقال لشاشة الـ OTP وتمرير البريد الإلكتروني
                Navigator.pushReplacementNamed(
                  context,
                  AppRoutes.otpVerification,
                  arguments: _emailController.text.trim(),
                );
              }
            },
            builder: (context, state) {
              return Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // استخدام TextStyles المجهزة بدلاً من TextStyle اليدوي[cite: 30]
                    Text(
                      AppStrings.createAccount,
                      style: TextStyles.font24WhiteBold, 
                    ),
                    const SizedBox(height: 8),
                    Text(
                      AppStrings.enterDetailsToCreateAccount,
                      style: TextStyles.font14GreyRegular, //[cite: 30]
                    ),
                    const SizedBox(height: 32),
    
                    // Email
                    AppTextFormField(
                      hintText: AppStrings.email,
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      // استخدام AppValidators
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
                          color: ColorsManager.textGrey, //[cite: 29]
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordObscure = !_isPasswordObscure;
                          });
                        },
                      ),
                      // استخدام AppValidators
                      validator: (value) => AppValidators.validatePassword(value ?? ''),
                    ),
                    const SizedBox(height: 16),
    
                    // Confirm Password
                    AppTextFormField(
                      hintText: AppStrings.confirmPassword,
                      controller: _confirmPasswordController,
                      isObscureText: _isConfirmPasswordObscure,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isConfirmPasswordObscure
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: ColorsManager.textGrey, //[cite: 29]
                        ),
                        onPressed: () {
                          setState(() {
                            _isConfirmPasswordObscure =
                                !_isConfirmPasswordObscure;
                          });
                        },
                      ),
                      // هنا نستخدم تحقق يدوي مبسط لأننا نحتاج لمقارنته بحقل الباسورد الأساسي
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppStrings.pleaseConfirmPassword;
                        }
                        if (value != _passwordController.text) {
                          return AppStrings.passwordsDoNotMatch;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 28),
    
                    // Sign up button / Loading indicator
                    state.status == AuthStatus.loading
                        ? const Center(child: CircularProgressIndicator(color: ColorsManager.mainBlue)) //[cite: 29]
                        : AppButton(
                            buttonText: AppStrings.register,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<AuthCubit>().register(
                                      email: _emailController.text.trim(),
                                      password: _passwordController.text,
                                    );
                              }
                            },
                          ),
                    const SizedBox(height: 24),
    
                    // Already have an account navigation
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(AppStrings.alreadyHaveAccount, style: TextStyles.font14GreyRegular), //[cite: 30]
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            AppStrings.login,
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