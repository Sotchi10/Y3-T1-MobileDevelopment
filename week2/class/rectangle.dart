class Point {
  int x;
  int y;

  Point({required this.x, required this.y}) {}

  @override
  String toString() {
    return "Point x= $x, y=$y";
  }

  void translate({required int deltaX, required int deltaY}) {
    x += deltaX;
    y += deltaY;
  }
}

class Rectangle {
  Point top_left;
  Point bottom_right;

  Rectangle({required this.top_left, required this.bottom_right}) {}

  int getWidth() => (bottom_right.x > top_left.x)
      ? bottom_right.x - top_left.x
      : top_left.x - bottom_right.x;

  int getHeight() => (bottom_right.y > top_left.y)
      ? bottom_right.y - top_left.y
      : top_left.y - bottom_right.y;

  int getArea() => getWidth() * getHeight();

  @override
  String toString() {
    return "width: ${getWidth()}, height: ${getHeight()}, area: ${getArea()}";
  }
}

void main() {
  // test
  Point p1 = Point(x: 5, y: 8);
  Point p2 = Point(x: 9, y: 10);
  print(p1);
  print(p2);
  Rectangle r1 = Rectangle(top_left: p2, bottom_right: p1);
  print(r1);

  //p1.translate(deltaX: 100, deltaY: 200);
  //print(p1);
}
