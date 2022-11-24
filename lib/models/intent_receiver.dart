import 'dart:io';

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
    File file = File("");

    Map<String, dynamic> idenified = {"type": "unknown", "file": file};

    if (extra != null) {
      if (extra!["android.intent.extra.STREAM"] != null) {
        source = extra!["android.intent.extra.STREAM"];
        file = await toFile(source);
      }
    }

    if (source.contains("audio")) {
      idenified = {"type": "audio", "file": file};
    } else if (source.contains("image")) {
      idenified = {"type": "image", "file": file};
    } else if (source.contains("video")) {
      idenified = {"type": "video", "file": file};
    }

    return idenified;
  }
}