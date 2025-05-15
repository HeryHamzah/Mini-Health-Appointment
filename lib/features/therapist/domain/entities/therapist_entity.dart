import 'package:equatable/equatable.dart';

class TherapistEntity extends Equatable {
  final String id;
  final String email;
  final String name;
  final String? profilePicPath;
  final String? role;

  const TherapistEntity(
      {required this.id,
      required this.name,
      this.profilePicPath,
      this.role,
      required this.email});
  @override
  List<Object?> get props => [id, name, profilePicPath, role, email];
}
