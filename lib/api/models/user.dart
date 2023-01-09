class User {
  final int? id;
  final String? email;

  static User? instance;

  User({
    required this.id,
    required this.email,
  }) {
    instance = this;
  }

  User.empty({
    this.id,
    this.email,
  }) {
    instance = this;
  }

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: int.parse(json["id"]),
        email: json["email"],
      );
}
