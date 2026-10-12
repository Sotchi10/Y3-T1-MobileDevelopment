class Vehicle {
  final String? name;
  final String? type;
  Vehicle(this.name, {required this.type});

  String get getname => name!;

  String get getType => type!;
}

void main() {
  Vehicle car = Vehicle("Buggati", type: "car");

  print(car.getname + " is a " + car.getType);
}
