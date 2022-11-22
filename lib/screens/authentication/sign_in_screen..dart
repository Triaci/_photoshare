import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:photoshare/helpers/utils.dart';
import 'package:photoshare/screens/authentication/reset_password_screen.dart';
import 'package:photoshare/screens/home_screen.dart';


class SignInScreen extends StatefulWidget {
  final VoidCallback onClickedSignUp;

  const SignInScreen({Key? key, required this.onClickedSignUp})
      : super(key: key);

  @override
  State<SignInScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SignInScreen> {
  final emailController = TextEditingController();
  final senhaController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    senhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: emailController,
            textInputAction: TextInputAction.next,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: senhaController,
            textInputAction: TextInputAction.next,
          ),
        ),
        ElevatedButton(
            onPressed: () {
              signIn();
            },
            child: Text('Login')),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: RichText(
              text: TextSpan(
                  text: 'Esqueceu sua senha ? ',
                  style: TextStyle(color: Colors.black),
                  children: [
                TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap =() {
                         MaterialPageRoute route =
                  MaterialPageRoute(builder: (context) => ResetScreen());
              Navigator.push(context, route); 
                      }
                      ,
                    text: 'Recuperar Senha')
              ])),
            ),

        RichText(
            text: TextSpan(
                text: 'Ainda não tem Conta ? ',
                style: TextStyle(color: Colors.black),
                children: [
              TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = widget.onClickedSignUp,
                  text: 'Registre-se')
            ]))
      ],
    ));
  }

  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: senhaController.text.trim());
    } on FirebaseAuthException catch (e) {
      print(e);

      Utils().showSnackBar(e.message);
    }
  }
}
