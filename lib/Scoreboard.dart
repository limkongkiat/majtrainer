import 'package:flutter/material.dart';

import 'TrainerScore.dart';
import 'package:firebase_database/firebase_database.dart';

Future<List<TrainerScore>> fetchTrainerScores() async {
  DatabaseReference ref = FirebaseDatabase.instance.ref('scores');
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
    return scores;
  } else {
    return [];
  }
}

class Scoreboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TrainerScore>>(
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
    );
  }
}
