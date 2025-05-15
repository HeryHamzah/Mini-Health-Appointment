import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_health_appointment/core/utils/app_exception.dart';
import 'package:mini_health_appointment/features/profile/domain/entities/profile_entity.dart';
import 'package:mini_health_appointment/features/profile/domain/use_cases/get_profile_use_case.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase getProfileUseCase;

  ProfileBloc({required this.getProfileUseCase}) : super(ProfileInitial()) {
    on<GetProfile>((event, emit) async {
      emit(ProfileLoading());

      final result = await getProfileUseCase();

      result.fold(
        (l) => emit(ProfileFailed(exception: l)),
        (r) => emit(
          ProfileLoaded(profile: r),
        ),
      );
    });
  }
}
