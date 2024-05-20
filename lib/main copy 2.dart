import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'mahjong trainer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 0, 126, 25)),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isIconChanged = false;

  void _changeIcon() {
    if (!isIconChanged) {
      setState(() {
        isIconChanged = !isIconChanged;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Icon Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(
                isIconChanged ? Icons.favorite : Icons.favorite_border,
                color: isIconChanged ? Colors.red : Colors.grey,
                size: 48.0,
              ),
              onPressed: () {
                if (isIconChanged) {
                  setState(() {
                    isIconChanged = !isIconChanged;
                  });
                }
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _changeIcon,
              child: Text('Change Icon'),
            ),
          ],
        ),
      ),
    );
  }
}
