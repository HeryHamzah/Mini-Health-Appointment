// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_therapist_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteTherapistModel _$RemoteTherapistModelFromJson(
        Map<String, dynamic> json) =>
    RemoteTherapistModel(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      userType: json['user_type'] as String,
      imagePath: json['image_path'] as String?,
      role: json['role'] as String?,
    );

Map<String, dynamic> _$RemoteTherapistModelToJson(
        RemoteTherapistModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'user_type': instance.userType,
      'image_path': instance.imagePath,
      'role': instance.role,
    };
