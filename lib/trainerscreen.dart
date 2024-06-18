import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math';
import 'ShantenCalculator.dart';
import 'TrainerResult.dart';
import 'Scoreboard.dart';
import 'RefLists.dart';

class TrainerScreen extends StatefulWidget {
  final User user;
  TrainerScreen(this.user);

  @override
  _TrainerScreenState createState() => _TrainerScreenState();
}

class _TrainerScreenState extends State<TrainerScreen> {
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
      int rng = random.nextInt(27);
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

  @override
  Widget build(BuildContext context) {
    Result result = findBestDiscard(tileCount);
    if (totalHands >= 5) {
      return Scoreboard(currScore, totalHands, widget.user);
    } else {
      //standard trainer page
      return Scaffold(
        appBar: AppBar(
          title:
              const Text('Trainer Mode', style: TextStyle(color: Colors.white)),
          backgroundColor: const Color.fromARGB(255, 13, 97, 51),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.help, color: Colors.white),
              tooltip: 'Help',
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Close'),
                            ),
                          ],
                          title: const Text(
                              'This is a quiz to test your Mahjong skills!\n\nFor each given hand, choose the best tile to discard to maximise your winrate. Simply click the tile you wish to choose.\n\nAfter each hand, you will be told whether you have chosen the right or wrong hand.\n\nAfter 5 hands, a score out of 5 will be given. Past scores can also be seen to see your progress!'),
                        ));
              },
            )
          ],
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
                                      tileCount,
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
