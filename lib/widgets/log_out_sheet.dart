import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tawfeer_market/l10n/app_localizations.dart';
import 'package:tawfeer_market/pages/login_page.dart';
import 'package:tawfeer_market/widgets/custom_confirmation_sheet.dart';

class LogOutSheet extends StatelessWidget {
  const LogOutSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;

    return CustomConfirmationSheet(
      message: locale.logoutConfirmation,
      messageColor: Colors.black,
      leftButtonText: locale.cancel,
      rightButtonText: locale.confirm,
      onLeftTap: () => Navigator.pop(context),
      onRightTap: () async {
        await FirebaseAuth.instance.signOut();

        if (context.mounted) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            LoginPage.id,
            (route) => false,
          );
        }
      },
    );
  }
}