import 'package:flutter/material.dart';
import 'package:gamehunt/core/constants/app_strings.dart';
import 'package:gamehunt/core/theme/colors.dart';
import 'package:gamehunt/core/theme/styles.dart';

class EmptyFavoritesWidget extends StatelessWidget {
  const EmptyFavoritesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.favorite_border_rounded,
            size: 70,
            color: ColorsManager.textSecondary,
          ),
          const SizedBox(height: 16),
          const Text(
            AppStrings.noGamesSavedYet,
            style: TextStyles.font18BoldWhite,
          ),
          const SizedBox(height: 8),
          Text(
            AppStrings.exploreGamesSubtitle,
            style: TextStyles.font14GreyRegular,
          ),
        ],
      ),
    );
  }
}