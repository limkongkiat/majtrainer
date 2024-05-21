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
  List<String> buttonImages = [
    'assets/button_image_1.png',
    'assets/button_image_2.png',
    'assets/button_image_1.png',
  ];

  void _removeButton(int index) {
    setState(() {
      buttonImages.removeAt(index);
    });
  }

  void _addButton() {
    setState(() {
      String nextImage =
          'assets/button_image_${(buttonImages.length % 2) + 1}.png';
      buttonImages.add(nextImage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mahjong Trainer'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addButton,
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7, // Number of columns
          childAspectRatio: 1, // Aspect ratio of each item
        ),
        itemCount: buttonImages.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () => _removeButton(index),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size(100, 100),
              ),
              child: Image.asset(buttonImages[index], fit: BoxFit.cover),
            ),
          );
        },
      ),
    );
  }
}
