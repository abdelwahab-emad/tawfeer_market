import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawfeer_market/cubits/favorite/favorite_cubit.dart';
import 'package:tawfeer_market/pages/empty_favorites_page.dart';
import 'package:tawfeer_market/pages/favorites_item.dart';

class FullFavoritesView extends StatelessWidget {
  const FullFavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, state) {
        if (state is FavoriteLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is FavoriteSuccess) {
          if (state.products.isEmpty) {
            return const EmptyFavoritesPage();
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: state.products.length,
            itemBuilder: (context, index) {
              return FavoritesItem(product: state.products[index]);
            },
          );
        } else if (state is FavoriteFailure) {
          return Center(child: Text(state.errorMessage));
        }
        return const SizedBox.shrink();
      },
    );
  }
}
