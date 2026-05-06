import 'package:flutter/material.dart';
import 'package:tawfeer_market/constants.dart';

class UsersCountCard extends StatelessWidget {
  const UsersCountCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 65,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xffF8F9FA),
        borderRadius: BorderRadius.circular(15),
    //    border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Total Registered Users',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
          Text(
            '150',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: const Color(kprimarycolor),
            ),
          ),
        ],
      ),
    );
  }
}
