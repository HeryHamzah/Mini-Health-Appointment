import 'package:equatable/equatable.dart';

sealed class GetAppointmentsEvent extends Equatable {
  const GetAppointmentsEvent();

  @override
  List<Object> get props => [];
}

final class GetMyAppointments extends GetAppointmentsEvent {}

final class GetMoreMyAppointments extends GetAppointmentsEvent {}
