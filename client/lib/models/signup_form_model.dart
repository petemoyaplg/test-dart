class SignUpForm {
  String password;
  String email;
  String usename;

  SignUpForm({
    required this.password,
    required this.email,
    required this.usename,
  });

  SignUpForm.fromJson(Map<String, dynamic> json)
      : password = json['password'],
        email = json['email'],
        usename = json['usename'];

  Map<String, dynamic> toJson() {
    Map<String, dynamic> value = {
      'password': password,
      'email': email,
      'usename': usename
    };
    // if (id != null) {
    //   value['_id'] = id;
    // }
    return value;
  }
}
