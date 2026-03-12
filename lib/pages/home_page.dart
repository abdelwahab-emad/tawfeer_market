import 'package:flutter/material.dart';
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
        preferredSize: const Size.fromHeight(130),
        child: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xFFFF9800), Color(0xFFFF5722)],
              ),
            ),
            child: SafeArea(
              child: Center(
                child: CustomTextField(
                  labelText: 'Search in Tawfeer Market',
                  prefixIcon: Icons.search,
                  prefixIconSize: 28, 
                  borderRadius: 40, 
                  readOnly: true, 
                ),
              ),
            ),
          ),
        ),
      ),
      body: const Center(child: Text("Home Content Starts Here")),
    );
  }
}
