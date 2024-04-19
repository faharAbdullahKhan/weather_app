import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:weather_app/data/models/cities_model.dart';
import 'package:weather_app/data/models/weather_model.dart';


class HiveInitializer {
  static Future<void> initialize() async {
    // Get the application documents directory
    final appDocumentDir = await getApplicationDocumentsDirectory();

    // Initialize Hive and specify the directory where Hive boxes will be stored
    Hive.init(appDocumentDir.path);

    // Register Hive adapter for your WeatherModel class
    Hive.registerAdapter(WeatherModelAdapter());
    Hive.registerAdapter(CitiesModelAdapter());

    // Open Hive box to store weather data
    await Hive.openBox<WeatherModel>('weatherBox');
    await Hive.openBox<WeatherModel>('citiesBox');
  }
}