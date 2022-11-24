import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:photoshare/components/share_component.dart';
import 'package:provider/provider.dart';

import '../services/shared_preferences.dart';

class AudioComponent extends StatefulWidget {
  final File file;
  const AudioComponent(this.file);

  @override
  State<AudioComponent> createState() => _AudioComponentState(file);
}

class _AudioComponentState extends State<AudioComponent> {
  late File file;
  AudioPlayer audioComponentPlayer = AudioPlayer();
  _AudioComponentState(this.file);

  @override
  void initState() {
    _initState();
    super.initState();
  }

  void _initState() async {
    await audioComponentPlayer.setSourceUrl(file.path);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SharedPreferencesService>(
        builder: (context, sharedPrefereces, child) {
      return Column(
        children: [
          // Image.network("https://gifimage.net/wp-content/uploads/2017/10/music-bars-gif-3.gif"), //default
          Image.network(sharedPrefereces.getPlayerAnimation),
          Row(
            children: [
              ElevatedButtonTheme(
                data: ElevatedButtonThemeData(
                    style:
                        ElevatedButton.styleFrom(minimumSize: Size(193, 60))),
                child: ButtonBar(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ElevatedButton(
                        onPressed: () => audioComponentPlayer.pause(),
                        child: Icon(Icons.stop)),
                    ElevatedButton(
                        onPressed: () => audioComponentPlayer.resume(),
                        child: Icon(Icons.play_arrow)),
                  ],
                ),
              ),
            ],
          ),
          ShareComponent(file: file),
        ],
      );
    });
  }
}