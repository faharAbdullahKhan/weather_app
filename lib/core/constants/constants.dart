class Constants {
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5';
  static const String apiKey = 'fc13941be5263a7be6b1c64a9e945251';

  static String currentWeatherByName(String city) =>
      '$baseUrl/weather?q=$city&appid=$apiKey&units=metric';

  static String weatherIcon(String iconCode) =>
      'http://openweathermap.org/img/wn/$iconCode@2x.png';
}
