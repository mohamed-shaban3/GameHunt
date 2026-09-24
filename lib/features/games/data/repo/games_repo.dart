import '../../../../core/networking/api_error/api_error_handler.dart';
import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/api_service.dart';
import '../models/games_response_model.dart';

class GamesRepo {
  final ApiService _apiService;

  GamesRepo(this._apiService);

Future<ApiResult<GamesResponseModel>> getGames({int page = 1, String? search, String? genres}) async {
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
}