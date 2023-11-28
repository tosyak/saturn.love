import 'package:flutter/material.dart';

void showSnackBarWidget(String message, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: const Duration(seconds: 3),
    content: Text(message),
  ));
}
