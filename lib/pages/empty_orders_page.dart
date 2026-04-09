import 'package:flutter/material.dart';
import 'package:tawfeer_market/l10n/app_localizations.dart';

class EmptyOrdersPage extends StatelessWidget {
  const EmptyOrdersPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;

    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/noOrders.png'),
          Text(
            locale.noOrdersFound,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}