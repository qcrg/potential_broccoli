import 'package:flutter/material.dart';
import 'package:potential_broccoli/constants.dart';

class MonthSelectionModel with ChangeNotifier {
  Months _month;

  MonthSelectionModel({Months? initial_month})
    : _month = initial_month ?? Months.fromDateTime(DateTime.now());

  Months get month => _month;
  set month(Months val) {
    _month = val;
    notifyListeners();
  }
}
