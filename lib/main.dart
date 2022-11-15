
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
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
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
