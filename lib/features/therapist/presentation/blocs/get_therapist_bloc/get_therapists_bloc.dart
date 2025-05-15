import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_health_appointment/core/utils/app_exception.dart';
import 'package:mini_health_appointment/features/therapist/domain/entities/therapist_entity.dart';
import 'package:mini_health_appointment/features/therapist/domain/usecases/get_therapists_use_case.dart';

part 'get_therapists_event.dart';
part 'get_therapists_state.dart';

class GetTherapistsBloc extends Bloc<GetTherapistsEvent, GetTherapistsState> {
  final GetTherapistsUseCase getTherapistsUseCase;

  GetTherapistsBloc({required this.getTherapistsUseCase})
      : super(GetTherapistsInitial()) {
    on<GetTherapists>((event, emit) async {
      emit(GetTherapistsLoading());

      final result = await getTherapistsUseCase();

      result.fold(
        (l) => emit(GetTherapistsFailed(exception: l)),
        (r) => emit(GetTherapistsLoaded(therapists: r)),
      );
    });
  }
}
