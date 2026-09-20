import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repo/games_repo.dart';

part 'games_state.dart';

class GamesCubit extends Cubit<GamesState> {
  final GamesRepo _gamesRepo;

  GamesCubit(this._gamesRepo) : super(GamesInitial());

  void getGames({String? search}) async {
    emit(GamesLoading());
    try {
      final response = await _gamesRepo.getGames(search: search);
      final List<dynamic> games = response['results'] ?? [];
      emit(GamesSuccess(games));
    } catch (error) {
      emit(GamesError(error.toString()));
    }
  }
}