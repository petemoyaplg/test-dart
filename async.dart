void main(List<String> args) async {
  Future<String> f = Future<String>.delayed(Duration(seconds: 3), () {
    int test = 0;
    if (test > 0) {
      throw Exception('error');
    }
    return 'fini';
  });

  await f.then((value) => print(value)).catchError((err) => print(err));
  print('hello');
}

Future getData() {
  return Future.value('je suis de la data');
}
