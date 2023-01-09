import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hubia_menu_app/app/app.dart';
import 'package:hubia_menu_app/app/modules/home/home_module.dart';

class HubiaBlocs {
  final List<BlocProvider> blocs = [];

  HubiaBlocs._() {
    this.blocs.addAll(app_blocs);
    this.blocs.addAll(home_blocs);
  }

  static HubiaBlocs _instance = HubiaBlocs._();
  factory HubiaBlocs() => _instance;
}
