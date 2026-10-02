import 'package:flutter/material.dart';
import 'package:gamehunt/core/routes/app_routes.dart';
import 'package:gamehunt/core/theme/colors.dart';
import 'package:gamehunt/core/theme/styles.dart';
import 'package:gamehunt/features/games/data/models/game_model.dart';
import 'package:gamehunt/features/games/presentation/ui/widgets/app_fade_slide_animation.dart';

class GameGridItem extends StatelessWidget {
  final GameModel game;
  final int index;

  const GameGridItem({super.key, required this.game, required this.index});

  @override
  Widget build(BuildContext context) {
    return AppFadeSlideAnimation(
      delay: Duration(milliseconds: 50 * (index % 6)),
      child: GestureDetector(
        onTap: () {
          if (game.id != null) {
            Navigator.pushNamed(
              context,
              AppRoutes.gameDetailsScreen,
              arguments: game.id,
            );
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: ColorsManager.surfaceDark,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: ColorsManager.borderDark),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              if (game.backgroundImage != null)
                Image.network(
                  game.backgroundImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  cacheWidth: 350,
                ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        ColorsManager.surfaceDark.withValues(alpha: 0.95),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
              // Rating Badge
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: ColorsManager.starYellow,
                        size: 12,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        '${game.rating ?? 0.0}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Game Title
              Positioned(
                bottom: 10,
                left: 10,
                right: 10,
                child: Text(
                  game.name ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.font12WhiteBold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}