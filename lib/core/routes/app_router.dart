import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamehunt/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:gamehunt/features/auth/presentation/ui/login_screen.dart';
import 'package:gamehunt/features/auth/presentation/ui/otp_verification_screen.dart';
import 'package:gamehunt/features/auth/presentation/ui/register_screen.dart';
import 'app_routes.dart';
import '../../features/games/presentation/ui/games_screen.dart';

// تأكد من استدعاء ملف الـ DI الذي يحتوي على getIt
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
          builder: (_) => const GamesScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}