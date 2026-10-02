import '../../data/models/game_model.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<GameModel> games;
  SearchSuccess(this.games);
}

class SearchError extends SearchState {
  final String error;
  SearchError(this.error);
}