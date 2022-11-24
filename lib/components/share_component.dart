import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:share_plus/share_plus.dart';

class ShareComponent extends StatelessWidget {
  final File file;
  const ShareComponent({required this.file});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButtonTheme(
          data: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(minimumSize: Size(395, 60))),
          child: ButtonBar(
            mainAxisSize: MainAxisSize.max,
            children: [
              ElevatedButton(
                onPressed: () => Share.shareXFiles([XFile(file.path)],
                    text: "Compartilhando com nosso App", subject: "Subject"),
                child: Icon(Icons.share),
              ),
            ],
          ),
        ),
      ],
    );
  }
}