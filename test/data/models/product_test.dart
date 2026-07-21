import 'package:flutter_test/flutter_test.dart';
import 'package:product_catalog/data/models/product.dart';
import 'package:product_catalog/data/models/rating.dart';

void main() {
  group('Product Model Tests', () {
    const testRating = Rating(rate: 4.5, count: 120);
    const testProduct = Product(
      id: 1,
      title: 'Test Product',
      price: 99.99,
      description: 'Test description',
      category: 'electronics',
      image: 'https://example.com/image.jpg',
      rating: testRating,
    );

    test('should correctly parse json into Product model', () {
      final json = {
        'id': 1,
        'title': 'Test Product',
        'price': 99.99,
        'description': 'Test description',
        'category': 'electronics',
        'image': 'https://example.com/image.jpg',
        'rating': {'rate': 4.5, 'count': 120},
      };

      final result = Product.fromJson(json);

      expect(result, equals(testProduct));
      expect(result.id, equals(1));
      expect(result.title, equals('Test Product'));
      expect(result.price, equals(99.99));
      expect(result.rating.rate, equals(4.5));
    });

    test('should correctly serialize Product model to json', () {
      final json = testProduct.toJson();

      expect(json['id'], equals(1));
      expect(json['title'], equals('Test Product'));
      expect(json['price'], equals(99.99));
      expect(json['rating']['rate'], equals(4.5));
    });
  });
}
