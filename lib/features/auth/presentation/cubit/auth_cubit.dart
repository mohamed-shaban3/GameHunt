import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_strings.dart';
import '../../data/repo/auth_repo.dart';
import '../../../../core/networking/api_result.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo _authRepo;

  AuthCubit(this._authRepo) : super(const AuthState());

  /// 1. Register
  Future<void> register({
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(status: AuthStatus.loading));

    final result = await _authRepo.register(email: email, password: password);

    switch (result) {
      case Success():
        emit(state.copyWith(
          status: AuthStatus.success,
          message: AppStrings.accountCreatedSuccessfully,
        ));
      case Failure(failure:final error):
        emit(state.copyWith(
          status: AuthStatus.error,
          message: error,
        ));
    }
  }

  /// 2. Login
  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(status: AuthStatus.loading));

    final result = await _authRepo.login(email: email, password: password);

    switch (result) {
      case Success():
        emit(state.copyWith(
          status: AuthStatus.success,
          message: AppStrings.loggedInSuccessfully,
        ));
      case Failure(failure:final error):
        emit(state.copyWith(
          status: AuthStatus.error,
          message: error,
        ));
    }
  }

  /// 3. Verify OTP
  Future<void> verifyOtp({
    required String email,
    required String token,
  }) async {
    emit(state.copyWith(status: AuthStatus.loading));

    final result = await _authRepo.verifyOtp(email: email, token: token);

    switch (result) {
      case Success():
        emit(state.copyWith(
          status: AuthStatus.success,
          message: AppStrings.emailVerifiedSuccessfully,
        ));
      case Failure(failure:final error):
        emit(state.copyWith(
          status: AuthStatus.error,
          message: error,
        ));
    }
  }
}