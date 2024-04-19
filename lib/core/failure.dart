import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];

}

class ServerFailure extends Failure {
  const ServerFailure(super.message);

}

class ConnectionFailure extends Failure {
  const ConnectionFailure(super.message);

}

class OfflineFailure extends Failure {
  const OfflineFailure(super.message);

}

class DBFailure extends Failure {
  const DBFailure(super.message);

}