import 'package:flutter/material.dart';
import 'package:tawfeer_market/constants.dart';
import 'recent_order_item.dart';

class RecentOrdersList extends StatelessWidget {
  const RecentOrdersList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Recent Orders",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D3436),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'See All',
                style: const TextStyle(
                  color: Color(kprimarycolor),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  decoration: TextDecoration.underline,
                  decorationColor: Color(kprimarycolor),
                  decorationThickness: 2,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 4,
          itemBuilder: (context, index) {
            return RecentOrderItem();
          },
        ),
      ],
    );
  }
}
