import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/constants/constants.dart';
import 'package:weather_app/presentation/bloc/weather_bloc.dart';
import 'package:weather_app/presentation/bloc/weather_event.dart';
import 'package:weather_app/presentation/bloc/weather_state.dart';
import 'package:weather_app/presentation/screens/weather_screen.dart';
import 'package:weather_app/widgets/app_textfield.dart';
import 'package:weather_app/widgets/big_text.dart';

class AddCityScreen extends StatelessWidget {
  const AddCityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BigText(
          text: "Weather",
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppTextField(
            hintText: "Enter city name",
            textInputType: TextInputType.text,
            onChanged: (query) {
              context.read<WeatherBloc>().add(OnCityChanged(query));
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => WeatherScreen()));

            },
          ),
        ],
      ),
    );;
  }
}
