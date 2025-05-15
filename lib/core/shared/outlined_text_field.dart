import 'package:flutter/material.dart';

class OutlinedTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final bool obscureText;
  final bool? enabled;
  final int? maxLines;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final int? maxLength;
  final TextStyle? hintStyle;
  final TextInputAction? textInputAction;
  final int? minLines;

  const OutlinedTextField({
    super.key,
    this.hintText,
    this.validator,
    this.suffixIcon,
    this.obscureText = false,
    this.controller,
    this.enabled,
    this.maxLines = 1,
    this.onChanged,
    this.keyboardType,
    this.maxLength,
    this.hintStyle,
    this.textInputAction,
    this.minLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      minLines: minLines,
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: obscureText,
      textInputAction: textInputAction,
      enabled: enabled,
      onChanged: onChanged,
      maxLength: maxLength,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: suffixIcon,
        hintStyle: hintStyle,
      ),
      validator: validator,
    );
  }
}
