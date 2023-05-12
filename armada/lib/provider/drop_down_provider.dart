import 'package:flutter/material.dart';

class DropDownProvider with ChangeNotifier {
  var accountType = ['Farmer', 'Service Provider', "Both"];
  var selectedAccount = 'Farmer';

  setAccountType(value) {
    selectedAccount = value!;
    notifyListeners();
  }
}
