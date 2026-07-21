import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/favorites/favorites_cubit.dart';
import '../../logic/favorites/favorites_state.dart';
import 'favorites_screen.dart';
import 'product_list_screen.dart';
import 'settings_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    ProductListScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, favState) {
          final favCount = favState.favoriteIds.length;

          return NavigationBar(
            selectedIndex: _currentIndex,
            onDestinationSelected: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            backgroundColor: isDark ? const Color(0xFF1E293B) : Colors.white,
            indicatorColor: const Color(0xFF635BFF).withAlpha(40),
            elevation: 8,
            destinations: [
              const NavigationDestination(
                icon: Icon(Icons.storefront_outlined),
                selectedIcon: Icon(Icons.storefront_rounded, color: Color(0xFF635BFF)),
                label: 'Catalog',
              ),
              NavigationDestination(
                icon: Badge(
                  isLabelVisible: favCount > 0,
                  label: Text('$favCount'),
                  backgroundColor: const Color(0xFFFF4757),
                  child: const Icon(Icons.favorite_outline_rounded),
                ),
                selectedIcon: Badge(
                  isLabelVisible: favCount > 0,
                  label: Text('$favCount'),
                  backgroundColor: const Color(0xFFFF4757),
                  child: const Icon(Icons.favorite_rounded, color: Color(0xFFFF4757)),
                ),
                label: 'Favorites',
              ),
              const NavigationDestination(
                icon: Icon(Icons.settings_outlined),
                selectedIcon: Icon(Icons.settings_rounded, color: Color(0xFF635BFF)),
                label: 'Settings',
              ),
            ],
          );
        },
      ),
    );
  }
}
