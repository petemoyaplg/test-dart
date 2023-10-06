import 'package:client/providers/user_provide.dart';
import 'package:client/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/signin_form_model.dart';
import '../../models/user_model.dart';
import '../../providers/auth_provider.dart';

class SingInView extends StatefulWidget {
  const SingInView({super.key});

  static const String routName = '/signin';

  @override
  State<SingInView> createState() => _SingInViewState();
}

class _SingInViewState extends State<SingInView> {
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  late SignInForm signInForm;
  bool hidePassword = true;

  FormState? get form => key.currentState;

  @override
  void initState() {
    signInForm = SignInForm(password: '', email: '');
    super.initState();
  }

  Future<void> submitForm() async {
    if (form!.validate()) {
      form!.save();
      final User user = await Provider.of<AuthProvider>(context, listen: false)
          .signin(signInForm);
      if (mounted) {
        Provider.of<UserProvider>(context, listen: false).updateUser(user);
        Navigator.pushNamed(context, ProfileView.routName);
      }
      // if (error == null && mounted) {
      //   Navigator.pushNamed(context, SingInView.routName);
      // }
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        body: Scaffold(
          body: Container(
            // alignment: Alignment.center,
            padding: const EdgeInsets.only(
              top: 70,
              left: 20,
              right: 20,
              bottom: 20,
            ),
            color: Colors.black,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Connexion',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  // textAlign: TextAlign.center,
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 20)),
                Form(
                  key: key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text('Email',
                          style: TextStyle(color: Colors.white)),
                      const Padding(padding: EdgeInsets.symmetric(vertical: 3)),
                      TextFormField(
                        decoration: InputDecoration(
                          fillColor: Colors.grey.shade900,
                          filled: true,
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                        onSaved: (newValue) {
                          signInForm.email = newValue!;
                        },
                      ),
                      const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10)),
                      const Text('Password',
                          style: TextStyle(color: Colors.white)),
                      const Padding(padding: EdgeInsets.symmetric(vertical: 3)),
                      TextFormField(
                        obscureText: hidePassword,
                        decoration: InputDecoration(
                          fillColor: Colors.grey.shade900,
                          filled: true,
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  hidePassword = !hidePassword;
                                });
                              },
                              icon: hidePassword
                                  ? const Icon(
                                      Icons.visibility_off,
                                      color: Colors.white,
                                    )
                                  : const Icon(
                                      Icons.visibility,
                                      color: Colors.white,
                                    )),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                        onSaved: (newValue) {
                          signInForm.password = newValue!;
                        },
                      ),
                      const Padding(
                          padding: EdgeInsets.symmetric(vertical: 15)),
                      OutlinedButton(
                        onPressed: () => submitForm(),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                        child: const Text(
                          "Se connecter",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
