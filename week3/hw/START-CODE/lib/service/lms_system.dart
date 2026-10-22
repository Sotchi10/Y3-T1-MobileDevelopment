import 'package:lms_layered_architecture_example/model/result.dart';

import '../model/student.dart';
import '../model/course.dart';

/// Manage on adding students, course, add student to course, add result to student in course
/// - [Student]
/// `addStudent` `removeStudent` `checkStudentResult`
/// - [Course]
/// - [Result]
class LmsSystem {
  final List<Student> students = [];
  final List<Course> courses = [];

  // ============ Getters ============
  List<Course> get getCourses => courses;
  List<Student> get getStudents => students;

  // ============================== Methods ==============================
  void printStudentInCourse({required String courseId}) {
    Course? course = _findCourseOrNull(courseId);
    if (course == null) {
      throw Exception("Course not exists!");
    }
    print("${course.name} has ${course.getStudentIds}");
  }

  void printResultInCourse({required String courseId}) {
    Course? course = _findCourseOrNull(courseId);
    if (course == null) {
      throw Exception("Course not exists!");
    }
    print("${course.name} has ${course.getStudentResults}");
  }

  Course? _findCourseOrNull(String courseId, {String? name}) {
    for (Course c in courses) {
      if (c.id == courseId || c.name == name) {
        return c;
      }
    }
    return null; // not found
  }

  Result? _findResultInCourse(Course course, String studentId) {
    for (var r in course.results) {
      if (r.studentId == studentId) {
        return r;
      }
    }
    return null; // not found
  }

  Student? _findStudentOrNull(String studentId) {
    for (Student s in students) {
      if (s.id == studentId) {
        return s;
      }
    }
    return null; // not found
  }

  // ============================== Course ==============================
  /// Adds new course to system.
  ///
  /// Preconditions:
  /// - [courseId] and [courseName] should identify the new course.
  /// - No existing course should match the specified ID or name.
  ///
  /// Postconditions:
  /// - A new [Course] is added to [courses].
  ///
  /// Throws an [Exception] if a course already exists.
  void createCourse({required String courseId, required String courseName}) {
    Course? course = _findCourseOrNull(courseId, name: courseName);
    if (course != null) {
      throw Exception('Course $course already exists');
    }
    courses.add(Course(id: courseId, name: courseName));
  }

  /// Removes a course from the system.
  ///
  /// Preconditions:
  /// - [courseId] must identify an existing course.
  ///
  /// Postconditions:
  /// - The course is removed from [courses].
  ///
  /// Throws an [Exception] if the specified course does not exist.
  void removeCourse({required String courseId}) {
    Course? course = _findCourseOrNull(courseId);
    if (course == null) {
      throw Exception("Course not exists!");
    }
   // remove result once course removed
    for (var result in course.results) {
      _findStudentOrNull(result.studentId)?.results.remove(result);
    }
    courses.remove(course);
  }

  /// Enrolls a student in a course.
  ///
  /// Preconditions:
  /// - [courseId] must identify an existing course.
  /// - [studentId] must identify an existing student.
  /// - The student must not already be enrolled in the course.
  ///
  /// Postconditions:
  /// - The student's ID is added to the course's [Course.studentIds].
  ///
  /// Throws an [Exception] if the course or student does not exist,
  /// or if the student is already enrolled in the course.
  void enrollStudent({required String courseId, required String studentId}) {
    Course? course = _findCourseOrNull(courseId);
    Student? student = _findStudentOrNull(studentId);
    // check if exist
    if (course == null || student == null) {
      throw Exception("Coures or Student must exists");
    }
    // check if duplicate student in same course
    for (var s in course.studentIds) {
      if (studentId == s) {
        throw Exception("${studentId} already exists in ${course.name}");
      }
    }
    course.studentIds.add(student.id);
    print(
      "${student.id} has been added to course ${course.id}: ${course.name}",
    );
    print(course.getStudentIds);
  }

