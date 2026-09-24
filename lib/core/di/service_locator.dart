import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../networking/dio_factory.dart';
import '../networking/api_service.dart';
import '../../features/games/data/repo/games_repo.dart';
import '../../features/games/presentation/cubit/games_cubit.dart';
import '../../features/auth/data/repos/auth_repo.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  // 1. DioFactory & Dio
  getIt.registerLazySingleton<Dio>(() => DioFactory.getDio());

  // 2. ApiService
  getIt.registerLazySingleton<ApiService>(() => ApiService(getIt<Dio>()));

  // 3. Games Repo & Cubit
  getIt.registerLazySingleton<GamesRepo>(() => GamesRepo(getIt<ApiService>()));
  getIt.registerFactory<GamesCubit>(() => GamesCubit(getIt<GamesRepo>()));

  // 4. Supabase Client
  getIt.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);

  // 5. Auth Repo & Cubit
  getIt.registerLazySingleton<AuthRepo>(() => AuthRepo(getIt<SupabaseClient>()));
  getIt.registerFactory<AuthCubit>(() => AuthCubit(getIt<AuthRepo>()));
}