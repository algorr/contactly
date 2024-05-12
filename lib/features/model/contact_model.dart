import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'contact_model.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
final class ContactModel {
  ContactModel({
    required this.name,
    required this.lastName,
    required this.phone,
    required this.photoUrl,
  });

  @HiveField(0)
  final String name;
  @HiveField(1)
  final String lastName;
  @HiveField(2)
  final String phone;
  @HiveField(3)
  final String photoUrl;

  factory ContactModel.fromJson(Map<String, dynamic> json) =>
      _$ContactModelFromJson(json);

  Map<String, dynamic> toJson() => _$ContactModelToJson(this);
}
