import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawfeer_market/constants.dart';
import 'package:tawfeer_market/cubits/language/language_cubit.dart';
import 'package:tawfeer_market/pages/login_page.dart';
import 'package:tawfeer_market/widgets/custom_button.dart';

class LanguageSelectionPage extends StatelessWidget {
  const LanguageSelectionPage({super.key});

  static const String id = 'Language_selection_page';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            SizedBox(height: 16),
             Directionality(
                  textDirection: TextDirection.ltr,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Tawfeer ',
                        style: TextStyle(
                          fontSize: 36,
                          color: Color(kprimarycolor),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'Market',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
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
                        context.read<LanguageCubit>().changeLanguage('en');
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
                        context.read<LanguageCubit>().changeLanguage('ar');
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