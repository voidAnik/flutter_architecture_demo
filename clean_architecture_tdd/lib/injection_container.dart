import 'package:clean_architecture_tdd/core/network/network_info.dart';
import 'package:clean_architecture_tdd/core/util/input_converter.dart';
import 'package:clean_architecture_tdd/features/number_trivia/data/data_sources/number_trivia_local_data_source.dart';
import 'package:clean_architecture_tdd/features/number_trivia/data/data_sources/number_trivia_remote_data_source.dart';
import 'package:clean_architecture_tdd/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:clean_architecture_tdd/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:clean_architecture_tdd/features/number_trivia/domain/use_cases/get_concrete_number_trivia.dart';
import 'package:clean_architecture_tdd/features/number_trivia/domain/use_cases/get_random_number_trivia.dart';
import 'package:clean_architecture_tdd/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  //! Features - Number Trivia Feature
  // * Bloc
  getIt.registerFactory(() => NumberTriviaBloc(
        getConcreteNumberTrivia: getIt(),
        getRandomNumberTrivia: getIt(),
        inputConverter: getIt(),
      ));

  // * Use Cases
  getIt
    ..registerLazySingleton(() => GetConcreteNumberTrivia(getIt()))
    ..registerLazySingleton(() => GetRandomNumberTrivia(getIt()));

  // * Repository
  getIt.registerLazySingleton<NumberTriviaRepository>(
      () => NumberTriviaRepositoryImpl(
            localDataSource: getIt(),
            remoteDataSource: getIt(),
            networkInfo: getIt(),
          ));

  // * Data Sources
  getIt
    ..registerLazySingleton<NumberTriviaLocalDataSource>(
        () => NumberTriviaLocalDataSourceImpl(
              sharedPreferences: getIt(),
            ))
    ..registerLazySingleton<NumberTriviaRemoteDataSource>(
        () => NumberTriviaRemoteDataSourceImpl(
              client: getIt(),
            ));

  //! Core
  getIt
    ..registerLazySingleton(() => InputConverter())
    ..registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt
    ..registerLazySingleton<SharedPreferences>(() => sharedPreferences)
    ..registerLazySingleton(() => http.Client())
    ..registerLazySingleton(() => InternetConnectionChecker());
}
