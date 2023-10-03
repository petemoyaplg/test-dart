import 'dart:math';

enum Direction { gauche, droite, devant, derriere }

void main() {
  // Nous créons deux instances de la classe Point :
  Point point1 = Point(10, 2);
  Point point2 = Point(22, 11);

  // Puis nous invoquons la méthode distanceTo :
  num distance = point1.distanceTo(point2);
  print(distance);

  var direction = Direction.gauche;

  switch (direction) {
    case Direction.gauche:
      print('A gauche !');
      break;
    case Direction.droite:
      print('A droite !');
      break;
    case Direction.devant:
      print('Devant !');
      break;
    case Direction.derriere:
      print('Derriere !');
      break;
  }

  List<int> values = [1, 2, 4, 5];
  print(soustraire(15, values));

  List<double> doubleValues = [1.1, 2.231, 3.123, 4.21];
  print(soustraire(15.0, doubleValues));
}

class Point {
  num x, y;

  Point(this.x, this.y);

  // Nous calculons la distance entre deux points dans
  // sur un plan carthésien :
  num distanceTo(Point autrePoint) {
    num dx = x - autrePoint.x;
    num dy = y - autrePoint.y;
    return sqrt(dx * dx + dy * dy);
  }
}

// Nous limitons le type de T avec extends à un num :
T soustraire<T extends num>(T values, List<T> items) {
  T x = values;
  for (var value in items) {
    x = (x - value) as T;
  }
  return x;
}
