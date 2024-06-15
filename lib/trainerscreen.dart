import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'ShantenCalculator.dart';
import 'TrainerResult.dart';
import 'Scoreboard.dart';

class TrainerScreen extends StatefulWidget {
  const TrainerScreen({super.key});

  @override
  _TrainerScreenState createState() => _TrainerScreenState();
}

class _TrainerScreenState extends State<TrainerScreen> {
  List<String> buttonImages = [
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

  List<int> selectedImages = [];
  List<int> tileCount = List.filled(34, 0);
  int currScore = 0;
  int totalHands = 0;

  @override
  void initState() {
    super.initState();
    _generateRandomTiles();
  }

  void _generateRandomTiles() {
    //reset hand
    while (selectedImages.isNotEmpty) {
      selectedImages.removeAt(0);
    }
    for (int i = 0; i < 34; i++) {
      tileCount[i] = 0;
    }
    //generate new hand
    final random = Random();
    while (selectedImages.length < 14) {
      int rng = random.nextInt(34);
      if (tileCount[rng] < 4) {
        tileCount[rng] += 1;
        selectedImages.add(rng);
      }
    }
    selectedImages.sort((a, b) => a.compareTo(b));
  }

  void nextHand(bool isCorrect) {
    setState(() {
      if (isCorrect) {
        currScore++;
      }
      totalHands++;
      _generateRandomTiles();
    });
  }

  void updateDatabase() {
    final database = FirebaseDatabase.instance.ref();
    final recentScore = <String, dynamic>{
      'time': DateTime.now().millisecondsSinceEpoch,
      'score': currScore
    };
    database
        .child('scores')
        .push()
        .set(recentScore)
        .then((_) => print('Score updated'))
        .catchError((error) => print('You got an error $error'));
  }

  @override
  Widget build(BuildContext context) {
    Result result = findBestDiscard(tileCount);
    if (totalHands >= 5) {
      //Final results screen.
      //TODO: make page not take up only half the screen
      final database = FirebaseDatabase.instance.ref();
      final recentScore = <String, dynamic>{
        'time': DateTime.now().millisecondsSinceEpoch,
        'score': currScore
      };
      database
          .child('scores')
          .push()
          .set(recentScore)
          .then((_) => print('Score updated'))
          .catchError((error) => print('You got an error $error'));
      return Scaffold(
          appBar: AppBar(
            title: const Text('Trainer Mode',
                style: TextStyle(color: Colors.white)),
            backgroundColor: const Color.fromARGB(255, 13, 97, 51),
          ),
          body: Container(
              color: const Color.fromARGB(255, 13, 97, 51),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Trainer Mode',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Done!\nScore: $currScore / $totalHands",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Past Scores:",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Scoreboard(),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 30.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text('BACK', style: TextStyle(fontSize: 20)),
                  ),
                ],
              )));
    } else {
      //standard trainer page
      return Scaffold(
        appBar: AppBar(
          title:
              const Text('Trainer Mode', style: TextStyle(color: Colors.white)),
          backgroundColor: const Color.fromARGB(255, 13, 97, 51),
        ),
        body: Container(
          color: const Color.fromARGB(255, 13, 97, 51),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Trainer Mode',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Hand',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Flexible(
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    crossAxisSpacing: 2.0,
                    mainAxisSpacing: 2.0,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: selectedImages.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TrainerResult(
                                      index,
                                      result,
                                      selectedImages,
                                      currScore,
                                      totalHands,
                                      nextHand)));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.all(5.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                        child: Image.asset(
                          buttonImages[selectedImages[index]],
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Choose a tile to discard',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Current Score:',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              Text(
                '$currScore',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Total Hands:',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              Text(
                '$totalHands',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 30.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text('BACK', style: TextStyle(fontSize: 20)),
              ),
            ],
          ),
        ),
      );
    }
  }
}
