class SignInForm {
  String password;
  String email;

  SignInForm({
    required this.password,
    required this.email,
  });

  SignInForm.fromJson(Map<String, dynamic> json)
      : password = json['password'],
        email = json['email'];

  Map<String, dynamic> toJson() {
    return {'password': password, 'email': email};
  }
}
