import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:weather_app/core/failure.dart';
import 'package:weather_app/data/data_sources/offline_data_source.dart';
import 'package:weather_app/data/data_sources/remote_data_source.dart';
import 'package:weather_app/domain/entities/weather.dart';
import 'package:weather_app/domain/repos/weather_repo.dart';

import '../../core/error/exceptions.dart';

class WeatherRepoImpl extends WeatherRepo {
  final WeatherRemoteDataSource weatherRemoteDataSource;
  WeatherRepoImpl({required this.weatherRemoteDataSource});

  @override
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(
      String cityName) async {
    try {
      final result = await weatherRemoteDataSource.getCurrentWeather(cityName);
      OfflineDataSource().storeWeatherData(cityName, result);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure('An error has occurred'));
    } on SocketException {
      try {
        final offlineResult =
            await OfflineDataSource().getWeatherData(cityName);
        if (offlineResult != null) {
          return Right(offlineResult.toEntity());
        } else {
          return Left(ConnectionFailure('Failed to connect to the network'));
        }
      } catch (e) {
        return Left(OfflineFailure('Failed to retrieve offline weather data'));
      }
    }
  }
}
