import 'package:flutter/material.dart';
import 'package:majtrainer/DiscardAdviser.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mahjong Trainer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 0, 49, 10)),
        useMaterial3: true,
      ),
      home: const DiscardAdvisor(),
    );
  }
}
