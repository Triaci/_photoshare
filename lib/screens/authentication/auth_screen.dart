import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:photoshare/screens/authentication/sign_in_screen..dart';
import 'package:photoshare/screens/authentication/sign_up_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) =>
      isLogin ? SignInScreen(onClickedSignUp: toggle) : SignUpScreen(onClickedSignIn: toggle);

  void toggle() => setState(() => isLogin = !isLogin);
}


