import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamehunt/features/favorites/data/repositories/favorites_repository_impl.dart';
import 'package:gamehunt/features/favorites/presentation/cubit/favorites_state.dart';
import '../../../games/data/models/game_model.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final FavoritesRepository repository;

  FavoritesCubit(this.repository) : super(FavoritesInitial());

  Future<void> getFavorites() async {
    emit(FavoritesLoading());
    try {
      final favorites = await repository.getFavorites();
      emit(FavoritesLoaded(favorites));
    } catch (e) {
      emit(FavoritesError('Failed to load favorites'));
    }
  }

Future<void> toggleFavorite(GameModel game) async {
  if (game.id == null) return;
  try {
    final isFav = await repository.isFavorite(game.id!);
    if (isFav) {
      await repository.removeFavorite(game.id!);
    } else {
      await repository.addFavorite(game);
    }
    getFavorites();
  } catch (e) {
    emit(FavoritesError('Failed to update favorite status'));
  }
}

  Future<bool> isFavorite(int gameId) async {
    return await repository.isFavorite(gameId);
  }
}