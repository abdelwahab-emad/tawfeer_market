import 'package:flutter/material.dart';
import 'package:tawfeer_market/constants.dart';
import 'package:tawfeer_market/pages/login_page.dart';
import 'package:tawfeer_market/widgets/custom_button.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  static const String id = 'splash_page';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Tawfeer ',
                  style: TextStyle(
                    fontSize: 26,
                    color: Color(kprimarycolor),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Market',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Spacer(flex: 1),
            Image.asset(
              'assets/splashphoto.png',
            ),
            const Spacer(flex: 2),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      onTap: () {
                        Navigator.pushNamed(context, LoginPage.id);
                      },
                      text: 'English',
                      textColor: Color(0xFF001D3D),
                      filledColor: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 14,),
                  Expanded(
                    child: CustomButton(
                      onTap: () {
                        Navigator.pushNamed(context, LoginPage.id);
                      },
                      text: 'العربيه',
                      textColor: Color(0xFF001D3D),
                      filledColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
