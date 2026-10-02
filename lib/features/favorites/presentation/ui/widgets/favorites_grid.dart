import 'package:flutter/material.dart';
import 'package:gamehunt/features/games/presentation/ui/widgets/game_grid_item.dart';


class FavoritesGrid extends StatelessWidget {
  final List favorites;

  const FavoritesGrid({super.key, required this.favorites});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        return GameGridItem(game: favorites[index], index: index,);
      },
    );
  }
}