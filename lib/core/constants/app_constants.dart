class AppConstants {
  static const String appName = 'Product Catalog';

  // API Endpoints
  static const String baseUrl = 'https://fakestoreapi.com';
  static const String productsEndpoint = '/products';

  // Storage Keys
  static const String favoritesKey = 'user_favorite_product_ids';
  static const String themeKey = 'app_theme_is_dark';

  // UI Constants
  static const double gridPadding = 16.0;
  static const double gridSpacing = 16.0;
  static const double borderRadius = 16.0;
  static const int searchDebounceMs = 300;
}
