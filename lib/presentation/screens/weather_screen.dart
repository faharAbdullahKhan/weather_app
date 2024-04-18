import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/constants/constants.dart';
import 'package:weather_app/presentation/bloc/weather_bloc.dart';
import 'package:weather_app/presentation/bloc/weather_event.dart';
import 'package:weather_app/presentation/bloc/weather_state.dart';
import 'package:weather_app/widgets/app_textfield.dart';
import 'package:weather_app/widgets/big_text.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BigText(
          text: "Weather",
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              if (state is WeatherLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is WeatherLoaded) {
                return Column(
                  key: const Key('weather_data'),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BigText(
                          text: state.result.cityName,
                          size: 22,
                        ),
                        Image(
                          image: NetworkImage(
                            Constants.weatherIcon(
                              state.result.iconCode,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    BigText(
                      text:'${state.result.main} | ${state.result.description}',
                        size: 16.0,
                    ),
                    const SizedBox(height: 24.0),
                    Table(
                      defaultColumnWidth: const FixedColumnWidth(150.0),
                      border: TableBorder.all(
                        color: Colors.grey,
                        style: BorderStyle.solid,
                        width: 1,
                      ),
                      children: [
                        TableRow(children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Temperature',
                              style: TextStyle(
                                fontSize: 16.0,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              state.result.temperature.toString(),
                              style: const TextStyle(
                                fontSize: 16.0,
                                letterSpacing: 1.2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ), // Will be change later
                        ]),
                        TableRow(children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Pressure',
                              style: TextStyle(
                                fontSize: 16.0,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              state.result.pressure.toString(),
                              style: const TextStyle(
                                  fontSize: 16.0,
                                  letterSpacing: 1.2,
                                  fontWeight: FontWeight.bold),
                            ),
                          ), // Will be change later
                        ]),
                        TableRow(children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Humidity',
                              style: TextStyle(
                                fontSize: 16.0,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              state.result.humidity.toString(),
                              style: const TextStyle(
                                fontSize: 16.0,
                                letterSpacing: 1.2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ), // Will be change later
                        ]),
                      ],
                    ),
                  ],
                );
              }
              if (state is WeatherLoadFailure) {
                return Center(
                  child: Text(state.message),
                );
              }
              return Container();
            },
          )
        ],
      ),
    );
  }
}
