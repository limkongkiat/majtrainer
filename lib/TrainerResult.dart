import 'package:flutter/material.dart';
import 'ShantenCalculator.dart';

class TrainerResult extends StatefulWidget {
  final Function(bool) callback;
  int chosen;
  Result result;
  List<int> selectedImages;
  int currScore;
  int totalHands;

  TrainerResult(this.chosen, this.result, this.selectedImages, this.currScore,
      this.totalHands, this.callback);

  @override
  State<TrainerResult> createState() => _TrainerResultState();
}

class _TrainerResultState extends State<TrainerResult> {
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

  final List<String> handTypeCode = [
    "standard hand",
    "Chiitoitsu hand",
    'Kokushi Musou hand'
  ];

  @override
  Widget build(BuildContext context) {
    bool isCorrect =
        widget.selectedImages[widget.chosen] == widget.result.bestTile;
    //Result result = findBestDiscard(tileCount);
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
                itemCount: widget.selectedImages.length,
                itemBuilder: (context, index) {
                  if (widget.selectedImages[index] == widget.result.bestTile) {
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
                },
              ),
            ),
            const SizedBox(height: 20),
            Text(
                '${isCorrect ? 'Correct!' : 'Wrong!'} Throw ${widget.result.bestTile} for a ${handTypeCode[widget.result.handType]} at ${widget.result.shanten}-shanten with acceptance of ${widget.result.ukeire} tiles',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center),
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
                widget.callback(widget.selectedImages[widget.chosen] ==
                    widget.result.bestTile);
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
