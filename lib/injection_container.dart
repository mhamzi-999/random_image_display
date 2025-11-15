import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'core/network/api_client.dart';
import 'features/random_image/data/datasources/random_image_remote_data_source.dart';
import 'features/random_image/data/repositories/random_image_repository_impl.dart';
import 'features/random_image/domain/repositories/random_image_repository.dart';
import 'features/random_image/domain/usecases/get_random_image.dart';
import 'features/random_image/presentation/bloc/random_image_bloc.dart';

final sl = GetIt.instance;

/// Registers all dependencies for the application.
Future<void> initInjection() async {
  sl
    ..registerLazySingleton<Dio>(
      () => Dio(
        BaseOptions(
          baseUrl: 'https://november7-730026606190.europe-west1.run.app',
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
      ),
    )
    ..registerLazySingleton<ApiClient>(() => ApiClient(dio: sl()))
    ..registerLazySingleton<RandomImageRemoteDataSource>(
      () => RandomImageRemoteDataSourceImpl(apiClient: sl()),
    )
    ..registerLazySingleton<RandomImageRepository>(
      () => RandomImageRepositoryImpl(remoteDataSource: sl()),
    )
    ..registerLazySingleton(() => GetRandomImage(sl()))
    ..registerFactory(() => RandomImageBloc(getRandomImage: sl()));
}
