import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawfeer_market/constants.dart';
import 'package:tawfeer_market/cubits/admin_orders/admin_orders_cubit.dart';
import 'package:tawfeer_market/models/order_model.dart';
import 'package:tawfeer_market/pages/order_details_page.dart';
import 'package:tawfeer_market/widgets/custom_button.dart';

class SingleOrderCard extends StatelessWidget {
  final OrderModel order;

  const SingleOrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final String status = order.status;

    Color badgeBgColor;
    Color badgeTextColor;

    switch (status) {
      case 'Pending':
        badgeBgColor = const Color(0xFFFFF3E0);
        badgeTextColor = const Color(0xFFE65100);
        break;
      case 'Confirmed':
        badgeBgColor = const Color(0xFFE3F2FD);
        badgeTextColor = const Color(0xFF1E88E5);
        break;
      case 'Delivered':
        badgeBgColor = const Color(0xFFE8F5E9);
        badgeTextColor = const Color(0xFF43A047);
        break;
      case 'Cancelled':
        badgeBgColor = const Color(0xFFFFEBEE);
        badgeTextColor = const Color(0xFFE53935);
        break;
      default:
        badgeBgColor = const Color(0xFFF5F5F5);
        badgeTextColor = Colors.black54;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black.withOpacity(0.06), width: 0.8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order.orderId,
                    style: const TextStyle(
                      color: Color(0xFF212529),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    "${order.orderDate.day}/${order.orderDate.month}/${order.orderDate.year}",
                    style: const TextStyle(color: Colors.black38, fontSize: 12),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: badgeBgColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: badgeTextColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12.0),
            child: Divider(color: Color(0xFFF1F3F5), height: 1),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "${order.items.length} Items",
                  style: const TextStyle(color: Colors.black54, fontSize: 13),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                "${order.totalPrice} EGP",
                style: const TextStyle(
                  color: Color(kprimarycolor),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          _buildActionButtons(context, status),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, String status) {
    if (status == 'Cancelled') {
      return CustomButton(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrderDetailsPage(orderId: order.orderId),
            ),
          );
        },
        text: 'View',
        textColor: const Color(0xFF212529),
        filledColor: Colors.white,
        borderColor: Colors.black12,
        borderWidth: 1.0,
        borderRadius: 8,
        icon: Icons.visibility_outlined,
        fontWeight: FontWeight.w500,
        fontSize: 14,
      );
    }

    String secondaryButtonText = '';
    IconData secondaryButtonIcon = Icons.check;
    String nextStatus = '';

    Color secondaryFilledColor = const Color(kprimarycolor);
    Color secondaryTextColor = Colors.white;
    Color secondaryBorderColor = Colors.transparent;
    double secondaryBorderWidth = 0.0;

    if (status == 'Pending') {
      secondaryButtonText = 'Confirm';
      secondaryButtonIcon = Icons.check;
      nextStatus = 'Confirmed';
    } else if (status == 'Confirmed') {
      secondaryButtonText = 'Mark Delivered';
      secondaryButtonIcon = Icons.local_shipping_outlined;
      nextStatus = 'Delivered';
    } else if (status == 'Delivered') {
      secondaryButtonText = 'Refund';
      secondaryButtonIcon = Icons.keyboard_return_rounded;
      secondaryFilledColor = Colors.white;
      secondaryTextColor = const Color(0xFF212529);
      secondaryBorderColor = Colors.black12;
      secondaryBorderWidth = 1.0;
      nextStatus = 'Cancelled';
    }

    return Row(
      children: [
        Expanded(
          child: CustomButton(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderDetailsPage(orderId: order.orderId),
                ),
              );
            },
            text: 'View',
            textColor: const Color(0xFF212529),
            filledColor: Colors.white,
            borderColor: Colors.black12,
            borderWidth: 1.0,
            borderRadius: 8,
            icon: Icons.visibility_outlined,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        const SizedBox(width: 12),

        Expanded(
          child: CustomButton(
            onTap: () {
              context.read<AdminOrdersCubit>().updateOrderStatus(
                    orderId: order.orderId,
                    newStatus: nextStatus,
                    currentStatus: status,
                    totalPrice: order.totalPrice,
                  );
            },
            text: secondaryButtonText,
            textColor: secondaryTextColor,
            filledColor: secondaryFilledColor,
            borderColor: secondaryBorderColor,
            borderWidth: secondaryBorderWidth,
            borderRadius: 8,
            icon: secondaryButtonIcon,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}