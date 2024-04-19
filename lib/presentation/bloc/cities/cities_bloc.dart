import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:weather_app/domain/usecases/get_cities.dart';
import 'package:weather_app/domain/usecases/get_current_weather.dart';
import 'package:weather_app/presentation/bloc/cities/cities_event.dart';
import 'package:weather_app/presentation/bloc/cities/cities_state.dart';
import 'package:weather_app/utils/logs.dart';

class CitiesBloc extends Bloc<CitiesEvent,CitiesState> {

  final GetCitiesUseCase _getCitiesUseCase;
  final GetCurrentWeatherUseCase _getCurrentWeatherUseCase;
  CitiesBloc(this._getCitiesUseCase, this._getCurrentWeatherUseCase) : super(CitiesEmpty()) {
    on<OnCountryChanged>(
          (event, emit) async {

        emit(CitiesLoading());
        final result = await _getCitiesUseCase.execute(event.countryName);
        logs("CitiesBloc $result");
        // fold method is from either
        result.fold(
              (failure) {
            logs("failure $failure");
            emit(CitiesLoadFailure(failure.message));
          },
              (data) {
            emit(CitiesLoaded(data));
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