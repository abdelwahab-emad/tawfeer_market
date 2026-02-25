import 'package:flutter/material.dart';
import 'package:tawfeer_market/constants.dart';
import 'package:tawfeer_market/pages/login_page.dart';
import 'package:tawfeer_market/widgets/custom_button.dart';
import 'package:tawfeer_market/widgets/custom_text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  static String id = 'Register_page';
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 130,),
            Row(
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
                Text(
                  'Market',
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 50,),
            CustomTextField(
              prefixIcon: Icons.person_outline,
              labelText: 'First Name',
            ),
            const SizedBox(height: 10),
            CustomTextField(
              prefixIcon: Icons.person_outline,
              labelText: 'Last Name',
            ),
            const SizedBox(height: 10),
            CustomTextField(
              prefixIcon: Icons.email_outlined,
              labelText: 'Email Address',
            ),
            const SizedBox(height: 10),
           CustomTextField(
              prefixIcon: Icons.lock_outline,
              suffixIcon: Icons.visibility_outlined,
              obscureText: true,
              labelText: 'Password',
            ),
             const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: CustomButton(
                onTap: () {},
                text: 'Sign Up',
                textColor: Colors.white,
                filledColor: Color(kprimarycolor),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              "Already have an Account?",
              style: TextStyle(color: Colors.grey[800], fontSize: 16),
            ),
            const SizedBox(height: 15),

            GestureDetector(
              onTap: () => Navigator.pop(context),

              child: Text(
                "Sign in",
                style: TextStyle(
                  color: Color(kprimarycolor),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}