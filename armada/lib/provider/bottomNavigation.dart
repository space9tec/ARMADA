import 'package:flutter/material.dart';

class BottomNavigation with ChangeNotifier {
  var position = 0;

  setBottomNavPosition(value) {
    position = value!;
    notifyListeners();
  }
}
