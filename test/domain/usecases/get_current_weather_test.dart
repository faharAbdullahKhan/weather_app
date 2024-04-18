import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/domain/entities/weather.dart';
import 'package:weather_app/domain/usecases/get_current_weather.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetCurrentWeatherUseCase getCurrentWeatherUseCase;
  late MockWeatherRepo mockWeatherRepo;

  // Flutter test has this function.
  //This function runs before every individual test
  setUp(() {
    mockWeatherRepo = MockWeatherRepo();
    getCurrentWeatherUseCase = GetCurrentWeatherUseCase(mockWeatherRepo);
  });

  const testDetail = WeatherEntity(
      cityName: "New York",
      main: "Rainy",
      description: "Clouds",
      iconCode: "02d",
      temperature: 302.28,
      pressure: 1009,
      humidity: 70);

  const testCityName = "New York";

  // To write and run the test we use test method in flutter
  test("get the current weather detail from repo", () async {
    // arrange
    when(mockWeatherRepo.getCurrentWeather(testCityName)).thenAnswer((realInvocation) async => const Right(testDetail) );

    // act
    final result = await getCurrentWeatherUseCase.execute(testCityName);

    // assert
    expect(result, const Right(testDetail));


  });
}
