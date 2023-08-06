import 'package:flutter/material.dart';

class RangeValuesProvider extends ChangeNotifier {
  RangeValues _currentRangeValues = RangeValues(400, 3500);

  RangeValues get currentRangeValues => _currentRangeValues;

  void setCurrentRangeValues(RangeValues values) {
    _currentRangeValues = values;
    notifyListeners();
  }
}
