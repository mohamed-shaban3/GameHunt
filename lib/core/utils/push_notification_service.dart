import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:gamehunt/core/di/service_locator.dart';
import 'package:gamehunt/features/notifications/presentation/cubit/notifications_cubit.dart';
import '../database/sqflite_helper.dart';
import '../routes/app_routes.dart';
import '../routes/app_router.dart'; // تأكد من وجود navigatorKey في هذا الملف
import 'notification_helper.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // التعامل مع الإشعارات والتطبيق مغلق
}

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final SqfliteHelper _sqfliteHelper;

  PushNotificationService(this._sqfliteHelper);

  Future<void> initNotification() async {
    // 1. طلب صلاحية الإشعارات
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // 2. إعداد Background Handler
      FirebaseMessaging.onBackgroundMessage(
        _firebaseMessagingBackgroundHandler,
      );

      // 3. الاستماع للإشعارات والتطبيق مفتوح (Foreground)
      _listenToForegroundMessages();

      // 4. الاستماع لضغط الإشعارات لتوجيه المستخدم
      _listenToNotificationClicks();
    }
  }

  void _listenToForegroundMessages() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      final title =
          message.notification?.title ??
          message.data['title'] ??
          'GameHunt Deal';
      final body = message.notification?.body ?? message.data['body'] ?? '';

      if (title.isNotEmpty && body.isNotEmpty) {
        final rawGameId = message.data['game_id'] ?? message.data['gameId'];
        final int? parsedGameId = rawGameId != null
            ? int.tryParse(rawGameId.toString())
            : null;

        // حفظ الإشعار في قاعدة البيانات المحلية Sqflite
        await _sqfliteHelper.insert('notifications', {
          'title': title,
          'body': body,
          'game_id': parsedGameId,
          'created_at': DateTime.now().toIso8601String(),
          'is_read': 0,
        });

        getIt<NotificationsCubit>().fetchNotifications();

        NotificationHelper.showNotification(
          id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
          title: title,
          body: body,
          payload: parsedGameId?.toString(),
        );
      }
    });
  }

  void _listenToNotificationClicks() {
    // أ: عند ضغط الإشعار والتطبيق يعمل في الخلفية (Background)
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleNotificationClick(message);
    });

    // ب: عند ضغط الإشعار والتطبيق مغلق تماماً (Terminated)
    _fcm.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        _handleNotificationClick(message);
      }
    });
  }

  void _handleNotificationClick(RemoteMessage message) {
    final rawGameId = message.data['game_id'] ?? message.data['gameId'];
    if (rawGameId != null) {
      final int? gameId = int.tryParse(rawGameId.toString());
      if (gameId != null) {
        navigatorKey.currentState?.pushNamed(
          AppRoutes.gameDetailsScreen,
          arguments: gameId,
        );
      }
    }
  }
}
