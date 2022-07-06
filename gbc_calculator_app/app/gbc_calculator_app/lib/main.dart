import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:gbc_calculator_app/providers/providers.dart';
import 'package:gbc_calculator_app/routes/app_routes.dart';
import 'package:gbc_calculator_app/themes/theme.dart';

void main() => runApp(const GbcCalculatorApp());

class GbcCalculatorApp extends StatelessWidget {

  const GbcCalculatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (( _ ) => CalculatorFormProvider()), lazy: false,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Calculadora GBC',
        initialRoute: AppRoutes.initalRoute,
        routes: AppRoutes.routes,
        theme: AppTheme.themeLight,
      ),
    );
  }
}