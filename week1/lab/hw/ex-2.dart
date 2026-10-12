double computeAverage(List<int> scores) {
  return scores.reduce((value, element) => value + element) / scores.length;
}

void main() {
  final students = [
    {"name": "Dara", "Dart": 70, "Flutter": 80, "Database": 60},
    {"name": "Sokha", "Dart": 50, "Flutter": 90, "Database": 70},
    {"name": "Lina", "Dart": 80, "Flutter": 70, "Database": 90},
  ];

  final courses = ["Dart", "Flutter", "Database"];
  
  // Expected Result
  //var coursenadscore = [
  //  { "name": "dart", "score": [70, 50, 80], "average": null,
  //  },
  //  { "name": "flutter", "score": [80, 90, 70], "average": null,
  //  },
  //  { "name": "database", "score": [60, 70, 90], "average": null,
  //  },
  //];
  
  //  Implement computeAverage()
  //  For each course:
  // 1. Create a list of scores
  // 2. Compute the average
  // 3. Display the course name and average
  for (var c in courses) {
    var scores = students.map((s) => s[c] as int).toList();
    var avg = computeAverage(scores);
    print('Course: $c, Score: $scores, Average: $avg');
  }
}


