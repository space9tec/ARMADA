import 'package:flutter/cupertino.dart';

class DatePickerProvider extends ChangeNotifier {
   DateTime? startDate;
  DateTime? endDate;

  void setStartDate(DateTime date) {
    startDate = date;
    notifyListeners();
  }

  void setEndDate(DateTime date) {
    endDate = date;
    notifyListeners();
  }
}
