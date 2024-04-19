import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/utils/utility.dart';

void main() {
  test('Celsius to Fahrenheit conversion test', () {
    // Test case 1: Test with freezing point of water (0°C)
    expect(AppUtility.celsiusToFahrenheit(0), 32);

    // Test case 2: Test with boiling point of water (100°C)
    expect(AppUtility.celsiusToFahrenheit(100), 212);

    // Test case 3: Test with a negative temperature (-10°C)
    expect(AppUtility.celsiusToFahrenheit(-10), 14);

  });
}