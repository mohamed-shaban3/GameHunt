import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/service_locator.dart';
import '../cubit/games_cubit.dart';
import 'widgets/games_bloc_builder.dart';

class GamesScreen extends StatelessWidget {
  const GamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<GamesCubit>()..getGames(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('GameHunt 🎮'),
          centerTitle: true,
        ),
        body: const GamesBlocBuilder(),
      ),
    );
  }
}