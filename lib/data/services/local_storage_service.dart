import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/app_constants.dart';

class LocalStorageService {
  final SharedPreferences prefs;

  LocalStorageService({required this.prefs});

  static Future<LocalStorageService> init() async {
    final prefs = await SharedPreferences.getInstance();
    return LocalStorageService(prefs: prefs);
  }

  // Favorites Management
  List<int> getFavoriteIds() {
    final List<String>? favStringList = prefs.getStringList(AppConstants.favoritesKey);
    if (favStringList == null) return [];
    return favStringList.map((idStr) => int.tryParse(idStr) ?? -1).where((id) => id != -1).toList();
  }

  Future<bool> saveFavoriteIds(List<int> favoriteIds) async {
    final favStringList = favoriteIds.map((id) => id.toString()).toList();
    return await prefs.setStringList(AppConstants.favoritesKey, favStringList);
  }

  // Theme Management
  bool isDarkMode() {
    return prefs.getBool(AppConstants.themeKey) ?? false;
  }

  Future<bool> saveThemeMode(bool isDark) async {
    return await prefs.setBool(AppConstants.themeKey, isDark);
  }
}
