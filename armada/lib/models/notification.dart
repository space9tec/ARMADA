class Notifications {
  final String id;
  final String user_id;
  final String message;
  final DateTime created_at;
  final String type;
  // final DateTime updated_at;
  String? owner_id;
  String? contract_id;

  Notifications({
    required this.id,
    required this.user_id,
    required this.message,
    required this.created_at,
    // required this.updated_at,
    this.owner_id,
    this.contract_id,
    required this.type,
  });

  factory Notifications.fromJson(Map<String, dynamic> json) {
    return Notifications(
      id: json['_id'],
      user_id: json['user_id'],
      message: json['message'],
      // created_at: json['content'],
      created_at: DateTime.parse(json['timestamp']),
      owner_id: json['owner_id'],
      contract_id: json['contract_id'],
      type: json['type'],
    );
  }
}
