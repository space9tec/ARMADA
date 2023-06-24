import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String? _name;
  String? _phone;

  void setUser(String name, String email) {
    _name = name;
    _phone = email;
    notifyListeners();
  }

  String? get name => _name;
  String? get email => _phone;
}
