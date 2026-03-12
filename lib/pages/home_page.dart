import 'package:flutter/material.dart';
import 'package:tawfeer_market/constants.dart';
import 'package:tawfeer_market/widgets/custom_text_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static String id = 'home_page';
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(kprimarycolor),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(60),
              bottomRight: Radius.circular(60),
            ),
          ),
          flexibleSpace: Center(
            child: CustomTextField(
              labelText: 'Search in Tawfeer Market',
              prefixIcon: Icons.search,
              borderRadius: 30,
              readOnly: true,
            ),
          ),
        ),
      ),
    );
  }
}
