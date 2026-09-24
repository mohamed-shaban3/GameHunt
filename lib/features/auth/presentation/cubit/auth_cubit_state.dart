import 'package:supabase_flutter/supabase_flutter.dart';

enum AuthStatus { initial, loading, success, error }

class AuthCubitState {
  final AuthStatus status;
  final String? message;
  final User? user;

  const AuthCubitState({
    this.status = AuthStatus.initial,
    this.message,
    this.user,
  });

  AuthCubitState copyWith({
    AuthStatus? status,
    String? message,
    User? user,
  }) {
    return AuthCubitState(
      status: status ?? this.status,
      message: message ?? this.message,
      user: user ?? this.user,
    );
  }
}