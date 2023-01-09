import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hubia_menu_app/app/bloc/app_bloc.dart';
import 'package:hubia_menu_app/app/app.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  void _push(BuildContext context, String page) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        Navigator.of(context).pushReplacementNamed(page);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(buildWhen: (previous, current) {
      return previous != current;
    }, builder: (context, state) {
      switch (state.runtimeType) {
        case AppInitial:
          context.read<AppBloc>().add(AppAuthRequested());
          break;
        case AppAuthentic:
          _push(context, "/home");
          break;
        case AppUnauthentic:
          _push(context, "/welcome");
          break;
      }

      return const Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}
