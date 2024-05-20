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
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 0, 49, 10)),
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
  List<String> buttonLabels = ['Button 1', 'Button 2', 'Button 3'];

  void _removeButton(int index) {
    setState(() {
      buttonLabels.removeAt(index);
    });
  }

  void _addButton() {
    setState(() {
      buttonLabels.add('Button ${buttonLabels.length + 1}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dynamic Button List'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addButton,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: buttonLabels.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () => _removeButton(index),
              child: Text(buttonLabels[index]),
            ),
          );
        },
      ),
    );
  }
}
