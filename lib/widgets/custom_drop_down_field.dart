import 'package:flutter/material.dart';

class CustomDropdownField<T> extends StatelessWidget {
  final String labelText;
  final List<T> items;
  final T? value;
  final Function(T?) onChanged;
  final String Function(T) itemLabel;
  final IconData? prefixIcon;
  final String? Function(T?)? validator;

  const CustomDropdownField({
    super.key,
    required this.labelText,
    required this.items,
    required this.value,
    required this.onChanged,
    required this.itemLabel,
    this.prefixIcon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: DropdownButtonFormField<T>(
        value: value,
        onChanged: onChanged,
        validator: validator,
        icon: const Icon(Icons.arrow_drop_down_rounded, size: 30),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.grey[700], fontSize: 18),

          prefixIcon: prefixIcon != null
              ? Icon(prefixIcon, color: Colors.grey[700])
              : null,

          filled: true,
          fillColor: Colors.white,

          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade200),
            borderRadius: BorderRadius.circular(15),
          ),

          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(15),
          ),

          contentPadding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 20,
          ),
        ),

        items: items.map((item) {
          return DropdownMenuItem<T>(value: item, child: Text(itemLabel(item)));
        }).toList(),
      ),
    );
  }
}
