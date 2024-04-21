import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:weather_app/core/failure.dart';
import 'package:weather_app/data/data_sources/weather_data_source/offline_data_source.dart';
import 'package:weather_app/data/data_sources/weather_data_source/remote_data_source.dart';
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
      if(await OfflineDataSource().checkIfBoxHasData(cityName)){
        final offlineResult =
        await OfflineDataSource().getWeatherData(cityName);
        return Right(offlineResult.toEntity());

      }else{
        final result = await weatherRemoteDataSource.getCurrentWeather(cityName);
        OfflineDataSource().storeWeatherData(cityName, result);
        return Right(result.toEntity());

      }
    } on ServerException {
      return const Left(ServerFailure('An error has occurred'));
    } on SocketException {
      try {
        final offlineResult =
            await OfflineDataSource().getWeatherData(cityName);
        return Right(offlineResult.toEntity());
            } catch (e) {
        return Left(OfflineFailure('Failed to retrieve offline weather data'));
      }
    }
  }


}
