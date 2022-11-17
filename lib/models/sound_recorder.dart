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
  String _recordPath = "";

  bool get isRecording => _audioRecorder!.isRecording;

  Future init() async {
    _audioRecorder = FlutterSoundRecorder();
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException("Microfone sem permissão");
    }
    await _audioRecorder!.openAudioSession();
    _isRecorderInitialized = true;
    var tempDir = await getApplicationDocumentsDirectory();
    _recordPath = '${tempDir.path}/record.aac';
  }

  void dispose() {
    if (!_isRecorderInitialized) return;
    _audioRecorder!.closeAudioSession();
    _audioRecorder = null;
    _isRecorderInitialized = false;
  }

  Future _record() async {
    if (!_isRecorderInitialized) return;
    await _audioRecorder!
        .startRecorder(toFile: _recordPath, codec: Codec.aacADTS);
  }

  Future _stop() async {
    if (!_isRecorderInitialized) return;
    await _audioRecorder!.stopRecorder();

    FlutterSoundPlayer? myPlayer =
        await FlutterSoundPlayer().openAudioSession();
    myPlayer!.startPlayer(fromURI: _recordPath, codec: Codec.aacADTS);

    Share.shareXFiles([XFile(_recordPath)],
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
