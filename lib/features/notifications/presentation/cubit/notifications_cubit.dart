import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repo/notifications_repository.dart';
import 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  final NotificationsRepository _repository;

  NotificationsCubit(this._repository) : super(NotificationsInitial());

  Future<void> fetchNotifications() async {
    emit(NotificationsLoading());
    try {
      final notifications = await _repository.getNotifications();
      emit(NotificationsSuccess(notifications));
    } catch (e) {
      emit(NotificationsError('Failed to load notifications'));
    }
  }

  Future<void> markAsRead(int id) async {
    try {
      await _repository.markAsRead(id);
      await fetchNotifications();
    } catch (_) {}
  }

  Future<void> deleteNotification(int id) async {
    try {
      await _repository.deleteNotification(id);
      await fetchNotifications();
    } catch (_) {}
  }

  Future<void> clearAllNotifications() async {
    try {
      await _repository.clearAllNotifications();
      await fetchNotifications();
    } catch (_) {}
  }
}