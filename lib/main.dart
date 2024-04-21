import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather_app/data/data_sources/list_of_cities_data_remote_source/cities_offline_data_source.dart';
import 'package:weather_app/data/data_sources/multi_cities_weather_offline_source/multi_cities_weather_offline_source.dart';
import 'package:weather_app/data/data_sources/weather_data_source/offline_data_source.dart';
import 'package:weather_app/injection_container.dart';
import 'package:weather_app/presentation/bloc/cities/cities_bloc.dart';
import 'package:weather_app/presentation/bloc/weather_bloc.dart';
import 'package:weather_app/presentation/screens/weather_screen.dart';
import 'package:weather_app/utils/hive_initailizer.dart';

import 'presentation/screens/inset_city_screen.dart';
import 'presentation/screens/testing_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  setupLocator();
  await HiveInitializer.initialize();
  await OfflineDataSource().openWeatherBoxes();
  await CitiesOfflineDataSource().openCitiesBoxes();
  await MultiCitiesOfflineDataSource().openMultiCitiesWeatherBoxes();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [

      BlocProvider(create: (_) => locator<WeatherBloc>()),
      BlocProvider(create: (_) => locator<CitiesBloc>())
    ], child: MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  HomeScreen(),
    ));
  }
}

