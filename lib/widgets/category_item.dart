import 'package:flutter/material.dart';
import 'package:tawfeer_market/constants.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.image, required this.label, this.onTap});

  final String image;
  final String label;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque, // عشان يلتقط التاب حتى لو ضغطت على المساحة الفاضية
      child: Column(
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: Color(kprimarycolor).withOpacity(0.05),
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.cover,
              )
            ),
          ),
      
          const SizedBox(height: 8),
      
          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
