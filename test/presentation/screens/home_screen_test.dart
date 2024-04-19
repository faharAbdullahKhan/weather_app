import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/domain/entities/cities.dart';
import 'package:weather_app/domain/entities/weather.dart';
import 'package:weather_app/presentation/bloc/cities/cities_bloc.dart';
import 'package:weather_app/presentation/bloc/cities/cities_event.dart';
import 'package:weather_app/presentation/bloc/cities/cities_state.dart';
import 'package:weather_app/presentation/bloc/weather_bloc.dart';
import 'package:weather_app/presentation/bloc/weather_event.dart';
import 'package:weather_app/presentation/bloc/weather_state.dart';
import 'package:weather_app/presentation/screens/inset_city_screen.dart';
import 'package:weather_app/presentation/screens/weather_screen.dart';


class MockCitiesBloc extends MockBloc<CitiesEvent,CitiesState> implements CitiesBloc {  }


void main() {
  late MockCitiesBloc mockCitiesBloc;


  setUp((){
    mockCitiesBloc = MockCitiesBloc();
    HttpOverrides.global = null;
  });


  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<CitiesBloc>(
      create: (context) => mockCitiesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  const testCities = CitiesEntity(error: false, msg: "succesfully fetches", data: [
    "Abu Dhabi Municipality",
    "Al Ain City",
    "Al Ain Municipality",
    "Al Dhafra",
    "Al Shamkhah City",
    "Bani Yas City",
    "Khalifah A City",
    "Musaffah",
    "Muzayri‘",
    "Zayed City",
    "Ajman",
    "Ajman City",
    "Manama",
    "Masfout",
    "Al Fujairah City",
    "Al Fujairah Municipality",
    "Dibba Al Fujairah Municipality",
    "Dibba Al-Fujairah",
    "Dibba Al-Hisn",
    "Reef Al Fujairah City",
    "Ras Al Khaimah",
    "Ras Al Khaimah City",
    "Adh Dhayd",
    "Al Batayih",
  ]);


  testWidgets(
    'should show progress indicator when state is loading',
        (widgetTester) async {
      //arrange
      when(()=> mockCitiesBloc.state).thenReturn(CitiesLoading());

      //act
      await widgetTester.pumpWidget(_makeTestableWidget(const HomeScreen()));

      //assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    },
  );


  testWidgets(
    'should show widget contain cities data when state is cities loaded',
        (widgetTester) async {
      //arrange
      when(()=> mockCitiesBloc.state).thenReturn(const CitiesLoaded(testCities));

      //act
      await widgetTester.pumpWidget(_makeTestableWidget(const HomeScreen()));

      //assert
      expect(find.byKey(const Key('cities_data')), findsOneWidget);
    },
  );





}