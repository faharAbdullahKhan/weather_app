

import 'package:hive/hive.dart';
import 'package:weather_app/data/models/cities_model.dart';
import 'package:weather_app/utils/logs.dart';

class CitiesOfflineDataSource{
  Future<void> openCitiesBoxes() async {
    // Open boxes for each city
    await Hive.openBox<CitiesModel>('citiesData_1');
    await Hive.openBox<CitiesModel>('citiesData_2');
    // Open boxes for other cities as needed
  }
  Future<void> storeCitiesData(String country, CitiesModel citiesData) async {
    var box = await Hive.openBox<CitiesModel>('citiesData_$country');
    box.put('data', citiesData);
  }

  Future<CitiesModel> getCitiesData(String country) async {
    var box = await Hive.openBox<CitiesModel>('citiesData_$country');
    var result = box.get('data');
    if(result != null){
      logs('Cities: ${result.data}');
      return result;


    }else{
      throw Exception('Weather data not found for $country');

    }
  }

  Future<bool> checkIfBoxIsEmpty (String country) async {
    var box = await Hive.openBox<CitiesModel>('citiesData_$country');
    if(box.isEmpty){
      return false;
    }else{
      return true;
    }

  }
}