import 'package:flutter/material.dart';
import 'package:gamehunt/core/constants/app_strings.dart';
import 'package:gamehunt/core/theme/colors.dart';
import 'package:gamehunt/features/games/data/models/deal_model.dart';

import 'game_deal_card.dart';

class GameDealsSection extends StatelessWidget {
  final List<DealModel> deals;

  const GameDealsSection({super.key, required this.deals});

  @override
  Widget build(BuildContext context) {
    if (deals.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          AppStrings.noDealsAvailable,
          style: TextStyle(color: ColorsManager.textSecondary, fontSize: 14),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          AppStrings.bestDealsAndPrices,
          style: TextStyle(
            color: ColorsManager.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: deals.length,
          separatorBuilder: (_, _) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            return GameDealCard(deal: deals[index]);
          },
        ),
      ],
    );
  }
}