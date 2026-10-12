class Product {
  String? name;
  double? price;

  Product(this.name, this.price);

  //Getter
  String get getName => name!;
  double get getPrice => price!;
  //Setter
  set setName(String? _name) {
    name = _name;
  }

  set setPrice(double? _price) {
    price = _price;
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'product name: $name , product price: $price';
  }
}

void main() {
  Product coffee = Product("Coffee", 2.5);
  print(coffee.toString());
}
