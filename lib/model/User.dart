
class User {
  final int id;
  final String name;
  final String login;
  final String picture;
  final String email;
  final String active;

  User({
    required this.id,
    required this.name,
    required this.login,
    required this.picture,
    required this.email,
    required this.active
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      login: json['login'],
      picture: json['picture'] == null ? '' : json['picture'],
      email: json['email'],
      active: json['active'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "name": this.name,
      "login": this.login,
      "picture": this.picture,
      "email": this.email,
      "active": this.active
    };
  }

}