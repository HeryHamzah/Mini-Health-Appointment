import 'package:json_annotation/json_annotation.dart';
import 'package:mini_health_appointment/features/appointment/domain/entities/appointment_status.dart';
import 'package:mini_health_appointment/features/appointment/domain/entities/patient_appointment_entity.dart';
import 'package:mini_health_appointment/features/appointment/domain/entities/therapist_appointment_entity.dart';
import 'package:mini_health_appointment/features/therapist/data/models/remote_therapist_model.dart';

part 'remote_appointment_model.g.dart';

@JsonSerializable()
class RemoteAppointmentModel {
  @JsonKey(name: "appointment_id")
  final String id;
  @JsonKey(name: "date_time")
  final int dateTime;
  final String? message;
  @JsonKey(name: "patient_name")
  final String patientName;
  final RemoteTherapistModel therapist;
  final String status;

  RemoteAppointmentModel(
      {required this.id,
      required this.dateTime,
      this.message,
      required this.patientName,
      required this.therapist,
      required this.status});

  factory RemoteAppointmentModel.fromJson(Map<String, dynamic> json) =>
      _$RemoteAppointmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteAppointmentModelToJson(this);

  TherapistAppointmentEntity therapistAppointmentEntity() {
    return TherapistAppointmentEntity(
      appointmentId: id,
      date: DateTime.fromMillisecondsSinceEpoch(dateTime),
      appointmentStatus: AppointmentStatus.values.singleWhere(
        (element) => element.name == status,
      ),
      patientName: patientName,
      message: message,
    );
  }

  PatientAppointmentEntity patientAppointmentEntity() {
    return PatientAppointmentEntity(
      appointmentId: id,
      date: DateTime.fromMillisecondsSinceEpoch(dateTime),
      appointmentStatus: AppointmentStatus.values.singleWhere(
        (element) => element.name == status,
      ),
      therapist: therapist.toEntity(),
    );
  }
}
