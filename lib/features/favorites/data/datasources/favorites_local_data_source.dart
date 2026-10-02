import '../../../../core/database/sqflite_helper.dart';
import '../../../games/data/models/game_model.dart';

abstract class FavoritesLocalDataSource {
  Future<List<GameModel>> getFavorites();
  Future<void> addFavorite(GameModel game);
  Future<void> removeFavorite(int gameId);
  Future<bool> isFavorite(int gameId);
}

class FavoritesLocalDataSourceImpl implements FavoritesLocalDataSource {
  final SqfliteHelper sqfliteHelper;

  FavoritesLocalDataSourceImpl(this.sqfliteHelper);

  static const String _tableName = 'favorites';

@override
Future<List<GameModel>> getFavorites() async {
  final result = await sqfliteHelper.query(_tableName);
  // استخدام fromSqflite بدلاً من fromJson
  return result.map((e) => GameModel.fromSqflite(e)).toList();
}

@override
Future<void> addFavorite(GameModel game) async {
  // استخدام toSqflite() لضمان مطابقة أسماء الأعمدة بنفس الشكل
  await sqfliteHelper.insert(_tableName, game.toSqflite());
}
  @override
  Future<void> removeFavorite(int gameId) async {
    await sqfliteHelper.delete(_tableName, 'id = ?', [gameId]);
  }

  @override
  Future<bool> isFavorite(int gameId) async {
    final result = await sqfliteHelper.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [gameId],
    );
    return result.isNotEmpty;
  }
}