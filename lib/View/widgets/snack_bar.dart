import 'package:flutter/material.dart';
import 'package:student_manager/View/widgets/style.dart';

class CustomSnackBar {
  void snackBar(context, String text, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          text,
        ),
        behavior: SnackBarBehavior.fixed,
        duration: const Duration(seconds: 1),
        backgroundColor: color,
      ),
    );
  }
}
