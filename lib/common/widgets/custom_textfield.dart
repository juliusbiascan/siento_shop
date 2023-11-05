import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  final bool? isObscureText;
  final TextInputType inputType;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.maxLines = 1,
    this.isObscureText = false,
    this.inputType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      obscureText: isObscureText!,
      keyboardType: inputType,
      style: GoogleFonts.lato(
        fontSize: 18,
        fontWeight: FontWeight.w800,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(90.0)),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.grey[350],
        hintText: hintText,
        hintStyle: GoogleFonts.lato(
          color: Colors.black26,
          fontSize: 18,
          fontWeight: FontWeight.w800,
        ),
      ),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return '$hintText required';
        }
        return null;
      },
    );
  }
}
