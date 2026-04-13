import 'package:flutter/material.dart';
import 'package:tawfeer_market/constants.dart';

class AdminHeader extends StatelessWidget {
  const AdminHeader({super.key, required this.title});
  
  final String title;
  double getBadding(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth * 0.15;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(left: getBadding(context)),
      child: Container(
        height: 70,
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                letterSpacing: 1.2,
                fontSize: 18,
              ),
            ),
            const Spacer(),
            const CircleAvatar(
              radius: 18,
              backgroundColor: Color(kprimarycolor),
              child: Icon(Icons.person, color: Colors.white, size: 20),
            ),
          ],
        ),
      ),
    );
  }
}
