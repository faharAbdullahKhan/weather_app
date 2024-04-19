import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'cities.g.dart';

@HiveType(typeId: 3)
class CitiesEntity extends Equatable {
  @HiveField(0)
  final bool error;
  @HiveField(1)
  final String msg;
  @HiveField(2)
  final List<String> data;

  const CitiesEntity(
      {required this.error, required this.msg, required this.data});

  @override
  // TODO: implement props
  List<Object?> get props => [
        error,
        msg,
        data,
      ];
}
