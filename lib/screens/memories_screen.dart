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
  Stream<List<Memoria>> readMemories() => FirebaseFirestore.instance
      .collection('memorias')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Memoria.fromJson(doc.data())).toList());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: 
        //lê as memorias no firebase
            StreamBuilder<List<Memoria>>(
                stream: readMemories(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("Algo deu Errado");
                  } else if (snapshot.hasData) {
                    final memorias = snapshot.data!;

                    return ListView(
                      children:  memorias.map(buildMemory).toList(),
                      
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
                //insere uma memoria com texto fixo no firebase
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: (() {
              createMemory(Memoria(
                  titulo: "segunda memoria",
                  corpo: "segundo corpo",
                  data: DateTime.now()));
            })));
  }

  Widget buildMemory(Memoria memoria) => ListTile(
        leading: CircleAvatar(
          child: Text('teste'),
        ),
        title: Text(memoria.titulo.toString()),
        subtitle: Text(memoria.corpo.toString()),
      );

  Future createMemory(Memoria memoria) async {
    final docUser = FirebaseFirestore.instance.collection('memorias').doc();

    final json = {
      'titulo': memoria.titulo,
      'corpo': memoria.corpo,
      'data': memoria.data
    };

    await docUser.set(json);
  }
}
