import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFieldCustom extends StatelessWidget {
  final String? hintText;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextInputType? keyboardType;
  final int? minLines;
  final Color? color;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  const TextFieldCustom({
    super.key,
    this.hintText,
    this.fontSize,
    this.fontWeight = FontWeight.normal,
    this.keyboardType = TextInputType.text,
    this.minLines = 1,
    this.controller,
    this.validator,
    this.onChanged,
    this.color,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      minLines: minLines,
      maxLines: null,
      autocorrect: false,
      focusNode: focusNode,
      keyboardType: keyboardType,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        overflow: TextOverflow.ellipsis,
        color: color,
      ),
      decoration: InputDecoration(
        filled: false,
        border: InputBorder.none,
        hintText: hintText,
        hintStyle: GoogleFonts.lato(
          color: color?.withOpacity(0.8),
        ),
      ),
    );
  }
}
