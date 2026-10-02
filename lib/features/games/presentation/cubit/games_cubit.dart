import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/networking/api_result.dart';
import '../../data/models/game_model.dart';
import '../../data/repo/games_repo.dart';
import 'games_state.dart';

class GamesCubit extends Cubit<GamesState> {
  final GamesRepo _gamesRepo;

  GamesCubit(this._gamesRepo) : super(const GamesState.initial());

  List<GameModel> gamesList = [];
  int currentPage = 1;
  String currentGenre = '';
  bool hasReachedMax = false;

  Future<void> getGames({bool isLoadMore = false, bool isRefresh = false}) async {
    if (isLoadMore) {
      if (hasReachedMax) return;
      emit(const GamesState.gamesPaginationLoading());
      currentPage++;
    } else if (isRefresh) {
      currentPage = 1;
      hasReachedMax = false;
      emit(const GamesState.gamesLoading());
    } else {
      emit(const GamesState.gamesLoading());
      currentPage = 1;
      hasReachedMax = false;
      gamesList.clear();
    }

    final result = await _gamesRepo.getGames(
      page: currentPage,
      genres: currentGenre.isNotEmpty ? currentGenre : null,
    );

    switch (result) {
      case Success(:final data):
        if (data.results.isEmpty) {
          hasReachedMax = true;
        }

        if (isLoadMore) {
          gamesList.addAll(data.results);
        } else {
          gamesList = data.results;
        }

        emit(GamesState.gamesSuccess(List.from(gamesList)));

      case Failure(:final failure):
        if (isLoadMore) {
          currentPage--;
          emit(GamesState.gamesPaginationError(failure));
        } else {
          emit(GamesState.gamesError(failure));
        }
    }
  }

  void filterByGenre(String genre) {
    currentGenre = genre == 'All' ? '' : genre.toLowerCase();
    getGames(isRefresh: true);
  }
}