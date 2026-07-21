import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/services/local_storage_service.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final LocalStorageService localStorageService;

  ThemeCubit({required this.localStorageService})
      : super(localStorageService.isDarkMode() ? ThemeMode.dark : ThemeMode.light);

  void toggleTheme() {
    final isDark = state == ThemeMode.dark;
    final newMode = isDark ? ThemeMode.light : ThemeMode.dark;
    localStorageService.saveThemeMode(newMode == ThemeMode.dark);
    emit(newMode);
  }
}
