import 'package:flutter/material.dart';
import 'ShantenCalculator.dart';

class DiscardResult extends StatelessWidget {
  final List<String> buttonImages = [
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

  final Result result;

  DiscardResult(this.result);

  @override
  Widget build(BuildContext context) {
    //TODO: Handle winning hand case
    return Container(
      color: Colors.green[700],
      padding: const EdgeInsets.all(16.0),
      child: Center(
          child: Column(
        children: <Widget>[
          const SizedBox(height: 100),
          Container(
              width: 240,
              height: 400,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Image.asset(
                  buttonImages[result.bestTile],
                  fit: BoxFit.cover,
                ),
              )),
          const SizedBox(height: 20),
          Text(
              'Discard for a ${handTypeCode[result.handType]} at ${result.shanten}-shanten with acceptance of ${result.ukeire} tiles',
              style: const TextStyle(color: Colors.white, fontSize: 20),
              textAlign: TextAlign.center),
          const SizedBox(height: 20),
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
