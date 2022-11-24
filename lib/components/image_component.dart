import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:photoshare/components/share_component.dart';

class ImageComponent extends StatelessWidget {
  final File file;
  const ImageComponent(this.file);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Image.file(file, width: 390),
          ],
        ),
        ShareComponent(file: file),
      ],
    );
  }
}