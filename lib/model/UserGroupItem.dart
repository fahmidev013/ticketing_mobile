
class UserGroupItem {
  final int group_id;
  final String group_name;


  UserGroupItem({
    required this.group_id,
    required this.group_name,

  });

  factory UserGroupItem.fromJson(Map<String, dynamic> json) {
    return UserGroupItem(
      group_id: json['group_id'],
      group_name: json['group_name'],

    );
  }

  Map<String, dynamic> toJson() {
    return {
      "group_id": this.group_id,
      "group_name": this.group_name,
    };
  }

}