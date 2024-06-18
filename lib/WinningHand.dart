import 'package:flutter/material.dart';
import 'RefLists.dart';
//import 'ShantenCalculator.dart';

class WinningHand extends StatelessWidget {
  final List<int> selectedImages;

  WinningHand(this.selectedImages);

  @override
  Widget build(BuildContext context) {
    //TODO: Handle winning hand case
    return Container(
      color: Color.fromARGB(255, 13, 97, 51),
      padding: const EdgeInsets.all(16.0),
      child: Center(
          child: Column(
        children: <Widget>[
          const SizedBox(height: 50),
          const Text('Winning Hand!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
          const SizedBox(height: 10),
          const Text('Final Hand',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
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
                  child: Container(
                      padding: const EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Image.asset(
                        buttonImages[selectedImages[index]],
                        fit: BoxFit.contain,
                      )),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
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
      )),
    );
  }
}
