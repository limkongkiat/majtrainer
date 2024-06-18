import 'package:flutter/material.dart';
import 'RefLists.dart';

class HandValueCalculator extends StatefulWidget {
  const HandValueCalculator({super.key});

  @override
  _HandValueCalculatorState createState() => _HandValueCalculatorState();
}

class _HandValueCalculatorState extends State<HandValueCalculator> {
  List<int> selectedImages = [];
  List<int> tileCount = List.filled(34, 0);

  int? tableWindIndex;
  int? seatWindIndex;
  String? selectedWind;

  void _removeButton(int index) {
    tileCount[selectedImages[index]] -= 1;
    setState(() {
      selectedImages.removeAt(index);
    });
  }

  void _addButtonImage(int index) {
    if (selectedWind == 'table') {
      _setTableWind(index);
    } else if (selectedWind == 'seat') {
      _setSeatWind(index);
    } else if (selectedImages.length < 14 && tileCount[index] < 4) {
      setState(() {
        selectedImages.add(index);
        selectedImages.sort((a, b) => a.compareTo(b));
      });
      tileCount[index] += 1;
    }
  }

  void _setTableWind(int index) {
    setState(() {
      tableWindIndex = index;
      selectedWind = null;
    });
  }

  void _setSeatWind(int index) {
    setState(() {
      seatWindIndex = index;
      selectedWind = null;
    });
  }

  void _selectWind(String wind) {
    setState(() {
      selectedWind = wind;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hand Value Calculator',
            style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 13, 97, 51),
      ),
      body: Container(
        color: const Color.fromARGB(255, 13, 97, 51),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '<WORK IN PROGRESS>',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
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
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const Text('Table Wind',
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () => _selectWind('table'),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: selectedWind == 'table'
                                ? Colors.yellow
                                : Colors.transparent,
                            width: 4.0,
                          ),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.red,
                        ),
                        padding: const EdgeInsets.all(20.0),
                        child: tableWindIndex != null
                            ? Image.asset(buttonImages[tableWindIndex!],
                                fit: BoxFit.cover)
                            : const SizedBox.shrink(),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text('Seat Wind',
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () => _selectWind('seat'),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: selectedWind == 'seat'
                                ? Colors.yellow
                                : Colors.transparent,
                            width: 4.0,
                          ),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.red,
                        ),
                        padding: const EdgeInsets.all(20.0),
                        child: seatWindIndex != null
                            ? Image.asset(buttonImages[seatWindIndex!],
                                fit: BoxFit.cover)
                            : const SizedBox.shrink(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
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
                          ),
                        );
                      } else {
                        // Perform calculation or navigation
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
                    child:
                        const Text('CALCULATE', style: TextStyle(fontSize: 20)),
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
                    child: const Text('BACK', style: TextStyle(fontSize: 20)),
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

void main() {
  runApp(MaterialApp(
    home: HandValueCalculator(),
  ));
}
