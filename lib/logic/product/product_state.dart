import 'package:equatable/equatable.dart';
import '../../data/models/product.dart';

enum ProductStatus { initial, loading, loaded, error }

class ProductState extends Equatable {
  final ProductStatus status;
  final List<Product> allProducts;
  final List<Product> filteredProducts;
  final String searchQuery;
  final String selectedCategory;
  final String? errorMessage;
  final bool isGridView;

  const ProductState({
    this.status = ProductStatus.initial,
    this.allProducts = const [],
    this.filteredProducts = const [],
    this.searchQuery = '',
    this.selectedCategory = 'All',
    this.errorMessage,
    this.isGridView = true,
  });

  List<String> get categories {
    final set = {'All'};
    for (final p in allProducts) {
      if (p.category.isNotEmpty) {
        set.add(p.category);
      }
    }
    return set.toList();
  }

  ProductState copyWith({
    ProductStatus? status,
    List<Product>? allProducts,
    List<Product>? filteredProducts,
    String? searchQuery,
    String? selectedCategory,
    String? errorMessage,
    bool? isGridView,
  }) {
    return ProductState(
      status: status ?? this.status,
      allProducts: allProducts ?? this.allProducts,
      filteredProducts: filteredProducts ?? this.filteredProducts,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      errorMessage: errorMessage ?? this.errorMessage,
      isGridView: isGridView ?? this.isGridView,
    );
  }

  @override
  List<Object?> get props => [
        status,
        allProducts,
        filteredProducts,
        searchQuery,
        selectedCategory,
        errorMessage,
        isGridView,
      ];
}
