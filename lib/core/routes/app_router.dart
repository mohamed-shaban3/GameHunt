import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamehunt/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:gamehunt/features/auth/presentation/ui/screens/login_screen.dart';
import 'package:gamehunt/features/auth/presentation/ui/screens/otp_verification_screen.dart';
import 'package:gamehunt/features/auth/presentation/ui/screens/register_screen.dart';
import 'package:gamehunt/features/games/presentation/cubit/games_cubit.dart';
import 'app_routes.dart';
import '../../features/games/presentation/ui/screens/games_screen.dart';
import '../di/service_locator.dart';

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

      case AppRoutes.gamesScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<GamesCubit>()..getGames(),
            child: const GamesScreen(),
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
