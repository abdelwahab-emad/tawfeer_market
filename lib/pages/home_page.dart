import 'package:flutter/material.dart';
import 'package:tawfeer_market/widgets/home_app_bar.dart';
import 'package:tawfeer_market/widgets/offers_slider.dart';

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
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(130),
        child: HomeAppBar(),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 30),
          OffersSlider(),
        ],
      ),
    );
  }
}
