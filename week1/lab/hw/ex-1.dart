List<String> getPassedStudents(Map<String, int> scores) {
  List<String> result = [];
  scores.forEach((name, score) => score >= 50 ? result.add(name) : null);
  return result;
}

void main() {
  Map<String, int> scores = {
    "Dara": 78,
    "Sokha": 45,
    "Lina": 62,
    "Vanna": 39,
    "Mony": 85,
  };
  
  List<String> result = getPassedStudents(scores);

  print(result);
}
