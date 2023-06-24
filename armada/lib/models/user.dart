class User {
  final String name;
  final String lastname;
  final String phone;
  const User({
    required this.name,
    required this.lastname,
    required this.phone,
  });
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['first_name'],
      lastname: json['last_name'],
      phone: json['phone'],
    );
  }
}
