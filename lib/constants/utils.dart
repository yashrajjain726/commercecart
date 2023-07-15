import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

void showSnackbar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}

String uppercaseFirstLetter(String value) {
  return value[0].toUpperCase() + value.substring(1);
}

String? checkNullAndEmpty(String? value, String text) {
  if (value == null || value.isEmpty) {
    return 'Please enter the $text';
  }
  return null;
}

String? validateEmail(String? value, String text) {
  checkNullAndEmpty(value, text);
  if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value!)) {
    return "Please enter a valid email address";
  }
  return null;
}

validateConfirmPassword(String? passValue, String? confirmPassValue) {
  checkNullAndEmpty(confirmPassValue, 'confirm password');
  if (confirmPassValue != passValue) {
    return 'Your confirm password doesn\t match with password';
  }
  return null;
}

Future<List<File>> pickImages() async {
  List<File> images = [];
  try {
    var files = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: true);
    if (files != null && files.files.isNotEmpty) {
      for (int i = 0; i < files.files.length; i++) {
        images.add(File(files.files[i].path!));
      }
    }
  } catch (e) {
    print(e);
  }
  return images;
}
