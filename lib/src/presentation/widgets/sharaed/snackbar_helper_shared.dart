import 'package:flutter/material.dart';

class SnackbarHelper {
  static void success(BuildContext context, String message) {
    _show(context, message, Colors.teal);
  }

  static void error(BuildContext context, String message) {
    _show(context, message, Colors.red);
  }

  static void _show(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: color),
    );
  }
}