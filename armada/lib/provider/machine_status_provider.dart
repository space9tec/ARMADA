import 'package:flutter/material.dart';

class MachineStatusProvider with ChangeNotifier {
  var accountType = ['Free', 'In Maintainance', "Rainted"];
  var selectedAccount = 'Free';

  setAccountType(value) {
    selectedAccount = value!;
    notifyListeners();
  }
}
