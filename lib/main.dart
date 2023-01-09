import 'package:flutter/material.dart';
import 'package:hubia_menu_app/app/app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  await initializeHiveBoxes();
  runApp(const App());
}

initializeHiveBoxes() async {
  await Hive.initFlutter();

  if (!Hive.isBoxOpen('endereco')) {
    await Hive.openBox("endereco");
  }
  if (!Hive.isBoxOpen('user')) {
    await Hive.openBox("user");
  }
}
