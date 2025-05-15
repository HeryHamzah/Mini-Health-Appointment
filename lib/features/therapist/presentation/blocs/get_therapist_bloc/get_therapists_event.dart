part of 'get_therapists_bloc.dart';

sealed class GetTherapistsEvent extends Equatable {
  const GetTherapistsEvent();

  @override
  List<Object> get props => [];
}

final class GetTherapists extends GetTherapistsEvent {}
