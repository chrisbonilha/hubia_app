import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hubia_menu_app/api/repository/auth_repository.dart';
import 'package:hubia_menu_app/app/modules/welcome/modules/login/bloc/login_bloc.dart';
import 'package:hubia_menu_app/app/modules/welcome/modules/login/pages/cpf_page.dart';
import 'package:hubia_menu_app/app/modules/welcome/modules/login/pages/password_page.dart';
import 'package:hubia_menu_app/shared/widgets/hubia_page.dart';
import 'package:hubia_menu_app/shared/widgets/hubia_module.dart';

class LoginModule extends StatelessWidget {
  const LoginModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(context.read<AuthRepository>()),
      child: HubiaModule(
        routes: {
          "/": (_) => HubiaPage.transparent(child: CpfPage()),
          "/password": (_) =>
              HubiaPage.transparent(child: const PasswordPage()),
        },
      ),
    );
  }
}
