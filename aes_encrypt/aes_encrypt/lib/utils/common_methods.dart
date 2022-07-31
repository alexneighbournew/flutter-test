import 'package:flutter/material.dart';

class CommonMethods {
  static showToast(BuildContext context, String text) {
    ScaffoldMessenger
      .of(context)
      .showSnackBar(
        SnackBar(
          content: Text(text)
        )
      );  
  }
}