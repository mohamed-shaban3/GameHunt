import 'package:flutter/material.dart';
import '../../../../../core/theme/colors.dart';
import '../../../data/models/game_model.dart';

class GameCard extends StatelessWidget {
  final GameModel game;
  final VoidCallback? onTap;

  const GameCard({
    super.key,
    required this.game,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorsManager.surfaceDark,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: ColorsManager.borderDark),
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.all(8),
        leading: _buildImage(),
        title: Text(
          game.name ?? '',
          style: const TextStyle(
            color: ColorsManager.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Row(
          children: [
            const Icon(Icons.star, color: Colors.amber, size: 16),
            const SizedBox(width: 4),
            Text(
              '${game.rating ?? 0.0}',
              style: const TextStyle(color: ColorsManager.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildImage() {
    if (game.backgroundImage != null && game.backgroundImage!.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          game.backgroundImage!,
          width: 60,
          height: 60,
          fit: BoxFit.cover,
        ),
      );
    }
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: ColorsManager.borderDark,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Icon(Icons.gamepad, color: ColorsManager.textSecondary),
    );
  }
}