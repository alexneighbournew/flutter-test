
import 'package:flutter/material.dart';

class CalculatorFormProvider extends ChangeNotifier {

  String _salary = '';

  String get salary => _salary;

  set salary (String salary) {
    _salary = salary;
    notifyListeners();
  }


  double _personalContribution = 0.0;

  double get personalContribution => _personalContribution;

  set personalContribution ( double personalContribution ) {
    _personalContribution = personalContribution;
    notifyListeners();
  }

  
  double _netIncome = 0.0;

  double get netIncome => _netIncome;

  set netIncome ( double netIncome ) {
    _netIncome = netIncome;
    notifyListeners();
  }


  double _basicFraction = 0.0;

  double get basicFraction => _basicFraction;

  set basicFraction ( double basicFraction ) {
    _basicFraction = basicFraction;
    notifyListeners();
  }


  double _surplusFraction = 0.0;

  double get surplusFraction => _surplusFraction;

  set surplusFraction ( double surplusFraction ) {
    _surplusFraction = surplusFraction;
    notifyListeners();
  }


  double _taxOnBasicFraction = 0.0;

  double get taxOnBasicFraction => _taxOnBasicFraction;

  set taxOnBasicFraction ( double taxOnBasicFraction ) {
    _taxOnBasicFraction = taxOnBasicFraction;
    notifyListeners();
  }


  double _taxOnSurplusFraction = 0.0;

  double get taxOnSurplusFraction => _taxOnSurplusFraction;

  set taxOnSurplusFraction ( double taxOnSurplusFraction ) {
    _taxOnSurplusFraction = taxOnSurplusFraction;
    notifyListeners();
  }


  double _totalTax = 0.0;

  double get totalTax => _totalTax;

  set totalTax ( double totalTax ) {
    _totalTax = totalTax;
    notifyListeners();
  }


  double _discountForPersonalExpenses = 0.0;

  double get discountForPersonalExpenses => _discountForPersonalExpenses;

  set discountForPersonalExpenses ( double discountForPersonalExpenses ) {
    _discountForPersonalExpenses = discountForPersonalExpenses;
    notifyListeners();
  }

  double _totalTaxToPay = 0.0;

  double get totalTaxToPay => _totalTaxToPay;

  set totalTaxToPay ( double totalTaxToPay ) {
    _totalTaxToPay = totalTaxToPay;
    notifyListeners();
  }



  double _employerWithholding = 0.0;

  double get employerWithholding => _employerWithholding;

  set employerWithholding ( double employerWithholding ) {
    _employerWithholding = employerWithholding;
    notifyListeners();
  }


  double _differentCapacityDeduction = 0.0;

  double get differentCapacityDeduction => _differentCapacityDeduction;

  set differentCapacityDeduction ( double differentCapacityDeduction ) {
    _differentCapacityDeduction = differentCapacityDeduction;
    notifyListeners();
  }

  double _totalDeductions = 0.0;

  double get totalDeductions => _totalDeductions;

  set totalDeductions ( double totalDeductions ) {
    _totalDeductions = totalDeductions;
    notifyListeners();
  }

  

}