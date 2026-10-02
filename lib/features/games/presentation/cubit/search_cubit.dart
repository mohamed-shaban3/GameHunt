import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/networking/api_result.dart';
import '../../data/models/game_model.dart';
import '../../data/repo/games_repo.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final GamesRepo _gamesRepo;

  SearchCubit(this._gamesRepo) : super(SearchInitial());

  List<GameModel> searchResults = [];

  Future<void> searchGames(String query) async {
    final trimmedQuery = query.trim();
    if (trimmedQuery.isEmpty) {
      clearSearch();
      return;
    }

    emit(SearchLoading());

    final result = await _gamesRepo.getGames(
      page: 1,
      search: trimmedQuery,
    );

    switch (result) {
      case Success(:final data):
        searchResults = data.results;
        emit(SearchSuccess(searchResults));
      case Failure(:final failure):
        emit(SearchError(failure));
    }
  }

  void clearSearch() {
    searchResults.clear();
    emit(SearchInitial());
  }
}