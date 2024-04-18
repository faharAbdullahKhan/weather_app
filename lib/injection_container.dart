import 'package:get_it/get_it.dart';
import 'package:weather_app/data/data_sources/remote_data_source.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/data/repos/weather_repo_impl.dart';
import 'package:weather_app/domain/repos/weather_repo.dart';
import 'package:weather_app/domain/usecases/get_current_weather.dart';

import 'presentation/bloc/weather_bloc.dart';

final locator = GetIt.instance;

void setupLocator() {

  // bloc
  locator.registerFactory(() => WeatherBloc(locator()));

  // usecase
  locator.registerLazySingleton(() => GetCurrentWeatherUseCase(locator()));

  // repository
  locator.registerLazySingleton<WeatherRepo>(
        () => WeatherRepoImpl (
        weatherRemoteDataSource: locator()
    ),
  );

  // data source
  locator.registerLazySingleton<WeatherRemoteDataSource>(
        () => WeatherRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // external
  locator.registerLazySingleton(() => http.Client());



}