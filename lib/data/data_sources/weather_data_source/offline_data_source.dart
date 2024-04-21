import 'package:hive/hive.dart';
import 'package:weather_app/data/models/weather_model.dart';
import 'package:weather_app/utils/logs.dart';

class OfflineDataSource{
  Future<void> openWeatherBoxes() async {
    // Open boxes for each city
    await Hive.openBox<WeatherModel>('weatherData_city1');
    await Hive.openBox<WeatherModel>('weatherData_city2');
    // Open boxes for other cities as needed
  }
  Future<void> storeWeatherData(String cityName, WeatherModel weatherData) async {
    var box = await Hive.openBox<WeatherModel>('weatherData_$cityName');
    box.put('data', weatherData);
  }

  Future<WeatherModel> getWeatherData(String cityName) async {
    var box = await Hive.openBox<WeatherModel>('weatherData_$cityName');
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

  Future<bool> checkIfBoxHasData(String cityName) async{
    var box = await Hive.openBox<WeatherModel>('weatherData_$cityName');
    if(box.isEmpty){
      return false;
    }else{
      return true;
    }
  }
}