import 'package:flutter/material.dart';
import 'package:hubia_menu_app/app/modules/welcome/modules/login/login_module.dart';
import 'package:hubia_menu_app/app/modules/welcome/pages/welcome_page.dart';
import 'package:hubia_menu_app/shared/widgets/hubia_module.dart';

class WelcomeModule extends StatelessWidget {
  const WelcomeModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HubiaModule(
      routes: {
        "/": (_) => const Scaffold(body: WelcomePage()),
        // "/login": (_) => const LoginModule(),
      },
    );
  }
}
