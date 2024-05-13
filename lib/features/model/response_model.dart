class Response {
  Response({
    required this.success,
    required this.messages,
    required this.data,
  });

  final bool? success;
  final dynamic messages;
  final Data? data;

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      success: json["success"],
      messages: json["messages"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }
}

class Data {
  Data({
    required this.users,
  });

  final List<User> users;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      users: json["users"] == null
          ? []
          : List<User>.from(json["users"]!.map((x) => User.fromJson(x))),
    );
  }
}

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
