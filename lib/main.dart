
import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'package:just_audio/just_audio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

void main() {
  runApp(const MyStarApp());
}

class MyStarApp extends StatelessWidget {
  const MyStarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MYSTAR Voice Chat',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: const VoiceChatPage(),
    );
  }
}

class VoiceChatPage extends StatefulWidget {
  const VoiceChatPage({super.key});

  @override
  State<VoiceChatPage> createState() => _VoiceChatPageState();
}

class _VoiceChatPageState extends State<VoiceChatPage> {
  final record = AudioRecorder();
  final player = AudioPlayer();
  bool isRecording = false;
  String? audioPath;

  Future<void> _startRecording() async {
    if (await Permission.microphone.request()) {
      await record.start(const RecordConfig());
      setState(() => isRecording = true);
    }
  }

  Future<void> _stopRecording() async {
    String? path = await record.stop();
    setState(() {
      isRecording = false;
      audioPath = path;
    });
  }

  Future<void> _playRecording() async {
    if (audioPath != null) {
      await player.setFilePath(audioPath!);
      await player.play();
    }
  }

  @override
  void dispose() {
    record.dispose();
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MYSTAR Voice Chat'), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Mic dabao aur bolo', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 30),
            GestureDetector(
              onLongPress: _startRecording,
              onLongPressUp: _stopRecording,
              child: CircleAvatar(
                radius: 50,
                backgroundColor: isRecording ? Colors.red : Colors.purple,
                child: Icon(
                  isRecording ? Icons.mic : Icons.mic_none,
                  size: 50,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 30),
            if (audioPath != null)
              ElevatedButton.icon(
                onPressed: _playRecording,
                icon: const Icon(Icons.play_arrow),
                label: const Text('Play Recording'),
              ),
          ],
        ),
      ),
    );
  }
}
