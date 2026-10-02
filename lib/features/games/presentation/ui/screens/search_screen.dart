import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamehunt/core/routes/app_routes.dart';
import 'package:gamehunt/core/widgets/app_error_widget.dart';
import 'package:gamehunt/features/games/presentation/cubit/search_cubit.dart';
import 'package:gamehunt/features/games/presentation/cubit/search_state.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/styles.dart';
import '../../../../../core/utils/debouncer.dart';
import '../widgets/game_card.dart';
import '../widgets/search_text_field.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final Debouncer _debouncer = Debouncer(milliseconds: 500);

  @override
  void dispose() {
    _searchController.dispose();
    _debouncer.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    _debouncer.run(() {
      if (!mounted) return;
      context.read<SearchCubit>().searchGames(query);
    });
  }

  void _clearSearch() {
    _searchController.clear();
    if (!mounted) return;
    context.read<SearchCubit>().clearSearch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.bgDark,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: SearchTextField(
          controller: _searchController,
          autofocus: true,
          onChanged: _onSearchChanged,
          onClear: _clearSearch,
        ),
      ),
      body: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          final cubit = context.read<SearchCubit>();

          if (state is SearchLoading) {
            return const Center(
              child: CircularProgressIndicator(color: ColorsManager.accentNeon),
            );
          }

          if (state is SearchError) {
            return AppErrorWidget(
              message: state.error,
              onRetry: () {
                cubit.searchGames(_searchController.text);
              },
            );
          }

          if (_searchController.text.trim().isEmpty || state is SearchInitial) {
            return const Center(
              child: Text(
                AppStrings.searchPrompt,
                style: TextStyles.font12Grey,
              ),
            );
          }

          if (cubit.searchResults.isEmpty) {
            return const Center(
              child: Text(
                AppStrings.noGamesFound,
                style: TextStyle(color: ColorsManager.textSecondary),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: cubit.searchResults.length,
            itemBuilder: (context, index) {
              final game = cubit.searchResults[index];
              return GameCard(
                game: game,
                onTap: () {
                  if (game.id != null) {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.gameDetailsScreen,
                      arguments: game.id,
                    );
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}