import 'package:test/test.dart';

import '../lib/service/lms_system.dart';

void main() {
  late LmsSystem lms;
  setUp(() {
    lms = LmsSystem();
  });
  group('addStudent()', () {
    test('Add student successfully', () {
      lms.addStudent(studentId: 'S1',studentName: 'ronan');
      expect(lms.students.length, 1);
      expect(lms.students.first.id, 'S1');
      expect(lms.students.first.name, 'ronan');
    });

    test('Throw exception when add duplicate student', () {
      lms.addStudent(studentId: 'S1',studentName: 'ronan');
      expect(
        () => lms.addStudent(studentId: 'S1',studentName: 'dara',),
        throwsException,
      );

      expect(lms.students.length, 1);
    });
  });

  group('removeStudent()', () {
    test('Remove existing student successfully', () {
      lms.addStudent(studentId: 'S1',studentName: 'ronan');

      lms.removeStudent(studentId: 'S1');

      expect(lms.students, isEmpty);
    });

    test('Throw exception when remove non-exist student', () {
      expect(
        () => lms.removeStudent(studentId: 'S999'),
        throwsException,
      );

      expect(lms.students, isEmpty);
    });
  });

  group('course management', () {
    test('creates and removes a course', () {
      lms.createCourse(courseId: 'C1', courseName: 'Mobile Development');

      expect(lms.getCourses, hasLength(1));
      expect(lms.getCourses.first.id, 'C1');
      expect(lms.getCourses.first.name, 'Mobile Development');

      lms.removeCourse(courseId: 'C1');
      expect(lms.getCourses, isEmpty);
    });

    test('throws when creating a duplicate course ID or name', () {
      lms.createCourse(courseId: 'C1', courseName: 'Mobile Development');

      expect(
        () => lms.createCourse(courseId: 'C1', courseName: 'Different name'),
        throwsException,
      );
      expect(
        () => lms.createCourse(courseId: 'C2', courseName: 'Mobile Development'),
        throwsException,
      );
    });

    test('throws when removing a course that does not exist', () {
      expect(() => lms.removeCourse(courseId: 'C999'), throwsException);
    });
  });

  group('enrollStudent()', () {
    setUp(() {
      lms.addStudent(studentId: 'S1', studentName: 'Ronan');
      lms.createCourse(courseId: 'C1', courseName: 'Mobile Development');
    });

    test('enrolls an existing student in an existing course', () {
      lms.enrollStudent(courseId: 'C1', studentId: 'S1');

      expect(lms.getCourses.first.studentIds, equals(['S1']));
    });

    test('throws when the student is enrolled twice', () {
      lms.enrollStudent(courseId: 'C1', studentId: 'S1');

      expect(
        () => lms.enrollStudent(courseId: 'C1', studentId: 'S1'),
        throwsException,
      );
    });

    test('throws when the course or student does not exist', () {
      expect(
        () => lms.enrollStudent(courseId: 'C999', studentId: 'S1'),
        throwsException,
      );
      expect(
        () => lms.enrollStudent(courseId: 'C1', studentId: 'S999'),
        throwsException,
      );
    });

    test('discards a student from a course and removes that course result', () {
      lms.enrollStudent(courseId: 'C1', studentId: 'S1');
      lms.addResult(courseId: 'C1', studentId: 'S1', sc: 75);

      lms.discardStudentFromCourse(courseId: 'C1', studentId: 'S1');

      expect(lms.getCourses.first.studentIds, isEmpty);
      expect(lms.getCourses.first.results, isEmpty);
      expect(lms.getStudents.first.results, isEmpty);
    });
  });

  group('result management', () {
    setUp(() {
      lms.addStudent(studentId: 'S1', studentName: 'Ronan');
      lms.createCourse(courseId: 'C1', courseName: 'Mobile Development');
      lms.enrollStudent(courseId: 'C1', studentId: 'S1');
    });

    test('adds a result for an enrolled student', () {
      lms.addResult(courseId: 'C1', studentId: 'S1', sc: 85.5);

      expect(lms.getCourses.first.results, hasLength(1));
      expect(lms.getCourses.first.results.first.score, 85.5);
      expect(lms.getStudents.first.results.single.score, 85.5);
    });

    test('throws for a negative score or a student not enrolled in the course', () {
      expect(
        () => lms.addResult(courseId: 'C1', studentId: 'S1', sc: -1),
        throwsException,
      );

      lms.addStudent(studentId: 'S2', studentName: 'Dara');
      expect(
        () => lms.addResult(courseId: 'C1', studentId: 'S2', sc: 70),
        throwsException,
      );
      expect(
        () => lms.addResult(courseId: 'C1', studentId: 'S1', sc: 101),
        throwsException,
      );
    });

    test('rejects a duplicate result in the same course', () {
      lms.addResult(courseId: 'C1', studentId: 'S1', sc: 85.5);

      expect(
        () => lms.addResult(courseId: 'C1', studentId: 'S1', sc: 90),
        throwsException,
      );
    });

    test('removes a student result from the course and student', () {
      lms.addResult(courseId: 'C1', studentId: 'S1', sc: 85.5);

      lms.removeResult(courseId: 'C1', studentId: 'S1');

      expect(lms.getCourses.first.results, isEmpty);
      expect(lms.getStudents.first.results, isEmpty);
    });

    test('throws when removing a result that does not exist', () {
      expect(
        () => lms.removeResult(courseId: 'C1', studentId: 'S1'),
        throwsException,
      );
    });
  });

  test('removing a student removes every enrollment and result', () {
    lms.addStudent(studentId: 'S1', studentName: 'Ronan');
    lms.addStudent(studentId: 'S2', studentName: 'Dara');
    lms.createCourse(courseId: 'C1', courseName: 'Mobile Development');
    lms.createCourse(courseId: 'C2', courseName: 'Databases');
    lms.enrollStudent(courseId: 'C1', studentId: 'S1');
    lms.enrollStudent(courseId: 'C1', studentId: 'S2');
    lms.enrollStudent(courseId: 'C2', studentId: 'S1');
    lms.addResult(courseId: 'C1', studentId: 'S1', sc: 80);
    lms.addResult(courseId: 'C1', studentId: 'S2', sc: 90);
    lms.addResult(courseId: 'C2', studentId: 'S1', sc: 70);

    lms.removeStudent(studentId: 'S1');

    expect(lms.students.map((student) => student.id), equals(['S2']));
    expect(lms.getCourses[0].studentIds, equals(['S2']));
    expect(lms.getCourses[0].results.map((result) => result.studentId),
        equals(['S2']));
    expect(lms.getCourses[1].studentIds, isEmpty);
    expect(lms.getCourses[1].results, isEmpty);
  });
}
