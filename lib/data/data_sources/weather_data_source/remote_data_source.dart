import 'dart:convert';

import 'package:weather_app/core/constants/constants.dart';
import 'package:weather_app/core/error/exceptions.dart';
import 'package:weather_app/data/models/weather_model.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/utils/logs.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getCurrentWeather(String cityName);
}

class WeatherRemoteDataSourceImpl extends WeatherRemoteDataSource {
  final http.Client client;
  WeatherRemoteDataSourceImpl({required this.client});

  @override
  Future<WeatherModel> getCurrentWeather(String cityName) async {
    final response =
    await client.get(Uri.parse(Constants.currentWeatherByName(cityName)));
    logs("response weather ${response.statusCode}");
    logs("response weather ${response.body}");

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }

    // throw UnimplementedError();
  }


}
