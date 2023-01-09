import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hubia_menu_app/api/repositories/home_repository.dart';
import 'package:hubia_menu_app/api/repository/auth_repository.dart';
import 'package:hubia_menu_app/app/bloc/app_bloc.dart';
import 'package:hubia_menu_app/app/modules/welcome/welcome_module.dart';
import 'package:hubia_menu_app/app/pages/splash_page.dart';
import 'package:hubia_menu_app/hubia_blocs.dart';
import 'package:hubia_menu_app/hubia_repositories.dart';
import 'package:hubia_menu_app/route_provider.dart';
import 'package:hubia_menu_app/shared/theme/hubia_theme.dart';
import 'package:hubia_menu_app/shared/widgets/hubia_module.dart';
import 'package:hubia_menu_app/api/api.dart';
import 'package:hubia_menu_app/shared/shared.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../shared/widgets/hubia_page.dart';

final RouteObserver appRouteObserver = RouteObserver<ModalRoute>();
final GlobalKey<NavigatorState> mainNavigatorKey = GlobalKey<NavigatorState>();

Map<String, HubiaPage Function(dynamic)> app_routes = {
  "/": (_) => HubiaPage.noAppBar(child: SplashPage())
};

List<RepositoryProvider> app_repositories = [
  RepositoryProvider<AuthRepository>(
    create: (context) => AuthRepository(context),
  ),
  RepositoryProvider<HomeRepository>(
    create: (context) => HomeRepository(context),
  )
];

List<BlocProvider> app_blocs = [
  BlocProvider<AppBloc>(
    create: (context) => AppBloc(context.read<AuthRepository>()),
  )
];

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var hubiaRepositories = HubiaRepositoires().repositories;
    var hubiaBlocs = HubiaBlocs().blocs;
    var hubiaRoutes = RouteProvider().routes;

    return MultiRepositoryProvider(
      providers: hubiaRepositories,
      child: MultiBlocProvider(
        providers: hubiaBlocs,
        child: MaterialApp(
            navigatorKey: mainNavigatorKey,
            theme: hubiaTheme(),
            routes: hubiaRoutes,
            navigatorObservers: [
              appRouteObserver
            ],
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ]),
      ),
    );
  }
}
