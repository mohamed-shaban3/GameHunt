// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'games_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GamesState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GamesState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GamesState()';
}


}

/// @nodoc
class $GamesStateCopyWith<$Res>  {
$GamesStateCopyWith(GamesState _, $Res Function(GamesState) __);
}


/// Adds pattern-matching-related methods to [GamesState].
extension GamesStatePatterns on GamesState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( GamesLoading value)?  gamesLoading,TResult Function( GamesSuccess value)?  gamesSuccess,TResult Function( GamesError value)?  gamesError,TResult Function( GamesPaginationLoading value)?  gamesPaginationLoading,TResult Function( GamesPaginationError value)?  gamesPaginationError,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case GamesLoading() when gamesLoading != null:
return gamesLoading(_that);case GamesSuccess() when gamesSuccess != null:
return gamesSuccess(_that);case GamesError() when gamesError != null:
return gamesError(_that);case GamesPaginationLoading() when gamesPaginationLoading != null:
return gamesPaginationLoading(_that);case GamesPaginationError() when gamesPaginationError != null:
return gamesPaginationError(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( GamesLoading value)  gamesLoading,required TResult Function( GamesSuccess value)  gamesSuccess,required TResult Function( GamesError value)  gamesError,required TResult Function( GamesPaginationLoading value)  gamesPaginationLoading,required TResult Function( GamesPaginationError value)  gamesPaginationError,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case GamesLoading():
return gamesLoading(_that);case GamesSuccess():
return gamesSuccess(_that);case GamesError():
return gamesError(_that);case GamesPaginationLoading():
return gamesPaginationLoading(_that);case GamesPaginationError():
return gamesPaginationError(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( GamesLoading value)?  gamesLoading,TResult? Function( GamesSuccess value)?  gamesSuccess,TResult? Function( GamesError value)?  gamesError,TResult? Function( GamesPaginationLoading value)?  gamesPaginationLoading,TResult? Function( GamesPaginationError value)?  gamesPaginationError,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case GamesLoading() when gamesLoading != null:
return gamesLoading(_that);case GamesSuccess() when gamesSuccess != null:
return gamesSuccess(_that);case GamesError() when gamesError != null:
return gamesError(_that);case GamesPaginationLoading() when gamesPaginationLoading != null:
return gamesPaginationLoading(_that);case GamesPaginationError() when gamesPaginationError != null:
return gamesPaginationError(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  gamesLoading,TResult Function( List<GameModel> games)?  gamesSuccess,TResult Function( String error)?  gamesError,TResult Function()?  gamesPaginationLoading,TResult Function( String error)?  gamesPaginationError,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case GamesLoading() when gamesLoading != null:
return gamesLoading();case GamesSuccess() when gamesSuccess != null:
return gamesSuccess(_that.games);case GamesError() when gamesError != null:
return gamesError(_that.error);case GamesPaginationLoading() when gamesPaginationLoading != null:
return gamesPaginationLoading();case GamesPaginationError() when gamesPaginationError != null:
return gamesPaginationError(_that.error);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  gamesLoading,required TResult Function( List<GameModel> games)  gamesSuccess,required TResult Function( String error)  gamesError,required TResult Function()  gamesPaginationLoading,required TResult Function( String error)  gamesPaginationError,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case GamesLoading():
return gamesLoading();case GamesSuccess():
return gamesSuccess(_that.games);case GamesError():
return gamesError(_that.error);case GamesPaginationLoading():
return gamesPaginationLoading();case GamesPaginationError():
return gamesPaginationError(_that.error);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  gamesLoading,TResult? Function( List<GameModel> games)?  gamesSuccess,TResult? Function( String error)?  gamesError,TResult? Function()?  gamesPaginationLoading,TResult? Function( String error)?  gamesPaginationError,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case GamesLoading() when gamesLoading != null:
return gamesLoading();case GamesSuccess() when gamesSuccess != null:
return gamesSuccess(_that.games);case GamesError() when gamesError != null:
return gamesError(_that.error);case GamesPaginationLoading() when gamesPaginationLoading != null:
return gamesPaginationLoading();case GamesPaginationError() when gamesPaginationError != null:
return gamesPaginationError(_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements GamesState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GamesState.initial()';
}


}




/// @nodoc


class GamesLoading implements GamesState {
  const GamesLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GamesLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GamesState.gamesLoading()';
}


}




/// @nodoc


class GamesSuccess implements GamesState {
  const GamesSuccess(final  List<GameModel> games): _games = games;
  

 final  List<GameModel> _games;
 List<GameModel> get games {
  if (_games is EqualUnmodifiableListView) return _games;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_games);
}


/// Create a copy of GamesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GamesSuccessCopyWith<GamesSuccess> get copyWith => _$GamesSuccessCopyWithImpl<GamesSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GamesSuccess&&const DeepCollectionEquality().equals(other._games, _games));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_games));

@override
String toString() {
  return 'GamesState.gamesSuccess(games: $games)';
}


}

