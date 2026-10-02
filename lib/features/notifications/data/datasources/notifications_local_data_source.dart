import 'package:gamehunt/core/database/sqflite_helper.dart';
import '../models/notification_model.dart';

abstract class NotificationsLocalDataSource {
  Future<List<NotificationModel>> getNotifications();
  Future<void> markAsRead(int id);
  Future<void> deleteNotification(int id);
  Future<void> clearAllNotifications();
}

class NotificationsLocalDataSourceImpl implements NotificationsLocalDataSource {
  final SqfliteHelper _sqfliteHelper;

  NotificationsLocalDataSourceImpl(this._sqfliteHelper);

  @override
  Future<List<NotificationModel>> getNotifications() async {
    final List<Map<String, dynamic>> maps = await _sqfliteHelper.query(
      'notifications',
      orderBy: 'created_at DESC',
    );

    return maps.map((map) => NotificationModel.fromSqflite(map)).toList();
  }

  @override
  Future<void> markAsRead(int id) async {
    await _sqfliteHelper.update(
      'notifications',
      {'is_read': 1},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<void> deleteNotification(int id) async {
    await _sqfliteHelper.delete(
      'notifications',
      'id = ?',
      [id],
    );
  }

  @override
  Future<void> clearAllNotifications() async {
    await _sqfliteHelper.delete('notifications');
  }
}