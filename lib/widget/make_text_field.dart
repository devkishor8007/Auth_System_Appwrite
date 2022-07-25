import 'package:flutter/material.dart';

Widget makeTextField(
    {String? hintText,
    required TextEditingController controller,
    bool? obscureText,
    Widget? suffixIcon,
    FocusNode? focusNode,
    Function(String)? onFieldSubmitted,
    TextInputAction? textInputAction,
    bool? autofocus}) {
  return TextFormField(
    autofocus: autofocus ?? false,
    focusNode: focusNode,
    textInputAction: textInputAction,
    onFieldSubmitted:(value) => onFieldSubmitted,
    controller: controller,
    obscureText: obscureText ?? false,
    decoration: InputDecoration(
      suffixIcon: suffixIcon,
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.grey),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      filled: true,
      fillColor: Colors.grey.withOpacity(0.06),
    ),
  );
}
