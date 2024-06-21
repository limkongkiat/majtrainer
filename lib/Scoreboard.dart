import 'package:flutter/material.dart';
import 'TrainerScore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Scoreboard extends StatelessWidget {
  final database = FirebaseDatabase.instance.ref();
  //late DatabaseReference deviceRef;
  int currScore, totalHands;
  final User user;

  Scoreboard(this.currScore, this.totalHands, this.user);

  void updateDatabase() {
    //final database = FirebaseDatabase.instance.ref();
    final recentScore = <String, dynamic>{
      'time': DateTime.now().millisecondsSinceEpoch,
      'score': currScore
    };
    database
        .child(user.uid)
        .push()
        .set(recentScore)
        .then((_) => print('Score updated'))
        .catchError((error) => print('You got an error $error'));
  }

  Future<List<TrainerScore>> fetchTrainerScores() async {
    DatabaseReference ref = database.child(user.uid);
    DataSnapshot snapshot = await ref.get();

    if (snapshot.exists && snapshot.value is Map) {
      final data = snapshot.value as Map<Object?, Object?>;
      List<TrainerScore> scores = data.entries.map((e) {
        final value = e.value;
        if (value is Map<Object?, Object?>) {
          final scoreMap = Map<String, dynamic>.from(value);
          return TrainerScore.fromRTDB(scoreMap);
        }
        return TrainerScore(DateTime.now(), 0); // default or error case
      }).toList();
      scores.sort((a, b) => b.timestamp.millisecondsSinceEpoch
          .compareTo(a.timestamp.millisecondsSinceEpoch));
      return scores;
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    updateDatabase();
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
                FutureBuilder<List<TrainerScore>>(
                  future: fetchTrainerScores(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No scores found.'));
                    } else {
                      final scores = snapshot.data!;
                      return Flexible(
                          child: ListView.builder(
                        itemCount: scores.length,
                        itemBuilder: (context, index) {
                          final score = scores[index];
                          return ListTile(
                            title: Text('Score: ${score.score}',
                                style: const TextStyle(color: Colors.white)),
                            subtitle: Text('Time: ${score.timestamp}',
                                style: const TextStyle(color: Colors.white)),
                          );
                        },
                      ));
                    }
                  },
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
            )));
  }
}
