import 'package:flutter/material.dart';

class GlobalFunctions {
  static showInfo1({required BuildContext context, required String message}) {
    // show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
