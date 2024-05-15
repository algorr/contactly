import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class User {
  User({
    required this.id,
    required this.createdAt,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.profileImageUrl,
  });

  @HiveField(0)
  String? id;
  @HiveField(1)
  DateTime? createdAt;
  @HiveField(2)
  String? firstName;
  @HiveField(3)
  String? lastName;
  @HiveField(4)
  String? phoneNumber;
  @HiveField(5)
  String? profileImageUrl;

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
