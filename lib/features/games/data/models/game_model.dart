import 'package:gamehunt/features/games/data/models/deal_model.dart';

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
  final String? description;
  final String? descriptionRaw;
  final List<DealModel>? deals;

  const GameModel({
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
    this.description,
    this.descriptionRaw,
    this.deals,
  });

  factory GameModel.fromJson(Map<String, dynamic> json) {
    return GameModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      slug: json['slug'] as String?,
      released: json['released'] as String?,
      backgroundImage: json['background_image'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      ratingTop: (json['rating_top'] as num?)?.toInt(),
      ratingsCount: (json['ratings_count'] as num?)?.toInt(),
      metacritic: (json['metacritic'] as num?)?.toInt(),
      playtime: (json['playtime'] as num?)?.toInt(),
      description: json['description'] as String?,
      descriptionRaw: json['description_raw'] as String?,
      deals: json['deals'] != null
          ? (json['deals'] as List)
                .map((e) => DealModel.fromJson(e as Map<String, dynamic>))
                .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'released': released,
      'background_image': backgroundImage,
      'rating': rating,
      'rating_top': ratingTop,
      'ratings_count': ratingsCount,
      'metacritic': metacritic,
      'playtime': playtime,
      'description': description,
      'description_raw': descriptionRaw,
      'deals': deals?.map((e) => e.dealID).toList(),
    };
  }
  
  GameModel copyWith({
    List<DealModel>? deals,
  }) {
    return GameModel(
      id: id,
      name: name,
      slug: slug,
      released: released,
      backgroundImage: backgroundImage,
      rating: rating,
      ratingTop: ratingTop,
      ratingsCount: ratingsCount,
      metacritic: metacritic,
      playtime: playtime,
      description: description,
      descriptionRaw: descriptionRaw,
      deals: deals ?? this.deals,
    );
  }
// 1. دالة التحويل إلى Map للحفظ في Sqflite
  Map<String, dynamic> toSqflite() {
    return {
      'id': id,
      'name': name,
      'background_image': backgroundImage, // نفس الاسم الموجود في جدول Sqflite
      'rating': rating,
      'released': released,
    };
  }

  // 2. دالة القراءة من Sqflite
  factory GameModel.fromSqflite(Map<String, dynamic> map) {
    return GameModel(
      id: map['id'] as int?,
      name: map['name'] as String?,
      backgroundImage: map['background_image'] as String?, // قراءة نفس المفتاح
      rating: (map['rating'] as num?)?.toDouble(),
      released: map['released'] as String?,
    );
  }
}
