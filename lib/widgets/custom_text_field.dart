import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.onChanged,
    this.controller,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    required this.labelText,
    this.onSuffixPressed,
    this.borderRadius = 15.0,
    this.readOnly = false,
    this.prefixIconSize = 22.0,
  });

  final String labelText;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool obscureText;
  final void Function()? onSuffixPressed;
  final double borderRadius;
  final bool readOnly;
  final double prefixIconSize;

  @override
  Widget build(BuildContext context) {
    const Color hintGrey = Color(0xFF9E9E9E);
    const Color kazyonOrange = Color(0xFFFF7900);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: TextFormField(
        onChanged: onChanged,
        controller: controller,
        validator: validator,
        obscureText: obscureText,
        cursorColor: kazyonOrange,
        style: const TextStyle(color: Colors.black, fontSize: 16),
        decoration: InputDecoration(
          labelText: labelText,
          floatingLabelBehavior: readOnly ? FloatingLabelBehavior.never : FloatingLabelBehavior.auto,
          labelStyle: TextStyle(color: Colors.grey[700], fontSize: 18),
          floatingLabelStyle: const TextStyle(color: hintGrey),
          hintStyle: const TextStyle(color: hintGrey, fontSize: 14),
          prefixIcon: prefixIcon != null
              ? Icon(prefixIcon, color: Colors.grey[700], size: prefixIconSize)
              : null,

          suffixIcon: suffixIcon != null
              ? IconButton(
                  icon: Icon(suffixIcon, color: Colors.grey[700], size: 22),
                  onPressed:
                      onSuffixPressed, 
                  splashColor: Colors
                      .transparent,
                )
              : null,
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade200, width: 1),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: hintGrey, width: 1.5),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 1.5),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 20,
          ),
        ),
      ),
    );
  }
}
