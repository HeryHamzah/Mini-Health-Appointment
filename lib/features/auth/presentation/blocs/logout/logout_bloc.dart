import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_health_appointment/features/auth/domain/usecases/logout_use_case.dart';

import '../../../../../core/utils/app_exception.dart';

part 'logout_event.dart';
part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final LogoutUseCase logoutUseCase;
  LogoutBloc({required this.logoutUseCase}) : super(LogoutInitial()) {
    on<LogoutRequested>((event, emit) async {
      emit(LogoutLoading());

      final result = await logoutUseCase();

      result.fold(
        (exception) => emit(LogoutFailed(exception: exception)),
        (r) => emit(LogoutSuccessful()),
      );
    });
  }
}
