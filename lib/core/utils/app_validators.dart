import '../constants/app_strings.dart';
import 'app_regex.dart';

class AppValidators {
  // 1. Email Validation
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.pleaseEnterEmail;
    }
    if (!AppRegex.isEmailValid(value.trim())) {
      return AppStrings.invalidEmail;
    }
    return null;
  }

  // 2. Password Validation
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.pleaseEnterPassword;
    }
    if (!AppRegex.isHasMinLength(value)) {
      return AppStrings.passwordTooShort;
    }
    return null;
  }

  // 3. OTP Validation
  static String? validateOtp(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.pleaseEnterOtp;
    }
    if (value.trim().length < 6) {
      return AppStrings.invalidOtpLength;
    }
    return null;
  }

  // 4. Confirm Password Validation
  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return AppStrings.pleaseConfirmPassword;
    }
    if (value != password) {
      return AppStrings.passwordsDoNotMatch;
    }
    return null;
  }
}