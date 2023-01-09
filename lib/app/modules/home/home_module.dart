import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hubia_menu_app/api/repositories/home_repository.dart';
import 'package:hubia_menu_app/app/modules/home/bloc/bloc.dart';
import 'package:hubia_menu_app/app/modules/home/pages/home_page.dart';
import 'package:hubia_menu_app/app/modules/home/pages/item_detail_page.dart';
import 'package:hubia_menu_app/app/modules/home/pages/menu_page.dart';
import 'package:hubia_menu_app/shared/widgets/hubia_page.dart';

Map<String, HubiaPage Function(dynamic)> home_routes = {
  "/home": (_) => HubiaPage.bottomBar(
        child: HomePage(),
        bottomBarIndex: 0,
      ),
  "/menu": (_) => HubiaPage(
        title: "Cardápio",
        child: MenuPage(),
      ),
  "/item_detail": (_) => HubiaPage(
        title: "Detalhes do item",
        child: ItemDetailPage(),
      ),
};

List<BlocProvider> home_blocs = [
  BlocProvider<HomeBloc>(
    create: (context) => HomeBloc(
      repository: context.read<HomeRepository>(),
    ),
  ),
];
