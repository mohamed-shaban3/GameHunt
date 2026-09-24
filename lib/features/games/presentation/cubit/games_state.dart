import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/game_model.dart';

part 'games_state.freezed.dart';

@freezed
class GamesState with _$GamesState {
  const factory GamesState.initial() = _Initial;
  
  // حالة التحميل لأول مرة
  const factory GamesState.gamesLoading() = GamesLoading;
  
  // حالة النجاح وبنمرر فيها قائمة الألعاب
  const factory GamesState.gamesSuccess(List<GameModel> games) = GamesSuccess;
  
  // حالة الخطأ
  const factory GamesState.gamesError(String error) = GamesError;
  
  // حالات الـ Pagination (هنحتاجها بعدين للـ Infinite Scroll)
  const factory GamesState.gamesPaginationLoading() = GamesPaginationLoading;
  const factory GamesState.gamesPaginationError(String error) = GamesPaginationError;
}