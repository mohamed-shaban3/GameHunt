import 'package:gamehunt/features/games/data/models/game_model.dart';
import '../datasources/favorites_local_data_source.dart';

abstract class FavoritesRepository {
  Future<List<GameModel>> getFavorites();
  Future<void> addFavorite(GameModel game);
  Future<void> removeFavorite(int gameId);
  Future<bool> isFavorite(int gameId);
}

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesLocalDataSource localDataSource;

  FavoritesRepositoryImpl(this.localDataSource);

  @override
  Future<List<GameModel>> getFavorites() => localDataSource.getFavorites();

  @override
  Future<void> addFavorite(GameModel game) => localDataSource.addFavorite(game);

  @override
  Future<void> removeFavorite(int gameId) => localDataSource.removeFavorite(gameId);

  @override
  Future<bool> isFavorite(int gameId) => localDataSource.isFavorite(gameId);
}