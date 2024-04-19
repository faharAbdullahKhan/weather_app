import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'weather.g.dart';

@HiveType(typeId: 0)
class WeatherEntity extends Equatable{
  @HiveField(0)
  final String cityName;
  @HiveField(1)
  final String main;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final String iconCode;
  @HiveField(4)
  final double temperature;
  @HiveField(5)
  final int pressure ;
  @HiveField(6)
  final int humidity;

  const WeatherEntity({required this.cityName, required this.main, required this.description, required this.iconCode, required this.temperature, required this.pressure, required this.humidity});

  @override
  // TODO: implement props
  List<Object?> get props => [
    cityName,
    main,
    description,
    iconCode,
    temperature,
    pressure,
    humidity
  ];







}