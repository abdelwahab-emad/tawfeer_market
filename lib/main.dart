import 'package:flutter/material.dart';
import 'package:tawfeer_market/pages/login_page.dart';
import 'package:tawfeer_market/pages/register_page.dart';
import 'package:tawfeer_market/pages/splash_page.dart';

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
        SplashPage.id : (context) => SplashPage(),
        LoginPage.id : (context) => LoginPage(),
        RegisterPage.id : (context) => RegisterPage(),
      },
      initialRoute: SplashPage.id,
    );
  }
}