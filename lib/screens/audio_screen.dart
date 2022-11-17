import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photoshare/models/sound_recorder.dart';
import 'package:photoshare/models/timer_controller.dart';

class AudioComponent extends StatefulWidget {
  final File file;
  const AudioComponent(this.file);

  @override
  State<AudioComponent> createState() => _AudioComponentState(file);
}

class _AudioComponentState extends State<AudioComponent> {
  late File file;
  final controller = TimerController();
  final recorder = SoundRecorder();
  AudioPlayer audioComponentPlayer = AudioPlayer();
  _AudioComponentState(this.file);

  @override
  void initState() {
    _initState();
    super.initState();
    recorder.init();
  }

  @override
  void dispose() {
    recorder.dispose();
    super.dispose();
  }

  void _initState() async {
    // await audioComponentPlayer.setSourceUrl(file.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: constroiBotao(),
      ),
    );
  }

  Widget constroiBotao() {
    final gravando = recorder.isRecording;
    final icon = gravando ? Icons.stop : Icons.mic;
    final text = gravando ? 'STOP' : 'START';
    final primary = gravando ? Colors.red : Colors.white;
    final onPrimary = gravando ? Colors.white : Colors.black;

    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
          minimumSize: Size(175, 50), primary: primary, onPrimary: onPrimary),
      icon: Icon(icon),
      label: Text(text),
      onPressed: () async {
        await recorder.toggleRecording();
        final gravando = recorder.isRecording;
        setState(() {
          if (gravando) {
            controller.startTimer();
          } else {
            controller.stopTimer();
          }
        });
      },
    );
  }
}
