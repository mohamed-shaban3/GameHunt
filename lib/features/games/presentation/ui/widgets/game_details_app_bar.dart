import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamehunt/core/theme/colors.dart';
import 'package:gamehunt/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:gamehunt/features/favorites/presentation/cubit/favorites_state.dart';
import 'package:gamehunt/features/games/data/models/game_model.dart';

class GameDetailsAppBar extends StatelessWidget {
  final String? imageUrl;
  final GameModel? game;
  const GameDetailsAppBar({super.key, required this.imageUrl, this.game});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      backgroundColor: ColorsManager.surfaceDark,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundColor: Colors.black.withValues(alpha: 0.5),
          child: const BackButton(color: Colors.white),
        ),
      ),
      actions: [
        if (game != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.black.withValues(alpha: 0.5),
              child: BlocBuilder<FavoritesCubit, FavoritesState>(
                builder: (context, state) {
                  final isFav = state is FavoritesLoaded &&
                      state.favorites.any((element) => element.id == game!.id);

                  return IconButton(
                    icon: Icon(
                      isFav ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                      color: isFav ? Colors.red : Colors.white,
                    ),
                    onPressed: () {
                      context.read<FavoritesCubit>().toggleFavorite(game!);
                    },
                  );
                },
              ),
            ),
          ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            if (imageUrl != null && imageUrl!.isNotEmpty)
              Image.network(
                imageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => Container(
                  color: ColorsManager.surfaceDark,
                  child: const Icon(Icons.broken_image_rounded, size: 48, color: ColorsManager.borderDark),
                ),
              )
            else
              Container(color: ColorsManager.surfaceDark),

            // Gradient Overlay للدمج مع الشاشة
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.4),
                      Colors.transparent,
                      ColorsManager.surfaceDark.withValues(alpha: 0.9),
                      ColorsManager.surfaceDark,
                    ],
                    stops: const [0.0, 0.3, 0.8, 1.0],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}