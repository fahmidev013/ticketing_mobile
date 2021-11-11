
class Issue {
  final int issue_id;
  final int issue_user_id;
  final String issue_status;
  final String issue_category;
  final String issue_priority;
  final String issue_resolution;
  final String issue_project;
  final String issue_component;
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
    required this.issue_category,
    required this.issue_priority,
    required this.issue_resolution,
    required this.issue_project,
    required this.issue_component,
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
      issue_id: json['issue_id'] == null ? '' : json['issue_id'],
      issue_user_id: json['issue_user_id'] == null ? '' : json['issue_user_id'],
      issue_status: json['issue_status']== null ? '' : json['issue_status'],
      issue_category: json['issue_category']== null ? '' : json['issue_category'],
      issue_priority: json['issue_priority']== null ? '' : json['issue_priority'],
      issue_resolution: json['issue_resolution']== null ? '' : json['issue_resolution'],
      issue_project: json['issue_project']== null ? '' : json['issue_project'],
      issue_component: json['issue_component']== null ? '' : json['issue_component'],
      issue_desc: json['issue_desc']== null ? '' : json['issue_desc'],
      issue_user_name: json['issue_user_name']== null ? '' : json['issue_user_name'],
      issue_register_date: json['issue_register_date']== null ? '' : json['issue_register_date'],
      issue_close_date: json['issue_close_date']== null ? '' : json['issue_close_date'],
      issue_labels: json['issue_labels']== null ? '' : json['issue_labels'],
      issue_title: json['issue_title']== null ? '' : json['issue_title'],
      issue_environment: json['issue_environment']== null ? '' : json['issue_environment'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "issue_id": this.issue_id,
      "issue_user_id": this.issue_user_id,
      "issue_status": this.issue_status,
      "issue_category": this.issue_category,
      "issue_priority": this.issue_priority,
      "issue_resolution": this.issue_resolution,
      "issue_project": this.issue_project,
      "issue_component": this.issue_component,
      "issue_desc": this.issue_desc,
      "issue_user_name": this.issue_user_name,
      "issue_register_date": this.issue_register_date,
      "issue_close_date": this.issue_close_date,
      "issue_labels": this.issue_labels,
      "issue_title": this.issue_title,
      "issue_environment": this.issue_environment
    };
  }

}