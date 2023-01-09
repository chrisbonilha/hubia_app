import 'package:hubia_menu_app/api/models/dish.dart';

class Restaurant {
  final int? id;
  final String? name;
  final String? image;
  final int? categoryId;
  final List<RestaurantSection>? sections;

  static Restaurant? instance;

  Restaurant(
      {required this.id,
      required this.name,
      required this.image,
      required this.categoryId,
      required this.sections}) {
    instance = this;
  }

  Restaurant.empty(
      {this.id, this.name, this.categoryId, this.image, this.sections}) {
    instance = this;
  }

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: int.parse(json["id"]),
        categoryId: json["categoryId"],
        name: json["name"],
        image: json["image"],
        sections: List<RestaurantSection>.from(
            json["sections"].map((x) => RestaurantSection.fromJson(x))),
      );
}

class RestaurantSection {
  final String? title;
  final List<Dish>? items;

  static RestaurantSection? instance;

  RestaurantSection({required this.title, required this.items}) {
    instance = this;
  }

  RestaurantSection.empty({this.title, this.items}) {
    instance = this;
  }

  factory RestaurantSection.fromJson(Map<String, dynamic> json) =>
      RestaurantSection(
        title: json["title"],
        items: List<Dish>.from(json["items"].map((x) => Dish.fromJson(x))),
      );
}
