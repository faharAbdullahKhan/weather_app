import 'package:equatable/equatable.dart';
import 'package:weather_app/domain/entities/weather.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object?> get props => [];
}

// initial state
class WeatherEmpty extends WeatherState {}

// when getting data from the api
class WeatherLoading extends WeatherState {}

// when data is loaded from the api
class WeatherLoaded extends WeatherState {
  final WeatherEntity result;

  const WeatherLoaded(this.result);

  @override
  List<Object?> get props => [result];
}


// gets error state
class WeatherLoadFailure extends WeatherState {
  final String message;

  const WeatherLoadFailure(this.message);

  @override
  List<Object?> get props => [message];
}