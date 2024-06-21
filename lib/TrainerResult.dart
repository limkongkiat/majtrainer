import 'package:flutter/material.dart';
import 'ShantenCalculator.dart';
import 'RefLists.dart';
import 'HelpPage.dart';

class TrainerResult extends StatefulWidget {
  final Function(bool) callback;
  int chosen;
  Result result;
  List<int> selectedImages;
  List<int> hand;
  int currScore;
  int totalHands;

  TrainerResult(this.chosen, this.result, this.selectedImages, this.hand,
      this.currScore, this.totalHands, this.callback);

  @override
  State<TrainerResult> createState() => _TrainerResultState();
}

class _TrainerResultState extends State<TrainerResult> {
  bool checkIfCorrect(List<int> hand, int tile, Result result) {
    bool isCorrect = false;
    hand[tile] -= 1;
    ShantenCalculator tempCalc = ShantenCalculator();
    if (tempCalc.calculateMinimumShanten(hand) == result.shanten &&
        calculateUkeire(hand) >= result.ukeire) {
      isCorrect = true;
    } else {
      isCorrect = false;
    }
    return isCorrect;
  }

  @override
  Widget build(BuildContext context) {
    bool isCorrect = checkIfCorrect(
        widget.hand, widget.selectedImages[widget.chosen], widget.result);
    //Result result = findBestDiscard(tileCount);
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
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HelpPage()));
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
                itemCount: widget.selectedImages.length,
                itemBuilder: (context, index) {
                  if (!isCorrect) {
                    if (widget.selectedImages[index] ==
                        widget.result.bestTile) {
                      return Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Stack(children: <Widget>[
                          Container(
                            padding: const EdgeInsets.all(2.0),
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2.0)),
                                color: Colors.white),
                            child: Image.asset(
                              buttonImages[widget.selectedImages[index]],
                              fit: BoxFit.contain,
                            ),
                          ),
                          Container(color: Colors.green.withOpacity(0.5))
                        ]),
                      );
                    } else if (index == widget.chosen) {
                      return Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Stack(children: <Widget>[
                          Container(
                            padding: const EdgeInsets.all(2.0),
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2.0)),
                                color: Colors.white),
                            child: Image.asset(
                              buttonImages[widget.selectedImages[index]],
                              fit: BoxFit.contain,
                            ),
                          ),
                          Container(color: Colors.red.withOpacity(0.5))
                        ]),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                          padding: const EdgeInsets.all(2.0),
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2.0)),
                              color: Colors.white),
                          child: Image.asset(
                            buttonImages[widget.selectedImages[index]],
                            fit: BoxFit.contain,
                          ),
                        ),
                      );
                    }
                  } else {
                    if (index == widget.chosen) {
                      return Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Stack(children: <Widget>[
                          Container(
                            padding: const EdgeInsets.all(2.0),
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2.0)),
                                color: Colors.white),
                            child: Image.asset(
                              buttonImages[widget.selectedImages[index]],
                              fit: BoxFit.contain,
                            ),
                          ),
                          Container(color: Colors.green.withOpacity(0.5))
                        ]),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                          padding: const EdgeInsets.all(2.0),
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2.0)),
                              color: Colors.white),
                          child: Image.asset(
                            buttonImages[widget.selectedImages[index]],
                            fit: BoxFit.contain,
                          ),
                        ),
                      );
                    }
                  }
                },
              ),
            ),
            const SizedBox(height: 20),
            FeedbackText(
                widget.selectedImages, widget.chosen, widget.result, isCorrect),
            const SizedBox(height: 20),
            const Text(
              'Current Score:',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            Text(
              '${isCorrect ? widget.currScore + 1 : widget.currScore}',
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
              '${widget.totalHands + 1}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                widget.callback(isCorrect);
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
              child: const Text('NEXT', style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}

class FeedbackText extends StatelessWidget {
  final List<int> selectedImages;
  final int chosen;
  final Result result;
  final bool isCorrect;

  const FeedbackText(
      this.selectedImages, this.chosen, this.result, this.isCorrect);

  @override
  Widget build(BuildContext context) {
    if (isCorrect) {
      return Text(
          'Correct! You get a ${handTypeCode[result.handType]} at ${result.shanten}-shanten with acceptance of ${result.ukeire} tiles',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
          textAlign: TextAlign.center);
    }
    return Text(
        'Wrong! Throw ${tileCode[result.bestTile]} for a ${handTypeCode[result.handType]} at ${result.shanten}-shanten with acceptance of ${result.ukeire} tiles',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
        textAlign: TextAlign.center);
  }
}
