import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double? width;
  final double? height;
  final VoidCallback onPressed;
  final String text;
  final TextStyle? textStyle;
  const CustomButton(
      {super.key,
      this.width,
      this.height,
      required this.onPressed,
      required this.text,
      this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
          style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(
                  Size(width ?? double.infinity, height ?? 50))),
          onPressed: onPressed,
          child: Text(
            text,
            style: textStyle,
          )),
    );
  }
}
