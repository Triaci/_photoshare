import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:photoshare/screens/audio_screen.dart';
import 'package:photoshare/screens/authentication/auth_screen.dart';
import 'package:photoshare/screens/camera_screen.dart';
import 'package:photoshare/screens/intent_screen.dart';
import 'package:photoshare/screens/map_screen.dart';
import 'package:photoshare/screens/memories_screen.dart';

import '../services/firebase_messaging_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    final firebaseMessaging = FireBaseMessagingService();
    firebaseMessaging.setNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: user != null ? Text(user.email.toString()) : Text("Usuário não logado")
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  MaterialPageRoute route =
                      MaterialPageRoute(builder: (context) => CameraScreen());
                  Navigator.push(context, route);
                },
                child: Text("Tirar Foto")),
            ElevatedButton(
                onPressed: () {
                  MaterialPageRoute route = MaterialPageRoute(
                      builder: (context) => AudioComponent(File('abc')));
                  Navigator.push(context, route);
                },
                child: Text("Gravar um Áudio.")),
            ElevatedButton(
                onPressed: () {
                  
                },
                child: Text("Receber um Intent")),
            ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  MaterialPageRoute route = MaterialPageRoute(
                      builder: (context) => AuthScreen());
                  Navigator.push(context, route);
                },
                child: Text("Sign Out")),
            ElevatedButton(
                onPressed: () {
                  MaterialPageRoute route = MaterialPageRoute(
                      builder: (context) => MemoriesScreen());
                  Navigator.push(context, route);
                },
                child: Text("Memorias")),
            ElevatedButton(
                onPressed: () {
                  MaterialPageRoute route = MaterialPageRoute(
                      builder: (context) => IntentScreen());
                  Navigator.push(context, route);
                },
                child: Text("intent")),
            ElevatedButton(
                onPressed: () {
                  MaterialPageRoute route = MaterialPageRoute(
                      builder: (context) => MapScreen());
                  Navigator.push(context, route);
                },
                child: Text("Map")),        

          ],
        ),
      ),
    );
  }
}
