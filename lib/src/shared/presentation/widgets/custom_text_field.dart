import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.labelText,
    this.errorText,
    this.textInputType = TextInputType.text,
    this.onChanged,
    this.obsecureText = false,
  });

  final String labelText;
  final String? errorText;
  final TextInputType textInputType;
  final Function(String)? onChanged;
  final bool obsecureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: textInputType,
      obscureText: obsecureText,
      style:
          Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelText: labelText,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
