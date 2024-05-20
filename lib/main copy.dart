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
  String text = "";

  void changeText(String text) {
    setState(() {
      text.length == 28 ? this.text = "Valid hand" : this.text = "Invalid hand";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Mahjong Trainer")),
        body: Column(
            children: <Widget>[HandInputWidget(changeText), Text(text)]));
  }
}

class HandInputWidget extends StatefulWidget {
  final Function(String) callback;

  const HandInputWidget(this.callback);

  @override
  State<HandInputWidget> createState() => _HandInputWidgetState();
}

class _HandInputWidgetState extends State<HandInputWidget> {
  final controller = TextEditingController();
  //String text = "";

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void click() {
    widget.callback(controller.text);
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        decoration: InputDecoration(
            prefixIcon: const Icon(Icons.message_rounded),
            labelText: "Enter a hand: ",
            suffixIcon:
                IconButton(icon: const Icon(Icons.send), onPressed: click)));
  }
}
