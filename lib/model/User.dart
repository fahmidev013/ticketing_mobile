
import 'package:mobile_ticketing/model/UserGroup.dart';
import 'package:mobile_ticketing/model/UserGroupItem.dart';

class User {
  final int user_id;
  final String user_name;
  final String user_login;
  final String user_email;
  final String user_picture;
  final List<UserGroupItem> user_group;

  User({
    required this.user_id,
    required this.user_name,
    required this.user_login,
    required this.user_email,
    required this.user_picture,
    required this.user_group
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      user_id: json['user_id'],
      user_name: json['user_name'],
      user_login: json['user_login'],
      user_picture: json['user_picture'] == null ? '' : json['user_picture'],
      user_email: json['user_email'],
      user_group: (json['user_group'] as List).map((x) => UserGroupItem.fromJson(x)).toList()
    );
  }


  Map<String, dynamic> toJson() {
    return {
      "user_id": this.user_id,
      "user_name": this.user_name,
      "user_login": this.user_login,
      "user_picture": this.user_picture,
      "user_email": this.user_email,
      "user_group": this.user_group
    };
  }

}