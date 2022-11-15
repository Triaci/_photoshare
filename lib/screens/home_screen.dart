import 'package:flutter/material.dart';
import 'package:photoshare/screens/camera_screen.dart';

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
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [ElevatedButton(onPressed: () {
            MaterialPageRoute route =
                MaterialPageRoute(builder: (context) => CameraScreen());
            Navigator.push(context, route);
            
          }, child: Text("Tirar Foto"))],
        ),
      ),
    );
  }
}
