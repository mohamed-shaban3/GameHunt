import 'package:supabase_flutter/supabase_flutter.dart';

class VerifyOtpRequestBody {
  final String email;
  final String token;
  final OtpType type;

  VerifyOtpRequestBody({
    required this.email,
    required this.token,
    required this.type,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'token': token,
        'type': type.name,
      };
}