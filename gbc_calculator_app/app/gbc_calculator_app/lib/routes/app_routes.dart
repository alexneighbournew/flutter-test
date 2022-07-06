import 'package:flutter/material.dart';

import 'package:gbc_calculator_app/pages/pages.dart';

class AppRoutes {

  static String initalRoute = 'home';

  static Map<String, Widget Function(BuildContext)> routes = {
    'home'       : ( _ ) => const HomePage(),
    'calculator' : ( _ ) => const CalculatorPage(),
  };
}