import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:googleapis/drivelabels/v2.dart';
import 'package:path/path.dart';
import 'package:photoshare/screens/home_screen.dart';

List<Widget> placeActions(BuildContext context) {
  return [
    IconButton(
      onPressed: () {
        MaterialPageRoute route =
            MaterialPageRoute(builder: (context) => HomePage());
        Navigator.of(context).push(route);
      },
      icon: Icon(Icons.list),
    )
  ];
}
