import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/core/constants/constants.dart';
import 'package:weather_app/data/data_sources/list_of_cities_data_remote_source/cities_offline_data_source.dart';
import 'package:weather_app/data/data_sources/multi_cities_weather_offline_source/multi_cities_weather_offline_source.dart';
import 'package:weather_app/data/models/cities_model.dart';
import 'package:weather_app/data/models/weather_model.dart';
import 'package:weather_app/utils/logs.dart';

class MultiCitiesWeatherBloc {
  final _weatherStreamController = StreamController<List<WeatherModel>>();
  Stream<List<WeatherModel>> get weatherStream =>
      _weatherStreamController.stream;

  final int citiesPerPage = 10;
  int currentPage = 1;
  List<String> cities = [];

  Future<List<String>> getCities({int page = 1, int pageSize = 10}) async {
    // Calculate the start index based on the page and page size
    CitiesModel cities =
    await CitiesOfflineDataSource().getCitiesData("United Arab Emirates");

    int startIndex = (page - 1) * pageSize;
    // Calculate the end index
    int endIndex = startIndex + pageSize;
    // Return a sublist of cities
    return cities.data.sublist(startIndex, endIndex);
  }
  Future<void> fetchWeather() async {
    List<WeatherModel> weatherList = [];

    CitiesModel cities =
        await CitiesOfflineDataSource().getCitiesData("United Arab Emirates");
    if(await MultiCitiesOfflineDataSource().checkIfBoxIsEmpty("cities.toEntity().data[i]")){

      for (int i = 0; i < cities.toEntity().data.length; i++) {
        final offlineResult = await MultiCitiesOfflineDataSource().getMultiCitiesWeatherData(cities.toEntity().data[i]);
        weatherList.add(offlineResult);

      }
    }else{
      logs("this is cities $cities");
      for (int i = 0; i < cities.toEntity().data.length; i++) {
        logs("cities $cities");
        try {
          final response = await http.get(Uri.parse(
              Constants.currentWeatherByName(cities.toEntity().data[i])));
          logs("status ${response.statusCode}");
          if (response.statusCode == 200) {
            final jsonData = json.decode(response.body);
            final weather = WeatherModel.fromJson(jsonData);
            weatherList.add(weather);
            MultiCitiesOfflineDataSource()
                .storeMultiCitiesWeatherData(cities.toEntity().data[i], weather);

            logs("weather list ${weatherList.length}");
          } else {
            logs('Failed to fetch weather for $cities: ${response.statusCode}');
          }
        } catch (e) {
          logs('Failed to fetch weather for $cities: $e');
        }
      }

    }
    logs("this is weather ${MultiCitiesOfflineDataSource().getMultiCitiesWeatherData("cities.toEntity().data[i]")}");
    _weatherStreamController.sink.add(weatherList);
  }

  void nextPage() {
    logs("nexr page");
    // currentPage++;
    // fetchWeather();
  }

  void dispose() {
    _weatherStreamController.close();
  }
}
