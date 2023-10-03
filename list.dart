void main(List<String> args) {
  var G7 = [
    "Allemagne",
    "Canada",
    "États-Unis",
    "France",
    "Italie",
    "Japon",
    "Royaume-Uni",
    "Union européenne"
  ];
  G7.forEach((pays) => print(pays.toUpperCase()));

  var nombresPremiers = Set();

  //Set<int> nombresPremiers = {};
  //var nombresPremiers = {}

  nombresPremiers.addAll([2, 3, 5, 7, 11, 13, 17, 19, 23]);
  print(nombresPremiers.length);
  print(nombresPremiers.first);
  print(nombresPremiers.last);

  print("element à l'index 5 : ${nombresPremiers.elementAt(5)}");

  nombresPremiers.removeAll([17, 19, 23]);
  print(nombresPremiers);

  nombresPremiers.addAll([11, 13, 17]);
  print(nombresPremiers);

  var map1 = {'clé1': 'valeur1', 1: 'valeur2'};

  // La propriété entries permet d'obternir les paires clé/valeur :
  print(map1.entries);

  // La propriété values permet d'obtenir les valeurs :
  print(map1.values);

  // La propriété keys permet d'obtenir les clés :
  print(map1.keys.runtimeType);

  var map2 = {...map1, 'clé3': 44.23};

  print(map2);
}
