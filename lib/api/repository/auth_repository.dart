import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:hubia_menu_app/api/data/service.dart';
import 'package:hubia_menu_app/api/models/enums/authentication_status.dart';
import 'package:hubia_menu_app/api/models/user.dart';

class AuthRepository {
  final MainService _service;
  final _statusStream = StreamController<AuthenticationStatus>();
  User? _user;

  AuthRepository(BuildContext context) : _service = MainService(context);

  Stream<AuthenticationStatus> get status async* {
    yield AuthenticationStatus.unauthenticated;
    yield* _statusStream.stream;
  }

  Future<void> checkStatus() async {
    // _statusStream.add(_user is User
    //     ? AuthenticationStatus.authenticated
    //     : AuthenticationStatus.unauthenticated);
    _statusStream.add(AuthenticationStatus.authenticated);
  }

  void logOut() {
    _statusStream.add(AuthenticationStatus.unauthenticated);
  }

  User getUser() {
    if (this._user == null) {
      this._user = User(id: 1, email: "chrisbsticchi@gmail.com");
    }
    return this._user!;
  }

  void dispose() => _statusStream.close();

  Future<void> logIn({
    required String cpf,
    required String password,
  }) async {
    // var response = await _service.post('/cadastro/auth/', data: {
    //   "username": cpf.replaceAll(RegExp(r"[^0-9]"), ""),
    // });
    // _user = User.fromJson(response['result']['cliente']);
    // _user!.setCredentials(response['result']);
    _statusStream.add(AuthenticationStatus.authenticated);
    // return response['result']['authChallenge'];
  }
}
