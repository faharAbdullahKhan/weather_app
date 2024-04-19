import 'package:dartz/dartz.dart';
import 'package:weather_app/core/failure.dart';
import 'package:weather_app/domain/entities/cities.dart';

abstract class CitiesRepo {
  //Either for handling errors
  Future<Either<Failure, CitiesEntity>> getCities(String countryName);
}
