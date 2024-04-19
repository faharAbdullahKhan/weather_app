import 'package:hive/hive.dart';
import 'package:weather_app/domain/entities/cities.dart';

part 'cities_model.g.dart';


@HiveType(typeId: 2)
class CitiesModel extends CitiesEntity {
  const CitiesModel({
    required bool error,
    required String msg,
    required List<String> data,
  }) : super(
          error: error,
          msg: msg,
          data: data,
        );

  factory CitiesModel.fromJson(Map<String, dynamic> json) => CitiesModel(
        error: json["error"],
        msg: json["msg"],
        data: List<String>.from(json["data"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "msg": msg,
        "data": List<dynamic>.from(data.map((x) => x)),
      };

  CitiesEntity toEntity() => CitiesEntity(
        error: error,
        msg: msg,
        data: data,
      );
}
