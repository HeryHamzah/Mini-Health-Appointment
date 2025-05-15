import 'package:equatable/equatable.dart';
import 'package:mini_health_appointment/features/auth/domain/entities/user_type_enum.dart';

class SessionEntity extends Equatable {
  final String token;
  final UserType userType;

  const SessionEntity({required this.token, required this.userType});

  @override
  List<Object?> get props => [token, userType];
}
