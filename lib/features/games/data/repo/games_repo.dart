import 'dart:developer';

import 'package:gamehunt/features/games/data/models/deal_model.dart';
import 'package:gamehunt/features/games/data/models/game_model.dart';

import '../../../../core/networking/api_error/api_error_handler.dart';
import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/api_service.dart';
import '../models/games_response_model.dart';

class GamesRepo {
  final ApiService _apiService;

  GamesRepo(this._apiService);

  Future<ApiResult<GamesResponseModel>> getGames({
    int page = 1,
    String? search,
    String? genres,
  }) async {
    try {
      final response = await _apiService.getGames(
        page: page,
        search: search,
        genres: genres,
      );
      final gamesResponse = GamesResponseModel.fromJson(response);
      return Success(gamesResponse);
    } catch (error) {
      return Failure(ApiErrorHandler.handle(error).toString());
    }
  }

  Future<ApiResult<GameModel>> getGameDetails(int gameId) async {
    try {
      // 1. جلب تفاصيل اللعبة الأساسية من RAWG
      final response = await _apiService.getGameDetails(gameId);
      var game = GameModel.fromJson(response);

      // 2. جلب العروض المتاحة باسم اللعبة من CheapShark
      if (game.name != null && game.name!.isNotEmpty) {
        try {
          final dealsResponse = await _apiService.getGameDeals(game.name!);
          final List<DealModel> deals = dealsResponse
              .map((e) => DealModel.fromJson(e as Map<String, dynamic>))
              .toList();

          game = game.copyWith(deals: deals);
        } catch (error, stackTrace) {
          
          log('CheapShark Fetch Error: $error');
          log('StackTrace: $stackTrace');
        }
      }

      return Success(game);
    } catch (error) {
      return Failure(ApiErrorHandler.handle(error).toString());
    }
  }
}
