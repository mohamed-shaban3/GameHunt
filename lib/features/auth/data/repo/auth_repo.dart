import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/networking/api_result.dart';

class AuthRepo {
  final SupabaseClient _supabaseClient;

  AuthRepo(this._supabaseClient);

  /// 1. إنشاء حساب جديد (Register)
  Future<ApiResult<AuthResponse>> register({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabaseClient.auth.signUp(
        email: email,
        password: password,
      );
      return Success(response);
    } on AuthException catch (e) {
      return Failure(e.message);
    } catch (e) {
      return Failure(e.toString());
    }
  }

  /// 2. تسجيل الدخول (Login)
  Future<ApiResult<AuthResponse>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return Success(response);
    } on AuthException catch (e) {
      return Failure(e.message);
    } catch (e) {
      return Failure(e.toString());
    }
  }

  /// 3. التأكيد بـ OTP
  Future<ApiResult<AuthResponse>> verifyOtp({
    required String email,
    required String token,
  }) async {
    try {
      final response = await _supabaseClient.auth.verifyOTP(
        type: OtpType.signup,
        token: token,
        email: email,
      );
      return Success(response);
    } on AuthException catch (e) {
      return Failure(e.message);
    } catch (e) {
      return Failure(e.toString());
    }
  }
}