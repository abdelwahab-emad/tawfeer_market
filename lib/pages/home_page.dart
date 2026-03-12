import 'package:flutter/material.dart';
import 'package:tawfeer_market/widgets/home_app_bar.dart';

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
        child: HomeAppBar(),
      ),
      body: const Center(child: Text("Home Content Starts Here")),
    );
  }
}
