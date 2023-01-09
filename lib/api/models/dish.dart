import 'package:intl/intl.dart';

class Dish {
  final int? id;
  final String? title;
  final String? description;
  final double? value;
  final String? image;
  final List<DishOption>? oneChoiceOptions;
  final List<DishOption>? multipleChoiceOptions;

  static Dish? instance;

  Dish({
    required this.id,
    required this.title,
    required this.description,
    required this.value,
    required this.image,
    this.oneChoiceOptions,
    this.multipleChoiceOptions,
  }) {
    instance = this;
  }

  Dish.empty(
      {this.id,
      this.title,
      this.value,
      this.description,
      this.image,
      this.oneChoiceOptions,
      this.multipleChoiceOptions}) {
    instance = this;
  }

  factory Dish.fromJson(Map<String, dynamic> json) => Dish(
        id: int.parse(json["id"]),
        title: json["title"],
        description: json["description"],
        value: json["value"],
        image: json["image"],
        oneChoiceOptions: json["oneChoiceOptions"],
        multipleChoiceOptions: json["multipleChoiceOptions"],
      );

  get valueFormatted => NumberFormat.currency(
        locale: "pt_BR",
        symbol: "R\$",
      ).format(value);
}

class DishOption {
  final String? title;
  final double? value;
  final int? min;
  final int? max;
  final List<DishOption>? options;

  // aux
  int? indexSelected;

  static DishOption? instance;

  DishOption(
      {required this.title,
      this.value,
      this.min,
      this.max,
      this.options,
      this.indexSelected}) {
    instance = this;
  }

  DishOption.empty(
      {this.title,
      this.value,
      this.min,
      this.max,
      this.options,
      this.indexSelected}) {
    instance = this;
  }

  factory DishOption.fromJson(Map<String, dynamic> json) => DishOption(
        title: json["title"],
        value: json["value"],
        min: json["min"],
        max: json["max"],
        options: json["options"],
      );

  get valueFormatted => NumberFormat.currency(
        locale: "pt_BR",
        symbol: "R\$",
      ).format(value);
}
