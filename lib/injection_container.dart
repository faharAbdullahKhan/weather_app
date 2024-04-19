import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/data/data_sources/list_of_cities_data_remote_source/list_of_cities_remote_data_source.dart';
import 'package:weather_app/data/data_sources/weather_data_source/remote_data_source.dart';
import 'package:weather_app/data/repos/cities_repo_impl.dart';
import 'package:weather_app/data/repos/weather_repo_impl.dart';
import 'package:weather_app/domain/repos/cities_repo.dart';
import 'package:weather_app/domain/repos/weather_repo.dart';
import 'package:weather_app/domain/usecases/get_cities.dart';
import 'package:weather_app/domain/usecases/get_current_weather.dart';
import 'package:weather_app/presentation/bloc/cities/cities_bloc.dart';

import 'presentation/bloc/weather_bloc.dart';

final locator = GetIt.instance;

void setupLocator() {
  // bloc
  locator.registerFactory(() => WeatherBloc(locator()));
  locator.registerFactory(() => CitiesBloc(locator(), locator()));

  // usecase
  locator.registerLazySingleton(() => GetCurrentWeatherUseCase(locator()));
  locator.registerLazySingleton(() => GetCitiesUseCase(locator()));

  // repository
  locator.registerLazySingleton<WeatherRepo>(
    () => WeatherRepoImpl(weatherRemoteDataSource: locator()),
  );
  locator.registerLazySingleton<CitiesRepo>(
    () => CitiesRepoImpl(citiesRemoteDataSource: locator()),
  );

  // data source
  locator.registerLazySingleton<WeatherRemoteDataSource>(
    () => WeatherRemoteDataSourceImpl(
      client: locator(),
    ),
  );
  locator.registerLazySingleton<CitiesRemoteDataSource>(
    () => CitiesRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // external
  locator.registerLazySingleton(() => http.Client());
}
