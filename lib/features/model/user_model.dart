class User {
  User({
    required this.id,
    required this.createdAt,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.profileImageUrl,
  });

  final String? id;
  final DateTime? createdAt;
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? profileImageUrl;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      firstName: json["firstName"],
      lastName: json["lastName"],
      phoneNumber: json["phoneNumber"],
      profileImageUrl: json["profileImageUrl"],
    );
  }
}
