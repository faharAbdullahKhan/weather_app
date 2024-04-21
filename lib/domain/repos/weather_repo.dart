import 'package:dartz/dartz.dart';
import 'package:weather_app/core/failure.dart';
import 'package:weather_app/domain/entities/weather.dart';

abstract class WeatherRepo{

  //Either for handling errors
  Future<Either<Failure,WeatherEntity>> getCurrentWeather(String cityName);


}