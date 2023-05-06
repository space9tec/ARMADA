import 'package:flutter/material.dart';

class ItemNotifire extends ChangeNotifier {
  int _activepage = 0;

  int get activepage => _activepage;

  set activePage(int newIndex) {
    _activepage = newIndex;
    notifyListeners();
  }
}
