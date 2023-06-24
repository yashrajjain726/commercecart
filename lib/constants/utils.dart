import 'package:flutter/material.dart';

void showSnackbar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}

String uppercaseFirstLetter(String value) {
  return value[0].toUpperCase() + value.substring(1);
}
