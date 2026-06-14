import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawfeer_market/constants.dart';
import 'package:tawfeer_market/cubits/admin_orders/admin_orders_cubit.dart';
import 'package:tawfeer_market/widgets/custom_text_field.dart';
import 'package:tawfeer_market/widgets/orders_state_grid.dart';
import 'package:tawfeer_market/widgets/single_order_card.dart';

class AdminOrdersView extends StatefulWidget {
  const AdminOrdersView({super.key});

  @override
  State<AdminOrdersView> createState() => _AdminOrdersViewState();
}

class _AdminOrdersViewState extends State<AdminOrdersView> {
  String selectedStatus = 'All';

  final List<String> statuses = [
    'All',
    'Pending',
    'Confirmed',
    'Delivered',
    'Cancelled',
  ];

  // final List<Map<String, dynamic>> allOrders = [
  //   {
  //     'id': '#TF9EkIVr',
  //     'date': '2026-06-14 - 09:46',
  //     'status': 'Pending',
  //     'items': '1 Item · Almarai Skinned Milk',
  //     'price': '46.5 EGP',
  //   },
  //   {
  //     'id': '#TF7MnXpQ',
  //     'date': '2026-06-14 - 08:30',
  //     'status': 'Confirmed',
  //     'items': '3 Items · Nutella, Coffee...',
  //     'price': '312 EGP',
  //   },
  //   {
  //     'id': '#TF5XyZ21',
  //     'date': '2026-06-14 - 07:15',
  //     'status': 'Delivered',
  //     'items': '2 Items · Potato Chips, Cola',
  //     'price': '85 EGP',
  //   },
  //   {
  //     'id': '#TF5XyZ21',
  //     'date': '2026-06-14 - 07:15',
  //     'status': 'Cancelled',
  //     'items': '2 Items · Potato Chips, Cola',
  //     'price': '85 EGP',
  //   },
  // ];
  @override
  Widget build(BuildContext context) {
    // final filterdOrders = selectedStatus == 'All'
    //     ? allOrders
    //     : allOrders
    //           .where((order) => order['status'] == selectedStatus)
    //           .toList();
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OrdersStateGrid(),
          SearchBar(),
          SizedBox(
            height: 38,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: statuses.length,
              itemBuilder: (context, index) {
                final status = statuses[index];
                final isSelected = status == selectedStatus;
                return Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedStatus = status;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? Color(kprimarycolor) : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected
                              ? Colors.transparent
                              : Colors.black.withOpacity(0.08),
                          width: 0.8,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          status,
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : const Color(0xFF616161),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Recent Orders',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3436),
            ),
          ),
          const SizedBox(height: 16),
          BlocBuilder<AdminOrdersCubit, AdminOrdersState>(
            builder: (context, state) {
              if (state is AdminOrdersLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: Color(kprimarycolor)),
                );
              } else if (state is AdminOrdersSuccess) {
                final filteredOrders = selectedStatus == 'All'
                    ? state.orders
                    : state.orders
                          .where((order) => order.status == selectedStatus)
                          .toList();
                if (filteredOrders.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 40.0),
                      child: Text(
                        'No orders found in this section',
                        style: TextStyle(color: Colors.black38),
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filteredOrders.length,
                  itemBuilder: (context, index) {
                    return SingleOrderCard(order: filteredOrders[index]);
                  },
                );
              } else if (state is AdminOrdersFailure) {
                return Center(child: Text(state.error));
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      labelText: 'Search Orders...',
      prefixIcon: Icons.search_rounded,
      borderRadius: 20,
      horizontalPadding: false,
    );
  }
}
