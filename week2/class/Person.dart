class Person {
  String firstname;
  String lastname;

  Person({required String this.firstname, required String this.lastname}) {}

  String get getFirstName => this.firstname;
  String get getLastName => this.lastname;
  String get getFullName => this.firstname + ' ' + this.lastname;

  @override
  String toString() {
    //Implement toString
    return "Firstname: $firstname, Lastname: $lastname, Fullname: $getFullName";
  }
}

void main() {
  Person p = Person(firstname: "Kim", lastname: "Leng");
  print(p);
 
}
