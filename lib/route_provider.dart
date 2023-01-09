import 'package:flutter/material.dart';
import 'package:hubia_menu_app/app/app.dart';
import 'package:hubia_menu_app/app/modules/home/home_module.dart';

class RouteProvider {
  final Map<String, Widget Function(BuildContext)> routes = {};

  RouteProvider._() {
    this.routes.addAll(app_routes);
    this.routes.addAll(home_routes);
  }
  static RouteProvider _instance = RouteProvider._();

  factory RouteProvider() => _instance;
}
