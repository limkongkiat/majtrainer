import 'package:firebase_core/firebase_core.dart';
import 'package:majtrainer/login.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
//import 'package:majtrainer/HomeScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
      home: LoginPage(),
    );
  }
}
