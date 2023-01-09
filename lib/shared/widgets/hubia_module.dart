import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

final GlobalKey<NavigatorState> oldMainNavigatorKey =
    GlobalKey<NavigatorState>();

class HubiaModule extends StatelessWidget {
  final Map<String, Widget Function(BuildContext)> routes;
  final HubiaMiddleware<PageRoute> _middleware;
  final bool material;
  final ThemeData? theme;
  final List<RouteObserver> navigatorObservers;

  HubiaModule({
    required this.routes,
    this.navigatorObservers = const [],
    Key? key,
  })  : _middleware = HubiaMiddleware<PageRoute>(routes),
        material = false,
        theme = null,
        super(key: key);

  HubiaModule.material({
    required this.routes,
    this.navigatorObservers = const [],
    this.theme,
    Key? key,
  })  : _middleware = HubiaMiddleware<PageRoute>(routes),
        material = true,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return material
        ? MaterialApp(
            navigatorKey: oldMainNavigatorKey,
            debugShowCheckedModeBanner: false,
            theme: theme,
            routes: routes,
            onUnknownRoute: _onUnknownRoute,
            navigatorObservers: [_middleware, ...navigatorObservers],
          )
        : WidgetsApp(
            navigatorObservers: [_middleware, ...navigatorObservers],
            debugShowCheckedModeBanner: false,
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            pageRouteBuilder:
                <T>(RouteSettings settings, WidgetBuilder builder) {
              return MaterialPageRoute<T>(settings: settings, builder: builder);
            },
            onUnknownRoute: _onUnknownRoute,
            color: Theme.of(context).primaryColor,
            routes: routes,
          );
  }

  Route<dynamic>? _onUnknownRoute(settings) {
    List<String> splited = settings.name!.split("/");
    splited.removeAt(0);
    if (splited.isNotEmpty && routes.containsKey("/${splited[0]}")) {
      final String nextRoute = "/${splited[0]}";
      splited.removeAt(0);
      if (splited.isNotEmpty) {
        pageStack.addAll(splited);
      }
      return MaterialPageRoute(
        settings: settings.copyWith(name: nextRoute),
        builder: routes[nextRoute]!,
      );
    }

    return MaterialPageRoute(
      settings: settings.copyWith(name: Navigator.defaultRouteName),
      builder: routes[Navigator.defaultRouteName]!,
    );
  }
}

final List<String> pageStack = [];
final List<String> pageTrack = [];

class HubiaMiddleware<R extends Route<dynamic>> extends RouteObserver<R> {
  final Map<String, Widget Function(BuildContext)> routes;
  final List<String> _untrackedPages = ["/"];
  HubiaMiddleware(this.routes);

  @override
  void didPush(Route route, Route? previousRoute) {
    if ((route.runtimeType != MaterialPageRoute &&
            route.runtimeType != PageRoute) ||
        route.settings.name == null) {
      return super.didPush(route, previousRoute);
    }

    if (!pageTrack.contains(route.settings.name!) &&
        !_untrackedPages.contains(route.settings.name!)) {
      pageTrack.add(route.settings.name!);
    }
    if (pageStack.isNotEmpty) {
      String nextPage = "/${pageStack[0]}";
      if (route.settings.name != nextPage && routes.containsKey(nextPage)) {
        pageStack.removeAt(0);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          navigator!.pushNamed(nextPage, arguments: route.settings.arguments);
        });
      }
    }
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    if ((route.runtimeType != MaterialPageRoute &&
            route.runtimeType != PageRoute) ||
        route.settings.name == null) {
      return super.didPop(route, previousRoute);
    }

    if (pageTrack.last == route.settings.name && previousRoute != null) {
      pageTrack.remove(route.settings.name!);
    }
    String? next;
    dynamic args = route.settings.arguments;

    if (args is Map && args.containsKey("backTo")) {
      next = args['backTo'];
    }
    if (previousRoute == null) {
      if (routes.containsKey(pageTrack.last)) {
        next = pageTrack.last;
      } else {
        next = pageTrack.join();
      }
    }

    if (next != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        navigator!.pushNamed(next!, arguments: args);
      });
    }

    super.didPop(route, previousRoute);
  }
}
