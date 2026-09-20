import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamehunt/features/games/presentation/cubit/games_cubit.dart';
import 'game_card_item.dart';

class GamesBlocBuilder extends StatelessWidget {
  const GamesBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GamesCubit, GamesState>(
      builder: (context, state) {
        if (state is GamesLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GamesSuccess) {
          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: state.games.length,
            itemBuilder: (context, index) {
              return GameCardItem(game: state.games[index]);
            },
          );
        } else if (state is GamesError) {
          return Center(
            child: Text(
              'Error: ${state.message}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}