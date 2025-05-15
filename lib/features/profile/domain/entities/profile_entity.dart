import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final String id;
  final String fullname;
  final String email;
  final String? imagepath;

  const ProfileEntity({
    required this.id,
    required this.fullname,
    required this.email,
    this.imagepath,
  });

  @override
  List<Object?> get props => [id, fullname, email, imagepath];
}
