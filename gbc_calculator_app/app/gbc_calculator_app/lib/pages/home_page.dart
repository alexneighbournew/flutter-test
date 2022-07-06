import 'package:flutter/material.dart';
import 'package:gbc_calculator_app/pages/pages.dart';
import 'package:gbc_calculator_app/themes/theme.dart';

import 'package:gbc_calculator_app/widgets/widgets.dart';

class HomePage extends StatelessWidget {

  const HomePage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [ 0.5, 0.5 ],
          colors: [
            AppTheme.skyColor,
            Colors.white
          ]
        )
      ),
      child: PageView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        children: const [

          _HomeBody(),

          CalculatorPage()


        ],
      ),
    );
  }
}

class _HomeBody extends StatelessWidget {
  const _HomeBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:  Background(),      
    );
  }
}