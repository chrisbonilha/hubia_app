import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hubia_menu_app/api/data/service.dart';
import 'package:http/http.dart' as http;
import 'package:hubia_menu_app/api/models/category.dart';
import 'package:hubia_menu_app/api/models/dish.dart';
import 'package:hubia_menu_app/api/models/restaurant.dart';
import 'package:hubia_menu_app/api/models/user.dart';

class HomeRepository {
  User? user;
  late final MainService _mainService;

  HomeRepository(BuildContext context) : _mainService = MainService(context);

  // HomeRepository(BuildContext context, {required this.user}) {
  //   this._mainService = MainService(context);
  // }

  // Future<Map<String, dynamic>> getCategorias() async {
  //   // return await this._mainService.get('/categorias');
  // }

  getUser() {
    return this.user!;
  }

  getCategorys() {
    List<Category> categorys = [
      Category(
          id: 1, name: "Pizza", image: "assets/images/ordinary/pizza.jpeg"),
      Category(
          id: 2, name: "Burger", image: "assets/images/ordinary/burger.jpeg"),
      Category(
          id: 3,
          name: "Japones",
          image: "assets/images/ordinary/japonesa.jpeg"),
      Category(
          id: 4,
          name: "Mexicano",
          image: "assets/images/ordinary/mexicana.jpeg"),
      Category(
          id: 5,
          name: "Prato Feito",
          image: "assets/images/ordinary/prato_feito.jpeg"),
      Category(
          id: 6, name: "Massas", image: "assets/images/ordinary/italiana.jpeg")
    ];
    return categorys;
  }

  getRestaurants() {
    List<Restaurant> restaurants = [
      Restaurant(
          id: 1,
          name: "Mc Donalds",
          image: "assets/images/ordinary/pizza.jpeg",
          categoryId: 2,
          sections: [
            RestaurantSection(title: "Teste", items: [
              Dish(
                  id: 1,
                  title: 'Grilled Fish',
                  description: "Spicy grilled fish",
                  value: 8.50,
                  image: "assets/images/ordinary/pizza.jpeg"),
              Dish(
                  id: 2,
                  title: 'Fried Chicken',
                  description: "Spicy fried chicken",
                  value: 8.50,
                  image: "assets/images/ordinary/pizza.jpeg")
            ])
          ]),
      Restaurant(
          id: 2,
          name: "1900 Pizzaria",
          image: "assets/images/ordinary/japonesa.jpeg",
          categoryId: 3,
          sections: [
            RestaurantSection(title: "Menu Especial", items: [
              Dish(
                  id: 1,
                  title: 'Pizza 2 sabores',
                  description: "Bla bla bla",
                  value: 0,
                  image: "assets/images/ordinary/pizza.jpeg",
                  oneChoiceOptions: [
                    DishOption(title: "Escolha sua massa", options: [
                      DishOption(title: "Fina", value: 0),
                      DishOption(title: "Média", value: 0),
                      DishOption(title: "Grossa", value: 0)
                    ]),
                    DishOption(title: "Deseja borda?", options: [
                      DishOption(title: "Borda de catupiry", value: 18),
                      DishOption(title: "Borda de nutella", value: 27),
                      DishOption(title: "Não quero borda", value: 0)
                    ])
                  ],
                  multipleChoiceOptions: [
                    DishOption(
                        title: "Escolha dois sabores :)",
                        min: 0,
                        max: 2,
                        options: [
                          DishOption(title: "1/2 Calabresa", value: 21.90),
                          DishOption(title: "1/2 Mussarela", value: 21.90),
                          DishOption(title: "1/2 Atum", value: 21.90)
                        ]),
                  ]),
            ])
          ]),
    ];
    return restaurants;
  }

  // getPratorByCategoria(String categoriaId) {
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
  //     Prato(
  //         id: 7,
  //         nome: "teste Potato",
  //         descricao: "Mashed potato with garlic",
  //         valor: 12.0,
  //         categoriaId: "2"),
  //   ];
  //   return pratos;
  // }
}
