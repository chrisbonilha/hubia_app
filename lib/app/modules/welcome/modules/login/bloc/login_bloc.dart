import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hubia_menu_app/api/repository/auth_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  AuthRepository authRepository;
  String? cpf;
  String? password;

  LoginBloc(this.authRepository) : super(LoginInitial()) {
    on<CpfSubmited>(_onCpfSubmited);
    on<FormValidated>(_onFormValidated);
    on<PasswordSubmited>(_onPasswordSubmited);
  }

  void _onCpfSubmited(event, emit) {
    cpf = event.cpf;
    emit(HasCpf(event.cpf));
  }

  void _onFormValidated(event, emit) {
    emit(FormValidation());
  }

  void _onPasswordSubmited(event, emit) async {
    password = event.password;
    emit(Loading());

    try {
      await this.authRepository.logIn(cpf: cpf!, password: password!);
    } catch (e) {
      debugPrint('Failed login: $e');
      emit(LoginError());
    }
  }
}
