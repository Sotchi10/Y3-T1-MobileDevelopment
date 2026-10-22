import 'package:lms_layered_architecture_example/model/result.dart';

class Student {
  final String id;
  final String name;
  final List<Result> results = [];

  Student({required this.id, required this.name});

  // ====== Getters ======
  String get getId => this.id;
  String get getName => this.name;
  List<Result> get getResults => List.unmodifiable(results);
  

  @override
  String toString() {
    // TODO: implement toString
    return "${this.id} : ${this.name}";
  }
}
