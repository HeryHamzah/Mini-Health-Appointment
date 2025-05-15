import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/profile_entity.dart';

part 'profile_model.g.dart';

@JsonSerializable()
class ProfileModel {
  final String id;
  final String email;
  final String name;
  @JsonKey(name: "user_type")
  final String userType;
  @JsonKey(name: "image_path")
  final String? imagePath;

  ProfileModel(
      {required this.id,
      required this.email,
      required this.name,
      required this.userType,
      this.imagePath});

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);

  ProfileEntity toEntity() {
    return ProfileEntity(
      id: id,
      email: email,
      fullname: name,
      imagepath: imagePath,
    );
  }
}
