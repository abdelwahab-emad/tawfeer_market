import 'package:flutter/material.dart';
import 'package:tawfeer_market/pages/bulk_view.dart';
import 'package:tawfeer_market/pages/categories_view.dart';
import 'package:tawfeer_market/pages/daily_needs_view.dart';
import 'package:tawfeer_market/pages/top_selling_page.dart';
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
      body: ListView(
        children: [
          HomeAppBar(),
          const SizedBox(height: 30),
          CategoriesView(),
          const SizedBox(height: 30),
          DailyNeedsView(),
          const SizedBox(height: 30),
          TopSellingPage(),
          const SizedBox(height: 30,),
          BulkView(),
        ],
      ),
    );
  }
}