/// @nodoc
abstract mixin class $GamesSuccessCopyWith<$Res> implements $GamesStateCopyWith<$Res> {
  factory $GamesSuccessCopyWith(GamesSuccess value, $Res Function(GamesSuccess) _then) = _$GamesSuccessCopyWithImpl;
@useResult
$Res call({
 List<GameModel> games
});




}
/// @nodoc
class _$GamesSuccessCopyWithImpl<$Res>
    implements $GamesSuccessCopyWith<$Res> {
  _$GamesSuccessCopyWithImpl(this._self, this._then);

  final GamesSuccess _self;
  final $Res Function(GamesSuccess) _then;

/// Create a copy of GamesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? games = null,}) {
  return _then(GamesSuccess(
null == games ? _self._games : games // ignore: cast_nullable_to_non_nullable
as List<GameModel>,
  ));
}


}

/// @nodoc


class GamesError implements GamesState {
  const GamesError(this.error);
  

 final  String error;

/// Create a copy of GamesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GamesErrorCopyWith<GamesError> get copyWith => _$GamesErrorCopyWithImpl<GamesError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GamesError&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'GamesState.gamesError(error: $error)';
}


}

/// @nodoc
abstract mixin class $GamesErrorCopyWith<$Res> implements $GamesStateCopyWith<$Res> {
  factory $GamesErrorCopyWith(GamesError value, $Res Function(GamesError) _then) = _$GamesErrorCopyWithImpl;
@useResult
$Res call({
 String error
});




}
/// @nodoc
class _$GamesErrorCopyWithImpl<$Res>
    implements $GamesErrorCopyWith<$Res> {
  _$GamesErrorCopyWithImpl(this._self, this._then);

  final GamesError _self;
  final $Res Function(GamesError) _then;

/// Create a copy of GamesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(GamesError(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class GamesPaginationLoading implements GamesState {
  const GamesPaginationLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GamesPaginationLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GamesState.gamesPaginationLoading()';
}


}




/// @nodoc


class GamesPaginationError implements GamesState {
  const GamesPaginationError(this.error);
  

 final  String error;

/// Create a copy of GamesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GamesPaginationErrorCopyWith<GamesPaginationError> get copyWith => _$GamesPaginationErrorCopyWithImpl<GamesPaginationError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GamesPaginationError&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'GamesState.gamesPaginationError(error: $error)';
}


}

/// @nodoc
abstract mixin class $GamesPaginationErrorCopyWith<$Res> implements $GamesStateCopyWith<$Res> {
  factory $GamesPaginationErrorCopyWith(GamesPaginationError value, $Res Function(GamesPaginationError) _then) = _$GamesPaginationErrorCopyWithImpl;
@useResult
$Res call({
 String error
});




}
/// @nodoc
class _$GamesPaginationErrorCopyWithImpl<$Res>
    implements $GamesPaginationErrorCopyWith<$Res> {
  _$GamesPaginationErrorCopyWithImpl(this._self, this._then);

  final GamesPaginationError _self;
  final $Res Function(GamesPaginationError) _then;

/// Create a copy of GamesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(GamesPaginationError(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
