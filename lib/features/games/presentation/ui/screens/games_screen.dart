import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamehunt/core/constants/app_strings.dart';
import 'package:gamehunt/core/routes/app_routes.dart';
import 'package:gamehunt/core/theme/colors.dart';
import 'package:gamehunt/core/theme/styles.dart';
import 'package:gamehunt/features/games/presentation/cubit/games_cubit.dart';
import 'package:gamehunt/features/games/presentation/cubit/games_state.dart';
import 'package:gamehunt/features/games/presentation/ui/widgets/category_chips_list.dart';
import 'package:gamehunt/features/games/presentation/ui/widgets/featured_banner_slider.dart';
import 'package:gamehunt/features/games/presentation/ui/widgets/game_grid_item.dart';
import 'package:gamehunt/features/games/presentation/ui/widgets/games_header.dart';
import 'package:gamehunt/features/games/presentation/ui/widgets/trending_games_section.dart';

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
  }

  void _startBannerAutoScroll(int itemCount) {
    _bannerTimer?.cancel();
    if (itemCount <= 1) return;

    _bannerTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_bannerPageController.hasClients) {
        setState(() {
          _currentBannerPage = (_currentBannerPage + 1) % itemCount;
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

            // بدء التمرير التلقائي ديناميكياً مع مراعاة عدد العناصر
            if (_bannerTimer == null && featuredGames.isNotEmpty) {
              _startBannerAutoScroll(featuredGames.length);
            }

            return CustomScrollView(
              controller: _scrollController,
              slivers: [
                // 1. Header with Search
                SliverToBoxAdapter(
                  child: GamesHeader(
                    onNotificationTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.notificationsScreen,
                      );
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

                // 5. Trending Horizontal List (استخدام الويدجت المخصصة)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12, bottom: 20),
                    child: TrendingGamesSection(games: cubit.gamesList),
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

                // 7. Grid View (استخدام الويدجت المخصصة GameGridItem)
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
                      return GameGridItem(
                        game: cubit.gamesList[index],
                        index: index,
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
