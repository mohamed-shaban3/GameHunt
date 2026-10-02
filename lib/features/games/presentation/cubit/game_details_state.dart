
import '../../data/models/game_model.dart';

abstract class GameDetailsState {}

class GameDetailsInitial extends GameDetailsState {}

class GameDetailsLoading extends GameDetailsState {}

class GameDetailsSuccess extends GameDetailsState {
  final GameModel gameDetails;
  GameDetailsSuccess(this.gameDetails);
}

class GameDetailsError extends GameDetailsState {
  final String error;
  GameDetailsError(this.error);
}