import 'package:flutter/widgets.dart';

import '../models/user_model.dart';

class UserProvider with ChangeNotifier {
  late User user;

  void updateUser(User updatedUser) {
    user = updatedUser;
    notifyListeners();
  }
}
