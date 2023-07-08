class UserModel {
  final String firstname;
  final String lastname;
  final String useid;
  final String phone;
  final String password;
  final String? image;
  const UserModel({
    required this.firstname,
    required this.lastname,
    required this.useid,
    required this.phone,
    required this.password,
    required this.image,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      useid: json['_id'],
      firstname: json['first_name'],
      lastname: json['last_name'],
      phone: json['phone'],
      password: json['password'],
      image: json['image'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      '_id': useid,
      'first_name': firstname,
      'last_name': lastname,
      'phone': phone,
      'password': password,
      'image': image,
      // Add other fields if needed
    };
  }
}
