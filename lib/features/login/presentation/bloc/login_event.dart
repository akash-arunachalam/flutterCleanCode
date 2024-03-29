part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginUserEvent extends LoginEvent {
  final LoginParams parameters;
  const LoginUserEvent({required this.parameters});
  @override
  List<Object?> get props => [];
}
