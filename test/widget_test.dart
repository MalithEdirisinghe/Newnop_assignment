import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:product_catalog/data/repositories/product_repository.dart';
import 'package:product_catalog/data/services/local_storage_service.dart';
import 'package:product_catalog/main.dart';

void main() {
  testWidgets('ProductCatalogApp renders Product Catalog title and search bar',
      (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    final localStorageService = await LocalStorageService.init();
    final productRepository = ProductRepository();

    await tester.pumpWidget(ProductCatalogApp(
      localStorageService: localStorageService,
      productRepository: productRepository,
    ));

    // Advance timer past splash screen
    await tester.pump(const Duration(seconds: 3));
    await tester.pump();

    expect(find.text('Catalog'), findsWidgets);
    expect(find.byType(TextField), findsOneWidget);
  });
}
