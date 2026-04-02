import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawfeer_market/constants.dart';
import 'package:tawfeer_market/cubits/bottom_nav_cubit/bottom_nav_cubit.dart';
import 'package:tawfeer_market/widgets/custom_button.dart';

class EmptyCardView extends StatelessWidget {
  const EmptyCardView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/Cartphoto.jpeg'),
          Text('Your cart is empty'),
          SizedBox(height: 10,),
          CustomButton(
            width: 200,
            borderRadius: 30,
            borderWidth: 1.2,
            fontWeight: FontWeight.normal,
            icon: Icons.shopping_cart,
            onTap: () {
              BlocProvider.of<BottomNavCubit>(context).changeIndex(0);
            },
            text: 'Start Shopping',
            textColor: const Color(kprimarycolor),
            filledColor: Colors.white,
          ),
        ],
    );
  }
}
