import 'package:dio/dio.dart';
class ApiService {
  final Dio _dio;

  ApiService(this._dio);

  static const String rawgApiKey = '58e1d7ddffd74bda9b8e797e988803d7';
  static const String cheapSharkBaseUrl = 'https://www.cheapshark.com/api/1.0/';

  /// جلب الألعاب من RAWG API مع دعم التصفح والبحث
  Future<Map<String, dynamic>> getGames({int page = 1, String? search}) async {
    final response = await _dio.get(
      'games',
      queryParameters: {
        'key': rawgApiKey,
        'page': page,
        if (search != null && search.isNotEmpty) 'search': search,
      },
    );
    return response.data;
  }
  /// جلب تفاصيل لعبة محددة بواسطة ID
  Future<Map<String, dynamic>> getGameDetails(int gameId) async {
    final response = await _dio.get(
      'games/$gameId',
      queryParameters: {
        'key': rawgApiKey,
      },
    );
    return response.data;
  }
  /// جلب عروض أسعار اللعبة في المتاجر المختلفة من CheapShark API
  Future<List<dynamic>> getGameDeals(String title) async {
    final response = await _dio.get(
      '${cheapSharkBaseUrl}deals',
      queryParameters: {
        'title': title,
      },
    );
    return response.data;
  }
}