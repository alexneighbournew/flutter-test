
import 'package:flutter/material.dart';

class AppTheme {

  static Color colorPrimary  = const Color(0xff1f4f65);
  static Color navyColor     = const Color(0xff1f52ae);  
  static Color seaColor      = const Color(0xff4683e0);
  static Color skyColor      = const Color(0xffc9e0ff);

  static TextStyle resultStyle = TextStyle( color: AppTheme.navyColor, fontFamily: 'RalewayBold', fontSize: 14 );

  static ThemeData themeLight = ThemeData.light().copyWith(    

    textTheme: ThemeData.light().textTheme.apply(
          fontFamily: 'Raleway',
    ),

    primaryTextTheme: ThemeData.light().textTheme.apply(
          fontFamily: 'Raleway',
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: colorPrimary
    ),

    inputDecorationTheme: InputDecorationTheme(

    floatingLabelStyle: TextStyle(
      color: AppTheme.navyColor,
      fontFamily: 'RalewayBold'
    ),
    helperStyle: const TextStyle( fontWeight: FontWeight.w600 ),
    disabledBorder: OutlineInputBorder(      
      borderSide: BorderSide( color: colorPrimary ),
      borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10), topRight: Radius.circular(10))
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide( color: colorPrimary ),
      borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10), topRight: Radius.circular(10))
    ),
    focusedBorder: OutlineInputBorder(      
      borderSide: BorderSide( color: colorPrimary, width: 2 ),
      borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10), topRight: Radius.circular(10))
    ),
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), topRight: Radius.circular(10))
    )
  )

    

  );

}