// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_appointment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteAppointmentModel _$RemoteAppointmentModelFromJson(
        Map<String, dynamic> json) =>
    RemoteAppointmentModel(
      id: json['appointment_id'] as String,
      dateTime: (json['date_time'] as num).toInt(),
      message: json['message'] as String?,
      patientName: json['patient_name'] as String,
      therapist: RemoteTherapistModel.fromJson(
          json['therapist'] as Map<String, dynamic>),
      status: json['status'] as String,
    );

Map<String, dynamic> _$RemoteAppointmentModelToJson(
        RemoteAppointmentModel instance) =>
    <String, dynamic>{
      'appointment_id': instance.id,
      'date_time': instance.dateTime,
      'message': instance.message,
      'patient_name': instance.patientName,
      'therapist': instance.therapist,
      'status': instance.status,
    };
