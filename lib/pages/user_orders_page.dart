import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawfeer_market/cubits/admin_orders/admin_orders_cubit.dart';
import 'package:tawfeer_market/widgets/single_order_card.dart';

class UserOrdersPage extends StatefulWidget {
  final String userId;

  const UserOrdersPage({super.key, required this.userId});

  @override
  State<UserOrdersPage> createState() => _UserOrdersPageState();
}

class _UserOrdersPageState extends State<UserOrdersPage> {
  @override
  void initState() {
    super.initState();
    context.read<AdminOrdersCubit>().getOrders(userId: widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("User Orders",), backgroundColor: Colors.white,),
      body: BlocBuilder<AdminOrdersCubit, AdminOrdersState>(
        builder: (context, state) {
          if (state is AdminOrdersLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is AdminOrdersSuccess) {
            if (state.orders.isEmpty) {
              return const Center(child: Text("No orders found"));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.orders.length,
              itemBuilder: (context, index) {
                return SingleOrderCard(order: state.orders[index]);
              },
            );
          }

          if (state is AdminOrdersFailure) {
            return Center(child: Text(state.error));
          }

          return const SizedBox();
        },
      ),
    );
  }
}
