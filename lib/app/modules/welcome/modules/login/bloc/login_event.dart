part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class FormValidated extends LoginEvent {}

class CpfSubmited extends LoginEvent {
  final String cpf;
  const CpfSubmited(this.cpf);

  @override
  List<Object> get props => [cpf];
}

class PasswordSubmited extends LoginEvent {
  final String password;
  const PasswordSubmited(this.password);

  @override
  List<Object> get props => [password];
}
