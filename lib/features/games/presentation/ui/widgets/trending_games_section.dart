import 'package:flutter/material.dart';
import 'package:gamehunt/core/routes/app_routes.dart';
import 'package:gamehunt/core/theme/colors.dart';
import 'package:gamehunt/features/games/data/models/game_model.dart';
import 'package:gamehunt/features/games/presentation/ui/widgets/app_fade_slide_animation.dart';

class TrendingGamesSection extends StatelessWidget {
  final List<GameModel> games;

  const TrendingGamesSection({super.key, required this.games});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: games.length,
        itemBuilder: (context, index) {
          final game = games[index];
          return AppFadeSlideAnimation(
            delay: Duration(milliseconds: 70 * index), // تأخير متدرج للعناصر الأفقية
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.gameDetailsScreen,
                  arguments: game.id,
                );
              },
              child: Container(
                width: 130,
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  color: ColorsManager.surfaceDark,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: ColorsManager.borderDark),
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: game.backgroundImage != null
                          ? Image.network(
                              game.backgroundImage!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              cacheWidth: 250,
                            )
                          : Container(color: Colors.grey[800]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        game.name ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: ColorsManager.textPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}