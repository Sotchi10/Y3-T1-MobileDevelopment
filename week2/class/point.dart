enum Color {red, green}

class Point {
  final int _x;
  final int _y;

  Point({required this._x, required this._y}) {}

  @override
  String toString() {
    return "Point x= $_x, y=$_y";
  }

  Point translate({required int deltaX, required int deltaY}) {
    return Point(x: this._x + deltaX, y: this._y + deltaY);
  }     
}

void main() {
  // test
  Point p1 = Point(x: 5, y: 8);
  print(p1);

  Point p2 = p1.translate(deltaX: 100, deltaY: 200);
  print(p2);


}
