import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tawfeer_market/pages/language_selection_page.dart';
import 'package:tawfeer_market/pages/user_main_layout_page.dart';

class SplashPage extends StatefulWidget {
  static const String id = 'splash_page';
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _goNext();
  }

  Future<void> _goNext() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    Navigator.pushReplacementNamed(context, LanguageSelectionPage.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF97316),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
              ),
              child: const Icon(
                Icons.shopping_cart_rounded,
                size: 60,
                color: Color(0xFFF97316),
              ),
            ),
          ),

          const SizedBox(height: 30),

          const Text(
            'توفير ماركت',
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'TAWFEER MARKET',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white70,
              letterSpacing: 3,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'أفضل العروض · Best deals every day',
            style: TextStyle(fontSize: 13, color: Colors.white54),
          ),
          const SizedBox(height: 60),
          const SizedBox(
            width: 160,
            child: LinearProgressIndicator(
              backgroundColor: Colors.white24,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              minHeight: 3,
            ),
          ),
        ],
      ),
    );
  }
}
