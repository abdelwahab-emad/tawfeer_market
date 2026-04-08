import 'package:flutter/material.dart';
import 'package:tawfeer_market/l10n/app_localizations.dart';

class EmptyFavoritesPage extends StatelessWidget {
  const EmptyFavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;

    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/favouritePhoto.jpeg'),
          const SizedBox(height: 10),
          Text(
            locale.noFavorites,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}