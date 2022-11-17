import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:flutter_sound_lite/public/flutter_sound_recorder.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

class SoundRecorder {
  FlutterSoundRecorder? _audioRecorder;
  bool _isRecorderInitialized = false;

  bool get isRecording => _audioRecorder!.isRecording;

  Future init() async {
    _audioRecorder = FlutterSoundRecorder();
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException("Microfone sem permissão");
    }
    await _audioRecorder!.openAudioSession();
    _isRecorderInitialized = true;
  }

  void dispose() {
    if (!_isRecorderInitialized) return;
    _audioRecorder!.closeAudioSession();
    _audioRecorder = null;
    _isRecorderInitialized = false;
  }

  Future _record() async {
    var tempDir = await getApplicationDocumentsDirectory();
    String path = '${tempDir.path}/flutter_sound.aac';
    if (!_isRecorderInitialized) return;
    await _audioRecorder!.startRecorder(toFile: path, codec: Codec.aacADTS);

    print(
        "..............................................................................");
    print(path);
    print(
        "..............................................................................");
  }

  Future _stop() async {
    if (!_isRecorderInitialized) return;
    await _audioRecorder!.stopRecorder();

    var tempDir = await getApplicationDocumentsDirectory();
    String path = '${tempDir.path}/flutter_sound.aac';

    print(
        "..............................................................................");
    // print(f.path);
    print(
        "..............................................................................");

    // final audioPlayer = Assets

    // FlutterSoundPlayer myPlayer = FlutterSoundPlayer();
    // FlutterSoundPlayer? myPlayer = await FlutterSoundPlayer().openAudioSession();

    // myPlayer!.startPlayer(fromURI: path, codec: Codec.aacADTS);

    Share.shareXFiles([XFile(path)],
        text: "Olha esse Audio que eu gravei com meu app Mano!!!!",
        subject: "PhotoShare");
  }

  Future toggleRecording() async {
    if (_audioRecorder!.isStopped) {
      await _record();
    } else {
      await _stop();
    }
  }
}
