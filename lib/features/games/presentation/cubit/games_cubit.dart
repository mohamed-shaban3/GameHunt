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

Future<void> getGames({bool isLoadMore = false}) async {
  if (isLoadMore) {
    emit(const GamesState.gamesPaginationLoading());
    currentPage++;
  } else {
    emit(const GamesState.gamesLoading());
    currentPage = 1;
    gamesList.clear(); 
  }

  final result = await _gamesRepo.getGames(
    page: currentPage,
    search: currentSearchQuery.isNotEmpty ? currentSearchQuery : null,
    genres: currentGenre.isNotEmpty ? currentGenre : null,
  );

  switch (result) {
    case Success(:final data):
      if (isLoadMore) {
        gamesList.addAll(data.results);
      } else {
        gamesList = data.results;
      }
      emit(GamesState.gamesSuccess(gamesList));
    case Failure(:final failure):
      if (isLoadMore) {
        emit(GamesState.gamesPaginationError(failure));
      } else {
        emit(GamesState.gamesError(failure));
      }
  }
}

  String currentSearchQuery = '';
  String currentGenre = '';

  void searchGames(String query) {
    currentSearchQuery = query;
    // إعادة تعيين القائمة وجلب أول صفحة بناءً على كلمة البحث
    getGames(isLoadMore: false);
  }


  void filterByGenre(String genre) {
    currentGenre = genre == 'All' ? '' : genre.toLowerCase();
    getGames(isLoadMore: false);
  }
}
