import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/product.dart';
import '../../data/repositories/product_repository.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository repository;

  ProductCubit({required this.repository}) : super(const ProductState());

  Future<void> loadProducts() async {
    emit(state.copyWith(status: ProductStatus.loading, errorMessage: null));

    try {
      final products = await repository.fetchProducts();
      if (products.isEmpty) {
        emit(state.copyWith(
          status: ProductStatus.loaded,
          allProducts: [],
          filteredProducts: [],
        ));
      } else {
        final filtered = _applyFilters(products, state.searchQuery, state.selectedCategory);
        emit(state.copyWith(
          status: ProductStatus.loaded,
          allProducts: products,
          filteredProducts: filtered,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: ProductStatus.error,
        errorMessage: 'Failed to load products. Please check your connection and try again.',
      ));
    }
  }

  void searchProducts(String query) {
    final filtered = _applyFilters(state.allProducts, query, state.selectedCategory);
    emit(state.copyWith(
      searchQuery: query,
      filteredProducts: filtered,
    ));
  }

  void selectCategory(String category) {
    final filtered = _applyFilters(state.allProducts, state.searchQuery, category);
    emit(state.copyWith(
      selectedCategory: category,
      filteredProducts: filtered,
    ));
  }

  void toggleLayoutView() {
    emit(state.copyWith(isGridView: !state.isGridView));
  }

  List<Product> _applyFilters(List<Product> products, String query, String category) {
    return products.where((product) {
      final matchesQuery = query.isEmpty ||
          product.title.toLowerCase().contains(query.trim().toLowerCase());
      final matchesCategory = category == 'All' ||
          product.category.toLowerCase() == category.toLowerCase();
      return matchesQuery && matchesCategory;
    }).toList();
  }
}
