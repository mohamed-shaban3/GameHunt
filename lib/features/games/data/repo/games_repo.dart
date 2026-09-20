import '../../../../core/networking/api_service.dart';

class GamesRepo {
  final ApiService _apiService;

  GamesRepo(this._apiService);

  Future<Map<String, dynamic>> getGames({int page = 1, String? search}) async {
    return await _apiService.getGames(page: page, search: search);
  }
}