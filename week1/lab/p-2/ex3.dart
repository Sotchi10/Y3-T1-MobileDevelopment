void main() {
  List<int> scores = [45, 78, 62, 49, 85, 33, 90, 50];
  // Method 1
  List<int> result = [];
  for(int i = 0; i < scores.length; i++) {
    if(scores[i] >= 50) {
      result.add(scores[i]);
    }
  }
  print(result);

  // Method 2
  List<int> result2 = scores.where((s) => (s >= 50)).toList();
  print(result2);
  
  }