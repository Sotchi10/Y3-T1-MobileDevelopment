import 'package:lms_layered_architecture_example/model/result.dart';

class Course {
  final String id;
  final String name;
  final List<String> studentIds = [];
  final List<Result> results = [];

  Course({required this.id, required this.name});

  // ====== Getters ======
  String get getId => this.id;
  String get getName => this.name;
  List<String> get getStudentIds => this.studentIds;
  List<Result> get getStudentResults => this.results;

  @override
  String toString() {
    // TODO: implement toString
    return "${this.id} : ${this.name}";
  }
}
