// import 'dart:io';
//
// import 'package:flutter_test/flutter_test.dart';
// import 'package:hive/hive.dart';
// import 'package:mockito/mockito.dart';
// import 'package:weather_app/data/models/weather_model.dart';
// import 'package:path_provider/path_provider.dart';
//
// class MockPathProvider extends Mock implements PathProviderPlatform {
//
//   @override
//   Future<String> getTemporaryPath() {
//     // Return a temporary path, for example:
//     return Future.value('/mock/temp');
//   }
// }
//
// void main() {
//   TestWidgetsFlutterBinding.ensureInitialized();
//
//   group('Offline Behavior Test', () {
//     late Box<WeatherModel> city1Box;
//     late Box<WeatherModel> city2Box;
//     late MockPathProvider mockPathProvider;
//
//
//     setUpAll(() async {
//       // Initialize Hive and open boxes
//       mockPathProvider = MockPathProvider();
//       when(mockPathProvider.getTemporaryDirectory())
//           .thenAnswer((_) async => Directory.systemTemp);
//       Hive.init(Directory.systemTemp.path);
//
//       city1Box = await Hive.openBox<WeatherModel>('weatherData_city1');
//       city2Box = await Hive.openBox<WeatherModel>('weatherData_city2');
//     });
//
//     test('Store and retrieve weather data offline', () async {
//       // Simulate storing weather data while offline
//       const weatherDataCity1 = WeatherModel(
//         cityName: 'City1',
//         main: 'Clear',
//         description: 'Clear sky',
//         iconCode: '01d',
//         temperature: 25.0,
//         pressure: 1013,
//         humidity: 60,
//       );
//       const weatherDataCity2 = WeatherModel(
//         cityName: 'City2',
//         main: 'Rain',
//         description: 'Light rain',
//         iconCode: '10n',
//         temperature: 20.0,
//         pressure: 1008,
//         humidity: 70,
//       );
//       await city1Box.put('data', weatherDataCity1);
//       await city2Box.put('data', weatherDataCity2);
//
//       // Simulate retrieving weather data while offline
//       final storedDataCity1 = city1Box.get('data');
//       final storedDataCity2 = city2Box.get('data');
//
//       // Assert that the retrieved data matches the stored data
//       expect(storedDataCity1, equals(weatherDataCity1));
//       expect(storedDataCity2, equals(weatherDataCity2));
//     });
//
//     tearDownAll(() async {
//       // Close boxes and delete Hive directory
//       await city1Box.close();
//       await city2Box.close();
//       Hive.deleteFromDisk();
//     });
//   });
// }
