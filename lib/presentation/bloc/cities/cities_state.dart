import 'package:equatable/equatable.dart';
import 'package:weather_app/domain/entities/cities.dart';

abstract class CitiesState extends Equatable {
  const CitiesState();

  @override
  List<Object?> get props => [];
}

// initial state
class CitiesEmpty extends CitiesState {}

// when getting data from the api
class CitiesLoading extends CitiesState {}

// when data is loaded from the api
class CitiesLoaded extends CitiesState {
  final CitiesEntity result;

  const CitiesLoaded(this.result);

  @override
  List<Object?> get props => [result];
}


// gets error state
class CitiesLoadFailure extends CitiesState {
  final String message;

  const CitiesLoadFailure(this.message);

  @override
  List<Object?> get props => [message];
}