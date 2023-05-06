import 'package:flutter/material.dart';

class DrawerNotifire with ChangeNotifier {
  int _currentDrawer = 0;

  int get getCurrentDrawer => _currentDrawer;

  void setCurrentDrawer(int index) {
    _currentDrawer = index;
    notifyListeners();
  }
}
