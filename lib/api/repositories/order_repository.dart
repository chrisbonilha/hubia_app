import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hubia_menu_app/api/data/service.dart';
import 'package:http/http.dart' as http;
import 'package:hubia_menu_app/api/models/category.dart';

import 'package:hubia_menu_app/api/models/user.dart';

class OrderRepository {
  User? user;
  late final MainService _mainService;

  OrderRepository(BuildContext context, {required this.user}) {
    this._mainService = MainService(context);
  }

  // Future<Map<String, dynamic>> getCategorias() async {
  //   // return await this._mainService.get('/categorias');
  // }

  getUser() {
    return this.user!;
  }

  // getPratos() {
  //   List<Prato> pratos = [
  //     Prato(
  //         id: 1,
  //         nome: "Grilled Fish",
  //         descricao: "Spicy grilled fish",
  //         valor: 8.50,
  //         categoriaId: "1"),
  //     Prato(
  //         id: 2,
  //         nome: "Fried Chicken",
  //         descricao: "Spicy fried chicken",
  //         valor: 7.50,
  //         categoriaId: "1"),
  //     Prato(
  //         id: 3,
  //         nome: "Fried Noodle",
  //         descricao: "Spicy fired noodle",
  //         valor: 6.50,
  //         categoriaId: "1"),
  //     Prato(
  //         id: 4,
  //         nome: "Fried Rice",
  //         descricao: "Spicy fired rice",
  //         valor: 4.50,
  //         categoriaId: "1"),
  //     Prato(
  //         id: 5,
  //         nome: "Magic Beans",
  //         descricao: "Magic beans from Joao",
  //         valor: 6.00,
  //         categoriaId: "1"),
  //     Prato(
  //         id: 6,
  //         nome: "Mashed Potato",
  //         descricao: "Mashed potato with garlic",
  //         valor: 12.0,
  //         categoriaId: "1"),
  //   ];
  //   return pratos;
  // }
}
