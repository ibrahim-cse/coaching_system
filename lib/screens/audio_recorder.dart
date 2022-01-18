import 'dart:async';
import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';

class Recorder extends StatefulWidget {
  late String title;

  Recorder({Key? key}) : super(key: key);

  @override
  _RecorderState createState() => _RecorderState();
}

class _RecorderState extends State<Recorder> {
  late FlutterSoundRecorder _myRecorder;
  final audioPlayer = AssetsAudioPlayer();
  late String filePath;
  bool _play = false;
  String _recorderTxt = 'Audio Recorder';

  @override
  void initState() {
    super.initState();
    startIt();
  }

  void startIt() async {
    filePath = '/sdcard/Download/temp.wav';
    _myRecorder = FlutterSoundRecorder();

    await _myRecorder.openAudioSession(
        focus: AudioFocus.requestFocusAndStopOthers,
        category: SessionCategory.playAndRecord,
        mode: SessionMode.modeDefault,
        device: AudioDevice.speaker);
    await _myRecorder.setSubscriptionDuration(const Duration(milliseconds: 10));
    await initializeDateFormatting();

    await Permission.microphone.request();
    await Permission.storage.request();
    await Permission.manageExternalStorage.request();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Audio Recorder'),
        // backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 400.0,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.lightBlueAccent,
                      Colors.blueAccent,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(
                    80.0,
                  ),
                ),
                child: Center(
                  child: Text(
                    _recorderTxt,
                    style: const TextStyle(fontSize: 50),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  buildElevatedButton(
                    icon: Icons.mic,
                    iconColor: Colors.red,
                    onPress: record,
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  buildElevatedButton(
                    icon: Icons.stop,
                    iconColor: Colors.black,
                    onPress: stopRecord,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  elevation: 10.0,
                ),
                onPressed: () {
                  setState(() {
                    _play = !_play;
                  });
                  if (_play) startPlaying();
                  if (!_play) stopPlaying();
                },
                icon: _play
                    ? const Icon(
                        Icons.stop,
                      )
                    : const Icon(Icons.play_arrow),
                label: _play
                    ? const Text(
                        "Stop Playing",
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      )
                    : const Text(
                        "Start Playing",
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ElevatedButton buildElevatedButton(
      {required IconData icon,
      required Color iconColor,
      required GestureTapCallback onPress}) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(5.0),
        side: const BorderSide(
          color: Colors.teal,
          width: 3.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        primary: Colors.white,
        elevation: 10.0,
      ),
      onPressed: onPress,
      icon: Icon(
        icon,
        color: iconColor,
        size: 35.0,
      ),
      label: const Text(''),
    );
  }

  Future<void> record() async {
    Directory dir = Directory(path.dirname(filePath));
    if (!dir.existsSync()) {
      dir.createSync();
    }
    _myRecorder.openAudioSession();
    await _myRecorder.startRecorder(
      toFile: filePath,
      codec: Codec.pcm16WAV,
    );

    StreamSubscription _recorderSubscription =
        _myRecorder.onProgress!.listen((e) {
      var date = DateTime.fromMillisecondsSinceEpoch(e.duration.inMilliseconds,
          isUtc: true);
      var txt = DateFormat('mm:ss:SS', 'en_GB').format(date);

      setState(() {
        _recorderTxt = txt.substring(0, 8);
      });
    });
    _recorderSubscription.cancel();
  }

  Future<String?> stopRecord() async {
    _myRecorder.closeAudioSession();
    return await _myRecorder.stopRecorder();
  }

  Future<void> startPlaying() async {
    _recorderTxt = 'Player Started';
    audioPlayer.open(
      Audio.file(filePath),
      autoStart: true,
      showNotification: true,
    );
  }

  Future<void> stopPlaying() async {
    _recorderTxt = 'Player Stopped';
    audioPlayer.stop();
  }
}
