import 'package:dartz/dartz.dart';
import 'package:weather_app/core/failure.dart';
import 'package:weather_app/domain/entities/cities.dart';
import 'package:weather_app/domain/repos/cities_repo.dart';

class GetCitiesUseCase{

  final CitiesRepo citiesRepo;

  GetCitiesUseCase( this.citiesRepo);


  Future<Either<Failure, CitiesEntity>> execute(String countryName){
    return citiesRepo.getCities(countryName);

  }



}