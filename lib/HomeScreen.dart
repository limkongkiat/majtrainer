import 'package:flutter/material.dart';
import 'package:majtrainer/DiscardAdviser.dart';
import 'package:majtrainer/HandValueCalculator.dart';
import 'package:majtrainer/trainerscreen.dart'; // Import the TrainerScreen
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatelessWidget {
  final User user;
  const HomeScreen(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 13, 97, 51),
      appBar: AppBar(
        title: const Text('Mahjong Trainer',
            style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 13, 97, 51),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Mahjong Trainer',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'made by\nLim Kong Kiat\nLow Yu Xuan',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: 250,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            TrainerScreen(user)), // Navigate to TrainerScreen
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Trainer', style: TextStyle(fontSize: 20)),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 250,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DiscardAdvisor()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Discard Calculator',
                    style: TextStyle(fontSize: 20)),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 250,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HandValueCalculator()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Hand Value Calculator',
                    style: TextStyle(fontSize: 20)),
              ),
            ),
            // const SizedBox(height: 20),
            // SizedBox(
            //   width: 250,
            //   child: ElevatedButton(
            //     onPressed: () {},
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: Colors.yellow,
            //       padding: const EdgeInsets.symmetric(vertical: 15),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(10),
            //       ),
            //     ),
            //     child: const Text('Settings', style: TextStyle(fontSize: 20)),
            //   ),
            // ),
            // const SizedBox(height: 20),
            // SizedBox(
            //   width: 250,
            //   child: ElevatedButton(
            //     onPressed: () {},
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: Colors.yellow,
            //       padding: const EdgeInsets.symmetric(vertical: 15),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(10),
            //       ),
            //     ),
            //     child: const Text('Changelogs', style: TextStyle(fontSize: 20)),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
