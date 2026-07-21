import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/services/local_storage_service.dart';
import 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final LocalStorageService localStorageService;

  FavoritesCubit({required this.localStorageService}) : super(const FavoritesState()) {
    loadFavorites();
  }

  void loadFavorites() {
    final savedFavs = localStorageService.getFavoriteIds();
    emit(FavoritesState(favoriteIds: savedFavs));
  }

  Future<void> toggleFavorite(int productId) async {
    final currentFavs = List<int>.from(state.favoriteIds);
    if (currentFavs.contains(productId)) {
      currentFavs.remove(productId);
    } else {
      currentFavs.add(productId);
    }
    emit(state.copyWith(favoriteIds: currentFavs));
    await localStorageService.saveFavoriteIds(currentFavs);
  }
}
