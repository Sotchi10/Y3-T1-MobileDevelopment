class Result {
  final String studentId;
  final String courseId;
  final double score;

  Result({required this.studentId, required this.courseId, required this.score});

  String get id => '$courseId:$studentId';
  String get getId => id;
  double get getScore => score;
  

  @override
  String toString() {
    // TODO: implement toString
    return "$courseId / $studentId: $score";
  }
}
