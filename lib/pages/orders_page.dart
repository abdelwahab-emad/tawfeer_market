import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tawfeer_market/constants.dart';
import 'package:tawfeer_market/cubits/orders/orders_cubit.dart';
import 'package:tawfeer_market/cubits/orders/orders_state.dart';
import 'package:tawfeer_market/l10n/app_localizations.dart';
import 'package:tawfeer_market/pages/order_details_page.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});
  static String id = 'orders_page';
  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  void initState() {
    super.initState();
    context.read<OrdersCubit>().fetchUserOrders();
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          locale.myOrders,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: BlocBuilder<OrdersCubit, OrdersState>(
        builder: (context, state) {
          if (state is OrdersLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Color(kprimarycolor)),
            );
          } else if (state is OrdersSuccess) {
            if (state.orders.isEmpty) {
              return Center(child: Text(locale.noOrdersFound));
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.orders.length,
              itemBuilder: (context, index) {
                final order = state.orders[index];

                String formattedDate = DateFormat(
                  'yyyy-MM-dd – kk:mm',
                ).format(order.orderDate);

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            OrderDetailsPage(orderId: order.orderId),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${locale.orderId}: #${order.orderId.substring(0, 8)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${locale.total}: ${order.totalPrice} ${locale.currency}',
                                style: const TextStyle(
                                  color: Color(kprimarycolor),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${locale.date}: $formattedDate',
                                style: const TextStyle(
                                  color: Color(kprimarycolor),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(kprimarycolor).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            order.status == 'pending'
                                ? locale.pending
                                : order.status,
                            style: const TextStyle(
                              color: Color(kprimarycolor),
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is OrdersFailure) {
            return Center(child: Text(state.errorMessage));
          }
          return const SizedBox();
        },
      ),
    );
  }
}
