import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final Function(String? value) validator;
  final TextEditingController controller;
  final String hintText;
  final bool? obscure;
  const CustomTextFormField({
    Key? key,
    required this.validator,
    required this.controller,
    required this.hintText,
    this.obscure,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black)),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black)),
      ),
      obscureText: obscure ?? false,
      validator: (value) => validator(value),
    );
  }
}
