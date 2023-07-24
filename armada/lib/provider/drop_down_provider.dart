import 'package:flutter/material.dart';

class DropDownProvider with ChangeNotifier {
  var accountType = [
    'Tigray',
    'Afar',
    "Amhara",
    "Oromia",
    "Somalia",
    "SNNP",
    "Gambela",
    "Benshangul",
    "Harar"
  ];
  var selectedAccount = 'Tigray';

  setAccountType(value) {
    selectedAccount = value!;
    notifyListeners();
  }
}
