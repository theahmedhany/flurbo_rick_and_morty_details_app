import 'package:dio/dio.dart';
import '../business_logic/cubit/characters_cubit.dart';
import '../data/api/characters_web_services.dart';
import '../data/repos/characters_repo.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void initGetIt() {
  getIt.registerLazySingleton<CharactersCubit>(() => CharactersCubit(getIt()));
  getIt.registerLazySingleton<CharactersRepo>(() => CharactersRepo(getIt()));
  getIt.registerLazySingleton<CharactersWebServices>(
    () => CharactersWebServices(CreateAndSetupDio()),
  );
}

// ignore: non_constant_identifier_names
Dio CreateAndSetupDio() {
  Dio dio = Dio();

  dio
    ..options.connectTimeout = const Duration(seconds: 1)
    ..options.receiveTimeout = const Duration(seconds: 10);

  dio.interceptors.add(LogInterceptor(
    request: true,
    requestHeader: false,
    requestBody: true,
    responseHeader: false,
    responseBody: true,
    error: true,
  ));

  return dio;
}
