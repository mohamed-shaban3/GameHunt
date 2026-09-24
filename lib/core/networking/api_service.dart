import 'package:dio/dio.dart';
import 'package:gamehunt/core/constants/api_constants.dart';
class ApiService {
  final Dio _dio;

  ApiService(this._dio);

  /// جلب الألعاب من RAWG API مع دعم التصفح والبحث
Future<Map<String, dynamic>> getGames({int page = 1, String? search, String? genres}) async {
  final response = await _dio.get(
    'games',
    queryParameters: {
      'key': ApiConstants.rawgApiKey,
      'page': page,
      if (search != null && search.isNotEmpty) 'search': search,
      if (genres != null && genres.isNotEmpty) 'genres': genres,
    },
  );
  return response.data;
}
  /// جلب تفاصيل لعبة محددة بواسطة ID
  Future<Map<String, dynamic>> getGameDetails(int gameId) async {
    final response = await _dio.get(
      'games/$gameId',
      queryParameters: {
        'key': ApiConstants.rawgApiKey,
      },
    );
    return response.data;
  }
  /// جلب عروض أسعار اللعبة في المتاجر المختلفة من CheapShark API
  Future<List<dynamic>> getGameDeals(String title) async {
    final response = await _dio.get(
      '${ApiConstants.cheapSharkBaseUrl}deals',
      queryParameters: {
        'title': title,
      },
    );
    return response.data;
  }
}