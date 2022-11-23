import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:photoshare/helpers/utils.dart';
import 'package:photoshare/screens/authentication/auth_screen.dart';
import 'package:photoshare/screens/home_screen.dart';

void main() async {
  await init();
  runApp(const PhotoShare());
}

Future init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

class PhotoShare extends StatelessWidget {
  const PhotoShare({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        scaffoldMessengerKey: Utils().messengerKey,
        home: Scaffold(
          body: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Algo deu Errado!"));
                } else if (snapshot.hasData) {
                  return HomePage();
                } else {
                  return HomePage();
                  //AuthScreen();
                }
              }),
        ),
      );
}
