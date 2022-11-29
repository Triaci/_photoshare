import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:share_plus/share_plus.dart';

import '../models/memoria_model.dart';
import '../screens/home_screen.dart';
import '../services/notification_service.dart';

class ShareComponent extends StatelessWidget {
  final File file;
  const ShareComponent({required this.file});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: () => Share.shareXFiles([XFile(file.path)],
              text: "Compartilhando com nosso App", subject: "Subject"),
          child: Icon(Icons.share),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              onPressed: () {
                createMemory(
                    Memoria(
                        titulo: "Essa eu recebi no whats da piazada",
                        corpo: file.path,
                        data: DateTime.now()),
                    context);
              },
              child: Icon(Icons.upload)),
        )
      ],
    );
  }

  Future createMemory(Memoria memoria, context) async {
    final notification = NotificationService();
    final docUser = FirebaseFirestore.instance.collection('memorias').doc();

    final json = {
      'titulo': memoria.titulo,
      'corpo': memoria.corpo,
      'data': memoria.data
    };

    await docUser.set(json);
    notification.showNotification(LocalNotification(
        id: 1,
        title: "A imagem foi salva nas Memorias",
        body: "Verifique o FireBase",
        payload: "asd"));

    MaterialPageRoute route =
        MaterialPageRoute(builder: (context) => HomePage());
    Navigator.push(context, route);
  }
}