  /// Removes a student's enrollment from a course.
  ///
  /// Preconditions:
  /// - [courseId] must identify an existing course.
  /// - [studentId] must identify an existing student.
  ///
  /// Postconditions:
  /// - The student's ID is removed from the course's [Course.studentIds]
  ///   if it exists.
  ///
  /// Throws an [Exception] if the course or student does not exist.
  void discardStudentFromCourse(
      {required String courseId, required String studentId}) {
    Course? course = _findCourseOrNull(courseId);
    Student? student = _findStudentOrNull(studentId);
    // check if exist
    if (course == null || student == null) {
      throw Exception("Coures or Student must exists");
    }
    // check if student exist in course
    if (!course.studentIds.contains(student.id)) {
      throw Exception("Student not exist in course");
    }

    var resultsToRemove = course.results.where((result) => result.studentId == student.id).toList();
    for (var result in resultsToRemove) {
      course.results.remove(result);
      student.results.remove(result);
    }
    course.studentIds.remove(student.id);

    print(
      "${student.id} has been removed to course ${course.id}: ${course.name}",
    );
    print(course.getStudentIds);
  }

  // ============================== Student ==============================
  /// Adds new student to system.
  ///
  /// Preconditions:
  /// - [studentId] must be unique.
  ///
  /// Postconditions:
  /// - A new [Student] is added to [students].
  ///
  /// Throws an [Exception] if a student with the same ID already exists.
  void addStudent({required String studentId, required String studentName}) {
    // ! Student shall not exist already
    Student? student = _findStudentOrNull(studentId);
    if (student != null) {
      throw Exception('Student $student already exists');
    }

    students.add(Student(id: studentId, name: studentName));
  }

  /// Removes a student from the system.
  ///
  /// Preconditions:
  /// - [studentId] must belong to an existing student.
  ///
  /// Postconditions:
  /// - The student with the specified ID is removed from [students].
  ///
  /// Throws an [Exception] if the student does not exist.
  void removeStudent({required String studentId}) {
    Student? student = _findStudentOrNull(studentId);
    if (student == null) {
      throw Exception('Student $studentId not found');
    }
    // Remove every realted before removing the student.
    for (final course in courses) {
      course.studentIds.remove(studentId);
      course.results.removeWhere((result) => result.studentId == studentId);
    }
    students.remove(student);
  }

  void checkStudentScore({required String studentId}) {
    Student? student = _findStudentOrNull(studentId);
    if (student == null) {
      throw Exception("Student not exists");
    }
    print(student.results);
  }

  // ============================== Result ==============================
  /// Adds student score to course.
  ///
  /// Preconditions:
  /// - [sc] must not be less than 0.
  /// - [course] and [student] both must exist in the system.
  /// - [student] must enrolled in [course], verified by
  ///   `course.studentIds.contains(student.id)`.
  ///
  /// Postconditions:
  /// - A [Result] containing the student's ID and [sc] is added to the
  ///   course's results.
  ///
  /// Throws an [Exception] if the score is negative, or if the specified
  /// student or course does not exist.
  void addResult({
    required String courseId,
    required String studentId,
    required double sc,
  }) {
    if (sc < 0 || sc > 100) {
      throw Exception("Score must be between 0 and 100");
    }

    Course? course = _findCourseOrNull(courseId);
    Student? student = _findStudentOrNull(studentId);
    // check if exist
    if (course == null || student == null) {
      throw Exception("Coures or Student must exists");
    }
    // check if student exist in course
    if (!course.studentIds.contains(student.id)) {
      throw Exception("Student not exist in course");
    }

    if (_findResultInCourse(course, student.id) != null) {
      throw Exception("Student already has a result in this course");
    }

    var result = Result(studentId: studentId, courseId: courseId, score: sc);
    course.results.add(result);
    student.results.add(result);
  }

  /// Removes student's result from a course.
  ///
  /// Preconditions:
  /// - The course and student must exist.
  /// - The student must have a result.
  ///
  /// Postconditions:
  /// - The student's result is cleared.
  /// - The result is removed from the course's results.
  ///
  /// Throws an [Exception] if the course or student does not exist.
  void removeResult({
    required String courseId,
    required String studentId,
  }) {
    Course? course = _findCourseOrNull(courseId);
    Student? student = _findStudentOrNull(studentId);

    if (course == null || student == null) {
      throw Exception("Course or student does not exist!");
    }

    var result = _findResultInCourse(course, student.id);

    if (result == null) {
      throw Exception("Student has no result to remove!");
    }

    course.results.remove(result);
    student.results.remove(result);
  }
}
