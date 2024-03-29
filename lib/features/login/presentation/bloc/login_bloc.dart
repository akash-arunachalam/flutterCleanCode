import 'dart:async';
// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttercleancode/core/constants/error_constants.dart';
import 'package:fluttercleancode/features/login/domain/params/login_params.dart';

import '../../../../core/error/failure.dart';
import '../../domain/usecases/login_user.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUser loginUser;

  LoginBloc(this.loginUser) : super(LoginInitial()) {
    on<LoginUserEvent>(loginEvent);
  }

  Future<FutureOr<void>> loginEvent(event, emit) async {
    emit(LoggingIn());

    final result = await loginUser.execute(parameters: event.parameters);
    emit(result.fold((l) => LoggedInWithError(message: _getErrorMessage(l)),
        (r) => LoggedInWithSuccess(message: r)));
  }

  String _getErrorMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return (failure as ServerFailure).message;

      default:
        return ErrorType.unknownError;
    }
  }
}
