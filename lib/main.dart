// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:photoshare/screens/camera_screen.dart';

void main() {
  runApp(const PhotoShare());
}

class PhotoShare extends StatelessWidget {
  const PhotoShare({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(      
      home: CameraScreen(),
    );
  }
}
