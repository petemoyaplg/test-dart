main() {
  List<int> values = [1, 2, 4, 5];
  print(soustraire(15, values));

  List<double> doubleValues = [1.1, 2.231, 3.123, 4.21];
  print(soustraire(15.0, doubleValues));
}

// Nous limitons le type de T avec extends à un num :
T soustraire<T extends num>(T values, List<T> items) {
  T x = values;
  for (var value in items) {
    x = (x - value) as T;
  }
  return x;
}
