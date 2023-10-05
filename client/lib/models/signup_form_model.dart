class SignUpForm {
  String password;
  String email;
  String username;

  SignUpForm({
    required this.password,
    required this.email,
    required this.username,
  });

  SignUpForm.fromJson(Map<String, dynamic> json)
      : password = json['password'],
        email = json['email'],
        username = json['username'];

  Map<String, dynamic> toJson() {
    Map<String, dynamic> value = {
      'password': password,
      'email': email,
      'username': username
    };
    // if (id != null) {
    //   value['_id'] = id;
    // }
    return value;
  }
}
