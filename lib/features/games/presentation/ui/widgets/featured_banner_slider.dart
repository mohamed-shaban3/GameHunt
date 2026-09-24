import 'package:flutter/material.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/styles.dart';

class FeaturedBannerSlider extends StatelessWidget {
  final PageController pageController;
  final List<dynamic> featuredGames;
  final int currentPage;

  const FeaturedBannerSlider({
    super.key,
    required this.pageController,
    required this.featuredGames,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    if (featuredGames.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        SizedBox(
          height: 190,
          child: PageView.builder(
            controller: pageController,
            itemCount: featuredGames.length,
            itemBuilder: (context, index) {
              final game = featuredGames[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: game.backgroundImage != null
                      ? DecorationImage(
                          image: NetworkImage(game.backgroundImage!),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        ColorsManager.bgDark.withValues(alpha: 0.95),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: ColorsManager.accentNeon,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          AppStrings.featured,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        game.name ?? '',
                        style: TextStyles.font18BoldWhite,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        // Indicator Dots
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            featuredGames.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 6,
              width: currentPage == index ? 20 : 6,
              decoration: BoxDecoration(
                color: currentPage == index ? ColorsManager.accentNeon : ColorsManager.surfaceDark,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ),
      ],
    );
  }
}