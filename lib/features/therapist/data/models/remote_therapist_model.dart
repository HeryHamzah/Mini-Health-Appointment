import 'package:json_annotation/json_annotation.dart';
import 'package:mini_health_appointment/features/therapist/domain/entities/therapist_entity.dart';

part 'remote_therapist_model.g.dart';

@JsonSerializable()
class RemoteTherapistModel {
  final String id;
  final String email;
  final String name;
  @JsonKey(name: "user_type")
  final String userType;
  @JsonKey(name: "image_path")
  final String? imagePath;
  final String? role;

  RemoteTherapistModel({
    required this.id,
    required this.email,
    required this.name,
    required this.userType,
    this.imagePath,
    this.role,
  });

  factory RemoteTherapistModel.fromJson(Map<String, dynamic> json) =>
      _$RemoteTherapistModelFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteTherapistModelToJson(this);

  TherapistEntity toEntity() {
    return TherapistEntity(
      id: id,
      email: email,
      name: name,
      profilePicPath: imagePath,
      role: role,
    );
  }
}
