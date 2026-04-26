import 'package:flutter/material.dart';

class CustomDropdownField extends StatelessWidget {
  const CustomDropdownField({
    super.key,
    required this.labelText,
    required this.items,
    required this.value,
    required this.onChanged,
    this.prefixIcon,
  });

  final String labelText;
  final List<String> items;
  final String? value;
  final Function(String?) onChanged;
  final IconData? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: DropdownButtonFormField<String>(
        value: value,
        onChanged: onChanged,
        icon: const Icon(Icons.arrow_drop_down_rounded, size: 30),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.grey[700], fontSize: 18),

          /// 👇 هنا prefix icon (زي category icon)
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

        items: items
            .map(
              (item) => DropdownMenuItem(
                value: item,
                child: Text(item),
              ),
            )
            .toList(),
      ),
    );
  }
}