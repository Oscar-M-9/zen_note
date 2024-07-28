import 'package:flutter/material.dart';

class CustomInput {
  static InputDecoration buildInputDecoration(
    BuildContext context, {
    required String hintText,
  }) {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      hintText: hintText,
      hintStyle: Theme.of(context).textTheme.bodyMedium,
      filled: true,
      fillColor: Theme.of(context).inputDecorationTheme.fillColor,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
    );
  }
}
