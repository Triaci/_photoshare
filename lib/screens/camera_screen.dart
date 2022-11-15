import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path/path.dart';
import 'package:photoshare/services/notification_services.dart';
import 'package:photoshare/screens/foto_screen.dart';
import 'package:provider/provider.dart';

class CameraScreen extends StatefulWidget {
  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController controller;
  late List<CameraDescription> cameras;
  late CameraDescription camera;
  Widget cameraPreview = Center(
    child: CircularProgressIndicator(),
  );
  late Image image;

  Future setCamera() async {
    cameras = await availableCameras();
    if (cameras.length != 0) {
      camera = cameras.first;
    }
  }

  @override
  void initState() {
    setCamera().then((_) {
      controller = CameraController(camera, ResolutionPreset.ultraHigh);
      controller.initialize().then((snapshot) {
        cameraPreview = Center(child: CameraPreview(controller));
        setState(() {
          cameraPreview = cameraPreview;
        });
      });
    });
  
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  //checkNotification() async {
  //await Provider.of<NotificationService>(context, listen: false)
  //    .checkForNotifications();
  //}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tire a foto'),
      ),
      body: Container(
        child: Column(
          children: [
            cameraPreview,
            //  TextButton(child: Text("Salvar"), onPressed: (){})
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20),
        child: FloatingActionButton(
          onPressed: () async {
            final image = await controller.takePicture();
            MaterialPageRoute route =
                MaterialPageRoute(builder: (context) => FotoScreen(image.path));
            Navigator.push(context, route);
          },
          child: Icon(Icons.camera_alt),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
