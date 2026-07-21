import 'package:equatable/equatable.dart';

class FavoritesState extends Equatable {
  final List<int> favoriteIds;

  const FavoritesState({this.favoriteIds = const []});

  bool isFavorite(int productId) => favoriteIds.contains(productId);

  FavoritesState copyWith({List<int>? favoriteIds}) {
    return FavoritesState(
      favoriteIds: favoriteIds ?? this.favoriteIds,
    );
  }

  @override
  List<Object?> get props => [favoriteIds];
}
