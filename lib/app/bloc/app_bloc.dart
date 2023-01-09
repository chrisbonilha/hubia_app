import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hubia_menu_app/api/api.dart';
import 'package:hubia_menu_app/api/models/enums/authentication_status.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AuthRepository authRepository;
  late StreamSubscription<AuthenticationStatus> _authSubscription;

  AppBloc(this.authRepository) : super(AppInitial()) {
    on<AppAuthRequested>(_onAuthRequested);
    on<AuthenticationStatusChanged>(_onAuthenticationStatusChanged);

    _authSubscription = authRepository.status.listen(
      (status) => add(AuthenticationStatusChanged(status)),
    );
  }

  void _onAuthRequested(event, emit) async {
    authRepository.checkStatus();
  }

  void _onAuthenticationStatusChanged(AuthenticationStatusChanged event, emit) {
    switch (event.status) {
      case AuthenticationStatus.authenticated:
        return emit(AppAuthentic(user: this.authRepository.getUser()));
      default:
        return emit(AppUnauthentic());
    }
  }

  @override
  Future<void> close() {
    _authSubscription.cancel();
    authRepository.dispose();
    return super.close();
  }
}
