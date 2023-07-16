import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String text;
  final double? height;
  final TextEditingController? controller;
  final String hintText;
  final int? maxLines;
  final bool? obscure;
  final Function(String? value) validator;
  final bool? enabled;

  const CustomTextField(
      {super.key,
      required this.text,
      this.enabled = true,
      this.height = 70,
      this.controller,
      required this.hintText,
      this.maxLines = 1,
      this.obscure = false,
      required this.validator});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.text),
        const SizedBox(height: 5),
        SizedBox(
          height: widget.height ?? 70,
          child: TextFormField(
            enabled: widget.enabled,
            maxLines: widget.maxLines ?? 1,
            controller: widget.controller,
            obscureText: widget.obscure == true ? passwordVisible : false,
            validator: (value) => widget.validator(value),
            decoration: InputDecoration(
              suffixIcon: widget.obscure == true
                  ? IconButton(
                      icon: Icon(passwordVisible
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        setState(
                          () {
                            passwordVisible = !passwordVisible;
                          },
                        );
                      })
                  : null,
              alignLabelWithHint: false,
              hintText: widget.hintText,
              hintStyle: const TextStyle(fontSize: 14),
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
            ),
          ),
        ),
      ],
    );
  }
}
