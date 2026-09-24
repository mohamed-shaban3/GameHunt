class GameModel {
  final int? id;
  final String? name;
  final String? slug;
  final String? released;
  final String? backgroundImage;
  final double? rating;
  final int? ratingTop;
  final int? ratingsCount;
  final int? metacritic;
  final int? playtime;

  GameModel({
    this.id,
    this.name,
    this.slug,
    this.released,
    this.backgroundImage,
    this.rating,
    this.ratingTop,
    this.ratingsCount,
    this.metacritic,
    this.playtime,
  });

  factory GameModel.fromJson(Map<String, dynamic> json) {
    return GameModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      slug: json['slug'] as String?,
      released: json['released'] as String?,
      backgroundImage: json['background_image'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      ratingTop: json['rating_top'] as int?,
      ratingsCount: json['ratings_count'] as int?,
      metacritic: json['metacritic'] as int?,
      playtime: json['playtime'] as int?,
    );
  }
}