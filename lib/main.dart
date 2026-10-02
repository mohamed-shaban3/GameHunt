import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:gamehunt/core/constants/api_constants.dart';
import 'package:gamehunt/core/di/service_locator.dart';
import 'package:gamehunt/core/local/cache_helper.dart';
import 'package:gamehunt/core/routes/app_router.dart';
import 'package:gamehunt/core/routes/app_routes.dart';
import 'package:gamehunt/core/utils/notification_helper.dart';
import 'package:gamehunt/core/utils/push_notification_service.dart';
import 'package:gamehunt/game_hunt.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  await CacheHelper.init();
  await Supabase.initialize(
    url: ApiConstants.supabaseUrl,
    publishableKey: ApiConstants.supabaseAnonKey,
  );

  setupServiceLocator();

  await NotificationHelper.init();
  await getIt<PushNotificationService>().initNotification();

  final session = Supabase.instance.client.auth.currentSession;
  final String initialRoute = session != null
      ? AppRoutes.mainLayout
      : AppRoutes.login;

  runApp(GameHunt(
    appRouter: AppRouter(),
    initialRoute: initialRoute,
  ));
}