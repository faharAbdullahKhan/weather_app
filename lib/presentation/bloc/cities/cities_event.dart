import 'package:equatable/equatable.dart';

abstract class CitiesEvent extends Equatable {
  const CitiesEvent();

  @override
  List<Object?> get props => [];
}

class OnCountryChanged extends CitiesEvent {
  final String countryName;

  const OnCountryChanged({required this.countryName});


  @override
  List<Object?> get props => [countryName];
}