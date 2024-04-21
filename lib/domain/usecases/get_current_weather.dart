import 'package:dartz/dartz.dart';
import 'package:weather_app/core/failure.dart';
import 'package:weather_app/domain/entities/weather.dart';
import 'package:weather_app/domain/repos/weather_repo.dart';

class GetCurrentWeatherUseCase {
  final WeatherRepo weatherRepo;

  GetCurrentWeatherUseCase(this.weatherRepo);

  Future<Either<Failure, WeatherEntity>> execute(String cityName) {
    return weatherRepo.getCurrentWeather(cityName);
  }


}
