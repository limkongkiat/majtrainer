import 'package:flutter/material.dart';
import 'package:majtrainer/DiscardResult.dart';
import 'package:majtrainer/WinningHand.dart';
import 'ShantenCalculator.dart';

class DiscardAdvisor extends StatefulWidget {
  const DiscardAdvisor({super.key});

  @override
  State<DiscardAdvisor> createState() => _DiscardAdvisorState();
}

class _DiscardAdvisorState extends State<DiscardAdvisor> {
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

  void _removeButton(int index) {
    tileCount[selectedImages[index]] -= 1;
    setState(() {
      selectedImages.removeAt(index);
    });
  }

  void _addButtonImage(int index) {
    if (selectedImages.length < 14 && tileCount[index] < 4) {
      setState(() {
        selectedImages.add(index);
        selectedImages.sort((a, b) => a.compareTo(b));
      });
      tileCount[index] += 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discard Advisor',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromARGB(255, 13, 97, 51),
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
                            'Select tiles from the bottom half of the screen to form your hand.\n\nTo deselect a tile, tap the tile in the selected hand.\n\nOnce 14 tiles have been selected, press Calculate to get the best discard.'),
                      ));
            },
          )
        ],
      ),
      body: Container(
        color: Color.fromARGB(255, 13, 97, 51),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Selected Hand Section
            const Text(
              'Selected Hand',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Flexible(
              //flex: 2,
              child: GridView.builder(
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
                    child: SizedBox(
                      //width: 50,
                      //height: 200,
                      child: ElevatedButton(
                        onPressed: () => _removeButton(index),
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
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            // Select Tiles Section
            const Text(
              'Select Tiles',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: GridView.builder(
                  itemCount: buttonImages.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6,
                    mainAxisSpacing: 4.0,
                    crossAxisSpacing: 4.0,
                    childAspectRatio: 0.8,
                  ),
                  itemBuilder: (context, index) {
                    return ElevatedButton(
                      onPressed: () => _addButtonImage(index),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.all(5.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      child:
                          Image.asset(buttonImages[index], fit: BoxFit.cover),
                    );
                  },
                ),
              ),
            ),
            // Calculate and Back Buttons
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (selectedImages.length < 14) {
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
                                  title: const Text('Please select 14 tiles.'),
                                ));
                      } else {
                        Result result = findBestDiscard(tileCount);
                        if (result.shanten == -1) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      WinningHand(selectedImages)));
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DiscardResult(result, selectedImages)));
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 30.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      'CALCULATE',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
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
                    child: const Text(
                      'BACK',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
