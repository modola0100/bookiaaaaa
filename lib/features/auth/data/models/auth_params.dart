class AuthParams {
  String? name;
  String? email;
  String? password;
  String? passwordConfirmation;

  AuthParams({this.name, this.email, this.password, this.passwordConfirmation});

  AuthParams.fromJson(Map<String, dynamic> jason) {
    AuthParams(
      name: jason['name'],
      email: jason['email'],
      password: jason['password'],
      passwordConfirmation: jason['password_confirmation'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "password": password,
      "password_confirmation": passwordConfirmation,
    };
  }
}
