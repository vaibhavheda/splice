import 'package:flutter/material.dart';

/*
 * Function to show a snackBar with a custom message
 */
void showSnackBarCustom(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      margin: EdgeInsets.all(16),
      behavior: SnackBarBehavior.floating,
      content: Text(
        message,
      ),
    ),
  );
}
