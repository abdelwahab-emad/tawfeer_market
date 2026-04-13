import 'package:flutter/material.dart';
import 'package:tawfeer_market/constants.dart';

class AdminSideMenuItem extends StatelessWidget {
  final int index;
  final int currentIndex;
  final IconData icon;
  final String label;
  final bool isCollapsed;
  final Function(int) onTap;

  const AdminSideMenuItem({
    super.key,
    required this.index,
    required this.currentIndex,
    required this.icon,
    required this.label,
    required this.isCollapsed,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    bool isSelected = index == currentIndex;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isCollapsed ? 4 : 12,
            vertical: 4,
          ),
          child: GestureDetector(
            onTap: () => onTap(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(kprimarycolor)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(
                    icon,
                    color: isSelected ? Colors.white : Colors.grey.shade600,
                    size: 24,
                  ),
                  if (!isCollapsed) ...[
                    const SizedBox(width: 15),
                    Expanded(
                      child: Text(
                        label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                        
                          color: Colors.black87,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
