class Category {
  final int? id;
  final String? name;
  final String? image;

  static Category? instance;

  Category({
    required this.id,
    required this.name,
    required this.image,
  }) {
    instance = this;
  }

  Category.empty({this.id, this.name, this.image}) {
    instance = this;
  }

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: int.parse(json["id"]),
        name: json["name"],
        image: json["image"],
      );
}
