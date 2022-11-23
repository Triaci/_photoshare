import 'dart:ffi';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:photoshare/helpers/utils.dart';
import 'package:photoshare/screens/authentication/auth_screen.dart';

class ResetScreen extends StatefulWidget {
  const ResetScreen({Key? key}) : super(key: key);

  @override
  State<ResetScreen> createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
              controller: emailController,
              textInputAction: TextInputAction.next,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) =>
                  value != null && !EmailValidator.validate(value)
                      ? "Insira um e-mail válido!"
                      : null),
        ),
        ElevatedButton(
            onPressed: () {
              resetPassword();
            },
            child: Text('Enviar um e-mail')),
      ],
    ));
  }

  void resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );
      MaterialPageRoute route =
          MaterialPageRoute(builder: (context) => AuthScreen());
      Navigator.push(context, route);
    } on FirebaseAuthException catch (e) {
      print('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
      print(e.message);
      print('&&&&&&&&&&&&&&&&&&&&&&&&&&&&');

      Utils.showSnackBar(e.message);
    }
  }
}
