
import 'package:mobile_ticketing/model/UserGroupItem.dart';

class UserGroup {
  final String user_group;
  final List<UserGroupItem> items;


  UserGroup({
    required this.user_group,
    required this.items,

  });

  factory UserGroup.fromJson(Map<String, dynamic> json) {
    return UserGroup(
      user_group: json['user_group'],
      items: json['items'],

    );
  }

  Map<String, dynamic> toJson() {
    return {
      "user_group": this.user_group,
      "items": this.items,
    };
  }

}