enum Skill { FLUTTER, DART, OTHER }

class Salary {
  Employee _e;
  final double expExtra = 2000.0;
  Map<String, double> bonus = {
    '${Skill.DART}': 5000.0,
    '${Skill.FLUTTER}': 3000.0,
    '${Skill.OTHER}': 1000.0,
  };

  Salary({required this._e});

  double computeSalary() {
    double skillBonus = 0.0;
    for (Skill skill in _e.getSkills) {
      if (bonus.containsKey(skill.toString())) {
        skillBonus += bonus[skill.toString()]!;
      }
    }
    return _e.getBaseSalary + expExtra * _e.getExp + skillBonus;
  }
}

class Employee {
  late String _name;
  late double _baseSalary;
  List<Skill> _skills = [];
  String? _address;
  int _yearsOfExperience = 0;

  Employee({required this._name, required this._baseSalary});

  Employee.address({
    required this._name,
    required this._baseSalary,
    required String street,
    required String city,
    required String zipCode,
  }) {
    this._address = '$street, $city, $zipCode';
  }

  Employee.mobileDeveloper({
    required this._name,
    required this._baseSalary,
    required Skill skill,
    required this._yearsOfExperience,
  }) {
    this._skills = [skill];
  }

  void printDetails() {
    print('Employee: $_name, Base Salary: \$$_baseSalary');
  }

  String get getName => _name;
  double get getBaseSalary => _baseSalary;
  String? get getAddress => _address;
  int get getExp => _yearsOfExperience;
  List<Skill> get getSkills => _skills.toList();
}

void main() {
  Employee emp1 = Employee.mobileDeveloper(
    name: 'Sokea',
    baseSalary: 40000,
    skill: Skill.OTHER,
    yearsOfExperience: 3,
  );
  Employee emp2 = Employee.mobileDeveloper(
    name: 'Ronan',
    baseSalary: 45000,
    skill: Skill.DART,
    yearsOfExperience: 20,
  );
  //Sokea
  Salary salary = Salary(e: emp1);
  emp1.printDetails();
  print('Total Salary: \$${salary.computeSalary()}');
  //Ronan
  Salary salary2 = Salary(e: emp2);
  emp2.printDetails();
  print('Total Salary: \$${salary2.computeSalary()}');
}
