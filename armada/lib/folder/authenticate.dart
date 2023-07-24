import 'package:flutter/material.dart';

class Authenticate extends ChangeNotifier {
  bool? logged;

  void setAuthenticate(bool name) {
    logged = name;
    notifyListeners();
  }

  bool? get authenticate => logged;
}
