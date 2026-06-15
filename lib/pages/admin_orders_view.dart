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
  String searchQuery = '';

  final List<String> statuses = [
    'All',
    'Pending',
    'Confirmed',
    'Delivered',
    'Cancelled',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminOrdersCubit, AdminOrdersState>(
      builder: (context, state) {
        if (state is AdminOrdersLoading) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(40.0),
              child: CircularProgressIndicator(color: Color(kprimarycolor)),
            ),
          );
        } 
        else if (state is AdminOrdersFailure) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                state.error,
                style: const TextStyle(color: Colors.red, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          );
        } 
        else if (state is AdminOrdersSuccess) {
          final filteredOrders = state.orders.where((order){
            final matchesStatus = selectedStatus == 'All' || 
                order.status.toLowerCase() == selectedStatus.toLowerCase();

            final orderDateStr = "${order.orderDate.day}/${order.orderDate.month}/${order.orderDate.year}";

            final query = searchQuery.toLowerCase();

            final matchesSearch = order.orderId.toLowerCase().contains(query) || orderDateStr.contains(query);

            return matchesStatus && matchesSearch;
          }).toList();

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OrdersStateGrid(
                  total: state.totalCount,
                  pending: state.pendingCount,
                  delivered: state.deliveredCount,
                  cancelled: state.cancelledCount,
                ),
                const SizedBox(height: 20),
                SearchBar(
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                ),
                const SizedBox(height: 14),
                SizedBox(
                  height: 42,
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
                                  color: isSelected ? Colors.white : const Color(0xFF616161),
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
                filteredOrders.isEmpty
                    ? const Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 40.0),
                          child: Text(
                            'No orders found in this section',
                            style: TextStyle(color: Colors.black38, fontSize: 14),
                          ),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: filteredOrders.length,
                        itemBuilder: (context, index) {
                          return SingleOrderCard(order: filteredOrders[index]);
                        },
                      ),
              ],
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({super.key, required this.onChanged});
  final ValueChanged<String> onChanged;
  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      labelText: 'Search Orders...',
      prefixIcon: Icons.search_rounded,
      borderRadius: 20,
      horizontalPadding: false,
      onChanged: onChanged,
    );
  }
}