import '../datasources/notifications_local_data_source.dart';
import '../models/notification_model.dart';

abstract class NotificationsRepository {
  Future<List<NotificationModel>> getNotifications();
  Future<void> markAsRead(int id);
  Future<void> deleteNotification(int id);
  Future<void> clearAllNotifications();
}

class NotificationsRepositoryImpl implements NotificationsRepository {
  final NotificationsLocalDataSource _localDataSource;

  NotificationsRepositoryImpl(this._localDataSource);

  @override
  Future<List<NotificationModel>> getNotifications() {
    return _localDataSource.getNotifications();
  }

  @override
  Future<void> markAsRead(int id) {
    return _localDataSource.markAsRead(id);
  }

  @override
  Future<void> deleteNotification(int id) {
    return _localDataSource.deleteNotification(id);
  }

  @override
  Future<void> clearAllNotifications() {
    return _localDataSource.clearAllNotifications();
  }
}