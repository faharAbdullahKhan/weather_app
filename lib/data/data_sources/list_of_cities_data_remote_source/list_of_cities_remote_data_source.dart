import 'dart:convert';

import 'package:weather_app/core/constants/constants.dart';
import 'package:weather_app/core/error/exceptions.dart';
import 'package:weather_app/data/models/cities_model.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/utils/logs.dart';

abstract class CitiesRemoteDataSource {
  Future<CitiesModel> getCities(String countryName);
}

class CitiesRemoteDataSourceImpl extends CitiesRemoteDataSource {
  final http.Client client;
  CitiesRemoteDataSourceImpl({required this.client});

  @override
  Future<CitiesModel> getCities(String countryName) async {


    // TODO: implement getCities

    final response =  await client.get(Uri.parse(Constants.getCities(countryName)));


    logs("response ${response.statusCode}");
    logs("response ${response.body}");
    if (response.statusCode == 200) {
      return CitiesModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
