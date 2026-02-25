import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.onChanged,
    this.controller,
    this.hasError = false,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    required this.labelText,
  });
  
  final String labelText;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final bool hasError;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    const Color lightGreyBackground = Color(0xFFF5F5F5);
    const Color hintGrey = Color(0xFF9E9E9E);
    const Color kazyonOrange = Color(0xFFFF7900);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: TextFormField(
        onChanged: onChanged,
        controller: controller,
        obscureText: obscureText,
        cursorColor: kazyonOrange,
        style: const TextStyle(color: Colors.black, fontSize: 16),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.grey[700], fontSize: 18),
          floatingLabelStyle: const TextStyle(color: hintGrey),
          hintStyle: const TextStyle(color: hintGrey, fontSize: 14),
          prefixIcon: prefixIcon != null
              ? Icon(prefixIcon, color: hasError ? Colors.red : Colors.grey[700], size: 22)
              : null,

          suffixIcon: suffixIcon != null
              ? Icon(suffixIcon, color: Colors.grey[700], size: 22)
              : null,
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: hasError ? Colors.red : Colors.grey.shade200,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: hasError ? Colors.red : hintGrey,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(15),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        ),
      ),
    );
  }
}