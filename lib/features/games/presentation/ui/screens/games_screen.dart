import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamehunt/core/constants/app_strings.dart';
import 'package:gamehunt/core/theme/colors.dart';
import 'package:gamehunt/core/theme/styles.dart';
import 'package:gamehunt/features/games/presentation/cubit/games_cubit.dart';
import 'package:gamehunt/features/games/presentation/cubit/games_state.dart';
import 'package:gamehunt/features/games/presentation/ui/widgets/category_chips_list.dart';
import 'package:gamehunt/features/games/presentation/ui/widgets/featured_banner_slider.dart';
import 'package:gamehunt/features/games/presentation/ui/widgets/games_header.dart';

class GamesScreen extends StatefulWidget {
  const GamesScreen({super.key});

  @override
  State<GamesScreen> createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
  final ScrollController _scrollController = ScrollController();
  final PageController _bannerPageController = PageController();
  int _currentBannerPage = 0;
  Timer? _bannerTimer;
  int _selectedCategoryIndex = 0;

  final List<String> _categories = [
    'All',
    'Action',
    'RPG',
    'Shooter',
    'Strategy',
    'Adventure',
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _startBannerAutoScroll();
  }

  void _startBannerAutoScroll() {
    _bannerTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_bannerPageController.hasClients) {
        setState(() {
          _currentBannerPage = (_currentBannerPage + 1) % 5;
        });
        _bannerPageController.animateToPage(
          _currentBannerPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 300) {
      final cubit = context.read<GamesCubit>();
      if (cubit.state is! GamesPaginationLoading) {
        cubit.getGames(isLoadMore: true);
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _bannerPageController.dispose();
    _bannerTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.bgDark,
      body: SafeArea(
        child: BlocBuilder<GamesCubit, GamesState>(
          builder: (context, state) {
            final cubit = context.read<GamesCubit>();

            if (state is GamesLoading && cubit.gamesList.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(
                  color: ColorsManager.accentNeon,
                ),
              );
            }

            if (state is GamesError && cubit.gamesList.isEmpty) {
              return Center(
                child: Text(
                  state.error,
                  style: const TextStyle(color: Colors.redAccent),
                ),
              );
            }

            if (cubit.gamesList.isEmpty) {
              return const Center(
                child: Text(
                  AppStrings.noGamesFound,
                  style: TextStyle(color: Colors.white),
                ),
              );
            }

            final featuredGames = cubit.gamesList.take(5).toList();

            return CustomScrollView(
              controller: _scrollController,
              slivers: [
                // 1. Header with Search
                SliverToBoxAdapter(
                  child: GamesHeader(
                    onSearchChanged: (query) {
                      context.read<GamesCubit>().searchGames(query);
                    },
                    onNotificationTap: () {
                      // فتح شاشة التنبيهات أو عرض BottomSheet
                    },
                  ),
                ),

                // 2. Featured Banner
                SliverToBoxAdapter(
                  child: FeaturedBannerSlider(
                    pageController: _bannerPageController,
                    featuredGames: featuredGames,
                    currentPage: _currentBannerPage,
                  ),
                ),

                // 3. Category Chips
                SliverToBoxAdapter(
                  child: CategoryChipsList(
                    categories: _categories,
                    selectedIndex: _selectedCategoryIndex,
                    onCategorySelected: (index) {
                      setState(() => _selectedCategoryIndex = index);
                      final selectedGenre = _categories[index];
                      context.read<GamesCubit>().filterByGenre(selectedGenre);
                    },
                  ),
                ),

                // 4. Trending Section Header
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppStrings.trendingNow,
                          style: TextStyles.font18BoldWhite,
                        ),
                        Text(
                          AppStrings.seeAll,
                          style: TextStyles.font13NeonBold,
                        ),
                      ],
                    ),
                  ),
                ),

                // 5. Trending Horizontal List
                SliverToBoxAdapter(
                  child: Container(
                    height: 180,
                    margin: const EdgeInsets.only(top: 12, bottom: 20),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: cubit.gamesList.length,
                      itemBuilder: (context, index) {
                        final game = cubit.gamesList[index];
                        return Container(
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
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      game.name ?? '',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyles.font12WhiteBold,
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          color: ColorsManager.starYellow,
                                          size: 12,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          '${game.rating ?? 0.0}',
                                          style: TextStyles.font12Grey,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // 6. All Games Header
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8,
                    ),
                    child: Text(
                      AppStrings.allGames,
                      style: TextStyles.font18BoldWhite,
                    ),
                  ),
                ),

                // 7. Grid View
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.75,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final game = cubit.gamesList[index];
                      return Container(
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
                                      ColorsManager.surfaceDark.withValues(
                                        alpha: 0.95,
                                      ),
                                      Colors.transparent,
                                    ],
                                  ),
                                ),
                              ),
                            ),
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
                      );
                    }, childCount: cubit.gamesList.length),
                  ),
                ),

                // Loader عند التمرير اللانهائي
                if (state is GamesPaginationLoading)
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: ColorsManager.accentNeon,
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
