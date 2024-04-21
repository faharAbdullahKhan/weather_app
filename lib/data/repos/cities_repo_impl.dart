import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/exceptions.dart';
import 'package:weather_app/core/failure.dart';
import 'package:weather_app/data/data_sources/list_of_cities_data_remote_source/cities_offline_data_source.dart';
import 'package:weather_app/data/data_sources/list_of_cities_data_remote_source/list_of_cities_remote_data_source.dart';
import 'package:weather_app/domain/entities/cities.dart';
import 'package:weather_app/domain/repos/cities_repo.dart';
import 'package:weather_app/utils/logs.dart';

class CitiesRepoImpl extends CitiesRepo {
  final CitiesRemoteDataSource citiesRemoteDataSource;

  CitiesRepoImpl({required this.citiesRemoteDataSource});

  @override
  Future<Either<Failure, CitiesEntity>> getCities(String countryName) async {
    // TODO: implement getCities
    try {
      if(await CitiesOfflineDataSource().checkIfBoxIsEmpty(countryName)){
        final offlineResult =
        await CitiesOfflineDataSource().getCitiesData(countryName);
        logs("from local storage");
        return Right(offlineResult.toEntity());

      }else{
        final result = await citiesRemoteDataSource.getCities(countryName);
        CitiesOfflineDataSource().storeCitiesData(countryName, result);
        return Right(result.toEntity());



      }

        } on ServerException {
      return const Left(ServerFailure('An error has occurred'));
    } on SocketException {
      try {
        final offlineResult =
        await CitiesOfflineDataSource().getCitiesData(countryName);
        logs("off CitiesRepoImpl $offlineResult");

        return Right(offlineResult.toEntity());
            } catch (e) {
        return Left(OfflineFailure('Failed to retrieve offline weather data'));
      }
    }

  }

}