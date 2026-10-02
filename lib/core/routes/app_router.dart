import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamehunt/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:gamehunt/features/auth/presentation/ui/screens/login_screen.dart';
import 'package:gamehunt/features/auth/presentation/ui/screens/otp_verification_screen.dart';
import 'package:gamehunt/features/auth/presentation/ui/screens/register_screen.dart';
import 'package:gamehunt/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:gamehunt/features/favorites/presentation/ui/screens/favorites_screen.dart';
import 'package:gamehunt/features/games/presentation/cubit/game_details_cubit.dart';
import 'package:gamehunt/features/games/presentation/cubit/games_cubit.dart';
import 'package:gamehunt/features/games/presentation/cubit/search_cubit.dart';
import 'package:gamehunt/features/games/presentation/ui/screens/game_details_screen.dart';
import 'package:gamehunt/features/main_layout/presentation/ui/screens/main_layout_screen.dart';
import 'package:gamehunt/features/notifications/presentation/cubit/notifications_cubit.dart';
import 'package:gamehunt/features/notifications/presentation/ui/screens/notifications_screen.dart';
import 'app_routes.dart';
import '../di/service_locator.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.login:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<AuthCubit>(),
            child: const LoginScreen(),
          ),
        );

      case AppRoutes.register:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<AuthCubit>(),
            child: const RegisterScreen(),
          ),
        );

      case AppRoutes.otpVerification:
        final email = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<AuthCubit>(),
            child: OtpVerificationScreen(email: email),
          ),
        );

      case AppRoutes.mainLayout:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<GamesCubit>()..getGames(),
              ),
              BlocProvider(create: (context) => getIt<SearchCubit>()),
              BlocProvider.value(
                value: getIt<FavoritesCubit>()..getFavorites(),
              ),
              BlocProvider.value(
                value: getIt<NotificationsCubit>()..fetchNotifications(),
              ),
            ],
            child: const MainLayoutScreen(),
          ),
        );

      case AppRoutes.gameDetailsScreen:
        final gameId = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    getIt<GameDetailsCubit>()..getGameDetails(gameId),
              ),
              BlocProvider.value(value: getIt<FavoritesCubit>()),
            ],
            child: GameDetailsScreen(gameId: gameId),
          ),
        );

      case AppRoutes.notificationsScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: getIt<NotificationsCubit>()..fetchNotifications(),
            child: const NotificationsScreen(),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
