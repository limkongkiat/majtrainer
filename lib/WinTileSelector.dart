import 'package:flutter/material.dart';
import 'package:majtrainer/HandValueResult.dart';
import 'ShantenCalculator.dart';
import 'ValueCalculator.dart';
import 'RefLists.dart';

class WinTileSelector extends StatelessWidget {
  final List<int> selectedImages;
  final List<int> tileCount;
  final Result result;
  final int tableWindIndex;
  final int seatWindIndex;
  const WinTileSelector(this.selectedImages, this.tileCount, this.result,
      this.tableWindIndex, this.seatWindIndex);

  @override
  Widget build(BuildContext context) {
    //standard trainer page
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hand Value Calculator',
            style: TextStyle(color: Colors.white)),
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
                            'The winning tile refers to the last tile you drew/another player discarded which led to you winning the hand.'),
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
              'Select Winning Tile',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
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
                        ValueCalculator vc = ValueCalculator();
                        ScoreInfo scInfo = vc.getScoreInfo(
                            result,
                            tileCount,
                            tableWindIndex,
                            seatWindIndex,
                            selectedImages[index]);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    HandValueResult(selectedImages, scInfo)));
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
