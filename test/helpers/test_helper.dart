import 'package:mockito/annotations.dart';
import 'package:weather_app/data/data_sources/list_of_cities_data_remote_source/list_of_cities_remote_data_source.dart';
import 'package:weather_app/data/data_sources/weather_data_source/remote_data_source.dart';
import 'package:weather_app/domain/repos/cities_repo.dart';
import 'package:weather_app/domain/repos/weather_repo.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/domain/usecases/get_cities.dart';
import 'package:weather_app/domain/usecases/get_current_weather.dart';

@GenerateMocks([WeatherRepo, WeatherRemoteDataSource, GetCurrentWeatherUseCase, GetCitiesUseCase, CitiesRepo, CitiesRemoteDataSource],

customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
)
void main() {}
