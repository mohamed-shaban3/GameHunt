import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamehunt/core/constants/app_strings.dart';
import 'package:gamehunt/core/theme/colors.dart';
import 'package:gamehunt/core/theme/styles.dart';
import 'package:gamehunt/core/widgets/app_error_widget.dart';
import 'package:gamehunt/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:gamehunt/features/favorites/presentation/cubit/favorites_state.dart';
import 'package:gamehunt/features/favorites/presentation/ui/widgets/empty_favorites_widget.dart';
import 'package:gamehunt/features/favorites/presentation/ui/widgets/favorites_grid.dart';
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.bgDark,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          AppStrings.myLibrary,
          style: TextStyles.font22BoldWhite,
        ),
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, state) {
          if (state is FavoritesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is FavoritesError) {
            return Center(
              child: AppErrorWidget(
                message: state.message,
                onRetry: () => context.read<FavoritesCubit>().getFavorites(),
              ),
            );
          }

          if (state is FavoritesLoaded) {
            if (state.favorites.isEmpty) {
              return const EmptyFavoritesWidget();
            }

            return FavoritesGrid(favorites: state.favorites);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}