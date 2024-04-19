import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/data/models/weather_model.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('Store and update weather data in Hive', () async {
    Hive.registerAdapter(WeatherModelAdapter());

    // Initialize Hive
    Hive.init('test_path'); // Use a temporary path for testing

    // Open a Hive box for storing weather data
    final box = await Hive.openBox<WeatherModel>('weatherData');

    // Define initial weather data
    const initialWeatherData = WeatherModel(
      cityName: 'City1',
      temperature: 25.0,
      main: '',
      description: '',
      iconCode: '',
      pressure: 0,
      humidity: 0,
    );

    // Store initial weather data in Hive
    await box.put('city1', initialWeatherData);

    // Retrieve weather data from Hive
    final storedWeatherData = box.get('city1');

    // Verify that stored data matches initial data
    expect(storedWeatherData, equals(initialWeatherData));

    // Define updated weather data
    const updatedWeatherData = WeatherModel(
      cityName: 'City1',
      temperature: 25.0,
      main: '',
      description: '',
      iconCode: '',
      pressure: 0,
      humidity: 0,
    );

    // Update weather data in Hive
    await box.put('city1', updatedWeatherData);

    // Retrieve updated weather data from Hive
    final updatedStoredWeatherData = box.get('city1');

    // Verify that updated data matches new data
    expect(updatedStoredWeatherData, equals(updatedWeatherData));

    // Close the Hive box and delete Hive directory
    await box.close();
    await Hive.deleteFromDisk();
  });
}
