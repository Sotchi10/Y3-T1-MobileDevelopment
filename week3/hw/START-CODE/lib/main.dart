import 'model/course.dart';
import 'model/student.dart';
import 'service/lms_system.dart';

void main() {
  LmsSystem system = LmsSystem();

  system.createCourse(courseId: "C01", courseName: "Mobile Development");
  system.addStudent(studentId: "S01", studentName: "Ban");
  system.addStudent(studentId: "S02", studentName: "Ban2");
  print(system.getStudents);
  print(system.getCourses);
  //system.removeCourse(courseId: "C01");
  //print(system.getCourses);

  system.enrollStudent(courseId: "C01", studentId: "S01");
  system.enrollStudent(courseId: "C01", studentId: "S02");
  
  //system.removeStudent(studentId: "S01");
  //print(system.getStudents);
  //system.printStudentInCourse(courseId: "C01");

  system.addResult(courseId: "C01", studentId: "S02", sc: 80.0);
  system.addResult(courseId: "C01", studentId: "S01", sc: 81.0);
  system.discardStudentFromCourse(courseId: "C01", studentId: "S02");
  system.checkStudentScore(studentId: "S02");
  system.removeResult(courseId: "C01", studentId: "S01");
  system.checkStudentScore(studentId: "S02");
  system.printResultInCourse(courseId: "C01");

  //system.enrollStudent(courseId: "001", studentId: "AA1");
  //system.enrollStudent(courseId: "002", studentId: "AA1");
  //system.enrollStudent(courseId: "002", studentId: "AA2");
}
