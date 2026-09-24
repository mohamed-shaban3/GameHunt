import 'package:gamehunt/features/auth/data/models/login_request_body.dart';
import 'package:gamehunt/features/auth/data/models/register_request_body.dart';
import 'package:gamehunt/features/auth/data/models/verify_otp_request_body.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/networking/api_result.dart';

class AuthRepo {
  final SupabaseClient _supabaseClient;

  AuthRepo(this._supabaseClient);

// 1. Register
  Future<ApiResult<AuthResponse>> register(
    RegisterRequestBody registerRequestBody,
  ) async {
    try {
      final response = await _supabaseClient.auth.signUp(
        email: registerRequestBody.email,
        password: registerRequestBody.password,
      );
      return Success(response);
    } on AuthException catch (e) {
      return Failure(e.message);
    } catch (e) {
      return Failure(e.toString());
    }
  }

  // 2. Login
  Future<ApiResult<AuthResponse>> login(
    LoginRequestBody loginRequestBody,
  ) async {
    try {
      final response = await _supabaseClient.auth.signInWithPassword(
        email: loginRequestBody.email,
        password: loginRequestBody.password,
      );
      return Success(response);
    } on AuthException catch (e) {
      return Failure(e.message);
    } catch (e) {
      return Failure(e.toString());
    }
  }

  // 3. VerifyOTP
  Future<ApiResult<AuthResponse>> verifyOtp(
  VerifyOtpRequestBody verifyOtpRequestBody,
) async {
  try {
    final response = await _supabaseClient.auth.verifyOTP(
      type: verifyOtpRequestBody.type,
      token: verifyOtpRequestBody.token,
      email: verifyOtpRequestBody.email,
    );
    return Success(response);
  } on AuthException catch (e) {
    return Failure(e.message);
  } catch (e) {
    return Failure(e.toString());
  }
}
}
