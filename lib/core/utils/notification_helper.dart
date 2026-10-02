import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../routes/app_routes.dart';
import '../routes/app_router.dart'; // تأكد من استيراد الملف الذي يحتوي على navigatorKey

class NotificationHelper {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notificationsPlugin.initialize(
      settings: settings, // تمرير اسم البرامتر settings:
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        if (response.payload != null && response.payload!.isNotEmpty) {
          final int? gameId = int.tryParse(response.payload!);
          if (gameId != null) {
            navigatorKey.currentState?.pushNamed(
              AppRoutes.gameDetailsScreen, // تأكد من مطابقة الاسم لما هو معرف في AppRoutes
              arguments: gameId,
            );
          }
        }
      },
    );
  }

  static Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'game_hunt_channel',
      'GameHunt Alerts',
      channelDescription: 'Notifications for game price drops and deals',
      importance: Importance.high,
      priority: Priority.high,
    );

    const details = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(),
    );

    // تمرير البرامترات بأسمائها (Named Arguments)
    await _notificationsPlugin.show(
      id: id,
      title: title,
      body: body,
      notificationDetails: details,
      payload: payload,
    );
  }
}