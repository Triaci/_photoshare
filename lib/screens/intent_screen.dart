import 'package:flutter/material.dart';
import 'package:photoshare/services/intent_receiver.dart';

class IntentScreen extends StatefulWidget {
  const IntentScreen({super.key});

  @override
  State<IntentScreen> createState() => _IntentScreenState();
}

class _IntentScreenState extends State<IntentScreen> {
  late Widget itentWidget = Text("Carregando...");
  IntentReceiverService intentService = IntentReceiverService();

  @override
  void initState() {
    _initState();
    super.initState();
  }

  _initState() async {
    //if (!mounted) return;
    await intentService.checkForIntent();
    print('init State ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;');
    Widget _widget = await intentService.getVisualComponent();
    setState(() {
      itentWidget = _widget;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Intents'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 50),
              child: itentWidget,
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, "/notifications"),
              child: Text("Notificar agora"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, "/laucher"),
              child: Text("Lançar URL"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, "/settings"),
        child: const Icon(Icons.settings),
      ),
    );
  }
}
