import 'dart:ffi';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../helpers/utils.dart';


class SignUpScreen extends StatefulWidget {
  final Function onClickedSignIn;
  const SignUpScreen({Key? key, required this.onClickedSignIn})
      : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final senhaController = TextEditingController();
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
              controller: senhaController,
              textInputAction: TextInputAction.next,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) => value != null && value.length < 6
                  ? "Insira uma Senha com pelo menos 6 Caracteres"
                  : null),
        ),
        ElevatedButton(
            onPressed: () {
              signUp();
            },
            child: Text('Registrar')),
        RichText(
            text: TextSpan(
                text: 'Já tem Conta ?',
                style: TextStyle(color: Colors.black),
                children: [
              TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = widget.onClickedSignIn as GestureTapCallback?,
                  text: 'Entrar')
            ]))
      ],
    ));
  }

  void signUp() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: senhaController.text.trim());
    } on FirebaseAuthException catch (e) {
      print('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
      print(e.message);
      print('&&&&&&&&&&&&&&&&&&&&&&&&&&&&');
      Utils.showSnackBar(e.message);
    }
  }
}
