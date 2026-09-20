import 'package:flutter/material.dart';
import 'core/routes/app_router.dart';

class GameHunt extends StatelessWidget {
  final AppRouter appRouter;
  final String initialRoute;

  const GameHunt({
    super.key,
    required this.appRouter,
    required this.initialRoute,
    });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game Hunt',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      initialRoute: initialRoute,
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}