import 'package:flutter_test/flutter_test.dart';
import 'package:product_catalog/data/models/product.dart';
import 'package:product_catalog/data/models/rating.dart';
import 'package:product_catalog/data/repositories/product_repository.dart';
import 'package:product_catalog/logic/product/product_cubit.dart';
import 'package:product_catalog/logic/product/product_state.dart';

class MockProductRepository extends ProductRepository {
  final List<Product> mockProducts;
  final bool shouldThrow;

  MockProductRepository({required this.mockProducts, this.shouldThrow = false});

  @override
  Future<List<Product>> fetchProducts() async {
    if (shouldThrow) {
      throw Exception('Network error');
    }
    return mockProducts;
  }
}

void main() {
  group('ProductCubit Tests', () {
    const p1 = Product(
      id: 1,
      title: 'Fjallraven Backpack',
      price: 109.95,
      description: 'Backpack desc',
      category: "men's clothing",
      image: '',
      rating: Rating(rate: 4.0, count: 50),
    );
    const p2 = Product(
      id: 2,
      title: 'Casual Slim Shirt',
      price: 22.30,
      description: 'Shirt desc',
      category: "men's clothing",
      image: '',
      rating: Rating(rate: 4.2, count: 60),
    );
    const p3 = Product(
      id: 3,
      title: 'Gold Dragon Bracelet',
      price: 695.0,
      description: 'Jewelry desc',
      category: 'jewelery',
      image: '',
      rating: Rating(rate: 4.8, count: 90),
    );

    late ProductCubit productCubit;
    late MockProductRepository mockRepository;

    setUp(() {
      mockRepository = MockProductRepository(mockProducts: [p1, p2, p3]);
      productCubit = ProductCubit(repository: mockRepository);
    });

    tearDown(() {
      productCubit.close();
    });

    test('initial state should be ProductState() with status initial', () {
      expect(productCubit.state.status, equals(ProductStatus.initial));
    });

    test('loadProducts emits [loading, loaded] with fetched products', () async {
      final expectedStates = [
        const ProductState(status: ProductStatus.loading),
        ProductState(
          status: ProductStatus.loaded,
          allProducts: [p1, p2, p3],
          filteredProducts: [p1, p2, p3],
        ),
      ];

      expectLater(productCubit.stream, emitsInOrder(expectedStates));

      await productCubit.loadProducts();
    });

    test('searchProducts filters products by substring title match', () async {
      await productCubit.loadProducts();

      productCubit.searchProducts('Backpack');

      expect(productCubit.state.filteredProducts.length, equals(1));
      expect(productCubit.state.filteredProducts.first.title, contains('Backpack'));
    });

    test('selectCategory filters products by category', () async {
      await productCubit.loadProducts();

      productCubit.selectCategory('jewelery');

      expect(productCubit.state.filteredProducts.length, equals(1));
      expect(productCubit.state.filteredProducts.first.category, equals('jewelery'));
    });

    test('toggleLayoutView toggles isGridView', () {
      expect(productCubit.state.isGridView, isTrue);
      productCubit.toggleLayoutView();
      expect(productCubit.state.isGridView, isFalse);
    });
  });
}
