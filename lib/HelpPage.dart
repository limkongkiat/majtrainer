import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Help', style: TextStyle(color: Colors.white)),
          backgroundColor: const Color.fromARGB(255, 13, 97, 51),
        ),
        body: Container(
          alignment: Alignment.topCenter,
          color: const Color.fromARGB(255, 13, 97, 51),
          padding: const EdgeInsets.all(16.0),
          child: const Center(
              child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 50),
              Text('Explanation of terms',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(height: 50),
              Text('Shanten:',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left),
              Text(
                  'Refers to how many tiles is the hand away from becoming a ready hand. (e.g. 2-shanten = 2 tiles away from ready hand)',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                  textAlign: TextAlign.left),
              SizedBox(height: 50),
              Text('Acceptance:',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left),
              Text(
                  'A hand\'s acceptance refers to the number of tiles that, when drawn, brings the hand closer to a ready hand.',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                  textAlign: TextAlign.left),
            ],
          )),
        ));
  }
}
