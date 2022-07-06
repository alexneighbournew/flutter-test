
import 'package:flutter/material.dart';

class CalculatorFormProvider extends ChangeNotifier {

  String _salary = '';

  String get salary => _salary;

  set salary (String salary) {
    _salary = salary;
    notifyListeners();
  }

  

}