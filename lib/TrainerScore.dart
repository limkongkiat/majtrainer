class TrainerScore {
  final DateTime timestamp;
  final int score;

  TrainerScore(this.timestamp, this.score);

  factory TrainerScore.fromRTDB(Map<String, dynamic> data) {
    return TrainerScore(
        (data['time'] != null)
            ? DateTime.fromMillisecondsSinceEpoch(data['time'])
            : DateTime.now(),
        data['score']);
  }
}
