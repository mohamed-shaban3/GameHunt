part of 'games_cubit.dart';

sealed class GamesState {}

final class GamesInitial extends GamesState {}

final class GamesLoading extends GamesState {}

final class GamesSuccess extends GamesState {
  final List<dynamic> games;
  GamesSuccess(this.games);
}

final class GamesError extends GamesState {
  final String message;
  GamesError(this.message);
}