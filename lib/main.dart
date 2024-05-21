import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
  List<String> selectedImages = [];

  final List<String> buttonImages = [
    'assets/Man1.png',
    'assets/Man2.png',
    'assets/Man3.png',
    'assets/Man4.png',
    'assets/Man5.png',
    'assets/Man6.png',
    'assets/Man7.png',
    'assets/Man8.png',
    'assets/Man9.png',
    'assets/Sou1.png',
    'assets/Sou2.png',
    'assets/Sou3.png',
    'assets/Sou4.png',
    'assets/Sou5.png',
    'assets/Sou6.png',
    'assets/Sou7.png',
    'assets/Sou8.png',
    'assets/Sou9.png',
    'assets/Pin1.png',
    'assets/Pin2.png',
    'assets/Pin3.png',
    'assets/Pin4.png',
    'assets/Pin5.png',
    'assets/Pin6.png',
    'assets/Pin7.png',
    'assets/Pin8.png',
    'assets/Pin9.png',
    'assets/Ton.png',
    'assets/Nan.png',
    'assets/Shaa.png',
    'assets/Pei.png',
    'assets/Chun.png',
    'assets/Hatsu.png',
    'assets/Haku.png',
  ];

  void _removeButton(int index) {
    setState(() {
      selectedImages.removeAt(index);
    });
  }

  void _addButtonImage(String imagePath) {
    setState(() {
      selectedImages.add(imagePath);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Discard Advisor'),
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: selectedImages.length,
              itemBuilder: (context, index) {
                return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 50,
                      height: 100,
                      child: ElevatedButton(
                        onPressed: () => _removeButton(index),
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            //minimumSize: Size(10, 20),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2))),
                        child: Image.asset(selectedImages[index],
                            fit: BoxFit.cover),
                      ),
                    ));
              },
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: GridView.count(
              crossAxisCount: 12,
              shrinkWrap: true,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              children: buttonImages.map((imagePath) {
                return SizedBox(
                    width: 50,
                    height: 100,
                    child: ElevatedButton(
                      onPressed: () => _addButtonImage(imagePath),
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          //minimumSize: Size(10, 20),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2))),
                      child: Image.asset(imagePath, fit: BoxFit.cover),
                    ));
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
