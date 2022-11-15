import 'package:flutter/material.dart';
import 'package:photoshare/screens/camera_screen.dart';
import 'package:photoshare/services/firebase_messaging_service.dart';
import 'package:photoshare/services/notification_services.dart';
import 'package:provider/provider.dart';

class PhotoShare extends StatefulWidget {
  const PhotoShare({Key? key}) : super(key: key);

  @override
  State<PhotoShare> createState() => _PhotoShareState();
}

class _PhotoShareState extends State<PhotoShare> {
  @override
 @override
  void initState() {
    
    final firebaseMessaging = FireBaseMessagingService();
    firebaseMessaging.setNotifications();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CameraScreen(),
    );
  }
}
