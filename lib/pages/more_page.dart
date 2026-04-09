import 'package:flutter/material.dart';
import 'package:tawfeer_market/l10n/app_localizations.dart';
import 'package:tawfeer_market/pages/edit_profile_page.dart';
import 'package:tawfeer_market/pages/orders_page.dart';
import 'package:tawfeer_market/widgets/language_sheet.dart';
import 'package:tawfeer_market/widgets/log_out_sheet.dart';
import 'package:tawfeer_market/widgets/more_app_bar.dart';
import 'package:tawfeer_market/widgets/more_item.dart';

class MorePage extends StatefulWidget {
  const MorePage({super.key});

  static String id = 'More_page';
  @override
  State<MorePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<MorePage> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: MoreAppBar(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.shade200, width: 1),
                ),
                child: Column(
                  children: [
                    MoreItem(
                      icon: Icons.shopping_bag_outlined,
                      title: locale.myOrders,
                      onTap: () {
                         Navigator.pushNamed(context, OrdersPage.id);
                      },
                    ),
                    const Divider(
                      color: Colors.grey,
                      height: 1,
                      thickness: 0.3,
                    ),
                    MoreItem(
                      icon: Icons.person_outline,
                      title: locale.editProfile,
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfilePage()));
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.shade200, width: 1),
                ),
                child: Column(
                  children: [
                    MoreItem(
                      icon: Icons.language_outlined,
                      title: locale.language,
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.white,
                          builder: (context) => const LanguageSheet(),
                        );
                      },
                    ),
                    const Divider(
                      color: Colors.grey,
                      height: 1,
                      thickness: 0.3,
                    ),
                    MoreItem(
                      icon: Icons.logout,
                      title: locale.logout,
                      isLogout: true,
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.transparent,
                          builder: (context) => const LogOutSheet(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
