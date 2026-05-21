import 'package:flutter/material.dart';
import 'package:tawfeer_market/l10n/app_localizations.dart';
import 'package:tawfeer_market/pages/edit_profile_page.dart';
import 'package:tawfeer_market/widgets/custom_admin_app_bar.dart';
import 'package:tawfeer_market/widgets/language_sheet.dart';
import 'package:tawfeer_market/widgets/log_out_sheet.dart';
import 'package:tawfeer_market/widgets/more_item.dart';

class AdminSettingsPage extends StatefulWidget {
  const AdminSettingsPage({super.key});

  static String id = 'AdminSettings_page';
  @override
  State<AdminSettingsPage> createState() => _AdminSettingsPageState();
}

class _AdminSettingsPageState extends State<AdminSettingsPage> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: CustomAdminAppBar(
          title: 'Settings',
          actionIcon: IconButton(
            icon: const Icon(Icons.filter_list_rounded, color: Colors.black),
            onPressed: () {},
          ),
        ),
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

