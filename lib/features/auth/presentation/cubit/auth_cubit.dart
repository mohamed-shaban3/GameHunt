import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/local/cache_helper.dart';
import '../../../../core/networking/api_result.dart';
import '../../data/models/login_request_body.dart';
import '../../data/models/register_request_body.dart';
import '../../data/models/verify_otp_request_body.dart';
import '../../data/repos/auth_repo.dart';
import 'auth_cubit_state.dart';

class AuthCubit extends Cubit<AuthCubitState> {
  final AuthRepo _authRepo;

  AuthCubit(this._authRepo) : super(const AuthCubitState());

  // 1. Register
  Future<void> register({
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(status: AuthStatus.loading));

    final result = await _authRepo.register(
      RegisterRequestBody(
        email: email,
        password: password,
      ),
    );

    switch (result) {
      case Success(data: final response):
        if (response.session?.accessToken != null) {
          await CacheHelper.setData(
            key: 'token',
            value: response.session!.accessToken,
          );
        }
        emit(state.copyWith(
          status: AuthStatus.success,
          message: AppStrings.accountCreatedSuccessfully,
          user: response.user,
        ));
      case Failure(failure: final error):
        emit(state.copyWith(
          status: AuthStatus.error,
          message: error,
        ));
    }
  }

  // 2. Login
  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(status: AuthStatus.loading));

    final result = await _authRepo.login(
      LoginRequestBody(
        email: email,
        password: password,
      ),
    );

    switch (result) {
      case Success(data: final response):
        if (response.session?.accessToken != null) {
          await CacheHelper.setData(
            key: 'token',
            value: response.session!.accessToken,
          );
        }
        emit(state.copyWith(
          status: AuthStatus.success,
          message: AppStrings.loggedInSuccessfully,
          user: response.user,
        ));
      case Failure(failure: final error):
        emit(state.copyWith(
          status: AuthStatus.error,
          message: error,
        ));
    }
  }

  // 3. Verify OTP
  Future<void> verifyOtp({
    required String email,
    required String token,
    OtpType type = OtpType.signup,
  }) async {
    emit(state.copyWith(status: AuthStatus.loading));

    final result = await _authRepo.verifyOtp(
      VerifyOtpRequestBody(
        email: email,
        token: token,
        type: type,
      ),
    );

    switch (result) {
      case Success(data: final response):
        if (response.session?.accessToken != null) {
          await CacheHelper.setData(
            key: 'token',
            value: response.session!.accessToken,
          );
        }
        emit(state.copyWith(
          status: AuthStatus.success,
          message: AppStrings.emailVerifiedSuccessfully,
          user: response.user,
        ));
      case Failure(failure: final error):
        emit(state.copyWith(
          status: AuthStatus.error,
          message: error,
        ));
    }
  }
}