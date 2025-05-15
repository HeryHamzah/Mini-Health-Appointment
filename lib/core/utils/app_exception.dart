import 'package:equatable/equatable.dart';

sealed class AppException extends Equatable implements Exception {
  final String message;

  const AppException({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}

class GeneralException extends AppException {
  const GeneralException({required super.message});
}

class ServerException extends AppException {
  final int code;
  const ServerException({required super.message, required this.code});

  @override
  List<Object?> get props => super.props + [code];
}

class ClientException extends AppException {
  final int code;
  const ClientException({required super.message, required this.code});

  @override
  List<Object?> get props => super.props + [code];
}
