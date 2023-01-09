part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class FormValidation extends LoginState {}

class Loading extends LoginState {}

class LoginError extends LoginState {}

class HasCpf extends LoginState {
  final String cpf;

  const HasCpf(this.cpf);

  @override
  List<Object> get props => [cpf];
}
