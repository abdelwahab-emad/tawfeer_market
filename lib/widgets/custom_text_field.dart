import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
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
    this.inputFormatters,
    this.keyboardType,
    this.focusColor = Colors.white,
    this.horizontalPadding = true,
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
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final Color? focusColor;
  final bool? horizontalPadding;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late FocusNode focusNode;

  @override
  void initState() {
    // TODO: implement initState
    focusNode = FocusNode();

    focusNode.addListener(() {
      setState(() {});
    });
    super.initState();
  }
  
  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    const Color hintGrey = Color(0xFF9E9E9E);
    const Color kazyonOrange = Color(0xFFFF7900);

    return Padding(
      padding: widget.horizontalPadding == true
          ? const EdgeInsets.symmetric(horizontal: 20, vertical: 8)
          : const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        onChanged: widget.onChanged,
        controller: widget.controller,
        readOnly: widget.readOnly,
        validator: widget.validator,
        obscureText: widget.obscureText,
        cursorColor: kazyonOrange,
        keyboardType: widget.keyboardType,
        inputFormatters: widget.inputFormatters,
        focusNode: focusNode,
        style: const TextStyle(color: Colors.black, fontSize: 16),
        decoration: InputDecoration(
          
          labelText: widget.labelText,
          floatingLabelBehavior: widget.readOnly
              ? FloatingLabelBehavior.never
              : FloatingLabelBehavior.auto,
          labelStyle: TextStyle(color: Colors.grey[700], fontSize: 18),
          floatingLabelStyle: const TextStyle(color: hintGrey),
          hintStyle: const TextStyle(color: hintGrey, fontSize: 14),
          prefixIcon: widget.prefixIcon != null
              ? Icon(widget.prefixIcon,
                  color: Colors.grey[700], size: widget.prefixIconSize)
              : null,
          suffixIcon: widget.suffixIcon != null
              ? IconButton(
                  icon: Icon(widget.suffixIcon,
                      color: Colors.grey[700], size: 22),
                  onPressed: widget.onSuffixPressed,
                  splashColor: Colors.transparent,
                )
              : null,
          filled: true,
          fillColor: focusNode.hasFocus ? widget.focusColor : Colors.white,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade200, width: 1),
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: hintGrey, width: 1.5),
            borderRadius: BorderRadius.circular(widget.borderRadius),
            
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 1.5),
            borderRadius: BorderRadius.circular(widget.borderRadius),
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