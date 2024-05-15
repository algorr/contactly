import 'dart:io';
import 'package:contactly/features/model/user.dart';
import 'package:flutter/material.dart';

abstract class ServiceManager {
  Future<List<User>?> fetchContacts();
  Future<String?> saveContact(String firstName, String lastName,
      String phoneNumber, String profileImageUrl);
  Future<String?> uploadContactImage(File imageFile);
  Future<void> deleteUser(String userId, BuildContext context, Size size);
  Future<void> updateUser(
      BuildContext context,
      String firstName,
      String lastName,
      String phoneNumber,
      String profileImageUrl,
      String userId);

  Future<void> delete(String id);
}
