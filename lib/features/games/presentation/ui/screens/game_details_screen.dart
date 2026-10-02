import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamehunt/core/theme/colors.dart';
import 'package:gamehunt/core/widgets/app_error_widget.dart';
import 'package:gamehunt/features/games/presentation/cubit/game_details_cubit.dart';
import 'package:gamehunt/features/games/presentation/cubit/game_details_state.dart';
import 'package:gamehunt/features/games/presentation/ui/widgets/game_deals_section.dart';
import '../widgets/game_details_app_bar.dart';
import '../widgets/game_details_description.dart';
import '../widgets/game_details_header_info.dart';

class GameDetailsScreen extends StatelessWidget {
  final int gameId;
  const GameDetailsScreen({super.key, required this.gameId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.surfaceDark,
      body: BlocBuilder<GameDetailsCubit, GameDetailsState>(
        builder: (context, state) {
          if (state is GameDetailsLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: ColorsManager.accentNeon,
              ),
            );
          }

          if (state is GameDetailsError) {
            return AppErrorWidget(
              message: state.error,
              onRetry: () {
                context.read<GameDetailsCubit>().getGameDetails(gameId);
              },
            );
          }
          if (state is GameDetailsSuccess) {
            final game = state.gameDetails;
            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                GameDetailsAppBar(imageUrl: game.backgroundImage, game: game),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GameDetailsHeaderInfo(game: game),
                        const SizedBox(height: 24),
                        GameDetailsDescription(
                          description: game.descriptionRaw ?? game.description,
                        ),
                        const SizedBox(height: 24),
                        GameDealsSection(deals: game.deals ?? []),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}