import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../data/models/product.dart';
import '../../logic/favorites/favorites_cubit.dart';
import '../../logic/favorites/favorites_state.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        actions: [
          BlocBuilder<FavoritesCubit, FavoritesState>(
            builder: (context, favState) {
              final isFav = favState.isFavorite(product.id);
              return IconButton(
                icon: Icon(
                  isFav ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                  color: isFav ? const Color(0xFFFF4757) : (isDark ? Colors.white : Colors.black),
                ),
                onPressed: () {
                  context.read<FavoritesCubit>().toggleFavorite(product.id);
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Container with Hero animation
            Container(
              width: double.infinity,
              height: 300,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF0F172A) : Colors.white,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
                boxShadow: [
                  BoxShadow(
                    color: isDark ? Colors.black.withAlpha(60) : Colors.black.withAlpha(15),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Hero(
                tag: 'product-image-${product.id}',
                child: CachedNetworkImage(
                  imageUrl: product.image,
                  fit: BoxFit.contain,
                  errorWidget: (context, url, error) => const Icon(
                    Icons.image_not_supported_rounded,
                    size: 60,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Details Section
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category & Rating Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF635BFF).withAlpha(30),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          product.category.toUpperCase(),
                          style: TextStyle(
                            color: isDark ? const Color(0xFF7A73FF) : const Color(0xFF635BFF),
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      // Rating Pill
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFB800).withAlpha(30),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.star_rounded, size: 18, color: Color(0xFFFFB800)),
                            const SizedBox(width: 4),
                            Text(
                              '${product.rating.rate}',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                            Text(
                              ' (${product.rating.count} reviews)',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontSize: 11,
                                color: isDark ? const Color(0xFF94A3B8) : Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Title
                  Text(
                    product.title,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontSize: 20,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Price
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: isDark ? const Color(0xFF00E5C3) : const Color(0xFF635BFF),
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 16),
                  // Description Label
                  Text(
                    'Description',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Description Body
                  Text(
                    product.description,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      height: 1.6,
                      color: isDark ? const Color(0xFFCBD5E1) : const Color(0xFF475569),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E293B) : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(20),
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              // Favourite toggle button
              BlocBuilder<FavoritesCubit, FavoritesState>(
                builder: (context, favState) {
                  final isFav = favState.isFavorite(product.id);
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isFav ? const Color(0xFFFF4757) : Colors.grey.shade400,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: IconButton(
                      icon: Icon(
                        isFav ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                        color: isFav ? const Color(0xFFFF4757) : Colors.grey,
                      ),
                      onPressed: () {
                        context.read<FavoritesCubit>().toggleFavorite(product.id);
                      },
                    ),
                  );
                },
              ),
              const SizedBox(width: 12),
              // Add to Cart Button
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${product.title} added to cart!'),
                        backgroundColor: const Color(0xFF635BFF),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                  icon: const Icon(Icons.shopping_bag_outlined),
                  label: const Text(
                    'Add to Cart',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF635BFF),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 3,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
