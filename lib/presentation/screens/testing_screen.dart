import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/constants/constants.dart';
import 'package:weather_app/data/models/weather_model.dart';
import 'package:weather_app/presentation/bloc/cities/cities_bloc.dart';
import 'package:weather_app/presentation/bloc/cities/cities_event.dart';
import 'package:weather_app/presentation/bloc/cities/cities_state.dart';
import 'package:weather_app/presentation/bloc/multiple_cities_weather/multi_cities_weather_bloc.dart';
import 'package:weather_app/presentation/bloc/weather_bloc.dart';
import 'package:weather_app/presentation/bloc/weather_event.dart';
import 'package:weather_app/presentation/screens/weather_screen.dart';
import 'package:weather_app/utils/logs.dart';
import 'package:weather_app/utils/utility.dart';
import 'package:weather_app/widgets/app_textfield.dart';
import 'package:weather_app/widgets/big_text.dart';
import 'package:weather_app/widgets/small_text.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final MultiCitiesWeatherBloc _multiCitiesWeatherBloc = MultiCitiesWeatherBloc();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    context.read<CitiesBloc>().add(OnCountryChanged(countryName: "United Arab Emirates"));
    // context.read<MultiCitiesWeatherBloc>().add(OnListOfCities(["Abu Dhabi", "Al Ain", "Al Khan"]));

    return Scaffold(
        appBar: AppBar(
          title: BigText(
            text: "Weather",
          ),
        ),
        body: BlocBuilder<CitiesBloc, CitiesState>(
          builder: (context, state) {
            if (state is CitiesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is CitiesLoaded) {
              logs("state $state");
              _multiCitiesWeatherBloc.fetchWeather();
              // _scrollController.addListener(_onScroll);

              return StreamBuilder<List<WeatherModel>>(
                stream: _multiCitiesWeatherBloc.weatherStream,
                builder: (context, snapshot) {
                  logs("snapshot $snapshot");
                  if (snapshot.hasData) {
                    return ListView.builder(
                      key: const Key('cities_data'),
                      controller: _scrollController,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final weather = snapshot.data![index];
                        return Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: (){
                                context.read<WeatherBloc>().add(OnCityChanged(state.result.data[index]));
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => WeatherScreen()));

                              },
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 3.0),
                                    child: BigText(text: state.result.data[index]),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "${AppUtility.celsiusToFahrenheit(weather.temperature).toInt().toString()} \u00B0F",
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        letterSpacing: 1.2,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                            Divider(color: Theme.of(context).primaryColor,)
                          ],
                        );

                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              );

            }
            if (state is CitiesLoadFailure) {
              return Center(
                child: Text(state.message),
              );
            }
            return Container();
          },
        )

      // Column(
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   children: [
      //     AppTextField(
      //       hintText: "Enter city name",
      //       textInputType: TextInputType.text,
      //       onChanged: (query) {
      //         context.read<WeatherBloc>().add(OnCityChanged(query));
      //         Navigator.of(context).push(MaterialPageRoute(builder: (context) => WeatherScreen()));
      //
      //       },
      //     ),
      //   ],
      // ),
    );
  }
}
