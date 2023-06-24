// import 'package:flutter/material.dart';

// import '../models/user.dart';

// class UserMProvider with ChangeNotifier {
//   User? _userModel;

//   User? get userModel => _userModel;

//   void setUserModel(User userModel) {
//     _userModel = userModel;
//     notifyListeners();
//   }
// }
import 'package:flutter/material.dart';

import '../models/user.dart';

class UserMProvider with ChangeNotifier {
  User? _userModel;

  User? get userModel => _userModel;

  void setUserModel(String userId) {
    _userModel = User(useid: userId, firstname: '', phone: '');
    notifyListeners();
  }
}
