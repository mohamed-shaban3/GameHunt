import 'package:flutter/material.dart';
import 'package:gamehunt/core/constants/app_strings.dart';
import 'package:gamehunt/core/theme/colors.dart';
import '../../../data/models/game_model.dart';

class GameDetailsHeaderInfo extends StatelessWidget {
  final GameModel game;
  const GameDetailsHeaderInfo({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // عنوان اللعبة
        Text(
          game.name ?? AppStrings.notAvailable,
          style: const TextStyle(
            color: ColorsManager.textPrimary,
            fontSize: 26,
            fontWeight: FontWeight.bold,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 14),
        // Badges الصفية
        Wrap(
          spacing: 10,
          runSpacing: 8,
          children: [
            // Badge التقييم
            if (game.rating != null)
              _buildBadge(
                icon: Icons.star_rounded,
                iconColor: ColorsManager.starYellow,
                text: '${game.rating}',
              ),

            // Badge تاريخ الإصدار
            if (game.released != null)
              _buildBadge(
                icon: Icons.calendar_today_rounded,
                iconColor: ColorsManager.accentNeon,
                text: game.released!,
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildBadge({required IconData icon, required Color iconColor, required String text}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: iconColor, size: 16),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              color: ColorsManager.textSecondary,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}