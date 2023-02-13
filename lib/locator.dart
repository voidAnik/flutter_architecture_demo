import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mvvm/repository/auth_repository.dart';
import 'package:mvvm/repository/home_repository.dart';
import 'package:mvvm/view_model/home_view_model.dart';
import 'package:mvvm/view_model/login_view_model.dart';
import 'package:mvvm/view_model/services/splash_services.dart';
import 'package:mvvm/view_model/user_session_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/retro/client/retro_client.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepository());
  getIt.registerLazySingleton<HomeRepository>(() => HomeRepository());
  getIt.registerLazySingleton<SplashServices>(() => SplashServices());
  getIt.registerFactory<HomeViewModel>(() => HomeViewModel());
  getIt.registerFactory<LoginViewModel>(() => LoginViewModel());
  getIt.registerFactory<UserSessionViewModel>(() => UserSessionViewModel());
  getIt.registerLazySingleton<RetroClient>(() => RetroClient(Dio()));
  getIt.registerLazySingletonAsync<SharedPreferences>(
      () => SharedPreferences.getInstance());
}
