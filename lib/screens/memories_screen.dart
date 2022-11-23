import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photoshare/models/memoria_model.dart';
import 'package:photoshare/screens/home_screen.dart';

class MemoriesScreen extends StatefulWidget {
  const MemoriesScreen({Key? key}) : super(key: key);

  @override
  State<MemoriesScreen> createState() => _MemoriesScreenState();
}

class _MemoriesScreenState extends State<MemoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    MaterialPageRoute route =
                        MaterialPageRoute(builder: (context) => HomePage());
                    Navigator.push(context, route);
                  },
                  child: Text('retorna para a tela principal')),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: (() {
              createUser(Memoria(
                  titulo: "segunda memoria",
                  corpo: "segundo corpo",
                  data: DateTime.now()));
            })));
  }

  Future createUser(Memoria memoria) async {
    final docUser = FirebaseFirestore.instance.collection('memorias').doc();

    final json = {
      'titulo': memoria.titulo,
      'corpo': memoria.corpo,
      'data': memoria.data
    };

    await docUser.set(json);
  }
}
