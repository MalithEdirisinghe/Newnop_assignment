import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/favorites/favorites_cubit.dart';
import '../../logic/favorites/favorites_state.dart';
import '../../logic/product/product_cubit.dart';
import '../../logic/product/product_state.dart';
import '../widgets/empty_state_view.dart';
import '../widgets/product_card.dart';
import '../widgets/product_list_tile.dart';
import 'product_detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Favorites'),
      ),
      body: BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, favState) {
          return BlocBuilder<ProductCubit, ProductState>(
            builder: (context, productState) {
              final favoriteProducts = productState.allProducts
                  .where((p) => favState.isFavorite(p.id))
                  .toList();

              if (favoriteProducts.isEmpty) {
                return const EmptyStateView(
                  title: 'No Favorites Yet',
                  message: 'Tap the heart icon on any product to save it to your favorites list.',
                  icon: Icons.favorite_border_rounded,
                );
              }

              if (productState.isGridView) {
                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.72,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: favoriteProducts.length,
                  itemBuilder: (context, index) {
                    final product = favoriteProducts[index];
                    return ProductCard(
                      product: product,
                      isFavorite: true,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProductDetailScreen(product: product),
                          ),
                        );
                      },
                      onFavoriteToggle: () {
                        context.read<FavoritesCubit>().toggleFavorite(product.id);
                      },
                    );
                  },
                );
              } else {
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: favoriteProducts.length,
                  itemBuilder: (context, index) {
                    final product = favoriteProducts[index];
                    return ProductListTile(
                      product: product,
                      isFavorite: true,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProductDetailScreen(product: product),
                          ),
                        );
                      },
                      onFavoriteToggle: () {
                        context.read<FavoritesCubit>().toggleFavorite(product.id);
                      },
                    );
                  },
                );
              }
            },
          );
        },
      ),
    );
  }
}
