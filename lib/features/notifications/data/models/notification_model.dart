class NotificationModel {
  final int? id;
  final String title;
  final String body;
  final int? gameId;
  final String createdAt;
  final bool isRead;

  const NotificationModel({
    this.id,
    required this.title,
    required this.body,
    this.gameId,
    required this.createdAt,
    this.isRead = false,
  });

  // تحويل البيانات القادمة من Sqflite (Map) إلى Model
  factory NotificationModel.fromSqflite(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id'] as int?,
      title: map['title'] as String,
      body: map['body'] as String,
      gameId: map['game_id'] as int?,
      createdAt: map['created_at'] as String,
      isRead: (map['is_read'] as int? ?? 0) == 1,
    );
  }

  // تحويل الـ Model إلى Map لحفظه أو تحديثه في Sqflite
  Map<String, dynamic> toSqflite() {
    return {
      if (id != null) 'id': id,
      'title': title,
      'body': body,
      'game_id': gameId,
      'created_at': createdAt,
      'is_read': isRead ? 1 : 0,
    };
  }

  NotificationModel copyWith({
    int? id,
    String? title,
    String? body,
    int? gameId,
    String? createdAt,
    bool? isRead,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      gameId: gameId ?? this.gameId,
      createdAt: createdAt ?? this.createdAt,
      isRead: isRead ?? this.isRead,
    );
  }
}