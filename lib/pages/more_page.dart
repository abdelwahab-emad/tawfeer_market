import 'package:flutter/material.dart';
import 'package:tawfeer_market/pages/more_page_view.dart';
import 'package:tawfeer_market/widgets/more_app_bar.dart';

class MorePage extends StatefulWidget {
  const MorePage({super.key});

  static String id = 'More_page';
  @override
  State<MorePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<MorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: MoreAppBar(),
      ),
      body: const MorePageView(),
    );
  }
}