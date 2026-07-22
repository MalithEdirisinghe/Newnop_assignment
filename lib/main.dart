import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/constants/app_constants.dart';
import 'core/theme/app_theme.dart';
import 'data/repositories/product_repository.dart';
import 'data/services/local_storage_service.dart';
import 'logic/favorites/favorites_cubit.dart';
import 'logic/product/product_cubit.dart';
import 'logic/theme/theme_cubit.dart';
import 'presentation/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final localStorageService = await LocalStorageService.init();
  final productRepository = ProductRepository();

  runApp(ProductCatalogApp(
    localStorageService: localStorageService,
    productRepository: productRepository,
  ));
}

class ProductCatalogApp extends StatelessWidget {
  final LocalStorageService localStorageService;
  final ProductRepository productRepository;

  const ProductCatalogApp({
    super.key,
    required this.localStorageService,
    required this.productRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<LocalStorageService>.value(value: localStorageService),
        RepositoryProvider<ProductRepository>.value(value: productRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ThemeCubit>(
            create: (context) => ThemeCubit(localStorageService: localStorageService),
          ),
          BlocProvider<FavoritesCubit>(
            create: (context) => FavoritesCubit(localStorageService: localStorageService),
          ),
          BlocProvider<ProductCubit>(
            create: (context) => ProductCubit(repository: productRepository),
          ),
        ],
        child: BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, themeMode) {
            return MaterialApp(
              title: AppConstants.appName,
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeMode,
              home: const SplashScreen(),
            );
          },
        ),
      ),
    );
  }
}
