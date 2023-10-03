import 'package:flutter/material.dart';

askModal({
  required BuildContext context,
  required String question,
}) async {
  return Navigator.push<String>(
    context,
    PageRouteBuilder(
      opaque: false,
      pageBuilder: (context, _, __) {
        return AskModal(question: question);
      },
    ),
  );
}

class AskModal extends StatelessWidget {
  const AskModal({super.key, required this.question});

  final String question;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      alignment: Alignment.center,
      child: Card(
        child: Container(
          color: Colors.white,
          width: double.infinity,
          height: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(question),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context, 'Ok'),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            return Colors.blue;
                          }
                          return null; // Use the component's default.
                        },
                      ),
                    ),
                    child: const Text('Ok'),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context, 'Annuler'),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            return Colors.red;
                          }
                          return Colors.grey; // Use the component's default.
                        },
                      ),
                    ),
                    child: const Text('Annuler'),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
