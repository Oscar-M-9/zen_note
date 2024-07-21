import 'package:flutter/material.dart';

class SearchInput extends StatelessWidget {
  final String hinText;
  final Widget prefixIcon;
  final Widget? suffixIcon;
  final void Function(String)? onChanged;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  // final String? initialValue;

  const SearchInput({
    super.key,
    required this.hinText,
    required this.prefixIcon,
    this.onChanged,
    this.focusNode,
    this.suffixIcon,
    this.controller,
    // this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15).copyWith(top: 15),
      child: Semantics(
        child: TextFormField(
          controller: controller,
          // initialValue: initialValue,
          keyboardType: TextInputType.text,
          focusNode: focusNode,
          autocorrect: false,
          onChanged: onChanged,
          style: Theme.of(context).textTheme.titleMedium,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(15),
            prefixIcon: prefixIcon,
            hintText: hinText,
            suffixIcon: suffixIcon,
            hintStyle: Theme.of(context).textTheme.bodyMedium,
            filled: true,
            fillColor: Theme.of(context).cardColor,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}
