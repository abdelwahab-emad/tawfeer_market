import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawfeer_market/cubits/bottom_nav_cubit/bottom_nav_cubit.dart';
import 'package:tawfeer_market/cubits/bottom_nav_cubit/bottom_nav_states.dart';
import 'package:tawfeer_market/l10n/app_localizations.dart';
import 'package:tawfeer_market/pages/home_page.dart';
import 'package:tawfeer_market/pages/cart_page.dart';
import 'package:tawfeer_market/pages/Favorites_page.dart';
import 'package:tawfeer_market/pages/more_page.dart';
import 'package:tawfeer_market/widgets/custom_nav_item.dart';

class UserMainLayout extends StatelessWidget {
  static const String id = 'user_main_layout';
  const UserMainLayout({super.key});

  final List<Widget> _pages = const [
    HomePage(),
    CartPage(),
    FavoritesPage(),
    MorePage(),
  ];

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;

    return BlocBuilder<BottomNavCubit, BottomNavState>(
      builder: (context, state) {
        int currentIndex = BlocProvider.of<BottomNavCubit>(context).currentIndex;
        return Scaffold(
          body: _pages[currentIndex],
          bottomNavigationBar: Container(
            height: 70,
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomNavItem(
                  index: 0,
                  icon: Icons.home,
                  label: locale.navHome,
                  currentIndex: currentIndex,
                ),
                CustomNavItem(
                  index: 1,
                  icon: Icons.shopping_cart,
                  label: locale.navCart,
                  currentIndex: currentIndex,
                ),
                CustomNavItem(
                  index: 2,
                  icon: Icons.favorite,
                  label: locale.navFavorites,
                  currentIndex: currentIndex,
                ),
                CustomNavItem(
                  index: 3,
                  icon: Icons.person,
                  label: locale.navMore,
                  currentIndex: currentIndex,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}