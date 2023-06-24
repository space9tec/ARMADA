class Contact {
  final String userid;
  final String username;

  Contact({
    required this.userid,
    required this.username,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      userid: json['_id'],
      username: json['first_name'],
    );
  }
}
