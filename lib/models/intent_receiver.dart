import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:uri_to_file/uri_to_file.dart';

class IntentReceiverModel {
  final String? fromPackageName;
  final List<String>? fromSignatures;
  final String? action;
  final String? data;
  final List<String>? categories;
  final Map<String, dynamic>? extra;

  IntentReceiverModel(
      {required this.fromPackageName,
      required this.fromSignatures,
      required this.action,
      required this.data,
      this.categories,
      required this.extra});

  Future<Map<String, dynamic>> getSource() async {
    String source = "";
    //passar a imagem padrão
    File file = File('images/sample.jpg');

    Map<String, dynamic> idenified = {"type": "unknown", "file": file};

    if (extra != null) {
      if (extra!["android.intent.extra.STREAM"] != null) {
        source = extra!["android.intent.extra.STREAM"];
        try{
            file = await toFile(source);
        }catch(e){

        }
        
      }
    }
      idenified = {"type": "image", "file": file};

    return idenified;
  }
}