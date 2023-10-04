import 'package:client/models/signup_form_model.dart';
import 'package:client/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'signin_view.dart';

class SingUpView extends StatefulWidget {
  const SingUpView({super.key});

  static const String routName = '/signup';

  @override
  State<SingUpView> createState() => _SingUpViewState();
}

class _SingUpViewState extends State<SingUpView> {
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  late SignUpForm signUpForm;

  FormState? get form => key.currentState;

  @override
  void initState() {
    signUpForm = SignUpForm(password: '', email: '', usename: '');
    super.initState();
  }

  Future<void> submitForm() async {
    print('FORM');
    print(signUpForm);
    if (form!.validate()) {
      form!.save();
      final error = await Provider.of<AuthProvider>(context, listen: false)
          .signup(signUpForm);
      if (error == null) {
        if (mounted) Navigator.pushNamed(context, SingInView.routName);
      }
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                'Inscription',
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
                    const Text('Email', style: TextStyle(color: Colors.white)),
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
                        signUpForm.email = newValue!;
                      },
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                    const Text('Username',
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
                        signUpForm.usename = newValue!;
                      },
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                    const Text('Password',
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
                        signUpForm.password = newValue!;
                      },
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 15)),
                    OutlinedButton(
                      onPressed: () => submitForm(),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      child: const Text(
                        "S'inscrire",
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
    );
  }
}
