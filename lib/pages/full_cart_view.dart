import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawfeer_market/constants.dart';
import 'package:tawfeer_market/cubits/cart/cart_cubit.dart';
import 'package:tawfeer_market/pages/cart_item.dart';
import 'package:tawfeer_market/pages/empty_card_view.dart';
import 'package:tawfeer_market/widgets/confirm_order_sheet.dart';
import 'package:tawfeer_market/widgets/custom_button.dart';
import 'package:tawfeer_market/widgets/delete_from_cart_page.dart';

class FullCartView extends StatelessWidget {
  const FullCartView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        if (state is CartLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CartSuccess) {
          if (state.products.isEmpty) {
            return const EmptyCardView();
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: state.products.length,
                  itemBuilder: (context, index) {
                    return CartItem(product: state.products[index]);
                  },
                ),
              ),

              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.15),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Subtotal',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                        Text(
                          '${context.read<CartCubit>().totalCost} EGP',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${context.read<CartCubit>().totalCost} EGP',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(kprimarycolor),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    CustomButton(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.transparent,
                          builder: (context) => ConfirmOrderSheet(products: state.products),
                        );
                      },
                      text: 'Confirm Order',
                      textColor: Colors.white,
                      filledColor: const Color(kprimarycolor),
                      borderRadius: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
            ],
          );
        } else if (state is CartFailure) {
          return Center(child: Text(state.errorMessage));
        }
        return const SizedBox.shrink();
      },
    );
  }
}
