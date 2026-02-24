import 'package:flutter/material.dart';
import 'package:tawfeer_market/splash_page.dart';

void main() {
  runApp(const TawfeerMarket());
}

class TawfeerMarket extends StatelessWidget {
  const TawfeerMarket({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        SplashPage.id: (context) => SplashPage(),
      },
      initialRoute: SplashPage.id,
    );
  }
}