import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hubia_menu_app/app/app.dart';

class HubiaRepositoires {
  final List<RepositoryProvider> repositories = [];

  HubiaRepositoires._() {
    this.repositories.addAll(app_repositories);
  }

  static HubiaRepositoires _instance = HubiaRepositoires._();
  factory HubiaRepositoires() => _instance;
}
