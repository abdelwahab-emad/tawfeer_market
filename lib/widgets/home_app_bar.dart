import 'package:flutter/material.dart';
import 'package:tawfeer_market/pages/search_products_page.dart';
import 'package:tawfeer_market/widgets/custom_button.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      toolbarHeight: 90, 
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      flexibleSpace: Container(
        decoration:  BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xFFFF9800), Color(0xFFFF5722)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            child: CustomButton(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchProductPage()));
              },
              text: 'Search in Tawfeer Market',
              textColor: const Color(0xFF6A6A6A), 
              filledColor: Colors.white,
              borderColor: Colors.transparent,
              borderWidth: 0.0,
              borderRadius: 30, 
              icon: Icons.search_rounded,
              alignment: MainAxisAlignment.start,
              horizontalPadding: 20.0,
              iconSize: 26.0,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}