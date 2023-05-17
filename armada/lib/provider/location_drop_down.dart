import 'package:flutter/material.dart';

class LocationSelectorProvider with ChangeNotifier {
  var location = ['Addis', 'Adama', "Bishoftu"];
  var selectedLocation = 'Addis';

  setLocation(value) {
    selectedLocation = value!;
    notifyListeners();
  }
}
