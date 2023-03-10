part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AppAuthRequested extends AppEvent {}

class AuthenticationStatusChanged extends AppEvent {
  final AuthenticationStatus status;

  const AuthenticationStatusChanged(this.status);

  @override
  List<Object> get props => [status];
}
