import 'dart:math';

import 'package:flutter/material.dart';

import 'package:gbc_calculator_app/themes/theme.dart';

class Background extends StatelessWidget {
  const Background({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: const [

        // Background
        _Background(),

        // Top shape
        //_Shape(),

        // Body
        _Body()
        
      ],
    );
  }
}



class _Background extends StatelessWidget {
  const _Background({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      color: AppTheme.skyColor,
      child: Image.asset('assets/bg/welcome-bg.jpg')
    );
  }
}

class _Shape extends StatelessWidget {
  const _Shape({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -50,
      left: -40,
      child: Transform.rotate(
        angle: -pi / 4.0,
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            color: AppTheme.seaColor,
            borderRadius: BorderRadius.circular(40)
          ),
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of( context ).size;

    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          Padding(
            padding: const EdgeInsets.only( top: 15 ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(  
                  width: size.width * 0.4,
                  image: const AssetImage( 'assets/logos/logo-gbc.png' )
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.only( top: 20 ),
            alignment: Alignment.center,
            width: double.infinity,
            child: Text('Calculadora Tributaria', style: TextStyle( color: AppTheme.colorPrimary, fontFamily: 'RalewayBold', fontSize: 22 ),)
          ),


          Expanded(child: Container()),
          

          Column(
            children: [

              Text('Deslice la pantalla para ir a la Calculadora', style: TextStyle( color: AppTheme.colorPrimary, fontFamily: 'RalewayLight', fontWeight: FontWeight.w700, fontSize: 16 ),),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(            
                    width: size.width * 0.5,
                    child: const Image( image: AssetImage('assets/icons/arrow-down.gif'), fit: BoxFit.cover, )
                  
                  ),
                ]
              ),
            ],
          )
        ],
      ),
    );
  }
}