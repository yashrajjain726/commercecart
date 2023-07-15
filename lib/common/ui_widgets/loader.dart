import 'package:flutter/material.dart';

class Loader {
  showLoadingDialog(context) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.white,
          ));
        });
  }

  closeLoadingDialog(context) async {
    Navigator.pop(context);
  }
}
