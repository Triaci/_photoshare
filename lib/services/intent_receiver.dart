// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart' hide Intent;
import 'package:photoshare/models/intent_receiver.dart';
import 'package:receive_intent/receive_intent.dart';

import '../components/audio_component.dart';
import '../components/image_component.dart';

class IntentReceiverService {
  late IntentReceiverModel? intentReceiver;

  Future<void> checkForIntent() async {
    final receivedIntent = await ReceiveIntent.getInitialIntent();
    print('passou.................');
    if (receivedIntent != null) {
      intentReceiver = IntentReceiverModel(
        fromPackageName: receivedIntent.fromPackageName,
        fromSignatures: receivedIntent.fromSignatures,
        action: receivedIntent.action,
        data: receivedIntent.data,
        extra: receivedIntent.extra,
      );
    }
  }

  Future<Widget> getVisualComponent() async {
    Map<String, dynamic> intentData = await intentReceiver!.getSource();
    if (intentData['type'] == 'unknown') {
      return Center(
        child: Column(children: [
          Text(
            "Aguardando Intent...",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          Padding(padding: EdgeInsets.only(bottom: 45)),
          CircularProgressIndicator(),
          Container(
            padding: EdgeInsets.all(45),
            child: Divider(thickness: 3),
          )
        ]),
      );
    } else {
        return ImageComponent(intentData["file"]);
    }

    

    //else if(intentData["type"] == "audio"){
    // TODO
    // }
  }
}
