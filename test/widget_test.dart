// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gamehunt/core/routes/app_router.dart';
import 'package:gamehunt/core/routes/app_routes.dart';
import 'package:gamehunt/game_hunt.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
  final session = Supabase.instance.client.auth.currentSession;
  final String initialRoute = session != null ? AppRoutes.gamesScreen : AppRoutes.login;
    await tester.pumpWidget(GameHunt(
      appRouter: AppRouter(),
      initialRoute: initialRoute,));

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
