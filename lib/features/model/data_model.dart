import 'user_model.dart';

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
