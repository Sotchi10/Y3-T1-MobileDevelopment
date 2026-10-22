enum Gender { MALE, FEMALE, OTHER }

class Student {
  String _student_id;
  String _student_name;

  DateTime _student_dob;

  Student(this._student_id, this._student_dob, this._student_name);
}
