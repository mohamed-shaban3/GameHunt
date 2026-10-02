import 'package:gamehunt/core/database/sqflite_helper.dart';
import 'package:gamehunt/features/favorites/data/datasources/favorites_local_data_source.dart';
import 'package:gamehunt/features/favorites/data/repositories/favorites_repository_impl.dart';
import 'package:gamehunt/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:gamehunt/features/games/presentation/cubit/game_details_cubit.dart';
import 'package:gamehunt/features/games/presentation/cubit/search_cubit.dart';
import 'package:gamehunt/features/notifications/data/datasources/notifications_local_data_source.dart';
import 'package:gamehunt/features/notifications/data/repo/notifications_repository.dart';
import 'package:gamehunt/features/notifications/presentation/cubit/notifications_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../networking/dio_factory.dart';
import '../networking/api_service.dart';
import '../../features/games/data/repo/games_repo.dart';
import '../../features/games/presentation/cubit/games_cubit.dart';
import '../../features/auth/data/repos/auth_repo.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';

import 'package:gamehunt/core/utils/push_notification_service.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  // 1. DioFactory & Dio
  getIt.registerLazySingleton<Dio>(() => DioFactory.getDio());

  // 2. ApiService
  getIt.registerLazySingleton<ApiService>(() => ApiService(getIt<Dio>()));

  // 3. Games Repo & Cubit
  getIt.registerLazySingleton<GamesRepo>(() => GamesRepo(getIt<ApiService>()));
  getIt.registerFactory<GamesCubit>(() => GamesCubit(getIt<GamesRepo>()));
  getIt.registerFactory<GameDetailsCubit>(() => GameDetailsCubit(getIt<GamesRepo>()));
  getIt.registerFactory<SearchCubit>(() => SearchCubit(getIt<GamesRepo>()));

  // 4. Supabase Client
  getIt.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);

  // 5. Auth Repo & Cubit
  getIt.registerLazySingleton<AuthRepo>(() => AuthRepo(getIt<SupabaseClient>()));
  getIt.registerFactory<AuthCubit>(() => AuthCubit(getIt<AuthRepo>()));

// Sqflite Helper
getIt.registerLazySingleton<SqfliteHelper>(() => SqfliteHelper());

// Favorites Local Data Source
getIt.registerLazySingleton<FavoritesLocalDataSource>(
  () => FavoritesLocalDataSourceImpl(getIt<SqfliteHelper>()),
);

// Favorites Repository
getIt.registerLazySingleton<FavoritesRepository>(
  () => FavoritesRepositoryImpl(getIt<FavoritesLocalDataSource>()),
);

// Favorites Cubit 
getIt.registerLazySingleton<FavoritesCubit>(
  () => FavoritesCubit(getIt()),
);

getIt.registerLazySingleton<PushNotificationService>(
  () => PushNotificationService(getIt<SqfliteHelper>()),
);
// Notifications Local Data Source & Repository
getIt.registerLazySingleton<NotificationsLocalDataSource>(
  () => NotificationsLocalDataSourceImpl(getIt<SqfliteHelper>()),
);

getIt.registerLazySingleton<NotificationsRepository>(
  () => NotificationsRepositoryImpl(getIt<NotificationsLocalDataSource>()),
);
// Notifications Cubit
getIt.registerLazySingleton<NotificationsCubit>(
  () => NotificationsCubit(getIt<NotificationsRepository>()),
);
}