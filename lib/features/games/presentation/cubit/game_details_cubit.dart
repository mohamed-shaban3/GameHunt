import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/networking/api_result.dart';
import '../../data/models/game_model.dart';
import '../../data/repo/games_repo.dart';
import 'game_details_state.dart';

class GameDetailsCubit extends Cubit<GameDetailsState> {
  final GamesRepo _gamesRepo;

  GameDetailsCubit(this._gamesRepo) : super(GameDetailsInitial());

  void getGameDetails(int gameId) async {
    emit(GameDetailsLoading());
    final response = await _gamesRepo.getGameDetails(gameId);

    // إضافة <GameModel> للتعرف على نوع البيانات
    if (response is Success<GameModel>) {
      emit(GameDetailsSuccess(response.data)); 
    } 
    // إضافة <GameModel> واستخدام .failure بدلاً من .message
    else if (response is Failure<GameModel>) {
      emit(GameDetailsError(response.failure)); 
    }
  }
}