import 'package:flutter/material.dart';

class Utils {
  static final GlobalKey<ScaffoldMessengerState> _messengerKey =
      GlobalKey<ScaffoldMessengerState>(); // initialize to avoid errors

  static GlobalKey<ScaffoldMessengerState> getMessengerKey() => _messengerKey;

  static showSnackBar(String? text) {
    if (text == null) return;

    final snackBar = SnackBar(content: Text(text), backgroundColor: Colors.red);

    _messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
