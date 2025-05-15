import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_health_appointment/core/utils/app_exception.dart';
import 'package:mini_health_appointment/features/auth/domain/entities/session_entity.dart';
import 'package:mini_health_appointment/features/auth/domain/entities/user_type_enum.dart';
import 'package:mini_health_appointment/features/auth/domain/usecases/check_login_status_use_case.dart';
import 'package:mini_health_appointment/features/auth/domain/usecases/login_with_email_and_password_use_case.dart';
import 'package:mini_health_appointment/features/auth/domain/usecases/register_use_case.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RegisterUseCase registerUseCase;
  final LoginWithEmailAndPasswordUseCase loginWithEmailAndPasswordUseCase;
  final CheckLoginStatusUseCase checkSessionUseCase;

  AuthBloc({
    required this.checkSessionUseCase,
    required this.loginWithEmailAndPasswordUseCase,
    required this.registerUseCase,
  }) : super(AuthInitial()) {
    on<LoginWithEmailAndPasswordRequested>((event, emit) async {
      emit(AuthLoading());

      final result = await loginWithEmailAndPasswordUseCase(
          email: event.email, password: event.password);

      result.fold(
        (exception) {
          emit(AuthError(exception: exception));
        },
        (session) {
          emit(Authenticated(session: session));
        },
      );
    });

    on<RegisterRequested>(
      (event, emit) async {
        emit(AuthLoading());

        final result = await registerUseCase(
            email: event.email,
            name: event.name,
            password: event.password,
            userType: event.userType);

        result.fold(
          (exception) {
            emit(AuthError(exception: exception));
          },
          (session) {
            emit(Authenticated(session: session));
          },
        );
      },
    );

    on<CheckLoginStatusRequested>(
      (event, emit) async {
        emit(AuthLoading());

        //TODO
        await Future.delayed(Duration(seconds: 1));

        final session = await checkSessionUseCase();

        if (session != null) {
          emit(Authenticated(session: session));
        } else {
          emit(Unauthenticated());
        }
      },
    );
  }
}
