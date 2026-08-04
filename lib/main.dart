import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MYSTAR Voice',
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<void> _openGoogleAIStudio() async {
    final Uri url = Uri.parse('https://aistudio.google.com/');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MYSTAR Voice Chat'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('MYSTAR', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              icon: const Icon(Icons.mic),
              label: const Text('Voice se Baat Karo'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: const TextStyle(fontSize: 18),
              ),
              onPressed: _openGoogleAIStudio,
            ),
            const SizedBox(height: 10),
            const Text('Button dabao aur Google AI Studio me baat karo', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
