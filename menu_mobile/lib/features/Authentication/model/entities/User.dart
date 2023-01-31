class User {
  String id;
  String name;
  String email;
  String password;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] ?? '',
        name: json["name"] ?? '',
        email: json["email"] ?? '',
        password: json["password"] ?? '',
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "email": email,
        "password": password,
        "name": name,
      };
}
