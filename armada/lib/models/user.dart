class User {
  final String firstname;
  final String useid;
  final String phone;
  const User({
    required this.firstname,
    required this.useid,
    required this.phone,
  });
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      useid: json['_id'],
      firstname: json['first_name'],
      phone: json['phone'],
    );
  }
}
