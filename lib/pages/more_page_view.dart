import 'package:flutter/material.dart';
import 'package:tawfeer_market/widgets/more_item.dart';

class MorePageView extends StatelessWidget {
  const MorePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                    title: 'My Orders',
                    onTap: () {},
                  ),
                  const Divider(color: Colors.grey, height: 1, thickness: 0.3),

                  MoreItem(
                    icon: Icons.shopping_cart_outlined,
                    title: 'My Cart',
                    onTap: () {},
                  ),
                  const Divider(color: Colors.grey, height: 1, thickness: 0.3),

                  MoreItem(
                    icon: Icons.favorite_border_rounded,
                    title: 'My Favorites',
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20,),
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
                    title: 'Edit Profile',
                    onTap: () {},
                  ),
                  const Divider(color: Colors.grey, height: 1, thickness: 0.3),

                  MoreItem(
                    icon: Icons.language_outlined,
                    title: 'Language',
                    onTap: () {},
                  ),
                  const Divider(color: Colors.grey, height: 1, thickness: 0.3),

                  MoreItem(
                    icon: Icons.logout,
                    title: 'Logout',
                    isLogout: true,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
