import 'game_model.dart';
class GamesResponseModel {
  final int? count;
  final String? next;
  final List<GameModel> results;

  GamesResponseModel({
    this.count,
    this.next,
    required this.results,
  });

  factory GamesResponseModel.fromJson(Map<String, dynamic> json) {
    return GamesResponseModel(
      count: json['count'] as int?,
      next: json['next'] as String?,
      results: (json['results'] as List?)
              ?.map((e) => GameModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}