import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawfeer_market/constants.dart';
import 'package:tawfeer_market/cubits/favorite/favorite_cubit.dart';
import 'package:tawfeer_market/models/product_model.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({super.key, required this.product});

  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, state) {
        bool isFavorite = false;

        if (state is FavoriteSuccess) {
          isFavorite = state.products.any(
            (element) => element.id == product.id,
          );
        }

        return GestureDetector(
          onTap: () {
            if (isFavorite) {
              context.read<FavoriteCubit>().deleteFromFavorites(
                productId: product.id,
              );
            } else {
              context.read<FavoriteCubit>().addProductToFavorite(
                product: product,
              );
            }
          },
          child: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: const Color(kprimarycolor),
          ),
        );
      },
    );
  }
}
