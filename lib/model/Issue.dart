
class Issue {
  final int issue_id;
  final int issue_user_id;
  final String issue_status;
  // final String issue_category;
  final String issue_priority;
  final String issue_resolution;
  final String issue_project;
  // final String issue_component;
  final String issue_desc;
  final String issue_user_name;
  final String issue_register_date;
  final String issue_close_date;
  final String issue_labels;
  final String issue_title;
  final String issue_environment;

  Issue({
    required this.issue_id,
    required this.issue_user_id,
    required this.issue_status,
    // required this.issue_category,
    required this.issue_priority,
    required this.issue_resolution,
    required this.issue_project,
    // required this.issue_component,
    required this.issue_desc,
    required this.issue_user_name,
    required this.issue_register_date,
    required this.issue_close_date,
    required this.issue_labels,
    required this.issue_title,
    required this.issue_environment,
  });

  factory Issue.fromJson(Map<String, dynamic> json) {
    return Issue(
      issue_id: json['issue_id'],
      issue_user_id: json['issue_user_id'],
      issue_status: json['issue_status'],
      // issue_category: json['issue_category'],
      issue_priority: json['issue_priority'],
      issue_resolution: json['issue_resolution'],
      issue_project: json['issue_project'],
      // issue_component: json['issue_component'],
      issue_desc: json['issue_desc'],
      issue_user_name: json['issue_user_name'],
      issue_register_date: json['issue_register_date'],
      issue_close_date: json['issue_close_date'],
      issue_labels: json['issue_labels'],
      issue_title: json['issue_title'],
      issue_environment: json['issue_environment'],
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     "id": this.id,
  //     "name": this.name,
  //     "login": this.login,
  //     "picture": this.picture,
  //     "email": this.email,
  //     "active": this.active
  //   };
  // }

}