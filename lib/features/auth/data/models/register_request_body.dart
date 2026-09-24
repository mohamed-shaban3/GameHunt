class RegisterRequestBody {
  final String email;
  final String password;

  RegisterRequestBody({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
      };
}