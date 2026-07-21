import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/favorites/favorites_cubit.dart';
import '../../logic/favorites/favorites_state.dart';
import '../../logic/product/product_cubit.dart';
import '../../logic/product/product_state.dart';
import '../../logic/theme/theme_cubit.dart';
import '../widgets/category_chips.dart';
import '../widgets/empty_state_view.dart';
import '../widgets/error_view.dart';
import '../widgets/loading_shimmer.dart';
import '../widgets/product_card.dart';
import '../widgets/product_list_tile.dart';
import '../widgets/search_bar_widget.dart';
import 'favorites_screen.dart';
import 'product_detail_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductCubit>().loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: const Color(0xFF635BFF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.storefront_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 10),
            const Text('Catalog'),
          ],
        ),
        actions: [
          // Light/Dark Theme Toggle
          BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, themeMode) {
              final isDarkMode = themeMode == ThemeMode.dark;
              return IconButton(
                tooltip: isDarkMode ? 'Switch to Light Mode' : 'Switch to Dark Mode',
                icon: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Icon(
                    isDarkMode ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                    key: ValueKey<bool>(isDarkMode),
                    color: isDarkMode ? const Color(0xFFFFB800) : const Color(0xFF635BFF),
                  ),
                ),
                onPressed: () {
                  context.read<ThemeCubit>().toggleTheme();
                },
              );
            },
          ),
          // Layout Toggle (Grid / List)
          BlocBuilder<ProductCubit, ProductState>(
            builder: (context, productState) {
              return IconButton(
                tooltip: productState.isGridView ? 'Switch to List View' : 'Switch to Grid View',
                icon: Icon(
                  productState.isGridView ? Icons.view_list_rounded : Icons.grid_view_rounded,
                ),
                onPressed: () {
                  context.read<ProductCubit>().toggleLayoutView();
                },
              );
            },
          ),
          // Favorites Button with Badge
          BlocBuilder<FavoritesCubit, FavoritesState>(
            builder: (context, favState) {
              final favCount = favState.favoriteIds.length;
              return Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    tooltip: 'View Favorites',
                    icon: const Icon(Icons.favorite_rounded, color: Color(0xFFFF4757)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const FavoritesScreen(),
                        ),
                      );
                    },
                  ),
                  if (favCount > 0)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Color(0xFF635BFF),
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          '$favCount',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          return Column(
            children: [
              // Search Bar
              SearchBarWidget(
                query: state.searchQuery,
                onChanged: (query) {
                  context.read<ProductCubit>().searchProducts(query);
                },
              ),

              // Category Selector Chips
              if (state.status == ProductStatus.loaded)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: CategoryChips(
                    categories: state.categories,
                    selectedCategory: state.selectedCategory,
                    onSelected: (category) {
                      context.read<ProductCubit>().selectCategory(category);
                    },
                  ),
                ),

              // Content Body based on state status
              Expanded(
                child: _buildBody(context, state, isDark),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, ProductState state, bool isDark) {
    if (state.status == ProductStatus.loading) {
      return LoadingShimmer(isGridView: state.isGridView);
    }

    if (state.status == ProductStatus.error) {
      return ErrorView(
        message: state.errorMessage ?? 'An error occurred while loading products.',
        onRetry: () {
          context.read<ProductCubit>().loadProducts();
        },
      );
    }

    if (state.filteredProducts.isEmpty) {
      final isSearching = state.searchQuery.isNotEmpty;
      return EmptyStateView(
        title: isSearching ? 'No Matching Products' : 'No Products Found',
        message: isSearching
            ? 'We couldn\'t find any products matching "${state.searchQuery}". Try a different keyword or clear search.'
            : 'There are no products available in this category.',
        onAction: isSearching
            ? () {
                context.read<ProductCubit>().searchProducts('');
              }
            : null,
        actionLabel: isSearching ? 'Clear Search' : null,
      );
    }

    return RefreshIndicator(
      color: const Color(0xFF635BFF),
      onRefresh: () async {
        await context.read<ProductCubit>().loadProducts();
      },
      child: BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, favState) {
          if (state.isGridView) {
            return GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.72,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: state.filteredProducts.length,
              itemBuilder: (context, index) {
                final product = state.filteredProducts[index];
                final isFav = favState.isFavorite(product.id);

                return ProductCard(
                  product: product,
                  isFavorite: isFav,
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
              itemCount: state.filteredProducts.length,
              itemBuilder: (context, index) {
                final product = state.filteredProducts[index];
                final isFav = favState.isFavorite(product.id);

                return ProductListTile(
                  product: product,
                  isFavorite: isFav,
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
      ),
    );
  }
}
