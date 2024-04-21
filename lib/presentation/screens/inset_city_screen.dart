import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/constants/constants.dart';
import 'package:weather_app/presentation/bloc/cities/cities_bloc.dart';
import 'package:weather_app/presentation/bloc/cities/cities_event.dart';
import 'package:weather_app/presentation/bloc/cities/cities_state.dart';
import 'package:weather_app/presentation/bloc/weather_bloc.dart';
import 'package:weather_app/presentation/bloc/weather_event.dart';
import 'package:weather_app/presentation/screens/testing_screen.dart';
import 'package:weather_app/presentation/screens/weather_screen.dart';
import 'package:weather_app/utils/logs.dart';
import 'package:weather_app/utils/utility.dart';
import 'package:weather_app/widgets/app_textfield.dart';
import 'package:weather_app/widgets/big_text.dart';
import 'package:weather_app/widgets/small_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    context.read<CitiesBloc>().add(OnCountryChanged(countryName: "United Arab Emirates"));
    // context.read<MultiCitiesWeatherBloc>().add(OnListOfCities(["Abu Dhabi", "Al Ain", "Al Khan"]));

    return Scaffold(
        appBar: AppBar(
          title: BigText(
            text: "Weather",
          ),
          actions: [
            GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => WeatherPage()));

              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: BigText(text: "Multiple Cities", size: 14,),
              ),
            )
          ],
        ),
        body: BlocBuilder<CitiesBloc, CitiesState>(
          builder: (context, state) {
            if (state is CitiesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is CitiesLoaded) {
              return ListView.builder(
                  key: const Key('cities_data'),
                  shrinkWrap: true,
                  itemCount: state.result.data.length,
                  padding: EdgeInsets.all(20),
                  itemBuilder: (context, index) {
                    return Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: (){
                            context.read<WeatherBloc>().add(OnCityChanged(state.result.data[index]));
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => WeatherScreen()));

                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 3.0),
                            child: BigText(text: state.result.data[index]),
                          ),
                        ),
                        Divider(color: Theme.of(context).primaryColor,)
                      ],
                    );
                  });
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
