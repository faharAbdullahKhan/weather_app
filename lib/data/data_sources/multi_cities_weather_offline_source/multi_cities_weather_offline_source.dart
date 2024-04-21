import 'package:hive_flutter/adapters.dart';
import 'package:weather_app/data/models/weather_model.dart';
import 'package:weather_app/utils/logs.dart';

class MultiCitiesOfflineDataSource{
  Future<void> openMultiCitiesWeatherBoxes() async {
    // Open boxes for each city
    await Hive.openBox<List<WeatherModel>>('MultiCitiesWeatherData_city1');
    await Hive.openBox<List<WeatherModel>>('MultiCitiesWeatherData_city2');
    // Open boxes for other cities as needed
  }
  Future<void> storeMultiCitiesWeatherData(String cityName, WeatherModel weatherData) async {
    var box = await Hive.openBox<WeatherModel>('MultiCitiesWeatherData_$cityName');
    box.put('data', weatherData);
  }

  Future<WeatherModel> getMultiCitiesWeatherData(String cityName) async {
    var box = await Hive.openBox<WeatherModel>('MultiCitiesWeatherData_$cityName');
    var result = box.get('data');
    if(result != null){

        logs('City: ${result.cityName}');
        logs('Main: ${result.main}');
        logs('Description: ${result.description}');
        logs('Icon code: ${result.iconCode}');
        logs('Temperature: ${result.temperature}');
        logs('Pressure: ${result.pressure}');
        logs('Humidity: ${result.humidity}');


      return result;


    }else{
      throw Exception('Weather data not found for $cityName');

    }
  }

  Future<bool> checkIfBoxIsEmpty (String cityName) async {
    var box = await Hive.openBox<WeatherModel>('MultiCitiesWeatherData_$cityName');
    if(box.isEmpty){
      return false;
    }else{
      return true;
    }

  }

}