import 'package:flutter/material.dart';
import 'package:gamehunt/core/local/cache_helper.dart';
import 'package:gamehunt/core/routes/app_routes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/di/service_locator.dart';
import 'core/routes/app_router.dart';
import 'game_hunt.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper.init();

  await Supabase.initialize(
    url: 'https://spmbytnmjyhejftpdzen.supabase.co',
    publishableKey: 'sb_publishable_g4nu16mULdx-743zRy6oxw_r1EdwGeh',
  );

  setupServiceLocator();
// 1️ Check session and determine initial screen
  final session = Supabase.instance.client.auth.currentSession;
  final String initialRoute = session != null ? AppRoutes.gamesScreen : AppRoutes.login;

  // Pass initialRoute to GameHunt
  runApp(GameHunt(
    appRouter: AppRouter(),
    initialRoute: initialRoute,
  ));
}
