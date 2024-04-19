import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/domain/usecases/get_current_weather.dart';
import 'package:rxdart/rxdart.dart';
import 'package:weather_app/presentation/bloc/weather_event.dart';
import 'package:weather_app/presentation/bloc/weather_state.dart';


class WeatherBloc extends Bloc<WeatherEvent,WeatherState> {

  final GetCurrentWeatherUseCase _getCurrentWeatherUseCase;
  WeatherBloc(this._getCurrentWeatherUseCase) : super(WeatherEmpty()) {
    on<OnCityChanged>(
          (event, emit) async {

        emit(WeatherLoading());
        final result = await _getCurrentWeatherUseCase.execute(event.cityName);
        // fold method is from either
        result.fold(
              (failure) {
                print("failure $failure");
            emit(WeatherLoadFailure(failure.message));
          },
              (data) {
            emit(WeatherLoaded(data));
          },
        );
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}